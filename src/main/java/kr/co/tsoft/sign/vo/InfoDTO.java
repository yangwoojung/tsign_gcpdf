package kr.co.tsoft.sign.vo;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
import lombok.ToString;

@Data
@ToString
@NoArgsConstructor
@AllArgsConstructor
public class InfoDTO {
	//info
    private String contractNo;
    private String email;
    private String socialNo1;
    private String socialNo2;
    private String signCanvasDataUrl;
    private String address1;
    private String address2;
    private String bankName;
    private String bankAccountNo;
    
    //attach-scrap info
	private String userNm;
	private String issueDt;
	private String type3_ownerNm;
	private String juminNo;
	private String license01;
	private String license02;
	private String license03;
	private String license04;

}
