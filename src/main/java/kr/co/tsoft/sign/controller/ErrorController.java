package kr.co.tsoft.sign.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
public class ErrorController {

    @RequestMapping("/error/error")
    public String error() {
        return "error/error";
    }
}
