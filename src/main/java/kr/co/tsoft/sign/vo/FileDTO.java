package kr.co.tsoft.sign.vo;

import lombok.Builder;
import lombok.Data;

@Data
@Builder
public class FileDTO {
    private Integer fileSeq;
    private String fileType;
    private String contractNo;
    private String formNm;
    private String orgFileNm;
    private String savFileNm;
    private String filePath;
    private String useYn;
//    private java.sql.Timestamp regDate;
    private String regId;
//    private java.sql.Timestamp modDate;
    private String modId;

}
