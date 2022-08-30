package kr.co.tsoft.sign.mapper.admin;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

@Mapper
public interface AttachmentMapper {

	List<Map<String, Object>> selectAttachmentList();

}
