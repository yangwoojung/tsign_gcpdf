package kr.co.tsoft.sign.service;

import kr.co.tsoft.sign.mapper.ComMapper;
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
}
