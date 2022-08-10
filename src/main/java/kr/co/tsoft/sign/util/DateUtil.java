package kr.co.tsoft.sign.util;

import java.text.SimpleDateFormat;

public class DateUtil {

    /**
     * 입력받은 parttern의 형태로 DateTime 리턴
     *
     * @param pattern yyyyMMddHHmmssSSS형식의 패턴
     * @return String
     *
     * <p><pre>
     *  - 사용 예
     *        String date = DateUtil.getDateByPattern("yyyyMMddHHmmssSSS");
     *  결과 : 20080719153048357
     * </pre>
     */
    public static String getDateByPattern(String pattern) {
        return new SimpleDateFormat(pattern, java.util.Locale.KOREA).format(new java.util.Date());
    }

    public static String yyyyMMddHHmmss() {
        return getDateByPattern("yyyyMMddHHmmss");
    }

}
