package kr.co.tsoft.sign.vo;

import lombok.Data;

import java.util.List;

@Data
public class ApiResponse {
    private String code;
    private List<ApiResponseData> data;
    private String message;
    private String status;
    private String trxnId;


}


