package kr.co.tsoft.sign.vo;

import lombok.Builder;
import lombok.Getter;
import lombok.ToString;
import lombok.Value;
import okhttp3.MultipartBody;

public class ApiRequest {

    @Getter
    @Builder
    @ToString
    public static class Tsa {
        private final String token;
        private final MultipartBody.Part file;
    }
    
    @Getter
    @Builder
    @ToString
    public static class Ocr {
    	private final String token;
    	private final MultipartBody.Part file;
    }

    @Getter
    @Builder
    @ToString
    public static class Scrap {
        private final String token;
        private final String type;
        private final String col1;
        private final String col2;
        private final String col3;
        private final String col4;
        private final String col5;
        private final String col6;
    }
    
    @Getter
    @Builder
    @ToString
    public static class Verify {
    	private final String token;
    	private final MultipartBody.Part file;
    }

}
