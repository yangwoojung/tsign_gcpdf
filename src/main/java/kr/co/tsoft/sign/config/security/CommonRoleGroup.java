package kr.co.tsoft.sign.config.security;

import org.springframework.security.core.GrantedAuthority;

public class CommonRoleGroup implements GrantedAuthority {

    private static final long serialVersionUID = 1L;

    private String roleName;

    @Override
    public String getAuthority() {
        return this.roleName;
    }

    public String getRoleName() {
        return roleName;
    }

    public void setRoleName(String roleName) {
        this.roleName = roleName;
    }
}
