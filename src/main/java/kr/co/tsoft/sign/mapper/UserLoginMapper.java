package kr.co.tsoft.sign.mapper;

import kr.co.tsoft.sign.vo.ContractVO;
import org.apache.ibatis.annotations.Mapper;

@Mapper
public interface UserLoginMapper {

	ContractVO selectContractInfoForVO(String contractNo);
}
