package kr.co.tsoft.sign.util;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Component;

import javax.net.ssl.HttpsURLConnection;
import javax.net.ssl.SSLContext;
import javax.net.ssl.X509TrustManager;
import java.io.BufferedReader;
import java.io.InputStreamReader;
import java.io.OutputStream;
import java.net.URL;
import java.security.cert.X509Certificate;

@Component
public class SendMessage {

	/*
	 * 뿌리오 발송 API 경로 - 서버측 인코딩과 응답형태에 따라 선택
	 */
	@Value("${sms.send.api}")
	String SEND_API_URL; // UTF-8 인코딩과 JSON 응답용 호출 페이지

	@Value("${sms.send.id}")
	private String SMS_SEND_ID;

	@Value("${sms.send.number}")
	private String SMS_SEND_NUMBER;

	public String send(String phone, String msg, String names, String appdate,
					   String subject) throws Exception {
		StringBuffer sb = new StringBuffer();
		sb.append("userid=");
		sb.append(SMS_SEND_ID);
		sb.append("&callback=");
		sb.append(SMS_SEND_NUMBER);
		sb.append("&phone=");
		sb.append(phone);
		sb.append("&msg=");
		sb.append(msg);
		sb.append("&names=");
		sb.append(names);
		sb.append("&appdate=");
		sb.append(appdate);
		sb.append("&subject=");
		sb.append(subject);
		return postHttps(SEND_API_URL, sb.toString());
	}

	private String postHttps(String apiUrl, String messageInfo) throws Exception {
		String resp = "";
		String readResp = "";

		HttpsURLConnection conn = null;

		try {
			SSLContext sslctx = SSLContext.getInstance("SSL");
			sslctx.init(null, new X509TrustManager[]{new MyTrustManager()}, null);

			HttpsURLConnection.setDefaultSSLSocketFactory(sslctx.getSocketFactory());

			URL url = new URL(apiUrl);
			conn = (HttpsURLConnection) url.openConnection();
			conn.setRequestMethod("POST");
			conn.setDoOutput(true);

			OutputStream os = conn.getOutputStream();
			os.write(messageInfo.getBytes());
			os.flush();
			os.close();

			BufferedReader br = null;
			if (conn.getResponseCode() == HttpsURLConnection.HTTP_OK) {
				br = new BufferedReader(new InputStreamReader(conn.getInputStream()));
			}

			String line = "";
			while ((line = br.readLine()) != null) {
				readResp += line;
			}
			resp = readResp;

			return resp;
		} catch (Exception ex) {
			ex.printStackTrace();
			throw new Exception("HTTPS exception : " + ex.toString());
		} finally {
			if (conn != null) {
				conn.disconnect();
			}
		}
	}

	class MyTrustManager implements X509TrustManager {
		public void checkClientTrusted(X509Certificate[] chain, String authType) {
		}

		public void checkServerTrusted(X509Certificate[] chain, String authType) {
		}

		public X509Certificate[] getAcceptedIssuers() {
			return new X509Certificate[0];
		}
	}

}
