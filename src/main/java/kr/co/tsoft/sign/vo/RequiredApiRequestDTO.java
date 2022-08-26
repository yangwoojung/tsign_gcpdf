package kr.co.tsoft.sign.vo;

import java.io.File;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Builder
@Data
@NoArgsConstructor
@AllArgsConstructor
public class RequiredApiRequestDTO {
	
	private String token;
	private String file;
	
	private String type;
	
	private String name;
    private String socialNo; 
    
	private String birthDt;
	
	private String issueDt;
	private String licenseNo;
}
