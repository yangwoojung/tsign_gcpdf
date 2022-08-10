package kr.co.tsoft.sign.util;

import org.springframework.web.context.request.RequestAttributes;
import org.springframework.web.context.request.RequestContextHolder;

import java.util.Map;

public class SessionUtil {
	
	public static void setAttribute(String name, Object object) {
		RequestContextHolder.getRequestAttributes().setAttribute(name, object, RequestAttributes.SCOPE_SESSION);
	}

	public static Object getAttribute(String name) {
		return (Object) RequestContextHolder.getRequestAttributes().getAttribute(name, RequestAttributes.SCOPE_SESSION);
	}

	public static void removeAttribute(String name) {
		RequestContextHolder.getRequestAttributes().removeAttribute(name, RequestAttributes.SCOPE_SESSION);
	}

	public static String getSessionId() {
		return RequestContextHolder.getRequestAttributes().getSessionId();
	}

	public static void setUser(Object object) {
		setAttribute("user", object);
	}

	@SuppressWarnings("unchecked")
	public static Map<String, Object> getUser() {
		return (Map<String, Object>) getAttribute("user");
	}

}
