package kr.co.tsoft.sign.vo;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

public class UserSessionVO {
    ArrayList<HashMap<String, Object>> historyList;
    private String cellNo;
    private String email;
    private String userNm;
    private String addr;
    private List<Map<String, Object>> hist;

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

    public String getUserNm() {
        return userNm;
    }

    public void setUserNm(String userNm) {
        this.userNm = userNm;
    }

    public String getAddr() {
        return addr;
    }

    public void setAddr(String addr) {
        this.addr = addr;
    }

    public List<Map<String, Object>> getHist() {
        return hist;
    }

    public void setHist(List<Map<String, Object>> hist) {
        this.hist = hist;
    }

}
