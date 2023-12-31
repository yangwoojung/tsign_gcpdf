package kr.co.tsoft.sign.controller.admin;

import java.util.HashMap;
import java.util.List;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import kr.co.tsoft.sign.service.admin.AttachmentService;
import kr.co.tsoft.sign.service.admin.ContrcService;
import kr.co.tsoft.sign.service.admin.FormService;
import kr.co.tsoft.sign.vo.admin.ContractGridDTO;
import kr.co.tsoft.sign.vo.common.GridResponse;
import kr.co.tsoft.sign.vo.common.TotalRowCount;

@Controller
public class ContrcController {

    private final Logger Logger = LoggerFactory.getLogger(ContrcController.class);

    @Autowired
    ContrcService contrcService;

    @Autowired
    FormService formService;
    
    @Autowired
    AttachmentService attachmentService;

    @RequestMapping(value = "/admin/contract/list")
    public ModelAndView adminFormList() throws Exception {
        Logger.debug(" === /admin/contract/list");
        return new ModelAndView();
    }

    @RequestMapping(value = "/admin/contract/lists")
    @ResponseBody
    public GridResponse adminFormLists(@RequestBody ContractGridDTO searchVO) throws Exception {
        Logger.debug(" === /admin/contract/lists");

        //전체 리스트 조회
        TotalRowCount count = contrcService.countSelectContrcList(searchVO);
        // 서식 리스트 조회
        List<ContractGridDTO> selectFromList = contrcService.selectContrcList(searchVO);

        GridResponse response = new GridResponse();
        response.setData(selectFromList);
        response.setDraw(searchVO.getDraw());
        response.setRecordsTotal(count.getRowCount());
        response.setRecordsFiltered(count.getRowCount());

        return response;
    }

    @RequestMapping(value = "/admin/contract/reg")
    public ModelAndView adminFormReg(@RequestParam(value="contrcSeq",required=false) String contractSeq) throws Exception {
        Logger.debug(" === /admin/contract/reg");
        ModelAndView mav = new ModelAndView("admin/contract/reg");

        if (contractSeq != null) {
        	Logger.debug(" contrcSeq : "+ contractSeq);
            
            ContractGridDTO dto = new ContractGridDTO();
            dto.setContractSeq(Integer.parseInt(contractSeq));
            //수정
            if (dto.getContractSeq() != null) {
            	//해당 계약번호 조회 하여 리턴 
            	ContractGridDTO resultContract = contrcService.selectContrcInfo2(dto);
            	Logger.debug(resultContract.toString());
            	mav.addObject("resultContract",resultContract);
            }
        }
        //구비서류 리스트 조회            
        mav.addObject("attachmentList",attachmentService.selectAttachmentList());

        return mav;
    }

    @RequestMapping(value = "/admin/contract/reg_insert", method = RequestMethod.POST)
    @ResponseBody
    public HashMap<String, Object> adminContractRegInsert(
    		@RequestBody ContractGridDTO paramVO) throws Exception {
        Logger.debug(" === /admin/contract/reg_insert");
        HashMap<String, Object> resultMap = new HashMap<String, Object>();

        // 계약등록 => 성공시 : 문자 전송 , 메일 전송
        HashMap<String, Object> result = contrcService.contrcReg(paramVO);
        resultMap.putAll(result);

        return resultMap;
    }
    
    @RequestMapping(value = "/admin/contract/reg_update", method = RequestMethod.POST)
    @ResponseBody
    public HashMap<String, Object> adminContractRegUpdate(
    		@RequestBody ContractGridDTO paramVO) throws Exception {
        Logger.debug(" === /admin/contract/reg_update");
        HashMap<String, Object> resultMap = new HashMap<String, Object>();

        // 계약 수정
        HashMap<String, Object> result = contrcService.contrcRegUpdate(paramVO);
        resultMap.putAll(result);

        return resultMap;
    }
}
