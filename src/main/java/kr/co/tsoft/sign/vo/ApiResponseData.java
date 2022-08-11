package kr.co.tsoft.sign.vo;

import lombok.Data;

@Data
public class ApiResponseData {
    public String code;
    public Object data;
    public String message;
    public String module;
    public String status;
}
