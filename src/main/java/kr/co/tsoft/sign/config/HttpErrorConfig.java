package kr.co.tsoft.sign.config;

import org.springframework.boot.autoconfigure.web.ServerProperties;
import org.springframework.boot.context.embedded.ConfigurableEmbeddedServletContainer;
import org.springframework.boot.web.servlet.ErrorPage;
import org.springframework.context.annotation.Configuration;
import org.springframework.http.HttpStatus;

@Configuration
public class HttpErrorConfig extends ServerProperties {

    @Override
    public void customize(ConfigurableEmbeddedServletContainer container) {
        super.customize(container);

        container.addErrorPages(new ErrorPage(HttpStatus.UNAUTHORIZED, "/error/error"));
        container.addErrorPages(new ErrorPage(HttpStatus.FORBIDDEN, "/error/error"));
        container.addErrorPages(new ErrorPage(HttpStatus.NOT_FOUND, "/error/error"));
        container.addErrorPages(new ErrorPage(HttpStatus.METHOD_NOT_ALLOWED, "/error/error"));
        container.addErrorPages(new ErrorPage(HttpStatus.INTERNAL_SERVER_ERROR, "/error/error"));
    }
}
