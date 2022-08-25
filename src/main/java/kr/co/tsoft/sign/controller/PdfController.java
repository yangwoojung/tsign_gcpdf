package kr.co.tsoft.sign.controller;

import com.clipsoft.lowagie.text.DocumentException;
import kr.co.tsoft.sign.config.security.CommonUserDetails;
import kr.co.tsoft.sign.service.ComService;
import kr.co.tsoft.sign.service.PdfService;
import kr.co.tsoft.sign.service.admin.FormService;
import kr.co.tsoft.sign.util.SessionUtil;
import kr.co.tsoft.sign.vo.FileDTO;
import kr.co.tsoft.sign.vo.InfoDTO;
import lombok.RequiredArgsConstructor;
import org.apache.commons.codec.binary.Base64;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import java.io.*;
import java.util.HashMap;
import java.util.Map;

@Controller
@RequiredArgsConstructor
@RequestMapping(value = {"/sign/pdf"})
public class PdfController {

	private final Logger logger = LoggerFactory.getLogger(getClass());

	private final ComService comService;
	private final PdfService pdfService;
	private final FormService formService;

	@Value("${config.upload.dir}")
	private String uploadDir;
	@Value("${config.pdf.temp.dir}")
	private String pdfTempDir;

	@RequestMapping("/view")
	public ModelAndView viewReport(InfoDTO infoDTO) throws Exception {
		logger.debug("===== /pdf/view 이동  ======");
		ModelAndView mv = new ModelAndView();

		CommonUserDetails user = SessionUtil.getUser();

		//TODO: 추후 세션에 저장되어 들어옴
		user.setBankAccountNo("593502-01-238928");
		user.setResidentNo("910710-1063131");

		//서식 원본 조회
		FileDTO fileDTO = FileDTO.builder()
				.contractNo(infoDTO.getContractNo())
				.fileType("100")
				.build();

		FileDTO formInfoInDB = formService.selectContrcFormInfo(fileDTO);
		if (null == formInfoInDB) {
			throw new Exception("서식파일이 존재하지 않습니다.");
		}

		String lastPath = "form";

		String fileFullName = formInfoInDB.getFilePath() + formInfoInDB.getSavFileNm();
		File oriFile = new File(fileFullName);

		//상대경로에 pdf가 존재해야 하는 이유로 temp파일로 복사해서 사용
		String newFileFullName = pdfTempDir + File.separatorChar + formInfoInDB.getSavFileNm();
		File copyFile = new File(newFileFullName);

		logger.debug("어드민에서 저장한 서식 경로 : " + oriFile);
		logger.debug("유저쪽에서 사용할 복사된 서식 경로 : " + copyFile);
		if (!copyFile.exists()) {
			try {
				FileInputStream fis = new FileInputStream(oriFile); //읽을파일
				FileOutputStream fos = new FileOutputStream(copyFile); //복사할파일

				int fileByte = 0;
				// fis.read()가 -1 이면 파일을 다 읽은것
				while ((fileByte = fis.read()) != -1) {
					fos.write(fileByte);
				}
				//자원사용종료
				fis.close();
				fos.close();
				fos.flush();
			} catch (FileNotFoundException e) {
				logger.debug("===FileNotFoundException===");
				e.printStackTrace();
			} catch (IOException e) {
				logger.debug("===IOException===");
				e.printStackTrace();
			}
		}

		//사인이미지 처리 inputSignCan
//		String encodeSignData = infoDTO.getSignCanvasDataUrl();
//		String fileName = pdfTempDir + File.separatorChar + "testSignImg.png";
//		byte[] signImgBytes = Base64.decodeBase64(encodeSignData.getBytes());
//		try {
//			FileOutputStream fos = new FileOutputStream(new File(fileName));
//			fos.write(signImgBytes);
//			fos.close();
//			fos.flush();
//		} catch (IOException e) {
//			logger.debug("===IOException===");
//			e.printStackTrace();
//		}

		String pdfPath = "/upload/temp/";
//		//서식 상대경로
//		resultMap.put("pdfPath", pdfPath);
//		//서식 파일명
//		resultMap.put("pdfFileNm", (String) formInfoInDB.get("SAV_FILE_NM"));
//		//생성한 계약서 저장할 파일명
//		resultMap.put("savedNewPdfFileNm", "(계약서)" + su.getSignUserDetails().getUserNm() + "_" + su.getSignUserDetails().getContractNo() + ".pdf");
//
//		resultMap.put("inputResidentNo1", residentNo1);
//		resultMap.put("inputResidentNo2", residentNo2);
//		resultMap.put("inputBankCd", paramMap.get("inputBankCd"));
//		resultMap.put("inputBankNm", bankNm);
//		resultMap.put("inputAcnutNo", accountNo);
//		resultMap.put("inputAddr", address);
////		resultMap.put("inputUserNm", 		paramMap.get("inputUserNm"));
////		resultMap.put("inputEmail", 		paramMap.get("inputEmail"));
//		resultMap.put("encodedSignCan", encodeSignData);//인코드 된 사인
//		resultMap.put("decodedSignCan", signImgBytes);//디코드 된 사인
//		resultMap.put("contrcNo", paramMap.get("contrcNo"));//계약번호

//		logger.debug("## //	resultMap	: " + resultMap);

		mv.addObject("info", infoDTO);
		mv.setViewName("sign/pdfViewer");
		return mv;
	}

