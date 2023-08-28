package kr.co.tsoft.sign.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import lombok.RequiredArgsConstructor;

@Controller
@RequiredArgsConstructor
public class GcpdfTestController {

	private final Logger Logger = LoggerFactory.getLogger(GcpdfTestController.class);

	@RequestMapping(value = "/gcpdfList")
    public String gcpdfList(HttpSession se, HttpServletRequest resquest) throws Exception {
		Logger.info("==== gcpdfList ");
                
        return "gcpdfTest/list";
    }
	
	@RequestMapping(value = "/gcpdfViewer_origin")
    public String gcpdfViewer_origin(HttpSession se, HttpServletRequest resquest) throws Exception {
		Logger.info("==== gcpdfViewer_origin ");
                
        return "gcpdfTest/gcpdfViewer_origin";
    }	
	
	@RequestMapping(value = "/gcpdfEditor")
	public String pdfEditor(HttpSession se, HttpServletRequest resquest) throws Exception {
		Logger.info("==== pdfEditor ");
		
		return "gcpdfTest/gcpdfEditor";
	}
	
	@RequestMapping(value = "/gcpdfViewer")
    public String pdfViewer(HttpSession se, HttpServletRequest resquest) throws Exception {
		Logger.info("==== pdfViewer ");
                
        return "gcpdfTest/gcpdfViewer";
    }
	
	@RequestMapping(value = "/gcpdfViewer_result")
    public String gcpdfViewer_result(HttpSession se, HttpServletRequest resquest) throws Exception {
		Logger.info("==== gcpdfViewer_result ");
                
        return "gcpdfTest/gcpdfViewer_result";
    }
	
}
