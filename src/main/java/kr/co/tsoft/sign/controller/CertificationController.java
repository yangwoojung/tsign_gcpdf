package kr.co.tsoft.sign.controller;

import java.util.HashMap;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import kr.co.tsoft.sign.service.CertificationService;
import kr.co.tsoft.sign.vo.CertificationDTO;
import kr.co.tsoft.sign.vo.common.CommonResponse;


@Controller
@RequestMapping("/sign/cert")
public class CertificationController {

    private final Logger logger = LoggerFactory.getLogger(CertificationController.class);

    @Autowired
    private CertificationService certService;

    @Value("${spring.profiles.active}")
    private String active;

    @RequestMapping("/result")
    public String getResultPhoneCert() {
        return "sign/certResult";
    }

    @RequestMapping("/checkCellNumber")
    @ResponseBody
    public CommonResponse checkCellNumber(@RequestBody HashMap<String, Object> paramMap) {
        return certService.checkCellNumber(paramMap);
    }
    
    @RequestMapping("/initPhone")
    @ResponseBody
    public CertificationDTO getInitPhoneCert() {
        return certService.initPhoneCert();
    }

    @RequestMapping("/idseed")
    public ModelAndView getResultPhoneCert(@RequestParam("retInfo") String retInfo) {
    	CertificationDTO cert = certService.getResultPhoneCert(retInfo);

    	ModelAndView mv = new ModelAndView("/sign/certResult");
        mv.addObject("cert", cert);

        return mv;
    }

}
