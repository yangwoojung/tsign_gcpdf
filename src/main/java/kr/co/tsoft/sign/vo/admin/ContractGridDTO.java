package kr.co.tsoft.sign.vo.admin;

import java.util.List;

import kr.co.tsoft.sign.vo.ContractAttachmentDTO;
import kr.co.tsoft.sign.vo.common.GridRequest;
import lombok.Data;

@Data
public class ContractGridDTO extends GridRequest {
    private Integer contractSeq;
    private String contractNo;
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
    
    private List<ContractAttachmentDTO> selectedAttach;

}
