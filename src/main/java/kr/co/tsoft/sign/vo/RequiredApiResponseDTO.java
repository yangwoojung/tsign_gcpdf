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
	private String name; //이름
	private String idType; //신분증 타입 > 주민등록증 : 1, 운전면허증 : 3
	private String socialNo; //주민등록번호
	private String issueDt; //주민등록증 발급일자
	private String licenseNo; //운전면허번호
}
