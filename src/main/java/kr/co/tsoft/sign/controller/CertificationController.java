package kr.co.tsoft.sign.controller;

import kr.co.tsoft.sign.service.CertificationService;
import kr.co.tsoft.sign.util.SessionUtil;
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

import java.util.HashMap;
import java.util.Map;


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
    public HashMap<String, String> checkCellNumber(@RequestBody HashMap<String, Object> paramMap) {
        return certService.checkCellNumber(paramMap);
    }

    @RequestMapping("/initPhone")
    @ResponseBody
    public HashMap<String, String> getInitPhoneCert() {
        return certService.initPhoneCert();
    }

	/*
	 * 계좌인증 
	@RequestMapping("/initAcc")
	@ResponseBody
	public HashMap<String, String> getInitAccountCert() {
		SecurityUtil su = new SecurityUtil();
		CommonUserDetails user = su.getSignUserDetails();
		if (user == null) {
			logger.error("계좌인증 Session 정보 미존재");
			throw new RuntimeException("계좌인증 Session 정보 미존재");
		}
		HashMap<String, String> paramMap = new HashMap<String, String>();
		paramMap.put("userName", user.getUserNm());
		paramMap.put("accNo", user.getInAccountNo());
		HashMap<String, String> accMap;
		try {
			String callbackUrl = "/cert/acseed";
			accMap = certService.initAccCert(paramMap, callbackUrl);
		} catch (Exception e) {
			logger.error("계좌인증 초기화 실패 : " + e.getMessage());
			throw new RuntimeException("계좌인증 초기화 실패");
		}
		return accMap;
	}*/

    @RequestMapping("/idseed")
    public ModelAndView getResultPhoneCert(@RequestParam("retInfo") String retInfo) {
        ModelAndView mv = new ModelAndView("/sign/certResult");
        Map<String, String> resultMap = new HashMap<String, String>();

        Map<String, Object> user = SessionUtil.getUser();

//        if ("local".equals(active)) {
//            SimpleDateFormat dateFormat = new SimpleDateFormat("yyyyMMddHHmmss");
//            String systemDTM = dateFormat.format(System.currentTimeMillis());
//
//            resultMap.put("type", "idseed");
//            resultMap.put("status", "0000");
//            resultMap.put("cellNo", (String) user.get("CELL_NO"));
//
//            resultMap.put("certDate", systemDTM);
//            resultMap.put("ci", "CI");
//            resultMap.put("di", "DI");
//        } else {
            resultMap = certService.getResultPhoneCert(retInfo);
//        }

//		if(resultMap != null && resultMap.get("status") != null && "0000".equals(resultMap.get("status"))) {
//			if(user != null) {
//				user.setCertPhoneNo(resultMap.get("cellNo"));
//				user.setCertFinDt(resultMap.get("certDate"));
//				user.setPhoneCi(resultMap.get("ci"));
//				user.setPhoneDi(resultMap.get("di"));
//			}
//		}

        mv.addObject("type", resultMap.get("type"));
        mv.addObject("status", resultMap.get("status"));

        return mv;
    }
	/*
	@RequestMapping("/acseed")
	public ModelAndView getResultAccCert(@RequestParam("ret_info") String retInfo) {
		ModelAndView mv = new ModelAndView("/cert/result");
		try {
			Map<String, String> resultMap = new HashMap<String, String>();
			SecurityUtil su = new SecurityUtil();
			CommonUserDetails user = su.getSignUserDetails();

			if ("local".equals(active)) {
				SimpleDateFormat dateFormat = new SimpleDateFormat("yyyyMMddHHmmss");
				String systemDTM = dateFormat.format(System.currentTimeMillis());

				resultMap.put("type", "idseed");
				resultMap.put("status", "0000");
				resultMap.put("accName", "계좌인증 예금주명");
				resultMap.put("bankName", "계좌인증 은행명");
				resultMap.put("accNo", "계좌인증 계좌번호");
				resultMap.put("certDate", systemDTM);
			} else {
				resultMap = certService.getResultAccCert(retInfo);
			}

//			if(resultMap != null && resultMap.get("status") != null && "0000".equals(resultMap.get("status"))) {
//				if(user != null) {
//					user.setAccCertName(resultMap.get("accName"));
//					user.setAccCertBank(resultMap.get("bankName"));
//					user.setAccCertAcc(resultMap.get("accNo"));
//					user.setAccCertFinTm(resultMap.get("certDate"));
//				}
//			}
			mv.addObject("type", resultMap.get("type"));
			mv.addObject("status", resultMap.get("status"));
		} catch (Exception e) {
			logger.error("계좌인증 결과 응답 Error");
			mv.addObject("status", "0001");
		}
		return mv;
	}*/

}
