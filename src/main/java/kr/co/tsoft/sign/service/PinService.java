package kr.co.tsoft.sign.service;

import com.fasterxml.jackson.core.type.TypeReference;
import kr.co.tsoft.sign.mapper.admin.ContrcMapper;
import kr.co.tsoft.sign.service.admin.ContrcService;
import kr.co.tsoft.sign.util.JsonUtil;
import kr.co.tsoft.sign.util.SendMessage;
import org.apache.commons.lang3.StringUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;

import java.util.HashMap;
import java.util.Map;
import java.util.Random;

@Service
public class PinService {

	private static int pinCnt = 5; //pin재발송 5번 기회
	private final Logger logger = LoggerFactory.getLogger(PinService.class);
	@Value("${spring.profiles.active}")
	private String active;
	@Autowired
	private SendMessage sendMessage;
	@Autowired
	private JsonUtil jsonUtil;
	@Autowired
	private ContrcMapper contrcMapper;
	@Autowired
	private ContrcService contrcService;

	public Map<String, Object> sendPinCode(String contrcNo) {
		Map<String, Object> resultMap = new HashMap<String, Object>();

		HashMap<String, Object> paramMap = new HashMap<String, Object>();
		paramMap.put("CONTRC_NO", contrcNo);
		HashMap<String, Object> selectContrcInfo = contrcService.selectContrcInfo(paramMap);
		if (selectContrcInfo != null) {
			String phoneNo = (String) selectContrcInfo.get("CELL_NO");

			// 총 5번의 기회 
			if (pinCnt == 0) {
				resultMap.put("resultCd", "0003"); // 횟수 초과
				resultMap.put("resultMsg", "PIN 요청 횟수 4회 초과"); // 횟수 초과
				// TODO 계약 정지 처리 
			} else {

				resultMap = sendPinSMS(phoneNo, contrcNo);
				if (resultMap.get("resultCd") != null && "0000".equals((String) resultMap.get("resultCd"))) {
					pinCnt--;
				}
			}
			logger.debug("=== pin요청 횟수" + pinCnt);
		}
		return resultMap;
	}

	public HashMap<String, Object> checkPinCode(String pinCode, String contrcNo) {
		HashMap<String, Object> paramMap = new HashMap<String, Object>();
		paramMap.put("CONTRC_NO", contrcNo);
		HashMap<String, Object> selectContrcInfo = contrcService.selectContrcInfo(paramMap);

		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		//db에 저장된 pin이랑 일치 하는지 
		if (StringUtils.isNotBlank(pinCode)) {
			if (pinCode.equals(selectContrcInfo.get("PIN_NO"))) {
				resultMap.put("resultCd", "0000");

			} else {
				resultMap.put("resultCd", "0001");
			}
		} else {
			resultMap.put("resultCd", "0002");
			resultMap.put("resultMsg", "Pin을 입력하지 않았습니다.");
			logger.error("Parameter 미존재");
		}

		return resultMap;
	}

	private HashMap<String, Object> sendPinSMS(String custPhone, String contrcNo) {
		HashMap<String, Object> resultMap = new HashMap<String, Object>();

		Random rnd = new Random();
		String pin = String.format("%06d", rnd.nextInt(999999));
		logger.debug("===== pin : " + pin);
		try {
			if ("local".equals(active)) {
				resultMap.put("pin", pin);
				resultMap.put("resultCd", "0000");
				//pin업데이트 
				HashMap<String, Object> pinParam = new HashMap<String, Object>();
				pinParam.put("PIN_NO", pin);
				pinParam.put("CONTRC_NO", contrcNo);
				pinParam.put("MOD_ID", custPhone);
				contrcMapper.updateContrcPin(pinParam);

			} else {
				String result = sendMessage.send(custPhone,
						String.format("[인증번호 : %s] 휴대폰(PIN) 인증을 위해 인증번호를 입력해 주세요.", pin), "", "", "PIN인증");
				logger.debug("## result: {}", result);

				Map<String, String> pinMap = jsonUtil.toEntity(result, new TypeReference<HashMap<String, String>>() {
				});
				/**
				 * ObjectMapper mapper = new ObjectMapper();
				 * Map<String, String> pinMap = mapper.readValue(result, new TypeReference<Map<String, String>>(){});
				 **/

				if (!"ok".equals(pinMap.get("result"))) {
					logger.error("Pin 발송 실패 : " + result);
					//이력 1
//					historyService.insertHistory("Pin 발송 실패");
					resultMap.put("resultCd", "0001");
					resultMap.put("result", pinMap);
				} else {
					//이력 1
//					historyService.insertHistory("Pin 발송 성공");
					resultMap.put("pin", pin);
					resultMap.put("result", pinMap);
					resultMap.put("resultCd", "0000");
					//pin업데이트 
					HashMap<String, Object> pinParam = new HashMap<String, Object>();
					pinParam.put("PIN_NO", pin);
					pinParam.put("CELL_NO", custPhone);
					pinParam.put("MOD_ID", custPhone);
					contrcMapper.updateContrcPin(pinParam);
				}
			}
		} catch (Exception e) {
			logger.error(e.getMessage());
			resultMap.put("resultCd", "0002");
		}
		return resultMap;
	}
}
