package kr.co.tsoft.sign.mapper;

import kr.co.tsoft.sign.vo.ContrcMgmtVO;
import org.apache.ibatis.annotations.Mapper;

@Mapper
public interface UserLoginMapper {

	ContrcMgmtVO selectContractInfoForVO(String contractNo);
}
