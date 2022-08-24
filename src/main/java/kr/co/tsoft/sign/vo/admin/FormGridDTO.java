package kr.co.tsoft.sign.vo.admin;

import kr.co.tsoft.sign.vo.common.GridRequest;
import lombok.Data;
import org.springframework.web.multipart.MultipartFile;

@Data
public class FormGridDTO extends GridRequest {

    private Integer fileSeq;
    private String fileType;
    private String contractNo;
    private String formNm;
    private String orgFileNm;
    private String savFileNm;
    private String filePath;
    private String useYn;
    private String regDate;
    private String regId;
    private String modDate;
    private String modId;
    private MultipartFile file;


}
