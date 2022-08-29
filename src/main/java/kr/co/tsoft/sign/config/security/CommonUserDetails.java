package kr.co.tsoft.sign.config.security;

import lombok.Builder;
import lombok.Data;
import org.springframework.security.core.userdetails.UserDetails;

import java.util.ArrayList;

@Data
@Builder
public class CommonUserDetails implements UserDetails {

    private String username;
    private String password;
    private ArrayList<CommonRoleGroup> authorities;

    // admin user info
    private String adminNm;
    private String adminCellNo;

    // sign user info
    private String contractNo;
    private long fileSeq;
    private String userNm;
    private String cellNo;
    private String email;
    private String signDueSdate;
    private String signDueEdate;

    // 사용자 입력
    private String socialNo1;      //주민번호 앞자리
    private String socialNo2;      //주민번호 뒷자리
    private String issueDt;        // 주민발급일자
    private String bankName;        //은행명
    private String bankAccountNo;   //계좌번호
    private String phoneCert;       //휴대폰 인증
    private String signCanvasDataUrl; //서명 base64 데이터
    private String address;         // 주소
    private String idType;       // ID TYPE (예: 1 - 주민등록증)

    @Override
    public int hashCode() {
        if (this.getUsername() != null) {
            return this.getUsername().hashCode();
        }
        return 0;
    }

    @Override
    public boolean equals(Object obj) {
        if (!(obj instanceof CommonUserDetails)) {
            return false;
        }

        CommonUserDetails other = (CommonUserDetails) obj;

        if (!this.getUsername().equalsIgnoreCase(other.getUsername())) {
            return false;
        }
        return true;
    }

    @Override
    public boolean isAccountNonExpired() {
        return false;
    }

    @Override
    public boolean isAccountNonLocked() {
        return false;
    }

    @Override
    public boolean isCredentialsNonExpired() {
        return false;
    }

    @Override
    public boolean isEnabled() {
        return false;
    }
}
