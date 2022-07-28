package kr.co.tsoft.sign.mapper;

import org.apache.ibatis.annotations.Mapper;

import java.util.HashMap;

@Mapper
public interface ComMapper {

    int insertFileUpload(HashMap<String, String> fileInfo);

}
