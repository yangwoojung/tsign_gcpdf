package kr.co.tsoft.sign.controller;

import java.util.Map;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.google.gson.Gson;

import kr.co.tsoft.sign.config.security.CommonUserDetails;
import kr.co.tsoft.sign.service.AttachService;
import kr.co.tsoft.sign.util.SessionUtil;
import kr.co.tsoft.sign.vo.ApiResponse;
import kr.co.tsoft.sign.vo.ApiResponseData;
import kr.co.tsoft.sign.vo.ContractAttachmentDTO;
import kr.co.tsoft.sign.vo.common.CommonResponse;
import kr.co.tsoft.sign.vo.common.Constant;
import kr.co.tsoft.sign.vo.common.ErrorCode;
import lombok.RequiredArgsConstructor;

@Controller
@RequiredArgsConstructor
@RequestMapping("/sign/attach")
public class AttachController {

    private final Logger logger = LoggerFactory.getLogger(AttachController.class);

    private final AttachService attachService;

    @GetMapping
    public String attachPage() {
        logger.info("===== attach page =====");
        return "sign/attach";
    }

    /**
     *  휴대폰 인증 이후 신분증 제출 페이지
     */
    @GetMapping("/id")
    public String attachPageForId(Model model) {
        logger.info("===== attach id page =====");
        model.addAttribute("type", Constant.ATTACHMENT_CD_ID);
        return "sign/attach";
    }

    @GetMapping("/check")
    public String attachPageForCheck(Model model) {
        logger.debug("===== attach check page =====");
        Gson gs = new Gson();

        CommonUserDetails user = SessionUtil.getUser();
        //TODO: 추후 API 수정완료시 제거
//        user.setSocialNo1("910710");
//        user.setSocialNo2("1063131");
//        user.setBankName("국민은행");
//        user.setBankAccountNo("59350201238928");
//        user.setIdType("1");

        model.addAttribute("user", gs.toJson(user));
        return "sign/attachCheck";
    }

    @GetMapping("/attachPop")
    public String attachPop() {
        logger.debug("===== attachPop page =====");
        return "sign/attach/attachPop";
    }

    @PostMapping("/upload")
    @ResponseBody
    public CommonResponse<?> upload(ContractAttachmentDTO input) {
        logger.info("========upload========");
        CommonResponse<?> result = null;

        try {
            result = attachService.uploadAttachFile(input);
        } catch (Exception e) {
            e.printStackTrace();
            return CommonResponse.fail(ErrorCode.COMMON_SYSTEM_ERROR);
        }

        return result;
    }
    
    @GetMapping("/skip")
    @ResponseBody
    public CommonResponse<?> skipAttachment(ContractAttachmentDTO input) {
        return attachService.updateSkipAttachment(input);
    }


    @GetMapping("/find")
    @ResponseBody
    public CommonResponse<?> contractAttachments(ContractAttachmentDTO input) {
        return attachService.getContractAttachmentsToBeUploaded(input);
    }

    @PostMapping("/scrap")
    @ResponseBody
    public ApiResponse<ApiResponseData.Scrap> scrapping(@RequestParam Map<String, Object> param) {
        logger.info(" ##### [ attach/scrap] start scrap #####");
        return attachService.scrapping(param);
    }

    @PostMapping("/submission")
    @ResponseBody
    public CommonResponse<?> submission() {
        logger.info(" ##### [ attach/submission] start submission #####");
        return attachService.submission();
    }

}
