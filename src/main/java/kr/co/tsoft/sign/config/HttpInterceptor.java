package kr.co.tsoft.sign.config;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Component;
import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@Component
public class HttpInterceptor extends HandlerInterceptorAdapter {

    private final Logger Logger = LoggerFactory.getLogger(HttpInterceptor.class);

    @Override
    public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler) throws Exception {
        Logger.debug("##### HttpInterceptor preHandle #####");
        Logger.debug("##### URL : " + request.getRequestURL());
        return super.preHandle(request, response, handler);
    }
}
