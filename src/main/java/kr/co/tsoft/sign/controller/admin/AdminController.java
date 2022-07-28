package kr.co.tsoft.sign.controller.admin;

import kr.co.tsoft.sign.controller.TestController;
import kr.co.tsoft.sign.util.SecurityUtil;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

@Controller
public class AdminController {

    private final Logger logger = LoggerFactory.getLogger(TestController.class);

    @RequestMapping(value = "/admin/login")
    public String adminLogin(HttpSession se, HttpServletRequest resquest) throws Exception {
        logger.info("==== 로그인 전 ");

        return "admin/login";
    }

    @RequestMapping(value = "/admin/main")
    public String adminMain(HttpSession se, HttpServletRequest resquest, HttpSession session, SecurityUtil su) throws Exception {
        logger.info("==== 로그인 성공후 ");

        return "admin/main";
    }

}
