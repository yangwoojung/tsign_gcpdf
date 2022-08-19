package kr.co.tsoft.sign.vo;

import lombok.Builder;
import lombok.Data;

@Data
@Builder
public class ContrcMgmtVO {
    private Integer contrcSeq;
//    private null contrcNo;
    private String contrcNo;
    private Integer fileSeq;
//    private null pinNo;
    private String pinNo;
    private String userNm;
    private String cellNo;
    private String cellNoMask;
    private String email;
    private String signDueSdate;
    private String signDueEdate;
    private java.sql.Timestamp inSignDate;
//    private null useYn;
    private String useYn;
    private java.sql.Timestamp regDate;
    private String regId;
    private java.sql.Timestamp modDate;
    private String modId;

}
