package kr.co.tsoft.sign.mapper;

import kr.co.tsoft.sign.vo.ContractAttachmentDTO;
import org.apache.ibatis.annotations.Mapper;

import java.util.List;

@Mapper
public interface ContractAttachmentMapper {

    List<ContractAttachmentDTO> selectContractAttachmentToBeUploaded(String contractNo);

    void updateUploadedContractAttachment(ContractAttachmentDTO dto);
}
