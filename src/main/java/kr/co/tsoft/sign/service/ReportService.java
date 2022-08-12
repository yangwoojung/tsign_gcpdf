package kr.co.tsoft.sign.service;

import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.OutputStream;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.lang3.StringUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;
import org.springframework.util.Base64Utils;

import com.clipsoft.clipreport.export.option.PDFOption;
import com.clipsoft.clipreport.oof.OOFDocument;
import com.clipsoft.clipreport.oof.connection.OOFConnectionMemo;
import com.clipsoft.clipreport.server.service.ClipReportExport;
import com.clipsoft.clipreport.server.service.DeleteReport;
import com.clipsoft.clipreport.server.service.ExePrintInfo;
import com.clipsoft.clipreport.server.service.ExportInfo;
import com.clipsoft.clipreport.server.service.NewReport;
import com.clipsoft.clipreport.server.service.Page;
import com.clipsoft.clipreport.server.service.PageCount;
import com.clipsoft.clipreport.server.service.PageImage;
import com.clipsoft.clipreport.server.service.PagePrint;
import com.clipsoft.clipreport.server.service.ReportUtil;
import com.clipsoft.clipreport.server.service.UpDatePage;
import com.clipsoft.clipreport.server.service.eform.EFormPage;
import com.clipsoft.clipreport.server.service.eform.EFormThumbnailPage;
import com.clipsoft.clipreport.server.service.eform.EFormUpdateDocument;
import com.clipsoft.clipreport.server.service.export.FileDownLoadCheck;
import com.clipsoft.clipreport.server.service.export.HWPReport;
import com.clipsoft.clipreport.server.service.export.ImageBase64Export;
import com.clipsoft.clipreport.server.service.export.PDFReport;
import com.clipsoft.clipreport.server.service.export.SVGExport;
import com.clipsoft.clipreport.server.service.export.save.SAVEReport;
import com.clipsoft.clipreport.server.service.export.save.SAVEReportToFile;
import com.clipsoft.clipreport.server.service.export.save.SAVEReportToFileCheck;
import com.clipsoft.clipreport.server.service.export.save.SAVEReportToFileDownload;
import com.clipsoft.clipreport.server.service.html.PrintHTML;
import com.clipsoft.clipreport.server.service.reporteservice.ConfigurationAuthorization;
import com.clipsoft.clipreport.server.service.reporteservice.PrintLicense;
import com.clipsoft.clipreport.server.service.reporteservice.UpdateLicense;
import com.clipsoft.clipreport.server.service.viewer.ExportViewImage;
import com.clipsoft.clipreport.server.service.viewer.MakeDocumentJSON;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.pdfxml.PdfUtil;

import kr.co.tsoft.sign.config.security.CommonUserDetails;
import kr.co.tsoft.sign.util.DateUtil;
import kr.co.tsoft.sign.util.FileUtil;
import kr.co.tsoft.sign.util.SessionUtil;

@Service
public class ReportService {
	private final Logger log = LoggerFactory.getLogger(ReportService.class);
	
	@Value("${clip.prop.path}")
	private String CLIP_PROP_PATH;
	@Value("${clip.contract.path}")
	private String CLIP_CONTRACT_PATH;
	@Value("${clip.sign.key}")
	private String CLIP_SIGN_KEY;
	
	public Map<String, Object> makeRep(HttpServletRequest request, Map<String, Object> param) throws Exception {
		
		log.debug("param : {}", param);

		Map<String, Object> reportDataMap = new HashMap<>();
		Map<String, Object> resultMap = new HashMap<>();
		String reportFileName = null;

		//전자서식 객체 생성
		OOFDocument oof = OOFDocument.newOOF();
		OOFConnectionMemo memo = null;

		oof.addFile("crfe.root", "%root%/crf/tsign_test.crfe");
		reportFileName = "tsign_test";
		reportDataMap.put("tsign_test", param);
		log.debug("reportDataMap : {} ",reportDataMap);

		//json 데이터로 변환
		final String json = new ObjectMapper().writeValueAsString(reportDataMap);
		
		log.debug("json : ",json);
		final String propertyPath = request.getSession().getServletContext().getRealPath("/") + CLIP_PROP_PATH;

		memo = oof.addConnectionMemo("*", json);
		memo.addContentParamJSON("*", "utf-8", "{%dataset.json.root%}");

		String reportKey = null;
		try {
			reportKey = ReportUtil.createEForm(request, oof, "false", "false", request.getRemoteAddr(), propertyPath);
		} catch (Exception e){
			e.printStackTrace();
			throw e;
		}

		resultMap.put("reportKey", reportKey);

		return resultMap;
	}
		
