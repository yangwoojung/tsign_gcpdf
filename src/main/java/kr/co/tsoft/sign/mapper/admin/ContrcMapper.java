package kr.co.tsoft.sign.mapper.admin;

import org.apache.ibatis.annotations.Mapper;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Mapper
public interface ContrcMapper {

    HashMap<String, Object> selectContrcInfo(HashMap<String, Object> paramMap);

    List<Map<String, Object>> selectContrcList(Map<String, Object> parameter);

    int countSelectContrcList(Map<String, Object> parameter);

    int insertContrcReg(HashMap<String, Object> parameter);

    int updateContrcPin(HashMap<String, Object> pinParam);

}
