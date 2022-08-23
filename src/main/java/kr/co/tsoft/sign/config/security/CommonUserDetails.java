package kr.co.tsoft.sign.config.security;

import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.LinkedList;

import org.springframework.security.core.userdetails.UserDetails;

import lombok.Builder;

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
    private Date inSignDate;        //서명일자
    private String inResidentNo;    //주민번호
    private String inAddress;        //주소
    private String inAccountNo;    //계좌
    private String inBankNm;        //은행명
    //진행중 업데이트
    private String pdfPageCnt;        //계약서 pdf페이지 수
    private String contrcState;        //계약상태
    private LinkedList<HashMap<String, String>> historyList = new LinkedList<>();
    //본인인증
    private Date ctrtCfmDt;
    private Date ownSignDt;
    private String phoneCert;        // 휴대폰 본인인증 복호화

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

    public Date getInSignDate() {
        return inSignDate;
    }

    public void setInSignDate(Date inSignDate) {
        this.inSignDate = inSignDate;
    }

    public String getInResidentNo() {
        return inResidentNo;
    }

    public void setInResidentNo(String inResidentNo) {
        this.inResidentNo = inResidentNo;
    }

    public String getInAddress() {
        return inAddress;
    }

    public void setInAddress(String inAddress) {
        this.inAddress = inAddress;
    }

    public String getInAccountNo() {
        return inAccountNo;
    }

    public void setInAccountNo(String inAccountNo) {
        this.inAccountNo = inAccountNo;
    }

    public String getInBankNm() {
        return inBankNm;
    }

    public void setInBankNm(String inBankNm) {
        this.inBankNm = inBankNm;
    }

    public String getPdfPageCnt() {
        return pdfPageCnt;
    }

    public void setPdfPageCnt(String inPdfPageCnt) {
        this.pdfPageCnt = inPdfPageCnt;
    }

    public String getContrcState() {
        return contrcState;
    }

    public void setContrcState(String contrcState) {
        this.contrcState = contrcState;
    }

    public LinkedList<HashMap<String, String>> getHistoryList() {
        return historyList;
    }

    public void setHistoryList(HashMap<String, String> map) {
        this.historyList.add(map);
    }

    public void setHistoryList(LinkedList<HashMap<String, String>> historyList) {
        this.historyList = historyList;
    }

    public Date getCtrtCfmDt() {
        return ctrtCfmDt;
    }

    public void setCtrtCfmDt(Date ctrtCfmDt) {
        this.ctrtCfmDt = ctrtCfmDt;
    }

    public Date getOwnSignDt() {
        return ownSignDt;
    }

    public void setOwnSignDt(Date ownSignDt) {
        this.ownSignDt = ownSignDt;
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
