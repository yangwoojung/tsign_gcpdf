package kr.co.tsoft.sign.controller.admin;

import kr.co.tsoft.sign.service.admin.ContrcService;
import kr.co.tsoft.sign.service.admin.FormService;
import kr.co.tsoft.sign.vo.PagingVO;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Controller
public class ContrcController {

    private final Logger Logger = LoggerFactory.getLogger(ContrcController.class);

    @Autowired
    ContrcService contrcService;

    @Autowired
    FormService formService;

    @RequestMapping(value = "/admin/contract/list")
    public ModelAndView adminFormList(@RequestParam Map<String, Object> parameter) throws Exception {
        Logger.debug(" === /admin/contract/list");

        //전체 리스트 조회
        int totalCount = contrcService.countSelectContrcList(parameter);

        int nowPage = 1;
        if (parameter.get("page") != null) {
            nowPage = Integer.parseInt((String) parameter.get("page"));
        }
        PagingVO pagingVO = new PagingVO(totalCount, nowPage);
        parameter.put("pagingVO", pagingVO);

        // 계약 리스트 조회
        List<Map<String, Object>> selectContrcList = contrcService.selectContrcList(parameter);

        ModelAndView mav = new ModelAndView();
        Map<String, Object> resultMap = new HashMap<String, Object>();
        resultMap.put("list", selectContrcList);
        resultMap.put("pagingVO", pagingVO);
        resultMap.put("param", parameter);

        mav.addObject("result", resultMap);

        return mav;
    }

    @RequestMapping(value = "/admin/contract/reg")
    public ModelAndView adminFormReg(@RequestParam Map<String, Object> parameter) throws Exception {
        Logger.debug(" === /admin/contract/reg");
        ModelAndView mav = new ModelAndView("admin/contract/reg");
        Map<String, Object> resultMap = new HashMap<String, Object>();

        return mav;
    }

    @RequestMapping(value = "/admin/contract/reg_insert", method = RequestMethod.POST)
    @ResponseBody
    public HashMap<String, Object> adminContractRegInsert(@RequestParam HashMap<String, Object> parameter
    ) throws Exception {
        Logger.debug(" === /admin/contract/reg_insert");
        HashMap<String, Object> resultMap = new HashMap<String, Object>();

        // 계약저장 => 성공시 : 문자 전송 , 메일 전송
        HashMap<String, Object> result = contrcService.contrcReg(parameter);
        resultMap.putAll(result);

        return resultMap;
    }
}
