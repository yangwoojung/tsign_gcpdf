package kr.co.tsoft.sign.service.admin;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;

import kr.co.tsoft.sign.mapper.admin.AttachmentMapper;
import kr.co.tsoft.sign.util.SendMessage;

@Service
public class AttachmentService {

    private final Logger Logger = LoggerFactory.getLogger(AttachmentService.class);
    @Autowired
    AttachmentMapper attachmentMapper;
    @Value("${spring.profiles.active}")
    private String active;
    @Autowired
    private SendMessage sendMessage;

    public List<Map<String, Object>> selectAttachmentList() {
        return attachmentMapper.selectAttachmentList();
    }

    
}
