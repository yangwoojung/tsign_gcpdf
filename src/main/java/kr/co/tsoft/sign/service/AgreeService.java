package kr.co.tsoft.sign.service;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;

import java.util.HashMap;
import java.util.Map;


@Service("agreeService")
public class AgreeService {

    private final Logger logger = LoggerFactory.getLogger(getClass());
//	@Autowired
//	private UserMapper userMapper;

    public Map<String, Object> updateAgreeInfo(HashMap<String, String> paramMap) throws Exception {
        Map<String, Object> resultMap = new HashMap<String, Object>();

//		if ("Y".equals(paramMap.get("agreeM1"))) {
//			historyService.insertHistory("[필수] 동의항목1 동의");
//		}
//		paramMap.put("contrcNo", (String) SessionUtil.getUser().get("contrcNo"));
//
//		String no1 = paramMap.get("inResidentNo1");
//		String no2 = paramMap.get("inResidentNo2");
//		paramMap.put("inResidentNo", no1 + no2);
//
//		int result = userMapper.updateContractInfo(paramMap);
//		if (result != 1) {
//			resultMap.put("result", "false");
//			resultMap.put("resMsg", "ajax오류");
//		} else {
//			resultMap.put("result", "success");
//			resultMap.put("resMsg", "성공");
//		}
        return resultMap;
    }

}
