package kr.co.tsoft.sign.vo;

import lombok.Data;

@Data
public class AttachVO {

    private String contractNo;
    private String file;
//    private List<String> files;
//    private List<MultipartFile> files;
    private String attachCd;
}
