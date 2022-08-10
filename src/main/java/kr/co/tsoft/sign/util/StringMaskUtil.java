package kr.co.tsoft.sign.util;

import org.apache.commons.lang3.StringUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import java.util.Arrays;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

public class StringMaskUtil extends StringUtils {

	private final static Logger logger = LoggerFactory.getLogger(StringMaskUtil.class);

	public static String mask(String str, String regex, int group, char mask) {
		if (isEmpty(str)) {
			return str;
		}

		Matcher matcher = Pattern.compile(regex).matcher(str);
		if (!matcher.matches()) {
			logger.debug("masking ... not match");
			return str;
		}

		String rep = "";

		for (int i = 1; i <= matcher.groupCount(); i++) {
			logger.debug(">> {}", matcher.group(i));
			if (i == group) {
				char[] c = new char[matcher.group(i).length()];
				Arrays.fill(c, mask);
				rep += String.valueOf(c);
			} else {
				rep += matcher.group(i);
			}
		}

		return rep;
	}

	public static String maskIp(String str) {
		String replaceString = str;

		Matcher matcher = Pattern.compile("^([0-9]{1,3})\\.([0-9]{1,3})\\.([0-9]{1,3})\\.([0-9]{1,3})$").matcher(str);

		if (matcher.matches()) {
			replaceString = "";

			for (int i = 1; i <= matcher.groupCount(); i++) {
				String replaceTarget = matcher.group(i);
				if (i == 2) {
					char[] c = new char[replaceTarget.length()];
					Arrays.fill(c, '*');

					replaceString = replaceString + String.valueOf(c);
				} else {
					replaceString = replaceString + replaceTarget;
				}
				if (i < matcher.groupCount()) {
					replaceString = replaceString + ".";
				}
			}
		}

		return replaceString;
	}

	public static String maskPhone(String str) {
		if (isEmpty(str)) {
			return str;
		}

		String regex = "^(.+)(.{4})(.{4})$";
		int group = 3;
		char mask = '*';

		Matcher matcher = Pattern.compile(regex).matcher(str);
		if (!matcher.matches()) {
			logger.debug("masking ... not match");
			return str;
		}

		String rep = "";

		for (int i = 1; i <= matcher.groupCount(); i++) {
			logger.debug(">> {}", matcher.group(i));
			if (i == group) {
				char[] c = new char[matcher.group(i).length()];
				Arrays.fill(c, mask);
				rep += String.valueOf(c);
			} else {
				rep += matcher.group(i);
			}
		}

		return rep;
	}

	public static String maskName(String name) {
		String maskedName = ""; // 마스킹 이름
		String firstName = ""; // 성
		String middleName = ""; // 이름 중간
		String lastName = ""; // 이름 끝
		int lastNameStartPoint; // 이름 시작 포인터
		if (!name.equals("") || name != null) {
			if (name.length() > 1) {
				firstName = name.substring(0, 1);
				lastNameStartPoint = name.indexOf(firstName);
				if (name.trim().length() > 2) {
					middleName = name.substring(lastNameStartPoint + 1, name.trim().length() - 1);
					lastName = name.substring(lastNameStartPoint + (name.trim().length() - 1), name.trim().length());
				} else {
					middleName = name.substring(lastNameStartPoint + 1, name.trim().length());
				}
				String makers = "";
				for (int i = 0; i < middleName.length(); i++) {
					makers += "*";
				}
				lastName = middleName.replace(middleName, makers) + lastName;
				maskedName = firstName + lastName;
			} else {
				maskedName = name;
			}
		}
		return maskedName;
	}

	public static String maskJumin(String jumin) {
		if (StringUtils.isNotBlank(jumin) && jumin.length() == 13) {
			String firstJumin = jumin.substring(0, 6);
			String lastJumin = jumin.substring(6);
			jumin = firstJumin.replaceAll("(.{2}$)", "**") + lastJumin.replaceAll("(.{6}$)", "******");
		}
		return jumin;
	}

}
