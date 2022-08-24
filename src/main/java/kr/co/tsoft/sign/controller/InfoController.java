package kr.co.tsoft.sign.controller;


import kr.co.tsoft.sign.config.security.CommonUserDetails;
import kr.co.tsoft.sign.util.SessionUtil;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;


@Controller
@RequestMapping("/sign/info")
public class InfoController {

    private final Logger logger = LoggerFactory.getLogger(getClass());

    @GetMapping
    public String info(Model model) {
        logger.info("=== sign/info");
        CommonUserDetails user = SessionUtil.getUser();

        model.addAttribute("user", user);
        return "sign/info";
    }

}
