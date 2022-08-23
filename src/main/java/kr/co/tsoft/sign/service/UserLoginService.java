package kr.co.tsoft.sign.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.co.tsoft.sign.mapper.UserLoginMapper;
import kr.co.tsoft.sign.vo.ContrcMgmtVO;

@Service
public class UserLoginService {
	
	@Autowired
	UserLoginMapper userMapper;

	public ContrcMgmtVO selectContractInfoForVO(String contractNo) {
		return userMapper.selectContractInfoForVO(contractNo);
	}

}
