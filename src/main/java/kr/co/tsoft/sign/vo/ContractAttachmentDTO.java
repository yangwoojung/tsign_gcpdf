package kr.co.tsoft.sign.vo;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@Builder
@NoArgsConstructor
@AllArgsConstructor
public class ContractAttachmentDTO {

    private Integer contractAttachmentSeq;
    private String contractNo;
    private Integer attachmentSeq;
    private String requiredYn;
    private String uploadedDate;
    private String uploadedYn;
    private String uploadedFile;
    private String regDate;
    private String regId;
    private String modDate;
    private String modId;

    //
    private String file;
    //
    private String attachmentCd;
    private String attachmentName;
    private String attachmentDescription;
    private String ocrYn;
    private String scrapYn;
    private String priority;

}
