package kr.co.tsoft.sign.mapper;

import org.apache.ibatis.annotations.Mapper;

import java.util.HashMap;

@Mapper
public interface AdminLoginMapper {

    HashMap<String, Object> selectAdminInfo(HashMap<String, Object> param);
}
