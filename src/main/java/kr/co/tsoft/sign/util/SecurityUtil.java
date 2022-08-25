package kr.co.tsoft.sign.util;

import kr.co.tsoft.sign.config.security.CommonUserDetails;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContext;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Component;

@Component
public class SecurityUtil {

	private final String IN_SIGN_DATE = "IN-SIGN-DATE";
	private final String IN_RESIDENT_NO = "IN_RESIDENT_NO";
	private final String IN_ADDRESS = "IN_ADDRESS";
	private final String IN_ACCOUNT_NO = "IN_ACCOUNT_NO";
	private final String IN_BANK_NM = "IN_BANK_NM";
	private final String PDF_PAGE_CNT = "PDF_PAGE_CNT";
	private final String CONTRC_STATE = "CONTRC_STATE";
	private final String HISTORY_LIST = "HISTORY_LIST";

	private final String PHONE_CERT = "PHONE_CERT";    // 휴대폰 본인인증 복호화

	public CommonUserDetails getAdminUserDetails() {
		return getUserDetails();
	}

	public CommonUserDetails getSignUserDetails() {
		return getUserDetails();
	}

//	public CommonUserDetails setAdminInSignDate(Date inSignDate) {
//		return setSomethingData(IN_SIGN_DATE, inSignDate);
//	}
//
//	public CommonUserDetails setResidentNo(String residentNo) {
//		return setSomethingData(IN_RESIDENT_NO, residentNo);
//	}
//
//	public CommonUserDetails setAddress(String address) {
//		return setSomethingData(IN_ADDRESS, address);
//	}
//
//	public CommonUserDetails setInAccountNo(String inAccountNo) {
//		return setSomethingData(IN_ACCOUNT_NO, inAccountNo);
//	}
//
//	public CommonUserDetails setInBankNm(String inBankNm) {
//		return setSomethingData(IN_BANK_NM, inBankNm);
//	}
//
//	public CommonUserDetails setPdfPageCnt(String pdfPageCnt) {
//		return setSomethingData(PDF_PAGE_CNT, pdfPageCnt);
//	}
//
//	public CommonUserDetails setContrcState(String contrcState) {
//		return setSomethingData(CONTRC_STATE, contrcState);
//	}
//
//	public CommonUserDetails setHistoryList(String log) {
//		HashMap<String, String> map = new HashMap<String, String>();
//		Date date = new Date();
//		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd k:m:S");
//
//		map.put("time", sdf.format(date));
//		map.put("log", log);
//		return setSomethingData(HISTORY_LIST, map);
//	}
//
//	public CommonUserDetails setPhoneCert(String contrcState) {
//		return setSomethingData(PHONE_CERT, contrcState);
//	}

	private void setNewAuthentication(Authentication authentication) {
		getSecurityContext().setAuthentication(authentication);
	}

	private Authentication makeNewAuthentication(CommonUserDetails userDetails) {
		if (userDetails == null) {
			return null;
		}

		return new UsernamePasswordAuthenticationToken(userDetails, userDetails.getPassword(), userDetails.getAuthorities());
	}

//	private CommonUserDetails setSomethingData(String flag, Object data) {
//		CommonUserDetails newUserDetails = setData(flag, data);
//
//		if (newUserDetails == null) {
//			return null;
//		}
//
//		Authentication newAuthentication = makeNewAuthentication(newUserDetails);
//		if (newAuthentication == null) {
//			return null;
//		}
//
//		setNewAuthentication(newAuthentication);
//
//		return getUserDetails();
//	}

//	private CommonUserDetails setData(String flag, Object data) {
//		CommonUserDetails oldUserDetails = getUserDetails();
//		if (oldUserDetails == null) {
//			return null;
//		}
//
//		CommonUserDetails newUserDetails = null;
//
//		if (IN_SIGN_DATE.equals(flag)) {
//			if (data != null && data instanceof Date) {
//				Date inSignDate = (Date) data;
//				oldUserDetails.setInSignDate(inSignDate);
//			}
//		} else if ("IN_RESIDENT_NO".equals(flag)) {
//			oldUserDetails.setInResidentNo((String) data);
//		} else if ("IN_ADDRESS".equals(flag)) {
//			oldUserDetails.setInAddress((String) data);
//		} else if ("IN_ACCOUNT_NO".equals(flag)) {
//			oldUserDetails.setInAccountNo((String) data);
//		} else if ("IN_BANK_NM".equals(flag)) {
//			oldUserDetails.setInBankNm((String) data);
//		} else if ("PDF_PAGE_CNT".equals(flag)) {
//			oldUserDetails.setPdfPageCnt((String) data);
//		} else if ("CONTRC_STATE".equals(flag)) {
//			oldUserDetails.setContrcState((String) data);
//		} else if ("HISTORY_LIST".equals(flag)) {
//			if (data != null && data instanceof HashMap) {
//				HashMap<String, String> dataMap = (HashMap<String, String>) data;
//				oldUserDetails.setHistoryList(dataMap);
//			}
//		} else if ("PHONE_CERT".equals(flag)) {
//			oldUserDetails.setPhoneCert((String) data);
//		} else if ("SOMETHING-FIELD".equals(flag)) {
//			// TODO
//		} else {
//			System.out.println("일치하는 필드명이 없습니다. ");
//		}
//
//		newUserDetails = oldUserDetails;
//
//		return newUserDetails;
//	}

	private CommonUserDetails getUserDetails() {
		CommonUserDetails userDetails = null;

		Object principal = getSecurityContext().getAuthentication().getPrincipal();

		if (principal != null && principal instanceof CommonUserDetails) {
			userDetails = (CommonUserDetails) principal;
		}

		return userDetails;
	}

	private SecurityContext getSecurityContext() {
		return SecurityContextHolder.getContext();
	}
}
