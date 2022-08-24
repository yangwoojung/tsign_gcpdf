package kr.co.tsoft.sign.mapper.admin;

import kr.co.tsoft.sign.vo.FileDTO;
import kr.co.tsoft.sign.vo.admin.FormGridDTO;
import kr.co.tsoft.sign.vo.common.TotalRowCount;
import org.apache.ibatis.annotations.Mapper;

import java.util.List;

@Mapper
public interface FormMapper {

    List<FormGridDTO> selectFormList(FormGridDTO parameter);
    TotalRowCount countSelectFormList(FormGridDTO parameter);

    FileDTO selectContrcFormInfo(FileDTO fileDTO);

}
