package kr.co.tsoft.sign.controller;

import kr.co.tsoft.sign.service.AttachService;
import kr.co.tsoft.sign.vo.ApiResponse;
import kr.co.tsoft.sign.vo.ApiResponseData;
import kr.co.tsoft.sign.vo.AttachDTO;
import kr.co.tsoft.sign.vo.ContractAttachmentDTO;
import kr.co.tsoft.sign.vo.common.CommonResponse;
import kr.co.tsoft.sign.vo.common.ErrorCode;
import lombok.RequiredArgsConstructor;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;
import java.util.List;
import java.util.Map;

@Controller
@RequiredArgsConstructor
@RequestMapping("/sign/attach")
public class AttachController {

    private final Logger logger = LoggerFactory.getLogger(AttachController.class);

    private final AttachService attachService;

    @RequestMapping(method = {RequestMethod.POST, RequestMethod.GET})
    public String attachPage(Model model) {
        logger.info("===== attach page =====");
        //TODO : db에서 구비서류 리스트 가져온 다음 화면에 뿌려주기 (param : 계약번호)
        List<Map<String, Object>> docList = attachService.docList();
        model.addAttribute("docList", docList);
        return "sign/attach/attach";
    }

    @RequestMapping(value = "/attachPop", method = {RequestMethod.POST, RequestMethod.GET})
    public ModelAndView attachPop(HttpServletRequest request) {
        logger.debug("===== attachPop Start =====");
        ModelAndView mv = new ModelAndView();
        mv.setViewName("sign/attach/attachPop");

        //TODO : db에서 구비서류 리스트 가져온 다음 화면에 뿌려주기 (param : 계약번호)
        List<Map<String, Object>> docList = attachService.docList();
        mv.addObject("docList", docList);

        logger.debug("===== attachPop End =====");
        return mv;
    }

    @PostMapping("/upload")
    @ResponseBody
    public CommonResponse<?> upload(ContractAttachmentDTO contractAttachmentDTO) {
        logger.info("========upload========");
        CommonResponse<?> result = null;

        try {
            result = attachService.uploadAttachFile(contractAttachmentDTO);
        } catch (Exception e) {
            e.printStackTrace();
            return CommonResponse.fail(ErrorCode.COMMON_SYSTEM_ERROR);
        }

        return result;
    }

    @GetMapping("/list")
    @ResponseBody
    public CommonResponse<?> contractAttachments() {
        return attachService.getContractAttachmentsToBeUploaded();
    }

    @PostMapping("/scrap")
    @ResponseBody
    public ApiResponse<ApiResponseData.Scrap> scrapping(@RequestParam Map<String, Object> param) {
        logger.info(" ##### [ attach/scrap] start scrap #####");
        return attachService.scrapping(param);
    }

    @PostMapping("/submission")
    @ResponseBody
    public Map<String, Object> submission() {
        logger.info(" ##### [ attach/submission] start submission #####");
        return attachService.submission();
    }

}
