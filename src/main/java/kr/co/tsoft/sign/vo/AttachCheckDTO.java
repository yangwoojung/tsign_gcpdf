package kr.co.tsoft.sign.vo;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
import lombok.ToString;

@Data
@ToString
@AllArgsConstructor
@NoArgsConstructor
public class AttachCheckDTO {
	private String userNm;
	private String socialNo1;
	private String socialNo2;
	private String issueDt;
	private String type2_ownerNm;
	private String juminNo;
	private String license01;
	private String license02;
	private String license03;
	private String license04;
}
