package kr.co.tsoft.sign.controller;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import kr.co.tsoft.sign.config.security.CommonUserDetails;
import kr.co.tsoft.sign.service.UserLoginService;
import kr.co.tsoft.sign.service.admin.ContrcService;
import kr.co.tsoft.sign.util.SessionUtil;
import kr.co.tsoft.sign.util.StringMaskUtil;
import kr.co.tsoft.sign.vo.ContrcMgmtVO;

@Controller
public class CmiController {

    private final Logger logger = LoggerFactory.getLogger(CmiController.class);

    @Autowired
    ContrcService contrcService;
    
    @Autowired
    UserLoginService userService;
    
    @Value("${spring.profiles.active}")
    private String active;

//    @RequestMapping(value = "/cmi/{contractNo}", method = RequestMethod.GET)
//    public String entry(@PathVariable(name = "contractNo", required = true) String contractNo, Model model) throws Exception {
//
//        HashMap<String, Object> paramMap = new HashMap<String, Object>();
//        paramMap.put("CONTRC_NO", contractNo);
//
//        // 해당 계약번호에 부합하는 정보 조회
//        HashMap<String, Object> selectContrcInfo = contrcService.selectContrcInfo(paramMap);
//
//        String cell_no_mask = StringMaskUtil.maskPhone((String) selectContrcInfo.get("CELL_NO"));
//        selectContrcInfo.put("CELL_NO_MASK", cell_no_mask);
//
//        SessionUtil.setUser(selectContrcInfo);
//
//        logger.info("#### INIT SESSION ID : {}", SessionUtil.getSessionId());
//        model.addAttribute("user", selectContrcInfo);
//        model.addAttribute("profilesActive", active);
//
//        return "sign/cert";
//    }
    
    @RequestMapping(value = "/cmi/{contractNo}", method = RequestMethod.GET)
    public String entry(@PathVariable(name = "contractNo", required = true) String contractNo, Model model) throws Exception {
        //vo 테스트
        ContrcMgmtVO contrcVO = userService.selectContractInfoForVO(contractNo);
        
        logger.info("contrcVO : {}", contrcVO);

        String cell_no_mask = StringMaskUtil.maskPhone(contrcVO.getCellNo());
        contrcVO.setCellNoMask(cell_no_mask);
        
        CommonUserDetails user = new CommonUserDetails();
        //TODO: contrcVO에 있는 user정보 CommonUserDetails에 옮겨담기
        	user.setContrcNo(contrcVO.getContrcNo());
        	user.setFileSeq(contrcVO.getFileSeq());
        	user.setUserNm(contrcVO.getUserNm());
        	user.setCellNo(contrcVO.getCellNo());
        	user.setEmail(contrcVO.getEmail());
        	user.setSignDueSdate(contrcVO.getSignDueSdate());
        	user.setSignDueEdate(contrcVO.getSignDueEdate());

        SessionUtil.setUser(user);
        
        logger.info("#### INIT SESSION ID : {}", SessionUtil.getSessionId());
        model.addAttribute("user", contrcVO);
        model.addAttribute("profilesActive", active);

        return "sign/cert";
    }

//    @RequestMapping(value = "/sign/pin")
//    public String signPin(HttpServletRequest req, Model model) throws Exception {
//
//        @SuppressWarnings("unchecked")
//        HashMap<String, Object> user = (HashMap<String, Object>) req.getAttribute("user");
//
//        String cell_no_mask = StringMaskUtil.maskPhone((String) user.get("CELL_NO"));
//        user.put("CELL_NO_MASK", cell_no_mask);
//        model.addAttribute("user", user);
//
//        return "sign/pin";
//    }

}
