package kr.co.tsoft.sign.service;

import java.io.File;
import java.io.IOException;
import java.util.ArrayList;
import java.util.Map;
import java.util.Optional;

import org.apache.tomcat.util.codec.binary.Base64;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.clipsoft.org.apache.commons.io.FileUtils;

import kr.co.tsoft.sign.config.security.CommonUserDetails;
import kr.co.tsoft.sign.mapper.ContractAttachmentMapper;
import kr.co.tsoft.sign.service.admin.ContrcService;
import kr.co.tsoft.sign.util.FileUtil;
import kr.co.tsoft.sign.util.MailHandler;
import kr.co.tsoft.sign.util.SessionUtil;
import kr.co.tsoft.sign.vo.ApiRequest;
import kr.co.tsoft.sign.vo.ApiResponse;
import kr.co.tsoft.sign.vo.ApiResponseData;
import kr.co.tsoft.sign.vo.ContractAttachmentDTO;
import kr.co.tsoft.sign.vo.common.CommonResponse;
import kr.co.tsoft.sign.vo.common.Constant;
import kr.co.tsoft.sign.vo.common.ErrorCode;
import lombok.RequiredArgsConstructor;
import okhttp3.MediaType;
import okhttp3.MultipartBody;

@Service
@RequiredArgsConstructor
public class AttachService {

    private final Logger logger = LoggerFactory.getLogger(AttachService.class);

    private final ApiService apiService;
    private final ContractAttachmentMapper contractAttachmentMapper;
    private final UploadService uploadService;

    @Value("${config.upload.dir}")
    private String CONTRACT_PATH;
    
    
    @Transactional
    public CommonResponse<?> uploadAndVertify(ContractAttachmentDTO contractAttachmentDTO) throws Exception {
    	CommonResponse<?> response = uploadService.uploadAttachFile(contractAttachmentDTO); // 업로드
//    	verifyingIdentificationCard(); // 진위여부 
    	
    	return response;
    }

    @Transactional
    public CommonResponse<?> uploadAttachFile(ContractAttachmentDTO contractAttachmentDTO) throws Exception {
 
    	CommonResponse<?> response = uploadService.uploadAttachFile(contractAttachmentDTO);
        return response;
     }

    public ApiResponse<ApiResponseData.Scrap> scrapping(Map<String, Object> param) {
        logger.info("#### [attachService > scrapping] start ##### ");
        logger.info("#### [attachService > scrapping] param : {} ##### ", param);

        CommonUserDetails user = SessionUtil.getUser();
        
        String idType = "00" + user.getIdType();
        
        logger.info("#### idType : {}", idType);
        
        String socialNo1 = (String) param.get("socialNo1");
        String socialNo2 = (String) param.get("socialNo2");
        
		ApiRequest.Scrap.ScrapBuilder builder = ApiRequest.Scrap.builder()
																.token("fc2yilEkhclyP1xGnWRNVFFIptXTLd")
																.type(idType);
		  
		if("001".equals(idType)) {
			
			builder.col1((String) param.get("userNm"))
				   .col2(socialNo1 + socialNo2)
				   .col3((String) param.get("issueDt"));
			
		} else if("003".equals(idType)) {
			
		  	builder.col1((String) param.get("type2_ownerNm"))
		  		    .col2((String) param.get("socialNo1"))
		  		    .col3((String) param.get("licence01"))
		  			.col4((String) param.get("licence02"))
		  			.col5((String) param.get("licence03"))
		  			.col6((String) param.get("licence04"));
		  }
		
		//      ApiRequest.Scrap request = ApiRequest.Scrap.builder().token("fc2yilEkhclyP1xGnWRNVFFIptXTLd")
		//              .type("").col1((String) param.get("col1")).col2((String) param.get("col2"))
		//              .col3((String) param.get("col3")).col4((String) param.get("col4")).col5((String) param.get("col5"))
		//              .col6((String) param.get("col6")).build();
		  
		ApiRequest.Scrap request = builder.build();
	
	    logger.info("#### Scrap API Request : {} ", request);
	    ApiResponse<ApiResponseData.Scrap> response = apiService.processScrap(request);
	    logger.info("#### Scrap API Response : {} ", response);

	    return response;
    }

