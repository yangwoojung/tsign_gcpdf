package kr.co.tsoft.sign.config;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.context.annotation.Configuration;

import javax.servlet.http.HttpSessionEvent;
import javax.servlet.http.HttpSessionListener;
import java.util.concurrent.TimeUnit;

@Configuration
public class SessionListener implements HttpSessionListener {

	private final Logger logger = LoggerFactory.getLogger(SessionListener.class);

	@Override
	public void sessionCreated(HttpSessionEvent se) {
		int interval = (int) TimeUnit.SECONDS.convert(30, TimeUnit.MINUTES);
		logger.debug("#### CREATED SESSION ID : {} ", se.getSession().getId());
		se.getSession().setMaxInactiveInterval(interval);
	}

	@Override
	public void sessionDestroyed(HttpSessionEvent se) {
		logger.debug("#### DESTROYED SESSION ID : {} ", se.getSession().getId());
	}
}
