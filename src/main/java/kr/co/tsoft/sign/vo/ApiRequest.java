package kr.co.tsoft.sign.vo;

import lombok.Builder;
import lombok.Data;
import lombok.Getter;
import lombok.ToString;
import okhttp3.MultipartBody;
import org.springframework.web.multipart.MultipartFile;

import java.io.File;
import java.util.List;

@Data
public class ApiRequest {

    @Getter
    @Builder
    @ToString
    public static class Tsa {
        private final String token;
        private final MultipartBody.Part file;
    }

}


