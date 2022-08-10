package kr.co.tsoft.sign.util;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Component;

import javax.servlet.http.HttpServletRequest;
import java.math.BigDecimal;
import java.nio.charset.StandardCharsets;
import java.util.Base64;
import java.util.Base64.Decoder;
import java.util.Base64.Encoder;
import java.util.Iterator;
import java.util.List;
import java.util.Map;

@Component
public class CommonUtil {

	private final Logger logger = LoggerFactory.getLogger(CommonUtil.class);
	
	/**
	 * Map 을 String 으로 변환
	 * @param paramMap
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public static String mapToString(Map<String, ?> paramMap) {
		String returnStr = "{";
		Iterator<String> i = paramMap.keySet().iterator();
		while (i.hasNext()) {
			String key = i.next();
			if (paramMap.get(key) instanceof List<?>) {
				returnStr += ("\"" + key + "\":" + listToString((List<Map<String, ?>>) paramMap.get(key)) + ",");
			} else if (paramMap.get(key) instanceof Map<?, ?>) {
				returnStr += ("\"" + key + "\":" + mapToString((Map<String, ?>) paramMap.get(key)) + ",");
			} else if (paramMap.get(key) instanceof Double) {
				BigDecimal bigDecimal = new BigDecimal((Double) paramMap.get(key));
				returnStr += ("\"" + key + "\":\"" + bigDecimal.toString() + "\",");
			} else {
				if (paramMap.get(key) != null) {
					returnStr += ("\"" + key + "\":\"" + paramMap.get(key).toString().replaceAll("\r\n", "").replaceAll("\n", "").replaceAll("'", "\\\\'") + "\",");
				} else {
					returnStr += ("\"" + key + "\":\"" + paramMap.get(key) + "\",");
				}
			}
		}
		if (!"{".equals(returnStr)) {
			returnStr = returnStr.substring(0, returnStr.length() - 1) + "}";
		} else {
			returnStr = returnStr + "}";
		}
		return returnStr;
	}
	
	/**
	 * List 를 String 으로 변환
	 * @param paramList
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public static String listToString(List<?> paramList) {
		String returnStr = "[";
		if (paramList != null && paramList.size() > 0) {
			for (int i = 0; i < paramList.size(); i++) {
				if (paramList.get(i) instanceof Map<?, ?>) {
					returnStr += (mapToString((Map<String, ?>) paramList.get(i))) + ",";
				}
			}
		}
		if (!"[".equals(returnStr)) {
			returnStr = returnStr.substring(0, returnStr.length() - 1) + "]";
		} else {
			returnStr = returnStr + "]";
		}
		return returnStr;
	}
	
	/**
	 * 해당 Map 의 Key 값이 Null 인지 Check 
	 * @param map
	 * @param key
	 * @return
	 */
	public boolean isNull(Map<String, Object> map, String key) {
		boolean result = false;

		if (!map.containsKey(key) || map.get(key) == null) {
			result = true;
		}

		return result;
	}
	
	/**
	 * UTF-8 Base Encoding
	 * @param str
	 * @return
	 */
	public String base64Encode(String str) {
		String returnStr = str;
		if (null != returnStr && !"".equals(returnStr)) {
			Encoder encoder = Base64.getEncoder();
			byte[] bytes = returnStr.getBytes(StandardCharsets.UTF_8);
			returnStr = encoder.encodeToString(bytes);
		}
		return returnStr;
	}
	
	/**
	 * UTF-8 Base Decoding
	 * @param str64
	 * @return
	 */
	public String base64Decode(String str64) {
		Decoder decoder = Base64.getDecoder();
		String returnStr;
		if (null == str64 || "".equals(str64)) {
			returnStr = "";
		} else {
			returnStr = new String(decoder.decode(str64), StandardCharsets.UTF_8);
		}
		return returnStr;
	}

	public static String getClientIpAddr(HttpServletRequest request) {
		String ip = request.getHeader("X-Forwarded-For");
		if (ip == null || ip.length() == 0 || ip.equalsIgnoreCase("unknown")) {
			ip = request.getHeader("Proxy-Client-IP");
		}
		if (ip == null || ip.length() == 0 || ip.equalsIgnoreCase("unknown")) {
			ip = request.getHeader("WL-Proxy-Client-IP");
		}
		if (ip == null || ip.length() == 0 || ip.equalsIgnoreCase("unknown")) {
			ip = request.getHeader("HTTP_X_FORWARDED_FOR");
		}
		if (ip == null || ip.length() == 0 || ip.equalsIgnoreCase("unknown")) {
			ip = request.getHeader("HTTP_X_FORWARDED");
		}
		if (ip == null || ip.length() == 0 || ip.equalsIgnoreCase("unknown")) {
			ip = request.getHeader("HTTP_X_CLUSTER_CLIENT_IP");
		}
		if (ip == null || ip.length() == 0 || ip.equalsIgnoreCase("unknown")) {
			ip = request.getHeader("HTTP_CLIENT_IP");
		}
		if (ip == null || ip.length() == 0 || ip.equalsIgnoreCase("unknown")) {
			ip = request.getHeader("HTTP_FORWARDED_FOR");
		}
		if (ip == null || ip.length() == 0 || ip.equalsIgnoreCase("unknown")) {
			ip = request.getHeader("HTTP_FORWARDED");
		}
		if (ip == null || ip.length() == 0 || ip.equalsIgnoreCase("unknown")) {
			ip = request.getHeader("HTTP_VIA");
		}
		if (ip == null || ip.length() == 0 || ip.equalsIgnoreCase("unknown")) {
			ip = request.getHeader("REMOTE_ADDR");
		}
		if (ip == null || ip.length() == 0 || ip.equalsIgnoreCase("unknown")) {
			ip = request.getRemoteAddr();
		}
		return ip;
	}

}
