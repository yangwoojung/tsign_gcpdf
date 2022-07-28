package kr.co.tsoft.sign.service.admin;

import kr.co.tsoft.sign.mapper.admin.FormMapper;
import kr.co.tsoft.sign.service.ComService;
import kr.co.tsoft.sign.util.MultipartFileHandler;
import kr.co.tsoft.sign.util.SecurityUtil;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;

@Service
public class FormService {

    @Autowired
    MultipartFileHandler multipartFileHandler;

    @Autowired
    ComService comService;

    @Autowired
    FormMapper formMapper;

    public HashMap<String, Object> formRegInsert(List<MultipartFile> files, String formNm) throws Exception {
        HashMap<String, Object> resultMap = new HashMap<String, Object>();

        HashMap<String, String> fileInfo = new HashMap<String, String>();
        //원본 계약서(100), 원본 추적표(101), 생성된 계약서(102), 생성된 추적표(103)
        fileInfo.put("FILE_TP", "100");//not null
        fileInfo.put("FORM_NM", formNm);
        fileInfo.put("lastPath", "form");//form : 원본 계약서(100), 원본 추적표(101), result : 생성된 계약서(102), 생성된 추적표(103)

        // 서버에 저장
        List<HashMap<String, String>> filesInfo = multipartFileHandler.handleFiles(files, fileInfo);
        resultMap.put("filesInfo", filesInfo);
        SecurityUtil su = new SecurityUtil();
        Iterator<HashMap<String, String>> iterator = filesInfo.iterator();
        while (iterator.hasNext()) {
            HashMap<String, String> file = iterator.next();
            file.put("user", su.getAdminUserDetails().getUsername());
            // db에 저장
            if (comService.insertFileUpload(file) > 0) {
                resultMap.put("result", "success");
                resultMap.put("message", "성공");
            } else {
                resultMap.put("result", "fail");
                resultMap.put("message", "저장 실패성공");
            }
        }
        return resultMap;

    }

    public List<Map<String, Object>> selectFormList(Map<String, Object> parameter) {

        return formMapper.selectFormList(parameter);
    }

    public int countSelectFormList(Map<String, Object> parameter) {
        return formMapper.countSelectFormList(parameter);
    }

    public List<HashMap<String, Object>> selectContrcFormList(HashMap<String, String> paramMap) {
        return formMapper.selectContrcFormList(paramMap);
    }

    public HashMap<String, String> selectContrcFormInfo(HashMap<String, String> paramMap) {
        return formMapper.selectContrcFormInfo(paramMap);
    }

}
