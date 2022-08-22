package kr.co.tsoft.sign.vo;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@Builder
@NoArgsConstructor
@AllArgsConstructor
public class CertificationVO {
	private String reqNum;
	private String reqInfo;
	private String retUrl;
	private String cellNo;
	private String certDate;
	private String ci;
	private String di;
	private String status;
	private String type;
	
}
