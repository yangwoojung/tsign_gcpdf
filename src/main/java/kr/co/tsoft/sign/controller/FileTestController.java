package kr.co.tsoft.sign.controller;

import java.io.File;
import java.io.FileOutputStream;
import java.util.HashMap;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

@Controller
@RequestMapping(value="/test/file")
public class FileTestController {
	
	private final Logger logger = LoggerFactory.getLogger(FileTestController.class);
	 
	@Value("${config.upload.dir}")
	private String ATTACH_PATH;
	 
	 @RequestMapping(value="/view")
	 public String view() {
		 return "sign/testView";
	 }
	 
	 @RequestMapping(value="/mkdir")
	 @ResponseBody
	 public HashMap<String, Object> mkdir(@RequestBody HashMap<String, Object> contNo) {
		 HashMap<String, Object> returnMap = new HashMap<>();
		 logger.debug("##### mkdir param : {}", contNo);
		 System.out.println(contNo);

		 //폴더 경로 
		 String folderPath = ATTACH_PATH + contNo.get("contNo");
		 //파일 저장 경로
		 final String path = folderPath +File.separator+"test.txt";
		 //폴더 객체 생성 
		 File Folder = new File(folderPath);
		//폴더 미존재 시 지정된 경로로 폴더 생성
		if(!Folder.exists()) { Folder.mkdirs(); }
		//파일 객체 생성
		File file = new File(path);
		String str = "지금은 파일 테스트 중이에요";
		byte[] bytes = str.getBytes();
		try {
			FileOutputStream os = new FileOutputStream(file);
			os.write(bytes);
			os.close();
			returnMap.put("result", path + " 경로에 파일 생성 성공");
		} catch (Exception e) {
			e.printStackTrace();
		}
		return returnMap;
	 }
	 
	 @RequestMapping(value="/deldir")
	 @ResponseBody
	 public HashMap<String, Object> deldir (@RequestBody HashMap<String, Object> contNo) {
		HashMap<String, Object> returnMap = new HashMap<>();
		logger.debug("##### mkdir param : {}", contNo);
		System.out.println(contNo);
	
		//폴더 경로 
		String folderPath = ATTACH_PATH + contNo.get("contNo");
		//파일 저장 경로
		final String path = folderPath +File.separator+"test.txt";
		//파일 객체 생성
		File file = new File(path);
		
		if(!file.exists()) {
			returnMap.put("result", "파일 미존재로 삭제 불가");
			return returnMap;
		} else {
			//파일 삭제
			file.delete();
			File folder = new File(folderPath);
			folder.delete();
			returnMap.put("result", folder + " 경로의 파일 및 디렉토리 삭제 완료");
		}
		return returnMap;
	 }
}
