package kr.co.tsoft.sign.controller;

import kr.co.tsoft.sign.config.security.CommonUserDetails;
import kr.co.tsoft.sign.service.UserLoginService;
import kr.co.tsoft.sign.service.admin.ContrcService;
import kr.co.tsoft.sign.util.SessionUtil;
import kr.co.tsoft.sign.util.StringMaskUtil;
import kr.co.tsoft.sign.vo.ContractDTO;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

@Controller
public class CmiController {

    private final Logger logger = LoggerFactory.getLogger(CmiController.class);

    @Autowired
    ContrcService contrcService;
    
    @Autowired
    UserLoginService userService;

    @Value("${spring.profiles.active}")
    private String active;

    @RequestMapping(value = "/cmi/{contractNo}", method = RequestMethod.GET)
    public String entry(@PathVariable(name = "contractNo") String contractNo, Model model) throws Exception {
    	logger.info("contractNo : {}", contractNo);
        ContractDTO contractInfoInDB = userService.selectContractInfoForVO(contractNo);

        if(null == contractInfoInDB) {
            return "sign/error/401";
        }

        String cell_no_mask = StringMaskUtil.maskPhone(contractInfoInDB.getCellNo());
        contractInfoInDB.setCellNoMask(cell_no_mask);
        
        CommonUserDetails user = CommonUserDetails.builder()
        											.contractNo(contractInfoInDB.getContractNo())
        											.fileSeq(contractInfoInDB.getFileSeq())
        											.userNm(contractInfoInDB.getUserNm())
        											.cellNo(contractInfoInDB.getCellNo())
        											.email(contractInfoInDB.getEmail())
        											.signDueSdate(contractInfoInDB.getSignDueSdate())
        											.signDueEdate(contractInfoInDB.getSignDueEdate())
        											.build();
        SessionUtil.setUser(user);
        
        logger.info("#### INIT SESSION ID : {}", SessionUtil.getSessionId());
        model.addAttribute("user", contractInfoInDB);
        model.addAttribute("profilesActive", active);

        return "sign/cert";
    }

}
