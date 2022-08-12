package kr.co.tsoft.sign.vo.admin;

import kr.co.tsoft.sign.vo.common.GridRequest;
import lombok.Data;

@Data
public class FormGridDto extends GridRequest {

    private Integer fileSeq;
    private String fileTp;
    private String contrcNo;
    private String formNm;
    private String orgFileNm;
    private String savFileNm;
    private String filePath;
    private String useYn;
    private String regDate;
    private String regId;
    private String modDate;
    private String modId;

}
