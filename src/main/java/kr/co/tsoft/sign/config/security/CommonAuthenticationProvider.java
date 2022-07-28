package kr.co.tsoft.sign.config.security;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.authentication.AuthenticationProvider;
import org.springframework.security.authentication.BadCredentialsException;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.AuthenticationException;
import org.springframework.security.core.userdetails.UsernameNotFoundException;

import javax.servlet.http.HttpServletRequest;

public class CommonAuthenticationProvider implements AuthenticationProvider {

    private final Logger Logger = LoggerFactory.getLogger(CommonAuthenticationProvider.class);

    @Autowired
    HttpServletRequest request;

    @Autowired
    SignUserDetailsService signUserDetailsService;

    @Autowired
    AdminUserDetailsService adminUserDetailsService;

    @Override
    public Authentication authenticate(Authentication authentication) throws AuthenticationException {
        String principal = (String) authentication.getPrincipal();
        String credentials = (String) authentication.getCredentials();

        CommonUserDetails userDetails = null;

        try {
            if ("SIGN".equals(getAuthType())) {
                userDetails = signUserDetailsService.loadUserByUsername(principal);

                if (!credentials.equals(userDetails.getPassword())) {
                    Logger.debug("##### incorrect pin #####");
                    throw new BadCredentialsException("incorrect pin");
                }
            } else if ("ADMIN".equals(getAuthType())) {
                userDetails = adminUserDetailsService.loadUserByUsername(principal);

                if (!credentials.equals(userDetails.getPassword())) {
                    Logger.debug("##### incorrect password #####");
                    throw new BadCredentialsException("incorrect password");
                }
            }
        } catch (UsernameNotFoundException e) {
            e.printStackTrace();
            throw new UsernameNotFoundException(e.getMessage());
        } catch (BadCredentialsException e) {
            e.printStackTrace();
            throw new BadCredentialsException(e.getMessage());
        } catch (Exception e) {
            e.printStackTrace();
            throw new RuntimeException(e.getMessage());
        }

        UsernamePasswordAuthenticationToken token = new UsernamePasswordAuthenticationToken(userDetails, credentials, userDetails.getAuthorities());

        return token;
    }

    private Object getAuthType() {
        String result = "";

        String uri = request.getRequestURI();
        if (uri.contains("sign")) {
            result = "SIGN";
        } else if (uri.contains("admin")) {
            result = "ADMIN";
        }

        return result;
    }

    @Override
    public boolean supports(Class<?> authentication) {
        return authentication.equals(UsernamePasswordAuthenticationToken.class);
    }
}
