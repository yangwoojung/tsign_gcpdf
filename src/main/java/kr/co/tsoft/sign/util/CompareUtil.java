package kr.co.tsoft.sign.util;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

public class CompareUtil {
	
	private static final Logger logger = LoggerFactory.getLogger(CompareUtil.class);

	public String removeSpace(String str) {
		str = str.replaceAll("[\\s\\p{Z}]", "");
		return str;
	}
	
	public String toHalfChar(String src) {
		StringBuffer strBuf = new StringBuffer();
		char c = 0;
		int nSrcLength = src.length();
		for (int i = 0; i < nSrcLength; i++) {
			c = src.charAt(i);
			// 영문이거나 특수 문자 일경우.
			if (c >= '！' && c <= '～') {
				c -= 0xfee0;
			} else if (c == '　') {
				c = 0x20;
			}
			// 문자열 버퍼에 변환된 문자를 쌓는다
			strBuf.append(c);
		}
		return strBuf.toString();
	}
	
	public Boolean compareAandB(String A, String B, String compareType, int len) {
		Boolean compared = false;
		logger.debug("====== compareAandB Start ======");
		logger.debug("compared_account_real_holder_name_BEFORE: {}", A);
		logger.debug("compared_request_holder_name_BEFORE : {}", B);
		String strA = toHalfChar(A);
		String strB = toHalfChar(B);
		strA = removeSpace(strA);
		strB = removeSpace(strB);
		strA = strA.toLowerCase();
		strB = strB.toLowerCase();
		if("contains".equalsIgnoreCase(compareType)) {
			if(len>0 && strB.length()>=len) strB = strB.substring(0, len);
			if(strA.contains(strB)) compared = true;
		}else {
			if(len>0 && strB.length()>=len && strA.length()>=len) {
				strA = strA.substring(0, len);
				strB = strB.substring(0, len);
			}
			if(strA.equalsIgnoreCase(strB)) compared = true;
		}
		logger.debug("compared_account_real_holder_name_AFTER : {}", strA);
		logger.debug("compared_request_holder_name_AFTER : {}", strB);
		logger.debug("====== compareAandB End ======");
		return compared;
	}
	
}
