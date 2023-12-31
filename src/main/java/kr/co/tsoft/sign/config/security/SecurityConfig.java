package kr.co.tsoft.sign.config.security;

import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.core.annotation.Order;
import org.springframework.security.authentication.AuthenticationProvider;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.config.annotation.web.builders.WebSecurity;
import org.springframework.security.config.annotation.web.configuration.EnableWebSecurity;
import org.springframework.security.config.annotation.web.configuration.WebSecurityConfigurerAdapter;
import org.springframework.security.web.firewall.DefaultHttpFirewall;
import org.springframework.security.web.firewall.HttpFirewall;

@Configuration
@EnableWebSecurity
public class SecurityConfig {

    @Bean
    public AuthenticationProvider authenticationProvider() {
        return new CommonAuthenticationProvider();
    }

    @Configuration
    @Order(1)
    public static class SecuritySignConfig extends WebSecurityConfigurerAdapter {

        @Bean
        public HttpFirewall defaultHttpFirewall() {
            return new DefaultHttpFirewall();
        }


        @Override
        public void configure(WebSecurity web) throws Exception {
            web.httpFirewall(defaultHttpFirewall());
            web.ignoring().antMatchers("/resources/**");
        }

        @Override
        protected void configure(HttpSecurity http) throws Exception {
            http
                    .antMatcher("/sign/**")
                    .authorizeRequests()
                    .antMatchers("/cmi/**").permitAll()
                    .antMatchers("/sign/error/**").permitAll()
                    .antMatchers("/sign/cert/**").permitAll()
                    .antMatchers("/sign/pin/**").permitAll()
                    .antMatchers("/sign/complete").permitAll()
                    .antMatchers("/test/**").permitAll()
                    .anyRequest().hasRole("SIGN")
                    .and()
                    .formLogin()
                    .loginPage("/sign/error/401")
                    .loginProcessingUrl("/sign/authenticate")
                    .defaultSuccessUrl("/sign/cert/checkAccount", true)
//                    .defaultSuccessUrl("/sign/attach/id", true)
                    .usernameParameter("c")
                    .passwordParameter("p")
                    .failureUrl("/sign/error/401")
                    .and()
                    .logout()
                    .logoutUrl("/sign/logout")
                    .deleteCookies("JSESSIONID")
                    .invalidateHttpSession(true)
                    .logoutSuccessUrl("/sign/error/401");

            http
                    .sessionManagement()
                    .maximumSessions(1)
                    .expiredUrl("/sign/error/401")
                    .maxSessionsPreventsLogin(false);

            http
                    .headers().frameOptions().sameOrigin();//동일 도메인 ifream오류 해결

            http
                    .csrf()
                    .disable();
        }
    }

    @Configuration
    @Order(2)
    public static class SecurityAdminConfig extends WebSecurityConfigurerAdapter {

        @Override
        public void configure(WebSecurity web) throws Exception {
            web.ignoring().antMatchers("/resources/**");
        }

        @Override
        protected void configure(HttpSecurity http) throws Exception {
            http
                    .antMatcher("/admin/**")
                    .authorizeRequests()
                    .antMatchers("/admin/login").permitAll()
                    .anyRequest().hasRole("ADMIN")
                    .and()
                    .formLogin()
                    .loginPage("/admin/login")
                    .loginProcessingUrl("/admin/authenticate")
                    .defaultSuccessUrl("/admin/main", true)
                    .usernameParameter("i")
                    .passwordParameter("p")
                    .failureUrl("/admin/login?failure")
                    .and()
                    .logout()
                    .logoutUrl("/admin/logout")
                    .deleteCookies("JSESSIONID")
                    .invalidateHttpSession(true)
                    .logoutSuccessUrl("/admin/login?logout");

            http
                    .sessionManagement()
                    .maximumSessions(1)
                    .expiredUrl("/admin/login?expired")
                    .maxSessionsPreventsLogin(false);

            http
                    .csrf()
                    .disable();
        }
    }
}
