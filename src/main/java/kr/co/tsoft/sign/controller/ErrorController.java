package kr.co.tsoft.sign.controller;

import javax.servlet.http.HttpServletRequest;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;

@RequestMapping("/sign/error")
@Controller
public class ErrorController {
	
	private final Logger logger = LoggerFactory.getLogger(ErrorController.class);
	
	@RequestMapping(value = "/runExp", method = {RequestMethod.POST, RequestMethod.GET})
	public ModelAndView handleRuntimeExceptionByView(HttpServletRequest request) {
		logger.debug("===== Error Controller Runtime Exception view =====");
		String errMsg = (String) request.getAttribute("errMsg");
		String errTit = (String) request.getAttribute("errTit");
		String errType = (String) request.getAttribute("errType");
		
		logger.debug("errMsg : " + errMsg);
		logger.debug("errTit : " + errTit);
		logger.debug("errType : " + errType);
		
		ModelAndView mav = new ModelAndView("error/5xx");
		mav.addObject("errMsg", errMsg);
		mav.addObject("errTit", errTit);
		mav.addObject("errType", errType);
		return mav;
	}
	
	@RequestMapping(value = "/runExp", consumes = { MediaType.APPLICATION_JSON_UTF8_VALUE,
			MediaType.APPLICATION_JSON_VALUE })
	public ResponseEntity<String> handleRuntimeExceptionByAjax(HttpServletRequest request) {
		logger.debug("===== Error Controller Runtime Exception ajax =====");
		String errMsg = (String) request.getAttribute("errMsg");
		return new ResponseEntity<String>(errMsg, new HttpHeaders(), HttpStatus.INTERNAL_SERVER_ERROR);
	}
	
	@RequestMapping(value = "/bizExp", method = {RequestMethod.POST, RequestMethod.GET})
	public ModelAndView handleBusinessExceptionByView(HttpServletRequest request) {
		logger.debug("===== Error Controller Business Exception view =====");
		String errMsg = (String) request.getAttribute("errMsg");
		ModelAndView mav = new ModelAndView("error/5xx");
		mav.addObject("errMsg", errMsg);
		return mav;
	}
	
	@RequestMapping(value = "/bizExp", consumes = { MediaType.APPLICATION_JSON_UTF8_VALUE,
			MediaType.APPLICATION_JSON_VALUE })
	public ResponseEntity<String> handleBusinessExceptionByAjax(HttpServletRequest request) {
		logger.debug("===== Error Controller Business Exception ajax =====");
		String errMsg = (String) request.getAttribute("errMsg");
		return new ResponseEntity<String>(errMsg, new HttpHeaders(), HttpStatus.SERVICE_UNAVAILABLE);
	}
	
	@RequestMapping("/401")
	public String view401() {
		return "sign/error/401";
	}
	
	@RequestMapping("/404")
	public String view404() {
		return "sign/error/404";
	}
	
}
