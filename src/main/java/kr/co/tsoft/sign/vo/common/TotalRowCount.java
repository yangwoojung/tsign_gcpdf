package kr.co.tsoft.sign.vo.common;

/*
 * TotalRowCountVO : 로우카운트 관리를 위한 공통객체 
 */

import lombok.Data;

@Data
public class TotalRowCount {

	private Integer rowCount;
	private long maxCount;

}
