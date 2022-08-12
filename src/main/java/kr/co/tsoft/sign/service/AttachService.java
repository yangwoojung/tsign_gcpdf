package kr.co.tsoft.sign.service;

import java.io.File;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.commons.codec.binary.Base64;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;

import com.clipsoft.org.apache.commons.io.FileUtils;

import kr.co.tsoft.sign.util.SessionUtil;

@Service
public class AttachService {
	
	private final Logger logger = LoggerFactory.getLogger(AttachService.class);
	
	@Value("${spring.http.multipart.location}")
	private String ATTACH_TMP_PATH;
	

	public List<Map<String, Object>> docList() {
		List<Map<String, Object>> docList = new ArrayList<Map<String, Object>>();
		Map<String, Object> map = new HashMap<>();
		Map<String, Object> map2 = new HashMap<>();
		
		map.put("docNm", "신분증");
		map.put("maxCnt", "5");
		map.put("docCd", "001");

		map2.put("docNm", "통장사본");
		map2.put("maxCnt", "5");
		map2.put("docCd", "002");
		
		docList.add(map);
		docList.add(map2);
		
		return docList;
	}

	public Map<String, Object> uploadAttachFile(Map<String, Object> param) throws Exception {
		
		logger.info("##### uploadAttachFile Service #####");
		//TODO : upload 하면서 OCR 실행 
		logger.info("ATTACH_TMP_PATH : {}", ATTACH_TMP_PATH);
		
		Map<String, Object> user = SessionUtil.getUser();

		String attachId = (String)param.get("attach_id");
		String attachChildId = (String)param.get("attach_child_id");
		
		String imgNm = (String)user.get("CONTRC_NO") + attachId + attachChildId;
		String img = (String) param.get("fileData");
		
		return null;
	}
	
}
