package kr.co.tsoft.sign.config.security;

import kr.co.tsoft.sign.mapper.UserLoginMapper;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.HashMap;

@Service
public class SignUserDetailsService implements UserDetailsService {

	private final Logger Logger = LoggerFactory.getLogger(SignUserDetailsService.class);

	@Autowired
	UserLoginMapper userLoginMapper;

	@Override
	public CommonUserDetails loadUserByUsername(String contractNo) throws UsernameNotFoundException {
		CommonUserDetails userDetails = new CommonUserDetails();

		HashMap<String, Object> param = new HashMap<String, Object>();
		param.put("contrc_no", contractNo);

		HashMap<String, Object> contractInfo = userLoginMapper.selectContractInfo(param);
		if (contractInfo == null) {
			Logger.debug("##### not found contract no : " + contractNo);
			throw new UsernameNotFoundException("not found contract no");
		}

		// set role : ROLE_SIGN
		ArrayList<CommonRoleGroup> authorities = new ArrayList<CommonRoleGroup>();
		CommonRoleGroup roleGroup = new CommonRoleGroup();
		roleGroup.setRoleName("ROLE_SIGN");
		authorities.add(roleGroup);

		userDetails.setAuthorities(authorities);
		userDetails.setUsername((String) contractInfo.get("CONTRC_NO"));
		userDetails.setContrcNo((String) contractInfo.get("CONTRC_NO"));
//		userDetails.setPassword((String) contractInfo.get("PIN_NO"));
		userDetails.setUserNm((String) contractInfo.get("USER_NM"));
		userDetails.setCellNo((String) contractInfo.get("CELL_NO"));
		userDetails.setEmail((String) contractInfo.get("EMAIL"));
		userDetails.setSignDueSdate((String) contractInfo.get("SIGN_DUE_SDATE"));
		userDetails.setSignDueEdate((String) contractInfo.get("SIGN_DUE_EDATE"));

		return userDetails;
	}
}
