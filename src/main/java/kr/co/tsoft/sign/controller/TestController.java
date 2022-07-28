package kr.co.tsoft.sign.controller;

import kr.co.tsoft.sign.config.security.CommonUserDetails;
import kr.co.tsoft.sign.util.MultipartFileHandler;
import kr.co.tsoft.sign.util.SecurityUtil;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

import java.util.Date;
import java.util.HashMap;
import java.util.List;

@Controller
public class TestController {

	private final Logger Logger = LoggerFactory.getLogger(TestController.class);

	@Autowired
	MultipartFileHandler multipartFileHandler;
	@Autowired
	SecurityUtil securityUtil;

	@RequestMapping(value = "/test", method = RequestMethod.GET)
	@ResponseBody
	public HashMap<String, Object> test() throws Exception {
		HashMap<String, Object> resultMap = new HashMap<String, Object>();

		resultMap.put("URL", "/test");
		resultMap.put("msg", "테스트");

		return resultMap;
	}

	@RequestMapping(value = "/upload-file", method = RequestMethod.POST)
	@ResponseBody
	public HashMap<String, Object> uploadFile(@RequestPart(name = "file") List<MultipartFile> files
			, @RequestParam(name = "col1") String col1
			, @RequestParam(name = "col2") String col2
			, @RequestParam(name = "col3") String col3) throws Exception {

		HashMap<String, Object> resultMap = new HashMap<String, Object>();

		resultMap.put("app", "TSign");
		resultMap.put("col1", col1);
		resultMap.put("col2", col2);
		resultMap.put("col3", col3);

		// List<HashMap<String, String>> filesInfo = multipartFileHandler.handleFiles(files);
		// resultMap.put("filesInfo", filesInfo);

		return resultMap;
	}


	@RequestMapping(value = "/sign/main")
	public String signMain() throws Exception {
		return "sign/main";
	}

	@RequestMapping(value = "/sign/complete")
	public String signComplete() throws Exception {
		return "sign/complete";
	}

	@RequestMapping(value = "/sign/test")
	public String signTest() throws Exception {
		return "sign/test";
	}

	@RequestMapping(value = "/admin/test")
	public String adminTest() throws Exception {
		return "admin/test";
	}

	@RequestMapping(value = "/admin/security-test")
	@ResponseBody
	public HashMap<String, Object> securityTest() throws Exception {
		HashMap<String, Object> result = new HashMap<String, Object>();

		CommonUserDetails adminUserDetails = securityUtil.getAdminUserDetails();
		Logger.debug("##### adminUserDetails.inSignDate-old : {} #####", adminUserDetails.getInSignDate());
		adminUserDetails = securityUtil.setAdminInSignDate(new Date());
		Logger.debug("##### adminUserDetails.inSignDate-new : {} #####", adminUserDetails.getInSignDate());

		result.put("userDetails", adminUserDetails);

		return result;
	}
}
