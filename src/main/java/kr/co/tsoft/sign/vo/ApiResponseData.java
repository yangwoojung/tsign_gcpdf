package kr.co.tsoft.sign.vo;

import com.google.gson.annotations.JsonAdapter;

import kr.co.tsoft.sign.util.retrofit.AlwaysListTypeAdapterFactory;
import lombok.Builder;
import lombok.Data;
import lombok.Getter;
import lombok.ToString;

@Data
public class ApiResponseData<T> {
    private String code;
    
    @JsonAdapter(AlwaysListTypeAdapterFactory.class)
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
    	private final String idType; //신분증 타입     1:주민등록증, 3:운전면허증
    	private final String socialNo; //주민등록번호
    	private final String name; //성명
    	private final String issueDt; //발급일자
    	private final String licenseNo; //면허번호(운전면허증)
//    	private final String checkDigit; //식별번호(운전면허증)
//        private final String encodeOcrFile; //OCR 처리한 이미지 파일 Base64로 encode한 문자열
    }
    
    @Getter
    @Builder
    @ToString
    public static class Scrap {
    	private final OutB001 outB0001; //주민등록증 / 운전면허증 결과 컨테이너
    }
    
    @Getter
    @Builder
    @ToString
    public static class Verify {
    	private final String idType; //신분증 타입     1:주민등록증, 3:운전면허증
    	private final String socialNo; //주민등록번호
    	private final String name; //성명
    	private final String issueDt; //발급일자
    	private final String licenseNo; //면허번호(운전면허증)
    	private final OutB001 outB0001; //주민등록증 / 운전면허증 결과 컨테이너
    }
    
    @Getter
    @Builder
    @ToString
    public static class OutB001 {
    	private final String errYn; //에러코드
    	private final String errMsg; //에러메시지
    	private final String truthYn; //주민등록증 진위여부
    	private final String truthMsg; //주민등록증 진위메시지
    	private final String juminNo; //주민등록번호
    	private final String licenceTruthYn; //운전면허증 진위여부
    	private final String licenceTruthMsg; //운전면허증 진위메시지
    }
}
