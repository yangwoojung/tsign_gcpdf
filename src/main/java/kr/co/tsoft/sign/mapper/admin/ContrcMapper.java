package kr.co.tsoft.sign.mapper.admin;

import kr.co.tsoft.sign.vo.admin.ContractGridDTO;
import kr.co.tsoft.sign.vo.common.TotalRowCount;
import org.apache.ibatis.annotations.Mapper;

import java.util.HashMap;
import java.util.List;

@Mapper
public interface ContrcMapper {

    HashMap<String, Object> selectContrcInfo(HashMap<String, Object> parameter);

    List<ContractGridDTO> selectContrcList(ContractGridDTO searchVO);

    TotalRowCount countSelectContrcList(ContractGridDTO searchVO);

    int insertContrcReg(ContractGridDTO paramVO);

    int updateContrcPin(HashMap<String, Object> pinParam);

	int updateContrcReg(ContractGridDTO paramVO);

	ContractGridDTO selectContrcInfo2(ContractGridDTO paramVO);

}
