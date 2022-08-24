package kr.co.tsoft.sign.mapper;

import kr.co.tsoft.sign.vo.admin.FormGridDTO;
import org.apache.ibatis.annotations.Mapper;

import java.util.HashMap;

@Mapper
public interface ComMapper {

    int insertFileUpload(HashMap<String, String> fileInfo);

    int insertFileUpload2(FormGridDTO dto);

}
