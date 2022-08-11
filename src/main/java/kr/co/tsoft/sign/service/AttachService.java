package kr.co.tsoft.sign.service;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Service;

@Service
public class AttachService {

	public List<Map<String, Object>> docList() {
		List<Map<String, Object>> docList = new ArrayList<Map<String, Object>>();
		Map<String, Object> map = new HashMap<>();
		Map<String, Object> map2 = new HashMap<>();
		
		map.put("docNm", "신분증");
		map.put("maxCnt", "5");
		map.put("docCd", "008");

		map2.put("docNm", "통장사본");
		map2.put("maxCnt", "5");
		map2.put("docCd", "001");
		
		docList.add(map);
		docList.add(map2);
		
		return docList;
	}
	
}
