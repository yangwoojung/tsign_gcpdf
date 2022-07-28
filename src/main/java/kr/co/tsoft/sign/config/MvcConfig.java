package kr.co.tsoft.sign.config;

import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.security.config.annotation.method.configuration.EnableGlobalMethodSecurity;
import org.springframework.web.servlet.config.annotation.CorsRegistry;
import org.springframework.web.servlet.config.annotation.InterceptorRegistry;
import org.springframework.web.servlet.config.annotation.ResourceHandlerRegistry;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurerAdapter;

@EnableGlobalMethodSecurity
@Configuration
public class MvcConfig extends WebMvcConfigurerAdapter {

    @Bean
    public HttpInterceptor httpInterceptor() {
        HttpInterceptor hi = new HttpInterceptor();
        return hi;
    }

    //	@Bean
//	public HttpFirewall allowUrlEncodedSlashHttpFirewall() {
//	    StrictHttpFirewall fireWall = new StrictHttpFirewall();
//	    fireWall.setAllowUrlEncodedSlash(true);    
//	    return fireWall;
//	}
//	
//	public void configure(WebSecurity web) throws Exception {
//	// add it 
//	web.httpFirewall(allowUrlEncodedSlashHttpFirewall());
//	}
//	
    @Override
    public void addCorsMappings(CorsRegistry registry) {
        registry
                .addMapping("/**")
                .allowedOrigins("*")
                .allowedMethods("*");
    }

    @Override
    public void addInterceptors(InterceptorRegistry registry) {
        registry
                .addInterceptor(httpInterceptor())
                .addPathPatterns("/**");
    }

    @Override
    public void addResourceHandlers(ResourceHandlerRegistry registry) {
        registry
                .addResourceHandler("/resources/**")
                .addResourceLocations("WEB-INF/resources/");
    }
}
