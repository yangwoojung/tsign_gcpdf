package kr.co.tsoft.sign.controller;

import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import kr.co.tsoft.sign.service.ReportService;

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
										@RequestParam(required=false) Map<String, Object> param) throws Exception {
		
		log.debug("===== generateReportKey Start =====");
		log.debug("param={}", param);

		ModelAndView mv = new ModelAndView("sign/report");

		Map<String, Object> result = reportService.makeRep(request, param);

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

}