    public CommonResponse<?> submission() {
        CommonUserDetails user = SessionUtil.getUser();
        String contNo = user.getContractNo();

        // TODO: 계약자 구비서류 검증
        // 전부 업로드 되었는지 해당 파일이 존재하는지 확인

        String filePath = CONTRACT_PATH + contNo;
        
        // TODO: TSA 적용 필요 
//        String tsaFile = CONTRACT_PATH + "TSA_" + contNo + ".pdf";
//        
//        File file = new File(filePath);
//		MultipartBody.Part filePart = MultipartBody.Part.createFormData("file", contNo, okhttp3.RequestBody.create(MediaType.parse("application/pdf"), file));
//
//		ApiRequest.Tsa requst = ApiRequest.Tsa.builder()
//				.token("vL9adtaTYkphP3vChWoKAkvLH2Ffxv")
//				.file(filePart)
//				.build();
//
//		logger.info("#### API requst : {} ", requst);
//		ApiResponse<ApiResponseData.Tsa> response = apiService.processTsa(requst);
//		logger.info("#### API response : {} ", response);
//		ApiResponseData<ApiResponseData.Tsa> tsaApiResponseData = response.getData().get(0);
//		ApiResponseData.Tsa data = tsaApiResponseData.getData();
//		logger.info("#### API encodeTsaFile : {} ", data);
//		FileUtils.writeByteArrayToFile(new File(tsaFile), Base64.decodeBase64(data.getEncodeTsaFile()));
        
        String zipFileName = filePath + ".zip";

        try {
            FileUtil.compress(filePath, zipFileName);
        } catch (Throwable e) {
            logger.error(" ##### [attachService > submission] 파일 압축 및 추가 실패 ##### ");
            e.printStackTrace();
        }

        File contractZipFile = new File(zipFileName);
        /**
         * 이메일 > 계약자(pdf), 관리자(알집) 메일 전송 후 알집 날리기
         * DB에서 USER_NM, EMAIL 조회
         */
        // 계약자에게 pdf 전송
        MailHandler mail = new MailHandler();
        String toMail = "hmlee@tsoft.co.kr";
        String title = "[(주)티소프트] 전자계약이 완료되었습니다.";
        String content = "<html><body>[(주)티소프트] 전자계약이 완료되었음을 안내드립니다.</body></html>";
        ArrayList<String> attachFileName = new ArrayList<String>();
        attachFileName.add(filePath + File.separator + "contract" + File.separator + contNo + ".pdf");

        mail.send(toMail, title, content, attachFileName);

        return CommonResponse.success();
    }

    /**
     * 계약자의 업로드 해야할 구비서류 리스트
     */
    public CommonResponse<?> getContractAttachmentsToBeUploaded(ContractAttachmentDTO input) {
        CommonUserDetails user = SessionUtil.getUser();

        ContractAttachmentDTO.ContractAttachmentDTOBuilder builder = ContractAttachmentDTO.builder().contractNo(user.getContractNo());
        Optional.ofNullable(input.getAttachmentCd()).ifPresent(builder::attachmentCd);

        ContractAttachmentDTO dto = builder.build();
        ContractAttachmentDTO contractAttachmentInDB = contractAttachmentMapper.selectOneAttachmentToBeUploaded(dto);

        return CommonResponse.success(contractAttachmentInDB);
    }

    /**
     * 필수가 아닌 구비서류 스킵  
     */
	public CommonResponse<?> updateSkipAttachment(ContractAttachmentDTO input) {
		CommonUserDetails user = SessionUtil.getUser();
		
		ContractAttachmentDTO dto = ContractAttachmentDTO.builder()
				.contractNo(user.getContractNo())
				.attachmentCd(input.getAttachmentCd())
				.build();
		
		ContractAttachmentDTO contractAttachmentInDB = contractAttachmentMapper.selectOneAttachmentToBeUploaded(dto);
		
		// DB에 있는 계약자의 구비서류 필수 여부 확인
		if(Constant.REQUIRED_VALUE.equals(contractAttachmentInDB.getRequiredYn())) return CommonResponse.fail(ErrorCode.COMMON_ILLEGAL_STATUS);
		
		contractAttachmentMapper.updateSkipAttachment(contractAttachmentInDB);
			
		return CommonResponse.success();
	}

}
