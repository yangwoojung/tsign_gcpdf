package kr.co.tsoft.sign.controller;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;

import kr.co.tsoft.sign.service.AttachService;

@Controller
@RequestMapping("/sign/attach")
public class AttachController {
	
	private final Logger logger = LoggerFactory.getLogger(AttachController.class);
	
	@Autowired
	private AttachService attachService;
	
	@RequestMapping(method = {RequestMethod.POST, RequestMethod.GET})
	public String attachPage() {
		logger.info("===== attach page =====");
		return "sign/attach/attach";
	}
	
	@RequestMapping(value = "/attachPop", method = {RequestMethod.POST, RequestMethod.GET})
	public ModelAndView attachPop(HttpServletRequest request) {
		logger.debug("===== attachPop Start =====");
		ModelAndView mv = new ModelAndView();
		mv.setViewName("sign/attach/attachPop");
		
		//TODO : db에서 구비서류 리스트 가져온 다음 화면에 뿌려주기 (param : 계약번호)
		List<Map<String, Object>> docList = attachService.docList();

		mv.addObject("docList", docList);
		
		logger.debug("===== attachPop End =====");
		return mv;
	}
	
//	@PostMapping("/upload")
//	public String upload() {
//		logger.info("========upload========");
//		return null;
//	}
	
}
