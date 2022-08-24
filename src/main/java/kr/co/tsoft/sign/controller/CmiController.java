package kr.co.tsoft.sign.controller;

import kr.co.tsoft.sign.config.security.CommonUserDetails;
import kr.co.tsoft.sign.service.UserLoginService;
import kr.co.tsoft.sign.service.admin.ContrcService;
import kr.co.tsoft.sign.util.SessionUtil;
import kr.co.tsoft.sign.util.StringMaskUtil;
import kr.co.tsoft.sign.vo.ContractVO;
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
    public String entry(@PathVariable(name = "contractNo", required = true) String contractNo, Model model) throws Exception {
    	logger.info("contractNo : {}", contractNo);
        //vo 테스트
        ContractVO contrcVO = userService.selectContractInfoForVO(contractNo);

        String cell_no_mask = StringMaskUtil.maskPhone(contrcVO.getCellNo());
        contrcVO.setCellNoMask(cell_no_mask);
        
        logger.info("contrcVO : {}", contrcVO);
        
        CommonUserDetails user = CommonUserDetails.builder()
        											.contractNo(contrcVO.getContractNo())
        											.fileSeq(contrcVO.getFileSeq())
        											.userNm(contrcVO.getUserNm())
        											.cellNo(contrcVO.getCellNo())
        											.email(contrcVO.getEmail())
        											.signDueSdate(contrcVO.getSignDueSdate())
        											.signDueEdate(contrcVO.getSignDueEdate())
        											.build();
        SessionUtil.setUser(user);
        
        logger.info("#### INIT SESSION ID : {}", SessionUtil.getSessionId());
        model.addAttribute("user", contrcVO);
        model.addAttribute("profilesActive", active);

        return "sign/cert";
    }

}