	//report 뷰어 열기 위한 코드
	public void getReportView(HttpServletRequest request, HttpServletResponse response) throws Exception {
		response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate");
		log.debug("get real path : " + request.getSession().getServletContext().getRealPath("/"));
		String propertyPath = request.getSession().getServletContext().getRealPath("/") + CLIP_PROP_PATH;
		log.debug("server property path :" + propertyPath);
		
		// 크로스 도메인 설정
		// response.setHeader("Access-Control-Allow-Origin", "*");
		
		// 세션을 활용하여 리포트키들을 관리하지 않는 옵션
		// request.getSession().setAttribute("ClipReport-SessionList-Allow", false);
		
		String passName = request.getParameter("ClipID");
		if (null != passName) {
			if ("R01".equals(passName)) {
				NewReport newReport = new NewReport();
				newReport.doPost(request, response, propertyPath);
				// String responseValue = newReport.doPostToString(request, response, propertyPath);
				
				// 리포트의 특정 사용자 ID를 부여합니다.
				// clipreport4.properties 의 useuserid 옵션이 true 일 때만 적용됩니다.
				// clipreport4.properties 의 useuserid 옵션이 true 이고 기본 예제[newReport.doPost(request, response,
				// propertyPath);] 사용 했을 때 세션ID가 userID로 사용 됩니다.
				// newReport.doPost(request, response, propertyPath, "userID");
				
				// 리포트key의 사용자문자열을 추가합니다.(문자숫자만 가능합니다.)
				// newReport.doPost(request, response, propertyPath, "userID", "userKey");
			} else if ("R02".equals(passName)) {
				Page page1 = new Page();
				page1.doPost(request, response, propertyPath);
				// String pageString = page1.doPostToString(request, response, propertyPath);
				// 리포트의 특정 사용자 ID를 부여합니다.
				// clipreport4.properties 의 useuserid 옵션이 true 일 때만 적용됩니다.
				// page1.doPost(request, response, propertyPath, "userID");
			} else if ("R03".equals(passName)) {
				PageCount pageCount = new PageCount();
				pageCount.doPost(request, response, propertyPath);
				// String responseValue = pageCount.doPostToString(request, response, propertyPath);
			} else if ("R04".equals(passName)) {
				DeleteReport deleteReport = new DeleteReport();
				deleteReport.doPost(request, response);
				// String responseValue = deleteReport.doPostToString(request, response, propertyPath);
			}
			
			else if ("R07".equals(passName)) {
				HWPReport hwpReport = new HWPReport();
				hwpReport.doPost(request, response);
				
				// 리포트의 특정 사용자 ID를 부여합니다.
				// clipreport4.properties 의 useuserid 옵션이 true 일 때만 적용됩니다.
				// hwpReport.doPost(request, response, "userID");
			} else if ("R08".equals(passName)) {
				PDFReport pdfReport = new PDFReport();
				pdfReport.doPost(request, response);
				
				// 리포트의 특정 사용자 ID를 부여합니다.
				// clipreport4.properties 의 useuserid 옵션이 true 일 때만 적용됩니다.
				// pdfReport.doPost(request, response, "userID");
			} else if ("R09".equals(passName)) {
				SAVEReport saveReport = new SAVEReport();
				saveReport.doPost(request, response);
				
				// 리포트의 특정 사용자 ID를 부여합니다.
				// clipreport4.properties 의 useuserid 옵션이 true 일 때만 적용됩니다.
				// saveReport.doPost(request, response, "userID");
				
				// 문서 암호화를 처리하기 위해서는 jsp forward 사용 합니다.
				// RequestDispatcher dispatcher = request.getRequestDispatcher("export/exportForEncryption.jsp");
				// dispatcher.forward(request, response);
				
			} else if ("R09S1".equals(passName)) {
				SAVEReportToFile localSaveReport = new SAVEReportToFile();
				localSaveReport.doPost(request, response);
				
				// 리포트의 특정 사용자 ID를 부여합니다.
				// clipreport4.properties 의 useuserid 옵션이 true 일 때만 적용됩니다.
				// saveReport.doPost(request, response, "userID");
				
				// 문서 암호화를 처리하기 위해서는 jsp forward 사용 합니다.
				// RequestDispatcher dispatcher = request.getRequestDispatcher("export/exportForEncryption.jsp");
				// dispatcher.forward(request, response);
				
			} else if ("R09S2".equals(passName)) {
				SAVEReportToFileCheck saveFileCheck = new SAVEReportToFileCheck();
				saveFileCheck.doPost(request, response);
			}
			
			else if ("R09S3".equals(passName)) {
				SAVEReportToFileDownload saveReport = new SAVEReportToFileDownload();
				saveReport.doPost(request, response);
			}
			
			else if ("R10".equals(passName)) {
				PagePrint page1 = new PagePrint();
				page1.doPost(request, response);
				
				// 리포트의 특정 사용자 ID를 부여합니다.
				// clipreport4.properties 의 useuserid 옵션이 true 일 때만 적용됩니다.
				// page1.doPost(request, response, "userID");
			} else if ("R11".equals(passName)) {
				UpDatePage page1 = new UpDatePage();
				page1.doPost(request, response);
				
				// 리포트의 특정 사용자 ID를 부여합니다.
				// clipreport4.properties 의 useuserid 옵션이 true 일 때만 적용됩니다.
				// page1.doPost(request, response, "userID");
			}
			
			else if ("R15".equals(passName)) {
				PrintHTML printHTML = new PrintHTML();
				printHTML.doPost(request, response);
			}
			
			else if ("R16".equals(passName)) {
				FileDownLoadCheck fileCheck = new FileDownLoadCheck();
				//fileCheck.doPost(request, response);
				// String responseValue = fileCheck.doPostToString(request, response, propertyPath);
			} else if ("R17".equals(passName)) {
				PageImage pageImage = new PageImage();
				pageImage.doPost(request, response);
			} else if ("R30".equals(passName)) {
				EFormPage eformPage = new EFormPage();
				eformPage.doPost(request, response, propertyPath);
				
				// 리포트의 특정 사용자 ID를 부여합니다.
				// clipreport4.properties 의 useuserid 옵션이 true 일 때만 적용됩니다.
				// eformPage.doPost(request, response, propertyPath, "userID");
			} else if ("R31".equals(passName)) {
				EFormUpdateDocument eformUpDate = new EFormUpdateDocument();
				eformUpDate.doPost(request, response, propertyPath);
			}
			
			else if ("R32".equals(passName)) {
				EFormThumbnailPage thumbnailPage = new EFormThumbnailPage();
				String responseValue = thumbnailPage.doPost(request, propertyPath);
				thumbnailPage.setOutPutText(response, responseValue);
			}
			
			else if ("R50".equals(passName)) {
				PrintLicense printLicense = new PrintLicense();
				printLicense.doPost(request, response, propertyPath);
			} else if ("R51".equals(passName)) {
				UpdateLicense updateLicense = new UpdateLicense();
				updateLicense.doPost(request, response, propertyPath);
			} else if ("R52".equals(passName)) {
				ConfigurationAuthorization authorization = new ConfigurationAuthorization();
				authorization.doPost(request, response, propertyPath);
			} else if ("R97".equals(passName)) {
				SVGExport svgExport = new SVGExport();
				svgExport.doZipPost(request, response);
			} else if ("R98".equals(passName)) {
				ImageBase64Export imageExport = new ImageBase64Export();
				imageExport.doPost(request, response);
			} else if ("S01".equals(passName)) {
				ExePrintInfo exePrintInfo = new ExePrintInfo();
				String strInfo = exePrintInfo.doPost(request);
				exePrintInfo.setOutPutText(response, strInfo);
			}
		}
		String ClipType = request.getParameter("ClipType");
		if (null != ClipType) {
			if ("exportViewImage".equals(ClipType)) {
				response.setHeader("Cache-Control", "max-age=1800");
				ExportViewImage viewImage = new ExportViewImage();
				viewImage.doPost(request, response, propertyPath);
			} else if ("exportViewImageBase64".equals(ClipType)) {
				ExportViewImage viewImage = new ExportViewImage();
				viewImage.doPostBase64(request, response, propertyPath);
			} else if ("DocumentPageView".equals(ClipType)) {
				MakeDocumentJSON documentPage = new MakeDocumentJSON();
				documentPage.doPost(request, response, propertyPath);
			}
		}
	}

