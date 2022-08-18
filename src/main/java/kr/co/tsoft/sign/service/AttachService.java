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

import kr.co.tsoft.sign.util.SessionUtil;
import kr.co.tsoft.sign.vo.ApiRequest;
import kr.co.tsoft.sign.vo.ApiResponse;
import kr.co.tsoft.sign.vo.ApiResponseData;
import okhttp3.MediaType;
import okhttp3.MultipartBody;

@Service
public class AttachService {
	
	private final Logger logger = LoggerFactory.getLogger(AttachService.class);
	
	@Value("${spring.http.multipart.location}")
	private String ATTACH_TMP_PATH;

	@Autowired
	private ApiService apiService;

	public List<Map<String, Object>> docList() {
		List<Map<String, Object>> docList = new ArrayList<Map<String, Object>>();
		Map<String, Object> map = new HashMap<>();
		Map<String, Object> map2 = new HashMap<>();
		
		map.put("docNm", "신분증");
		map.put("maxCnt", "5");
		map.put("docCd", "001");

		map2.put("docNm", "통장사본");
		map2.put("maxCnt", "5");
		map2.put("docCd", "002");
		
		docList.add(map);
		docList.add(map2);
		
		return docList;
	}

	public Map<String, Object> uploadAttachFile(Map<String, Object> param) throws Exception {
		
		logger.info("##### uploadAttachFile Service #####");
		/**
		 * TODO
		 * 1. base64로 인코딩된 파일 업로드하면서 tmp 폴더에 저장
		 * 2. ocr
		 * 3. 리턴받은 base64를 contract 폴더에 저장
		 * 4. 제출할 때 tmp 폴더 내의 계약번호 폴더 날리기
		 * 
		 */
		
		Map<String, Object> user = SessionUtil.getUser();
		Map<String, Object> resultMap = new HashMap<>();

		String attachCd = (String) param.get("attach_cd");
		String attachChildId = String.format("_04%d", Integer.parseInt((String)param.get("attach_child_id")));
		String contNo = (String)user.get("CONTRC_NO");
		
		
		String imgNm = contNo + attachCd + attachChildId;
		String img = (String) param.get("fileData");
		
		File uploadAttach = transferDecryptDataToDestFile(ATTACH_TMP_PATH + File.separator + contNo , imgNm, img);
//		FileUtils.writeByteArrayToFile(new File(ATTACH_TMP_PATH + File.separator + contNo + File.separator + imgNm + ".jpg"),  Base64.decodeBase64(img));
		
		//OCR 연결
		if("001".equals(attachCd)) {
			MultipartBody.Part filePart = MultipartBody.Part.createFormData("file", uploadAttach.getName(), okhttp3.RequestBody.create(MediaType.parse("image/*"), uploadAttach));
			
			ApiRequest.Ocr request = ApiRequest.Ocr.builder()
									.token("WuL299MCpJEwTs5ArcpoYJB4GaQ0PQ") //운영토큰
									.file(filePart)
									.build();
			
			logger.info("#### OCR API Request : {} ", request);
			ApiResponse<ApiResponseData.Ocr> response = apiService.processOcr(request);
			logger.info("#### name : {} " , response.getData().get(0).getData());
			resultMap.put("code", response.getData().get(0).getCode());
			resultMap.put("ocrResult", response.getData().get(0).getData());
			resultMap.put("resultMessage", response.getData().get(0).getStatus());
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
	
}
