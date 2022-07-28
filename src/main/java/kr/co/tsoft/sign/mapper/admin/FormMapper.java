package kr.co.tsoft.sign.mapper.admin;

import org.apache.ibatis.annotations.Mapper;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Mapper
public interface FormMapper {

    List<Map<String, Object>> selectFormList(Map<String, Object> parameter);

    int countSelectFormList(Map<String, Object> parameter);

    List<HashMap<String, Object>> selectContrcFormList(HashMap<String, String> paramMap);

    HashMap<String, String> selectContrcFormInfo(HashMap<String, String> paramMap);

}