	public Map<String, Object> makePdf(HttpServletRequest request, HashMap<String, Object> param) throws Exception {
		
		Map<String, Object> resultMap = new HashMap<>();

		Map<String, Object> user = SessionUtil.getUser();
		String contNo = (String) user.get("CONTRC_NO");
		
		String repKey = (String) param.get("repKey");
		log.debug("repKey : " + repKey);

		String propertyPath = request.getSession().getServletContext().getRealPath("/") + CLIP_PROP_PATH;
		
		File localDirSave = new File(CLIP_CONTRACT_PATH);
		
		if (!localDirSave.exists()) {
			localDirSave.mkdirs();
		}
		
		File contractFolder = new File(localDirSave, contNo);
		if (!contractFolder.exists()) {
			contractFolder.mkdirs();
		}
		
		File contractDir = new File(contractFolder, "contract");
		if (!contractDir.exists()) {
			contractDir.mkdirs();
		}
		
		FileUtil.deleteDirectory(contractDir, false);
		
		File localFileSave = new File(contractDir, contNo + ".pdf");
		log.debug("localFileSave : " + localFileSave.getPath());
		
		if (!localFileSave.exists()) {
			localFileSave.createNewFile();
		}
		
		try {
			OutputStream fileStream = new FileOutputStream(localFileSave);
			
			PDFOption option = null;
			// statusType == 0 정상적인 출력
			// statusType == 1 인스톨 오류
			// statusType == 2 oof 문서 오류
			// statusType == 3 리포트 엔진 오류
			// statusType == 4 PDF 출력 오류
			// statusType == 5 리포트의 페이지 0 일 경우 오류
			ExportInfo exportInfo = ClipReportExport.createExportForPartPDF(request, repKey, fileStream, option, propertyPath);
			int errorCode = exportInfo.getErrorCode();
			log.debug("errorCode : " + errorCode);
			
			if (errorCode == 0) {
				resultMap.put("resultCd", "0000");
			}else {
				log.error("E-form 생성 실패");
				throw new RuntimeException("전자문서 생성에 실패하였습니다.");
			}
		} catch (Exception e) {
			log.error("E-form 생성 실패");
			throw new RuntimeException("전자문서 생성에 실패하였습니다.");
		}
		return resultMap;
	}
}
