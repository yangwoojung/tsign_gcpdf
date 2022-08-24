package kr.co.tsoft.sign.vo;

import lombok.Data;

@Data
public class ContractAttachmentVO {

    private Integer contractAttachmentSeq;
    private String contractNo;
    private Integer attachmentSeq;
    private String savedFileNm;
    private String filePath;
    private String uploadedYn;
    private String regDate;
    private String regId;
    private String modDate;
    private String modId;

}
