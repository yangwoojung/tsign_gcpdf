package kr.co.tsoft.sign.service;

import kr.co.tsoft.sign.mapper.UserLoginMapper;
import kr.co.tsoft.sign.vo.ContractDTO;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class UserLoginService {
	
	@Autowired
	UserLoginMapper userMapper;

	public ContractDTO selectContractInfoForVO(String contractNo) {
		return userMapper.selectContractInfoForVO(contractNo);
	}

}
