package kr.co.tsoft.sign.controller;


import kr.co.tsoft.sign.config.security.CommonUserDetails;
import kr.co.tsoft.sign.util.SecurityUtil;
import kr.co.tsoft.sign.util.SessionUtil;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import java.util.Map;


@Controller
@RequestMapping("/sign/info")
public class InfoController {

    private final Logger logger = LoggerFactory.getLogger(getClass());

    @GetMapping
    public ModelAndView agree(SecurityUtil su) {
        logger.info("=== sign/info");
        CommonUserDetails detail = SessionUtil.getUser();

        logger.info("#### AGREE DETAIL : {} ", detail);

        ModelAndView mav = new ModelAndView("sign/info");
        
        mav.addObject("contrcNo", detail.getContractNo());
        mav.addObject("userNm", detail.getUserNm());
        mav.addObject("email", detail.getEmail());

        return mav;
    }

}
