package kr.co.tsoft.sign.config.security;

import lombok.Builder;
import org.springframework.security.core.userdetails.UserDetails;

import java.util.ArrayList;

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
    private String residentNo;      //주민번호
    private String bankName;        //은행명
    private String bankAccountNo;   //계좌번호
    private String phoneCert;       //휴대폰 인증

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

    public String getUsername() {
        return username;
    }

    public void setUsername(String username) {
        this.username = username;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public ArrayList<CommonRoleGroup> getAuthorities() {
        return this.authorities;
    }

    public void setAuthorities(ArrayList<CommonRoleGroup> authorities) {
        this.authorities = authorities;
    }

    public String getAdminNm() {
        return adminNm;
    }

    public void setAdminNm(String adminNm) {
        this.adminNm = adminNm;
    }

    public String getAdminCellNo() {
        return adminCellNo;
    }

    public void setAdminCellNo(String adminCellNo) {
        this.adminCellNo = adminCellNo;
    }

    public String getContractNo() {
        return contractNo;
    }

    public void setContractNo(String contractNo) {
        this.contractNo = contractNo;
    }

    public long getFileSeq() {
        return fileSeq;
    }

    public void setFileSeq(long fileSeq) {
        this.fileSeq = fileSeq;
    }

    public String getUserNm() {
        return userNm;
    }

    public void setUserNm(String userNm) {
        this.userNm = userNm;
    }

    public String getCellNo() {
        return cellNo;
    }

    public void setCellNo(String cellNo) {
        this.cellNo = cellNo;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getSignDueSdate() {
        return signDueSdate;
    }

    public void setSignDueSdate(String signDueSdate) {
        this.signDueSdate = signDueSdate;
    }

    public String getSignDueEdate() {
        return signDueEdate;
    }

    public void setSignDueEdate(String signDueEdate) {
        this.signDueEdate = signDueEdate;
    }

    public String getResidentNo() {
        return residentNo;
    }

    public void setResidentNo(String residentNo) {
        this.residentNo = residentNo;
    }

    public String getBankName() {
        return bankName;
    }

    public void setBankName(String bankName) {
        this.bankName = bankName;
    }

    public String getBankAccountNo() {
        return bankAccountNo;
    }

    public void setBankAccountNo(String bankAccountNo) {
        this.bankAccountNo = bankAccountNo;
    }

    public String getPhoneCert() {
        return phoneCert;
    }

    public void setPhoneCert(String phoneCert) {
        this.phoneCert = phoneCert;
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
