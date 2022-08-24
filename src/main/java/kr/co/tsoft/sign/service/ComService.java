package kr.co.tsoft.sign.service;

import kr.co.tsoft.sign.mapper.ComMapper;
import kr.co.tsoft.sign.vo.admin.FormGridDTO;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.HashMap;

@Service
public class ComService {

    @Autowired
    ComMapper comMapper;

    public int insertFileUpload(HashMap<String, String> fileInfo) {
        return comMapper.insertFileUpload(fileInfo);
    }

    public int insertFileUpload(FormGridDTO form) {
        return comMapper.insertFileUpload2(form);
    }
}
