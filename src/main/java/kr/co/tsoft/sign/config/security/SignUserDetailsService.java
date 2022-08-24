package kr.co.tsoft.sign.config.security;

import kr.co.tsoft.sign.mapper.UserLoginMapper;
import kr.co.tsoft.sign.service.UserLoginService;
import kr.co.tsoft.sign.vo.ContractVO;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.stereotype.Service;

import java.util.ArrayList;

@Service
public class SignUserDetailsService implements UserDetailsService {

	private final Logger Logger = LoggerFactory.getLogger(SignUserDetailsService.class);

	@Autowired
	UserLoginMapper userLoginMapper;
	
	@Autowired
	UserLoginService userService;

	@Override
	public CommonUserDetails loadUserByUsername(String contractNo) throws UsernameNotFoundException {

		ContractVO contractInfo = userService.selectContractInfoForVO(contractNo);
		
		if (contractInfo == null) {
			Logger.debug("##### not found contract no : " + contractNo);
			throw new UsernameNotFoundException("not found contract no");
		}

		// set role : ROLE_SIGN
		ArrayList<CommonRoleGroup> authorities = new ArrayList<CommonRoleGroup>();
		CommonRoleGroup roleGroup = new CommonRoleGroup();
		roleGroup.setRoleName("ROLE_SIGN");
		authorities.add(roleGroup);
		
		CommonUserDetails userDetails = CommonUserDetails.builder()
														.authorities(authorities)
														.username(contractInfo.getContractNo())
														.contractNo(contractInfo.getContractNo())
														.userNm(contractInfo.getUserNm())
														.cellNo(contractInfo.getCellNo())
														.email(contractInfo.getEmail())
														.signDueSdate(contractInfo.getSignDueSdate())
														.signDueEdate(contractInfo.getSignDueEdate())
														.build();

		return userDetails;
	}
}
