package kr.co.tsoft.sign.util;

import kr.co.tsoft.sign.vo.admin.FormGridDto;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Component;
import org.springframework.web.multipart.MultipartFile;

import java.io.File;
import java.text.Normalizer;
import java.util.*;

@Component
public class MultipartFileHandler {

    @Value("${config.upload.dir}")
    private String uploadDir;

    public List<HashMap<String, String>> handleFiles(List<MultipartFile> orgFiles, HashMap<String, String> fileInfo) throws Exception {
        if (orgFiles == null || orgFiles.size() == 0) {
            return null;
        }

        List<HashMap<String, String>> result = new ArrayList<HashMap<String, String>>();

        Iterator<MultipartFile> iterator = orgFiles.iterator();
        while (iterator.hasNext()) {
            MultipartFile multipartFile = iterator.next();

            if (multipartFile.isEmpty()) {
                continue;
            }

            String orgFileName = multipartFile.getOriginalFilename();
            fileInfo.put("ORG_FILE_NM", orgFileName);

            UUID uuid = UUID.randomUUID();
            String savedName = uuid.toString();
            String finalPath = uploadDir + File.separatorChar + fileInfo.get("lastPath") + File.separatorChar;

            fileInfo.put("SAV_FILE_NM", savedName);
            fileInfo.put("FILE_PATH", finalPath);


            //실제 저장되는 위치 c:/project/upload/#{lastPath}/생성한 svaedName
            File dest = new File(finalPath + savedName);

            //서버 경로에 저장
            multipartFile.transferTo(dest);

            result.add(fileInfo);
        }

        return result;
    }

    public FormGridDto handleFiles(FormGridDto form) throws Exception {
        if (form == null) return null;

        MultipartFile multipartFile = form.getFile();
        if (multipartFile.isEmpty()) return null;

        String orgFileName = multipartFile.getOriginalFilename();
        String savedName = UUID.randomUUID().toString();
        String pathByFileType = findPathByFileType(form.getFileTp());
        String finalPath = uploadDir + File.separatorChar + pathByFileType + File.separatorChar;

        form.setOrgFileNm(orgFileName);
        form.setSavFileNm(savedName);
        form.setFilePath(finalPath);

        //실제 저장되는 위치 c:/project/upload/#{lastPath}/생성한 svaedName
        multipartFile.transferTo(new File(finalPath + savedName));

        return form;
    }

    private String findPathByFileType(String fileType) {
        if ("100".equals(fileType)) {
            return "form";
        }
        return "";
    }

}
