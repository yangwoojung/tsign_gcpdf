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
@RequestMapping("/sign/agree")
public class AgreeController {

    private final Logger logger = LoggerFactory.getLogger(getClass());

    @GetMapping
    public ModelAndView agree(SecurityUtil su) {
        logger.info("=== sign/agree");
        CommonUserDetails detail = su.getSignUserDetails();
        CommonUserDetails user = SessionUtil.getUser();

        logger.info("#### AGREE DETAIL : {} ", detail);
        logger.info("#### AGREE USER : {} ", user);

        ModelAndView mav = new ModelAndView("sign/agree");
        mav.addObject("contrcNo", detail.getContractNo());
        mav.addObject("userNm", detail.getUserNm());
        mav.addObject("email", detail.getEmail());

        return mav;
    }

    @RequestMapping("/agreePop1")
    public ModelAndView agreePop1() {
        logger.info("=== sign/agreePop1");
        ModelAndView mav = new ModelAndView("sign/agreePop1");
        return mav;
    }

}
