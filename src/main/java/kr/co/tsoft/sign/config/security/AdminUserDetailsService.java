package kr.co.tsoft.sign.config.security;

import kr.co.tsoft.sign.mapper.AdminLoginMapper;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.HashMap;

@Service
public class AdminUserDetailsService implements UserDetailsService {

    private final Logger Logger = LoggerFactory.getLogger(AdminUserDetailsService.class);

    @Autowired
    AdminLoginMapper adminLoginMapper;

    @Override
    public CommonUserDetails loadUserByUsername(String adminId) throws UsernameNotFoundException {

        HashMap<String, Object> param = new HashMap<String, Object>();
        param.put("adm_id", adminId);

        HashMap<String, Object> adminInfo = adminLoginMapper.selectAdminInfo(param);
        if (adminInfo == null) {
            Logger.debug("##### not found admin ID : " + adminId);
            throw new UsernameNotFoundException("not found admin ID");
        }

        // set role : ROLE_ADMIN
        ArrayList<CommonRoleGroup> authorities = new ArrayList<CommonRoleGroup>();
        CommonRoleGroup roleGroup = new CommonRoleGroup();
        roleGroup.setRoleName("ROLE_ADMIN");
        authorities.add(roleGroup);

        CommonUserDetails userDetails = CommonUserDetails.builder()
        												.authorities(authorities)
        												.username((String) adminInfo.get("ADM_ID"))
        												.password((String) adminInfo.get("ADM_PWD"))
        												.adminNm((String) adminInfo.get("ADM_NM"))
        												.adminCellNo((String) adminInfo.get("ADM_CELL_NO"))
        												.build();
        
        return userDetails;
    }
}
