package kr.co.tsoft.sign.vo;

import lombok.Data;

import java.util.List;

@Data
public class ApiResponse<T> {
    private String code;
    private List<ApiResponseData<T>> data;
    private String message;
    private String status;
    private String trxnId;

}
