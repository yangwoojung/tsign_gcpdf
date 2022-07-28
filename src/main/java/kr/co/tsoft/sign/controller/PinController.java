package kr.co.tsoft.sign.controller;

import kr.co.tsoft.sign.service.PinService;
import kr.co.tsoft.sign.service.admin.ContrcService;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpSession;
import java.util.HashMap;
import java.util.Map;

@Controller
@RequestMapping("/sign/pin")
public class PinController {

	private static final int HashMap = 0;

	private static final int String = 0;

	private final Logger Logger = LoggerFactory.getLogger(PinController.class);

	@Autowired
	private PinService pinService;

	@Value("${spring.profiles.active}")
	private String active;

	@Autowired
	private ContrcService contrcService;

	@RequestMapping("/pinPop")
	public ModelAndView viewPinPop() {

		ModelAndView mv = new ModelAndView("/sign/pinPop");
		mv.addObject("profilesActive", active);
		return mv;
	}

	@RequestMapping("/send")
	@ResponseBody
	public Map<String, Object> sendPinCode(@RequestBody HashMap<String, Object> paramMap) {
		Logger.info(" ==== sign/pin/send");
		String contrcNo = (String) paramMap.get("contrcNo");
		Map<String, Object> resultMap = pinService.sendPinCode(contrcNo);

		return resultMap;
	}

	@RequestMapping("/phone")
	@ResponseBody
	public HashMap<String, Object> phonePinCode(@RequestBody HashMap<String, Object> paramMap, HttpSession session) {
		HashMap<String, Object> resultMap = new HashMap<String, Object>();

		//계약번호에 해당하는 핸드폰 번호 일치 하는지 확인 로직 		
		HashMap<String, Object> selectContrcInfo = contrcService.selectContrcInfo(paramMap);
//		Logger.debug("=== result {}", selectContrcInfo);

		//핸드폰 번호 뒤4자리 확인
		String cellNoLast = (String) paramMap.get("cellNoLast");
		Logger.debug("cellNoLast :" + cellNoLast);
		String cellNo = (String) selectContrcInfo.get("CELL_NO");
		Logger.debug("cellNo :" + cellNo);
		Logger.debug("cellNo.substring(7) :" + cellNo.substring(7));
		if (cellNo.substring(7).equals(cellNoLast)) {
			resultMap.put("result", "success");
		} else {
			resultMap.put("result", "fail");
		}
		return resultMap;
	}

	@RequestMapping("/check")
	@ResponseBody
	public HashMap<String, Object> checkPinCode(@RequestBody HashMap<String, Object> paramMap, HttpSession session) {
		String pinCode = (String) paramMap.get("pinCode");
		String contrcNo = (String) paramMap.get("contrcNo");

		HashMap<String, Object> resultMap = pinService.checkPinCode(pinCode, contrcNo);
		return resultMap;
	}

}
