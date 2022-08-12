package kr.co.tsoft.sign.controller.admin;

import kr.co.tsoft.sign.service.admin.FormService;
import kr.co.tsoft.sign.vo.PagingVO;
import kr.co.tsoft.sign.vo.admin.FormGridDto;
import kr.co.tsoft.sign.vo.common.GridResponse;
import kr.co.tsoft.sign.vo.common.TotalRowCount;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpSession;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Controller
public class FormController {

    private final Logger Logger = LoggerFactory.getLogger(FormController.class);

    @Autowired
    FormService formService;

    @RequestMapping(value = "/admin/form/list")
    public ModelAndView adminFormList() throws Exception {
        Logger.debug(" === /admin/form/list");
        return new ModelAndView();
    }

    @RequestMapping(value = "/admin/form/lists")
    @ResponseBody
    public GridResponse adminFormLists(@RequestBody FormGridDto searchVO) throws Exception {
        Logger.debug(" === /admin/form/lists");

        //전체 리스트 조회
        TotalRowCount count = formService.countSelectFormList(searchVO);
        // 서식 리스트 조회
        List<FormGridDto> selectFromList = formService.selectFormList(searchVO);
        GridResponse response = new GridResponse();
        response.setData(selectFromList);
        response.setDraw(searchVO.getDraw());
        response.setRecordsTotal(count.getRowCount());
        response.setRecordsFiltered(count.getRowCount());

        return response;
    }

    /*@RequestMapping(value = "/admin/form/list")
    public ModelAndView adminFormList(@RequestParam Map<String, Object> parameter, HttpSession session) throws Exception {
        Logger.debug(" === /admin/form/list");

        //전체 리스트 조회
        int totalCount = formService.countSelectFormList(parameter);

        int nowPage = 1;
        if (parameter.get("page") != null) {
            nowPage = Integer.parseInt((String) parameter.get("page"));
        }
        PagingVO pagingVO = new PagingVO(totalCount, nowPage);
        parameter.put("pagingVO", pagingVO);

        // 서식 리스트 조회
        parameter.put("fileTp", "100");
        List<Map<String, Object>> selectFromList = formService.selectFormList(parameter);

        ModelAndView mav = new ModelAndView();
        Map<String, Object> resultMap = new HashMap<String, Object>();
        resultMap.put("list", selectFromList);
        resultMap.put("pagingVO", pagingVO);
        resultMap.put("param", parameter);
        mav.addObject("result", resultMap);

        return mav;
    }*/

    @RequestMapping(value = "/admin/form/ajaxPopList", method = RequestMethod.POST)
    @ResponseBody
    public HashMap<String, Object> formList(@RequestParam Map<String, Object> parameter) {
        Logger.debug(" === /admin/form/ajaxPopList");

        //전체 리스트 조회
//        int totalCount = formService.countSelectFormList(parameter);

        int nowPage = 1;
        if (parameter.get("page") != null) {
            nowPage = Integer.parseInt((String) parameter.get("page"));
        }
        PagingVO pagingVO = new PagingVO(0, nowPage);
        parameter.put("pagingVO", pagingVO);

        // 서식 리스트 조회
//        List<Map<String, Object>> selectFromList = formService.selectFormList(parameter);

//		parameter.put("tableNm", "form_mgmt");
//		parameter.put("pageVo", pageVo);
        HashMap<String, Object> resultMap = new HashMap<String, Object>();
        resultMap.put("list", null);
        resultMap.put("pagingVO", pagingVO);
        resultMap.put("param", parameter);

        return resultMap;
    }

    @RequestMapping(value = "/admin/form/reg")
    public ModelAndView adminFormReg() throws Exception {
        Logger.debug(" === /admin/form/reg");
        ModelAndView mav = new ModelAndView("admin/form/reg");
        Map<String, Object> resultMap = new HashMap<String, Object>();
        return mav;
    }

    @RequestMapping(value = "/admin/form/reg_insert", method = RequestMethod.POST)
    @ResponseBody
    public HashMap<String, Object> uploadFile(@RequestPart(name = "file") List<MultipartFile> file
            , @RequestParam(name = "formNm") String formNm
            , HttpSession se) throws Exception {
        Logger.debug(" === /admin/form/reg_insert");
        HashMap<String, Object> resultMap = new HashMap<String, Object>();
        // 서식등록
        HashMap<String, Object> result = formService.formRegInsert(file, formNm);
        resultMap.putAll(result);

        return resultMap;
    }
}
