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
@RequestMapping("/sign/report")
public class ReportController {
	
	private final Logger log = LoggerFactory.getLogger(ReportController.class);
	
	@Value("${clip.prop.path}")
	private String CLIP_PROP_PATH;
	@Value("${clip.contract.path}")
	private String CLIP_CONTRACT_PATH;
	
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
		reportService.getReportView(request, response);
		log.debug("===== getReportView End =====");
	}
	
	@SuppressWarnings("unchecked")
	@RequestMapping(value = "/makePDF", method = {RequestMethod.POST, RequestMethod.GET})
	@ResponseBody
	public Map<String, Object> generatePDF(Locale locale, HttpServletRequest request, HttpServletResponse response
		, @RequestBody HashMap<String, Object> reqMap) throws Exception {
		
		log.debug("===== generatePDF Start =====");
		Map<String, Object> resultMap = reportService.makePdf(request, reqMap);
		log.debug("===== generatePDF End =====");
		
		return resultMap;
	}
}
