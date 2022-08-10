package kr.co.tsoft.sign.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

@Controller
public class DoneController {
	
	@GetMapping("/done")
	public String agreePage() {
		return "/done/done";
	}
	
}