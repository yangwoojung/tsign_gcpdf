package kr.co.tsoft.sign.mapper;

import org.apache.ibatis.annotations.Mapper;

import java.util.HashMap;
import java.util.Map;

@Mapper
public interface PdfMapper {

	Map<String, Object> selectAdmin(HashMap<String, String> paramMap);

	Map<String, Object> selectContrcInfoByContrcNo(HashMap<String, String> paramMap);

}
