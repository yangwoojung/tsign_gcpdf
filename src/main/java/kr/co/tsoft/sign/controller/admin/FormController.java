package kr.co.tsoft.sign.controller.admin;

import kr.co.tsoft.sign.service.admin.FormService;
import kr.co.tsoft.sign.vo.PagingVO;
import kr.co.tsoft.sign.vo.admin.FormGridDto;
import kr.co.tsoft.sign.vo.common.CommonResponse;
import kr.co.tsoft.sign.vo.common.GridResponse;
import kr.co.tsoft.sign.vo.common.TotalRowCount;
import lombok.RequiredArgsConstructor;
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
@RequestMapping("/admin/forms")
@RequiredArgsConstructor
public class FormController {

    private final Logger Logger = LoggerFactory.getLogger(FormController.class);

    private final FormService formService;

    @RequestMapping
    public String formPage() {
        Logger.debug(" === /admin/form");
        return "admin/form/list";
    }

    @RequestMapping(value = "/list", method = RequestMethod.POST)
    @ResponseBody
    public GridResponse formList(@RequestBody FormGridDto form) {
        Logger.debug(" === /api/forms : {}", form);
        return formService.getFormList(form);
    }

    @RequestMapping(method = RequestMethod.DELETE)
    @ResponseBody
    public CommonResponse deleteForm(@RequestBody String param) {
        Logger.info("DELETE : {}", param);
        formService.deleteForm(param);
        return CommonResponse.success();
    }

    @RequestMapping(method = RequestMethod.POST)
    @ResponseBody
    public CommonResponse insertForm(@RequestBody FormGridDto form) throws Exception {
        Logger.info("DELETE : {}", form);
        FormGridDto savedForm = formService.insertForm(form);
        return CommonResponse.success(savedForm);
    }

}
