package kr.co.tsoft.sign.mapper;

import kr.co.tsoft.sign.vo.ContractDTO;
import org.apache.ibatis.annotations.Mapper;

@Mapper
public interface UserLoginMapper {

	ContractDTO selectContractInfoForVO(String contractNo);
}
