package kr.co.tsoft.sign.vo;

import lombok.Data;

@Data
public class AdmMgmtVO {
    private Integer admSeq;
    private String admId;
    private String admNm;
    private String admPwd;
//    private null admCellNo;
    private Byte pwdFailCnt;
    private java.sql.Timestamp lastLoginDate;
//    private null useYn;
    private java.sql.Timestamp regDate;
    private String regId;
    private java.sql.Timestamp modDate;
    private String modId;

}
