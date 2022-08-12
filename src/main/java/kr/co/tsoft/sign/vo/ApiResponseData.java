package kr.co.tsoft.sign.vo;

import lombok.Builder;
import lombok.Data;
import lombok.Getter;
import lombok.ToString;

@Data
public class ApiResponseData<T> {
    private String code;
    private T data;
    private String message;
    private String module;
    private String status;

    @Getter
    @Builder
    @ToString
    public static class Tsa {
        private final String encodeTsaFile;
    }

    @Getter
    @Builder
    @ToString
    public static class Ocr {
        private final String encodeOcrFile;
    }
}
