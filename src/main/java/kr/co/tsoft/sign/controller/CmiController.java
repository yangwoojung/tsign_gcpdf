package kr.co.tsoft.sign.controller;

import kr.co.tsoft.sign.service.admin.ContrcService;
import kr.co.tsoft.sign.util.StringMaskUtil;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import javax.servlet.http.HttpServletRequest;
import java.util.HashMap;

@Controller
public class CmiController {

    private final Logger Logger = LoggerFactory.getLogger(CmiController.class);

    @Autowired
    ContrcService contrcService;

    @Value("${config.upload.dir}")
    private String uploadDir;

    @RequestMapping(value = "/cmi/{contractNo}", method = RequestMethod.GET)
    public String entry(@PathVariable(name = "contractNo", required = true) String contractNo,
                        HttpServletRequest request) throws Exception {

        HashMap<String, Object> paramMap = new HashMap<String, Object>();
        paramMap.put("CONTRC_NO", contractNo);
        // 해당 계약번호에 부합하는 정보 조회
        HashMap<String, Object> selectContrcInfo = contrcService.selectContrcInfo(paramMap);
        request.setAttribute("user", selectContrcInfo);

        return "forward:/sign/pin";
    }

    @RequestMapping(value = "/sign/pin")
    public String signPin(HttpServletRequest req, Model model) throws Exception {

        @SuppressWarnings("unchecked")
        HashMap<String, Object> user = (HashMap<String, Object>) req.getAttribute("user");

        String cell_no_mask = StringMaskUtil.maskPhone((String) user.get("CELL_NO"));
        user.put("CELL_NO_MASK", cell_no_mask);
        model.addAttribute("user", user);

        return "sign/pin";
    }

}
