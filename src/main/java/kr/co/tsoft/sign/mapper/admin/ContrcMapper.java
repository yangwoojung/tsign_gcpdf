package kr.co.tsoft.sign.mapper.admin;

import kr.co.tsoft.sign.vo.admin.ContractGridDto;
import kr.co.tsoft.sign.vo.common.TotalRowCount;
import org.apache.ibatis.annotations.Mapper;

import java.util.HashMap;
import java.util.List;

@Mapper
public interface ContrcMapper {

    HashMap<String, Object> selectContrcInfo(HashMap<String, Object> parameter);

    List<ContractGridDto> selectContrcList(ContractGridDto searchVO);

    TotalRowCount countSelectContrcList(ContractGridDto searchVO);

    int insertContrcReg(HashMap<String, Object> parameter);

    int updateContrcPin(HashMap<String, Object> pinParam);

}
