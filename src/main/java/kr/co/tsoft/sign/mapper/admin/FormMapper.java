package kr.co.tsoft.sign.mapper.admin;

import kr.co.tsoft.sign.vo.FileMgmtVO;
import kr.co.tsoft.sign.vo.admin.FormGridDto;
import kr.co.tsoft.sign.vo.common.TotalRowCount;
import org.apache.ibatis.annotations.Mapper;

import java.util.List;

@Mapper
public interface FormMapper {

    List<FormGridDto> selectFormList(FormGridDto parameter);
    TotalRowCount countSelectFormList(FormGridDto parameter);

    FileMgmtVO selectContrcFormInfo(FileMgmtVO fileMgmtVO);

}
