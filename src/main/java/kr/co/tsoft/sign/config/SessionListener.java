package kr.co.tsoft.sign.config;

import org.springframework.context.annotation.Configuration;

import javax.servlet.http.HttpSessionEvent;
import javax.servlet.http.HttpSessionListener;
import java.util.concurrent.TimeUnit;

@Configuration
public class SessionListener implements HttpSessionListener {

	@Override
	public void sessionCreated(HttpSessionEvent se) {
		int interval = (int) TimeUnit.SECONDS.convert(1L, TimeUnit.HOURS);

		se.getSession().setMaxInactiveInterval(interval);
	}

	@Override
	public void sessionDestroyed(HttpSessionEvent se) {
	}
}
