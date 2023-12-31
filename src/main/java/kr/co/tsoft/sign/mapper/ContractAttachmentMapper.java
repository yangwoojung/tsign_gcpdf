package kr.co.tsoft.sign.mapper;

import kr.co.tsoft.sign.vo.ContractAttachmentDTO;
import org.apache.ibatis.annotations.Mapper;

@Mapper
public interface ContractAttachmentMapper {

    ContractAttachmentDTO selectOneAttachmentToBeUploaded(ContractAttachmentDTO dto);

    void updateUploadedAttachment(ContractAttachmentDTO dto);

	ContractAttachmentDTO selectAttachInfoByAttachCd(String attachmentCd);
	
	int insertContractAttachmentList(ContractAttachmentDTO dto);

	void updateSkipAttachment(ContractAttachmentDTO contractAttachmentInDB);
}
