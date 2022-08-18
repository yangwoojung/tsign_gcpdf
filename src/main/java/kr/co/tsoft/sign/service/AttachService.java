package kr.co.tsoft.sign.service;

import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.commons.codec.binary.Base64;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;

import kr.co.tsoft.sign.service.admin.ContrcService;
import kr.co.tsoft.sign.util.FileUtil;
import kr.co.tsoft.sign.util.MailHandler;
import kr.co.tsoft.sign.util.SessionUtil;
import kr.co.tsoft.sign.vo.ApiRequest;
import kr.co.tsoft.sign.vo.ApiResponse;
import kr.co.tsoft.sign.vo.ApiResponseData;
import okhttp3.MediaType;
import okhttp3.MultipartBody;

@Service
public class AttachService {

	private final Logger logger = LoggerFactory.getLogger(AttachService.class);

	@Value("${config.upload.dir}")
	private String CONTRACT_PATH;

	@Autowired
	private ApiService apiService;
	
	@Autowired
	private ContrcService contrcService;

	public List<Map<String, Object>> docList() {
		List<Map<String, Object>> docList = new ArrayList<Map<String, Object>>();
		Map<String, Object> map = new HashMap<>();
		Map<String, Object> map2 = new HashMap<>();

		map.put("docNm", "신분증");
		map.put("maxCnt", "5");
		map.put("docCd", "001");
		map.put("subReq", "1");

		map2.put("docNm", "통장사본");
		map2.put("maxCnt", "5");
		map2.put("docCd", "002");
		map2.put("subReq", "1");

		docList.add(map);
		docList.add(map2);

		return docList;
	}

	public Map<String, Object> uploadAttachFile(Map<String, Object> param) throws Exception {

		logger.info("##### [attach > uploadAttachFile Service] #####");

		Map<String, Object> user = SessionUtil.getUser();
		Map<String, Object> resultMap = new HashMap<>();

		String attachCd = (String) param.get("attach_cd");
		String attachChildId = (String) param.get("attach_child_id");
		String contNo = (String) user.get("CONTRC_NO");

		String imgNm = contNo + "_" + attachCd + "_" + attachChildId;
		String img = (String) param.get("fileData");

		String savePath = CONTRACT_PATH + contNo + File.separator + "attach" + File.separator;

		switch (attachCd) {
		case "001":
			savePath = savePath + "신분증";
			break;
		case "002":
			savePath = savePath + "통장사본";
			break;
		}

		File uploadAttach = transferDecryptDataToDestFile(savePath, imgNm, img);

		// OCR 연결
		if ("001".equals(attachCd)) {
			MultipartBody.Part filePart = MultipartBody.Part.createFormData("file", uploadAttach.getName(),
					okhttp3.RequestBody.create(MediaType.parse("image/*"), uploadAttach));

			ApiRequest.Ocr request = ApiRequest.Ocr.builder().token("WuL299MCpJEwTs5ArcpoYJB4GaQ0PQ") // 운영토큰
					.file(filePart).build();

			logger.info("#### OCR API Request : {} ", request);
			ApiResponse<ApiResponseData.Ocr> response = apiService.processOcr(request);
			resultMap.put("code", response.getData().get(0).getCode());
			resultMap.put("ocrResult", response.getData().get(0).getData());
			resultMap.put("resultMessage", response.getData().get(0).getStatus());
		} else {
			File Directory = new File(savePath);
			if (Directory.exists()) {
				resultMap.put("code", "0000");
				resultMap.put("resultMessage", "S");
			}
		}

		return resultMap;
	}

	public File transferDecryptDataToDestFile(String filePath, String fileName, String fileData) throws IOException {
		byte[] data = fileData.getBytes();
		String DecodeString = new String(data, "UTF-8");
		String[] removeDataString = DecodeString.split("base64,");
		byte[] decodedByte = null;
		String extension = ".jpg";
		if (DecodeString.indexOf("base64,") != -1) {
			decodedByte = Base64.decodeBase64(removeDataString[1]);
			String extensionHeaderString = removeDataString[0].toLowerCase();
			if (extensionHeaderString.indexOf("png") != -1) {
				extension = ".jpg";
			} else if (extensionHeaderString.indexOf("jpg") == -1 && extensionHeaderString.indexOf("jpeg") == -1) {
				if (extensionHeaderString.indexOf("pdf") != -1) {
					extension = ".pdf";
				} else {
					extension = ".tiff";
				}
			} else {
				extension = ".jpg";
			}
		} else {
			decodedByte = Base64.decodeBase64(removeDataString[0]);
		}

		File newDirectory = new File(filePath);
		if (!newDirectory.exists()) {
			newDirectory.mkdirs();
		}

		File destFile = new File(filePath + File.separator + fileName + extension);
		FileOutputStream stream = new FileOutputStream(destFile);

		try {
			stream.write(decodedByte);
		} finally {
			stream.close();
		}

		return destFile;
	}

	public ApiResponse<ApiResponseData.Scrap> scrapping(Map<String, Object> param) {
		logger.info("#### [attachService > scrapping] start ##### ");
		logger.info("#### [attachService > scrapping] param : {} ##### ", param);

		ApiRequest.Scrap request = ApiRequest.Scrap.builder().token("fc2yilEkhclyP1xGnWRNVFFIptXTLd")
				.type((String) param.get("type")).col1((String) param.get("col1")).col2((String) param.get("col2"))
				.col3((String) param.get("col3")).col4((String) param.get("col4")).col5((String) param.get("col5"))
				.col6((String) param.get("col6")).build();

		logger.info("#### Scrap API Request : {} ", request);
		ApiResponse<ApiResponseData.Scrap> response = apiService.processScrap(request);
		logger.info("#### Scrap API Response : {} ", response);

		return response;
	}

	public Map<String, Object> submission() {
		Map<String, Object> user = SessionUtil.getUser();
		String contNo = (String) user.get("CONTRC_NO");
//		ContrcMgmtVO contrMgmt;
//		user = contrcService.selectContrcInfo(contNo);
		
		
		
		Map<String, Object> resultMap = new HashMap<>();
		String filePath = CONTRACT_PATH + contNo;
		String zipFileName = filePath + ".zip";

		try {
			FileUtil.compress(filePath, zipFileName);
		} catch (Throwable e) {
			logger.error(" ##### [attachService > submission] 파일 압축 및 추가 실패 ##### ");
			e.printStackTrace();
		}

		File contractZipFile = new File(zipFileName);
		/**
		 * 이메일 > 계약자(pdf), 관리자(알집) 메일 전송 후 알집 날리기
		 * DB에서 USER_NM, EMAIL 조회
		 */
		// 계약자에게 pdf 전송
		MailHandler mail = new MailHandler();
		String toMail = "hmlee@tsoft.co.kr";
		String title = "[(주)티소프트] 전자계약이 완료되었습니다.";
		String content = "<html><body>[(주)티소프트] 전자계약이 완료되었음을 안내드립니다.</body></html>";
		ArrayList<String> attachFileName = new ArrayList<String>();
		attachFileName.add(filePath + File.separator + "contract" + File.separator + contNo + ".pdf");

		try {
			mail.send(toMail, title, content, attachFileName);
			resultMap.put("resCd", "0000");
		} catch (Exception e) {
			e.printStackTrace();
		}

		return resultMap;
	}

}
