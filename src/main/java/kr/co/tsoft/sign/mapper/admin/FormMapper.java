package kr.co.tsoft.sign.mapper.admin;

import kr.co.tsoft.sign.vo.admin.FormGridDto;
import kr.co.tsoft.sign.vo.common.TotalRowCount;
import org.apache.ibatis.annotations.Mapper;

import java.util.HashMap;
import java.util.List;

@Mapper
public interface FormMapper {

    List<FormGridDto> selectFormList(FormGridDto parameter);
    TotalRowCount countSelectFormList(FormGridDto parameter);
//    List<Map<String, Object>> selectFormList(Map<String, Object> parameter);
//
//    int countSelectFormList(Map<String, Object> parameter);

    List<HashMap<String, Object>> selectContrcFormList(HashMap<String, String> paramMap);

    HashMap<String, String> selectContrcFormInfo(HashMap<String, String> paramMap);

}
