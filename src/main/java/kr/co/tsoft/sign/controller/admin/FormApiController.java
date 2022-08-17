package kr.co.tsoft.sign.controller.admin;

import kr.co.tsoft.sign.service.admin.FormService;
import kr.co.tsoft.sign.vo.admin.FormGridDto;
import kr.co.tsoft.sign.vo.common.GridResponse;
import kr.co.tsoft.sign.vo.common.TotalRowCount;
import lombok.RequiredArgsConstructor;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RestController;

import java.util.List;

@RestController
@RequestMapping("api")
@RequiredArgsConstructor
public class FormApiController {

    private final Logger Logger = LoggerFactory.getLogger(FormApiController.class);
    private final FormService formService;

    @RequestMapping(value = "/forms", method = RequestMethod.POST)
    public GridResponse adminFormLists(FormGridDto searchVO) throws Exception {
        Logger.debug(" === /api/forms");

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

    @RequestMapping(value = "/forms", method = RequestMethod.DELETE)
    public void deleteForm(FormGridDto param) throws Exception {
        Logger.info("DELETE : {}", param);
    }

}
