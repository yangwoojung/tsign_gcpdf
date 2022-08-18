package kr.co.tsoft.sign.controller.admin;

import kr.co.tsoft.sign.service.admin.FormService;
import kr.co.tsoft.sign.vo.admin.FormGridDto;
import kr.co.tsoft.sign.vo.common.CommonResponse;
import kr.co.tsoft.sign.vo.common.GridResponse;
import lombok.RequiredArgsConstructor;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.http.MediaType;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

@Controller
@RequestMapping("/admin/forms")
@RequiredArgsConstructor
public class FormController {

    private final Logger Logger = LoggerFactory.getLogger(FormController.class);

    private final FormService formService;

    @RequestMapping(value = "/page")
    public String formPage() {
        Logger.debug(" === /admin/form");
        return "admin/form/list";
    }

    @RequestMapping(method = RequestMethod.GET)
    @ResponseBody
    public GridResponse formList(FormGridDto form) {
        Logger.debug(" === /api/forms : {}", form);
        return formService.getFormList(form);
    }

    @RequestMapping(method = RequestMethod.POST, consumes = { MediaType.MULTIPART_FORM_DATA_VALUE})
    @ResponseBody
    public CommonResponse insertForm(FormGridDto form) throws Exception {
        Logger.info("INSERT : {}", form);
        formService.insertForm(form);
        return CommonResponse.success();
    }

    @RequestMapping(method = RequestMethod.DELETE)
    @ResponseBody
    public CommonResponse deleteForm(@RequestBody String param) {
        Logger.info("DELETE : {}", param);
        formService.deleteForm(param);
        return CommonResponse.success();
    }

}
