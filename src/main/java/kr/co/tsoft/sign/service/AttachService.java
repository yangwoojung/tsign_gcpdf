package kr.co.tsoft.sign.service;

import java.io.File;
import java.util.ArrayList;
import java.util.List;
import java.util.Optional;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import kr.co.tsoft.sign.config.security.CommonUserDetails;
import kr.co.tsoft.sign.mapper.ContractAttachmentMapper;
import kr.co.tsoft.sign.util.FileUtil;
import kr.co.tsoft.sign.util.MailHandler;
import kr.co.tsoft.sign.util.SessionUtil;
import kr.co.tsoft.sign.vo.ApiRequest;
import kr.co.tsoft.sign.vo.ApiResponse;
import kr.co.tsoft.sign.vo.ApiResponseData;
import kr.co.tsoft.sign.vo.ApiResponseData.OutB001;
import kr.co.tsoft.sign.vo.ApiResponseData.Scrap;
import kr.co.tsoft.sign.vo.ContractAttachmentDTO;
import kr.co.tsoft.sign.vo.InfoDTO;
import kr.co.tsoft.sign.vo.common.CommonResponse;
import kr.co.tsoft.sign.vo.common.Constant;
import kr.co.tsoft.sign.vo.common.ErrorCode;
import lombok.RequiredArgsConstructor;

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

    public CommonResponse<?> scrapping(InfoDTO infoDTO) {
        logger.info("#### [attachService > scrapping] start ##### ");
        logger.info("#### [attachService > scrapping] AttachCheckDTO : {} ##### ", infoDTO);

        CommonUserDetails user = SessionUtil.getUser();
        
        String socialNo1 = infoDTO.getSocialNo1();
        String socialNo2 = infoDTO.getSocialNo2();
        
		ApiRequest.Scrap.ScrapBuilder builder = ApiRequest.Scrap.builder()
																.token("fc2yilEkhclyP1xGnWRNVFFIptXTLd");
		  
		if("1".equals(user.getIdType())) {
			
			builder	.type("001")
					.col1(infoDTO.getUserNm())
				    .col2(socialNo1 + socialNo2)
				    .col3(infoDTO.getIssueDt());
			
		} else if("3".equals(user.getIdType())) {
			
		  	builder .type("002")
		  	        .col1(infoDTO.getType3_ownerNm())
		  		    .col2(infoDTO.getJuminNo())
		  		    .col3(infoDTO.getLicense01())
		  			.col4(infoDTO.getLicense02())
		  			.col5(infoDTO.getLicense03())
		  			.col6(infoDTO.getLicense04());
		  }
		  
		ApiRequest.Scrap request = builder.build();
	
		logger.info("#### Scrap API Request : {} ", request);
		
		ApiResponse<ApiResponseData.Scrap> response = null;
			response = apiService.processScrap(request);
			logger.info("#### Scrap API Response : {} ", response);

			if(!"0000".equals(response.getCode())) {
				return CommonResponse.fail(ErrorCode.COMMON_SYSTEM_ERROR);
			} else {
				OutB001 getDataInresponse = response.getData().get(0).getData().getOutB0001();
				
				if("Y".equals(getDataInresponse.getTruthYn()) || "Y".equals(getDataInresponse.getLicenceTruthYn())) {
					return CommonResponse.success();
				} else if(getDataInresponse.getLicenceTruthYn() != null) {
					return CommonResponse.fail(response, getDataInresponse.getLicenceTruthMsg());
				} else {
					return CommonResponse.fail(ErrorCode.COMMON_SYSTEM_ERROR);
				}
			}
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