	/*
	 * 생성된 계약서 업로드 */
	@RequestMapping("/createPdfUpload")
	@ResponseBody
	public HashMap<String, Object> upload(@RequestParam Map<String, String> parameter
	) throws Exception {
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		//base64 인코딩 된 파일 스트링
		String fileString = parameter.get("fileString");
		resultMap.put("fileString", parameter.get("fileString"));

		byte[] decodedBytes = Base64.decodeBase64(fileString.getBytes());
		String contrcNo = parameter.get("contrcNo");
		//계약번호에 해당하는 폴더 생성 
		mkdir(contrcNo);
		//디코딩후 파일로
		String savedNewPdfFileNm = parameter.get("savedNewPdfFileNm");
		String filePath = uploadDir + File.separatorChar + contrcNo;
		File base64ToImgFile = new File(filePath + File.separatorChar + savedNewPdfFileNm);
		try {
			FileOutputStream fos = new FileOutputStream(base64ToImgFile);

			fos.write(decodedBytes);
			HashMap<String, String> fileInfo = new HashMap<String, String>();
//			fileInfo.put("FILE_TP", "102");
//			fileInfo.put("CONTRC_NO", su.getSignUserDetails().getContractNo());
//			fileInfo.put("ORG_FILE_NM", savedNewPdfFileNm);
//			fileInfo.put("SAV_FILE_NM", savedNewPdfFileNm);
//			fileInfo.put("FILE_PATH", filePath);
//			fileInfo.put("user", su.getSignUserDetails().getUsername());
			if (comService.insertFileUpload(fileInfo) > 0) {
				resultMap.put("message", "계약서 생성을 완료했습니다.");
			}
		} catch (Exception e) {
			resultMap.put("message", "계약서 생성에 실패했습니다.");
		}

		return resultMap;
	}

	@RequestMapping("/completeContract")
	@ResponseBody
	public HashMap<String, Object> createPdf(@RequestParam Map<String, String> parameter
	) throws IOException, DocumentException {
//		HashMap<String, Object> resultMap = new HashMap<String, Object>();
//		
//		covertPdf.test();

		// 추적표 조회&생성 => 메일전송
//		HashMap<String, Object> resultMap = pdfService.createHistPdf(parameter.get("contrcNo"));

//		return resultMap;
		return null;
	}

	public void mkdir(String contrcNo) {
		String path = uploadDir + File.separatorChar + contrcNo; //폴더 경로
		File Folder = new File(path);

		// 해당 디렉토리가 없을경우 디렉토리를 생성합니다.
		if (!Folder.exists()) {
			try {
				Folder.mkdir(); //폴더 생성합니다.
				logger.info("폴더가 생성되었습니다.");
			} catch (Exception e) {
				e.getStackTrace();
			}
		} else {
			logger.info("이미 폴더가 생성되어 있습니다.");
		}
	}

}
