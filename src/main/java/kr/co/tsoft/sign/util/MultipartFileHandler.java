package kr.co.tsoft.sign.util;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Component;
import org.springframework.web.multipart.MultipartFile;

import java.io.File;
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

            // pdf 파일이 아니면 삭제 처리
//            if (!isPdf(dest)) {
//                if (dest.exists()) {
//                    if (dest.delete()) {
//                        // 파일 삭제 완료
//                    }
//                }
//            }

            result.add(fileInfo);
        }

        return result;
    }

//    private boolean isPdf(File file) throws Exception {
//        if (file == null || !file.exists()) {
//            return false;
//        }
//
//        boolean result = false;
//
//        String mimeType = new Tika().detect(file);
//        if ("application/pdf".equals(mimeType)) {
//            return true;
//        }
//
//        return result;
//    }
}
