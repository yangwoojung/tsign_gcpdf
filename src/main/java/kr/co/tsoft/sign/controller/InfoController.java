package kr.co.tsoft.sign.controller;


import kr.co.tsoft.sign.config.security.CommonUserDetails;
import kr.co.tsoft.sign.util.SessionUtil;
import kr.co.tsoft.sign.vo.InfoDTO;
import kr.co.tsoft.sign.vo.InfoDtoMapper;
import kr.co.tsoft.sign.vo.common.CommonResponse;
import lombok.RequiredArgsConstructor;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;


@Controller
@RequiredArgsConstructor
@RequestMapping("/sign/info")
public class InfoController {

    private final Logger logger = LoggerFactory.getLogger(getClass());
    private final InfoDtoMapper infoDtoMapper;

    @GetMapping
    public String info(Model model) {
        logger.info("=== sign/info");
        CommonUserDetails user = SessionUtil.getUser();

        model.addAttribute("user", user);
        return "sign/info";
    }

    @PostMapping("/update")
    @ResponseBody
    public CommonResponse<?> updateInfo(InfoDTO infoDTO) {
        logger.info("=== sign/ update info");

        infoDtoMapper.updateUserDetails(SessionUtil.getUser(), infoDTO);

        CommonUserDetails user = SessionUtil.getUser();
        //TODO: 추후 API 수정완료시 제거
        user.setSocialNo1("910710");
        user.setSocialNo2("1063131");
        user.setBankName("국민은행");
        user.setBankAccountNo("59350201238928");
        user.setAddress(infoDTO.getAddress());
        user.setSignCanvasDataUrl(infoDTO.getSignCanvasDataUrl());

        return CommonResponse.success();
    }

}
