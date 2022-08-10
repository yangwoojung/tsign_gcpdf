package kr.co.tsoft.sign.controller;

import java.io.File;
import java.io.FileOutputStream;
import java.io.OutputStream;
import java.util.HashMap;
import java.util.Locale;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.tomcat.util.bcel.classfile.Constant;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.clipsoft.clipreport.export.option.PDFOption;
import com.clipsoft.clipreport.server.service.ClipReportExport;
import com.clipsoft.clipreport.server.service.ExportInfo;

import kr.co.tsoft.sign.config.security.CommonUserDetails;
import kr.co.tsoft.sign.service.ReportService;
import kr.co.tsoft.sign.util.FileUtil;
import kr.co.tsoft.sign.util.SecurityUtil;
import kr.co.tsoft.sign.util.SessionUtil;

@Controller
@RequestMapping("/report")
public class ReportController {
	
	private final Logger log = LoggerFactory.getLogger(ReportController.class);
	
	@Value("${clip.prop.path}")
	private String propPath;
	
	@Value("${clip.contract.path}")
	private String contractPath;
	
	@Autowired
	private ReportService reportService;
	
	@Transactional(rollbackFor= {Exception.class})
	@RequestMapping(value="/viewReport", method = {RequestMethod.POST, RequestMethod.GET})
	public ModelAndView generateReportKey(HttpServletRequest request, HttpServletResponse response, 
										@RequestParam Map<String, Object> param) throws Exception {
		
		log.debug("===== generateReportKey Start =====");
		log.debug("param={}", param);

		Map<String, Object> result = reportService.makeRep(request, param);

		ModelAndView mv = new ModelAndView("sign/report");
		mv.addObject("reportKey", result.get("reportKey"));
		mv.addObject("reportFileName", result.get("reportFileName"));

		log.debug("===== generateReportKey End =====");
		
		return mv;
	}
	
	@RequestMapping(value = "/view", method = {RequestMethod.POST, RequestMethod.GET})
	public void getReportView(HttpServletRequest request, HttpServletResponse response)
			throws Exception {
		log.debug("===== getReportView Start =====");
		reportService.getReportView(request, response, propPath);
		log.debug("===== getReportView End =====");
	}
	
	@SuppressWarnings("unchecked")
	@RequestMapping(value = "/makePDF", method = {RequestMethod.POST, RequestMethod.GET})
	@ResponseBody
	public HashMap<String, Object> generatePDF(Locale locale, HttpServletRequest request, HttpServletResponse response
		, @RequestBody HashMap<String, Object> reqMap, SecurityUtil su) throws Exception {
		
	//	CommonUserDetails detail = su.getSignUserDetails();

		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		String repKey = (String) reqMap.get("repKey");

		log.debug("repKey : " + repKey);

		String propertyPath = request.getSession().getServletContext().getRealPath("/") + propPath;
		
		File localDirSave = new File(contractPath);
		
		if (!localDirSave.exists()) {
			localDirSave.mkdirs();
		}
		
//		File contractFolder = new File(localDirSave, detail.getContractNo());
		File contractFolder = new File(localDirSave, "contract");
		if (!contractFolder.exists()) {
			contractFolder.mkdirs();
		}
		
		File contractDir = new File(contractFolder, "contract");
		if (!contractDir.exists()) {
			contractDir.mkdirs();
		}
		
		FileUtil.deleteDirectory(contractDir, false);
		
//		File localFileSave = new File(contractDir, detail.getContractNo() + ".pdf");
		File localFileSave = new File(contractDir, "contract.pdf");
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
		
		log.debug("===== generatePDF End =====");
		return resultMap;
	}
}
