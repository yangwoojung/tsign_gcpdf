package kr.co.tsoft.sign.vo;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Builder
@Data
@NoArgsConstructor
@AllArgsConstructor
public class RequiredApiResponseDTO {
	private String idType; //신분증 타입 > 주민등록증 : 1, 운전면허증 : 3
	private String socialNo1; //주민등록번호 앞자리
	private String socialNo2; //주민등록번호 뒷자리
	private String issueDt; //주민등록증 발급일자 
	private String licenseNo1; //운전면허번호 1
	private String licenseNo2; //운전면허번호 2
	private String licenseNo3; //운전면허번호 3 
	private String licenseNo4; //운전면허번호 4
}
