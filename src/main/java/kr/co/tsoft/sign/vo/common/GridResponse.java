package kr.co.tsoft.sign.vo.common;

import lombok.Data;

import java.util.List;

/*
 * GridResponse : 그리드 정보 처리를 위한 Response 객체
 * 
 * {
  "draw": 1,
  "recordsTotal": 57,
  "recordsFiltered": 57,
  "data": [
    {}
    ]
 * 
 */

@Data
public class GridResponse {

	private int draw = 0;
	private int recordsTotal = 0;
	private int recordsFiltered = 0;
	private List data;
	
}
