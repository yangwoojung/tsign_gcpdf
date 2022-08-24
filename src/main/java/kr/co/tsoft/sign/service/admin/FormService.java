package kr.co.tsoft.sign.service.admin;

import kr.co.tsoft.sign.mapper.admin.FormMapper;
import kr.co.tsoft.sign.service.ComService;
import kr.co.tsoft.sign.util.MultipartFileHandler;
import kr.co.tsoft.sign.util.SecurityUtil;
import kr.co.tsoft.sign.vo.FileDTO;
import kr.co.tsoft.sign.vo.admin.FormGridDTO;
import kr.co.tsoft.sign.vo.common.GridResponse;
import kr.co.tsoft.sign.vo.common.TotalRowCount;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

@Service
@RequiredArgsConstructor
public class FormService {

    private final MultipartFileHandler multipartFileHandler;
    private final ComService comService;
    private final FormMapper formMapper;

    public List<FormGridDTO> selectFormList(FormGridDTO parameter) {
        return formMapper.selectFormList(parameter);
    }

    public TotalRowCount countSelectFormList(FormGridDTO parameter) {
        return formMapper.countSelectFormList(parameter);
    }

    public FileDTO selectContrcFormInfo(FileDTO fileDTO) {
        return formMapper.selectContrcFormInfo(fileDTO);
    }

    public GridResponse getFormList(FormGridDTO searchVO) {

        //전체 리스트 조회
        TotalRowCount count = countSelectFormList(searchVO);
        // 서식 리스트 조회
        List<FormGridDTO> selectFromList = selectFormList(searchVO);
        GridResponse response = new GridResponse();
        response.setData(selectFromList);
        response.setDraw(searchVO.getDraw());
        response.setRecordsTotal(count.getRowCount());
        response.setRecordsFiltered(count.getRowCount());

        return response;
    }

    public void deleteForm(String param) {

    }

    @Transactional
    public FormGridDTO insertForm(FormGridDTO form) throws Exception {

        //원본 계약서(100), 원본 추적표(101), 생성된 계약서(102), 생성된 추적표(103)
        form.setFileType("100");

        // 서버에 파일 저장
        form = multipartFileHandler.handleFiles(form);

        SecurityUtil su = new SecurityUtil();
        form.setRegId(su.getAdminUserDetails().getUsername());
        form.setModId(su.getAdminUserDetails().getUsername());

        comService.insertFileUpload(form);

        return form;
    }
}
