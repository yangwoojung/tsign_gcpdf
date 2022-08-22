package kr.co.tsoft.sign.mapper;

import org.apache.ibatis.annotations.Mapper;

import kr.co.tsoft.sign.vo.ContrcMgmtVO;

import java.util.HashMap;

@Mapper
public interface UserLoginMapper {

    HashMap<String, Object> selectContractInfo(HashMap<String, Object> param);

	ContrcMgmtVO selectContractInfoForVO(String contractNo);
}
