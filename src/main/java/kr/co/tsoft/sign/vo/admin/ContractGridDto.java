package kr.co.tsoft.sign.vo.admin;

import kr.co.tsoft.sign.vo.common.GridRequest;
import lombok.Data;

@Data
public class ContractGridDto extends GridRequest {
    private Integer contrcSeq;
    private String contrcNo;
    private Integer fileSeq;
    private String pinNo;
    private String userNm;
    private String cellNo;
    private String email;
    private String signDueSdate;
    private String signDueEdate;
    private String inSignDate;
    private String useYn;
    private String regDate;
    private String regId;
    private String modDate;
    private String modId;

    private String formNm;
    private String filePath;


}