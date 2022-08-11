package kr.co.tsoft.sign.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

@Controller
@RequestMapping("/sign/done")
public class DoneController {
	
	@RequestMapping(method = {RequestMethod.POST, RequestMethod.GET})
	public String agreePage() {
		return "sign/done/done";
	}
	
}