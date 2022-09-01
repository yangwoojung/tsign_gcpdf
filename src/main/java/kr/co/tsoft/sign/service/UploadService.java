package kr.co.tsoft.sign.service;

import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;

import org.apache.commons.codec.binary.Base64;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import kr.co.tsoft.sign.config.security.CommonUserDetails;
import kr.co.tsoft.sign.mapper.ContractAttachmentMapper;
import kr.co.tsoft.sign.util.SessionUtil;
import kr.co.tsoft.sign.vo.ApiRequest;
import kr.co.tsoft.sign.vo.ApiResponse;
import kr.co.tsoft.sign.vo.ApiResponseData;
import kr.co.tsoft.sign.vo.ApiResponseData.Verify;
import kr.co.tsoft.sign.vo.ContractAttachmentDTO;
import kr.co.tsoft.sign.vo.RequiredApiResponseDTO;
import kr.co.tsoft.sign.vo.RequiredApiResponseDTOMapper;
import kr.co.tsoft.sign.vo.SessionDTOMapper;
import kr.co.tsoft.sign.vo.common.CommonResponse;
import kr.co.tsoft.sign.vo.common.Constant;
import kr.co.tsoft.sign.vo.common.ErrorCode;
import lombok.RequiredArgsConstructor;
import okhttp3.MediaType;
import okhttp3.MultipartBody;

@Service
@RequiredArgsConstructor
public class UploadService {

    private final Logger logger = LoggerFactory.getLogger(AttachService.class);

    private final ContractAttachmentMapper contractAttachmentMapper;
    private final ApiService apiService;
    private final RequiredApiResponseDTOMapper requiredApiResponseDtoMapper;
    private final SessionDTOMapper sessionDTOMapper;

    @Value("${config.upload.dir}")
    private String CONTRACT_PATH;

    @Transactional
    public CommonResponse<?> uploadAttachFile(ContractAttachmentDTO contractAttachmentDTO) throws Exception {

        logger.info("##### [uploadService > uploadAttachFile ] #####");

        CommonUserDetails user = SessionUtil.getUser();
        String contractNo = user.getContractNo(); //계약번호
        String attachmentCd = contractAttachmentDTO.getAttachmentCd(); //서류코드

        //DB에서 attachementCd에 따른 Info 조회
        ContractAttachmentDTO attachInfoInDB = contractAttachmentMapper.selectAttachInfoByAttachCd(attachmentCd); //attachmentInfo

        //경로 지정 및 파일  업로드
        String savePath = CONTRACT_PATH + contractNo + File.separator + "attach";
        File uploadedFile = transferDecryptDataToDestFile(savePath, contractNo + "_" + attachmentCd, contractAttachmentDTO.getFile());
        
        CommonResponse<?> response = null;
        	
        try {
			boolean requiredOcr = Constant.REQUIRED_VALUE.equals(attachInfoInDB.getOcrYn());
			boolean requiredScrap = Constant.REQUIRED_VALUE.equals(attachInfoInDB.getScrapYn());

				//ocr 필수 && scrap 필수
			    if(requiredOcr && requiredScrap) {
			        response = verifyTheFile(uploadedFile, user);
			    } 
			    
			    ContractAttachmentDTO.ContractAttachmentDTOBuilder builder = ContractAttachmentDTO.builder()
			    																					.contractNo(contractNo)
			    																					.attachmentCd(attachmentCd)
			    																					.uploadedFile(uploadedFile.getAbsolutePath())
			    																					.uploadedYn("N");
			    if(!"FAIL".equals(response.getMessage())) {
			    	builder.uploadedYn("Y");
			    }

		        ContractAttachmentDTO updateContractAttachment = builder.build();
		        updateContractAttachment(updateContractAttachment);
			    
		} catch (Exception e) {
			e.printStackTrace();
		}
        return response;
    }

    public CommonResponse<?> verifyTheFile(File uploadedFile, CommonUserDetails user) {

        MultipartBody.Part filePart = MultipartBody.Part.createFormData("file", uploadedFile.getName(),
            okhttp3.RequestBody.create(MediaType.parse("image/*"), uploadedFile));

        ApiRequest.Verify verifyRequest = ApiRequest.Verify.builder()
												            .token("yBnwrSX4mGfOMd11IUf4KyuwnsVZ5I")
												            .file(filePart).build();

        ApiResponse<ApiResponseData.Verify> verifyResponse = apiService.processVerify(verifyRequest);
        logger.info("### Verify API Response : {} ", verifyResponse);

        //API 통신 실패
        if(!"0000".equals(verifyResponse.getCode())) {
            return CommonResponse.fail(ErrorCode.COMMON_SYSTEM_ERROR, "FAIL");
        } else {
            //ocr / scrap 데이터 구분
            Verify ocrData = null;
            Verify scrapData = null;

            for(ApiResponseData <Verify> list : verifyResponse.getData()) {
                if("O".equals(list.getModule())) {
                    ocrData = list.getData();
                } else if("S".equals(list.getModule())) {
                    scrapData = list.getData();
                } else {
                    return CommonResponse.fail(ErrorCode.COMMON_SYSTEM_ERROR,"FAIL");
                }
            }
            RequiredApiResponseDTO response = requiredApiResponseDtoMapper.of(ocrData);
            
            logger.info(" ##### ocrData : {}" , ocrData);
            logger.info(" ##### RequiredApiResponseDTO response : {}", response);

            if(ocrData != null) {
            	String idType = ocrData.getIdType();
                if("1".equals(idType)) {
                    String[] socialNumbers = getSocialNumbers(ocrData.getSocialNo());

                    response.setSocialNo1(socialNumbers[0]);
                    response.setSocialNo2(socialNumbers[1]);

                } else if("3".equals(idType)) {
                    String[] licenseNumbers = getLicenseNumbers(ocrData.getLicenseNo());

                    response.setLicenseNo1(licenseNumbers[0]);
                    response.setLicenseNo2(licenseNumbers[1]);
                    response.setLicenseNo3(licenseNumbers[2]);
                    response.setLicenseNo4(licenseNumbers[3]);
                }
                response.setIssueDt(ocrData.getIssueDt().replaceAll("-", ""));
                sessionDTOMapper.updateUserDetails(user, response);
                logger.info(" ##### RequiredApiResponseDTO response : {}", response);
                logger.info(" ##### user : {}", user);
            } else {
                return CommonResponse.fail(ErrorCode.COMMON_INVALID_PARAMETER, "FAIL");
            }
            
            //스크래핑 성공
            if("Y".equals(scrapData.getOutB0001().getTruthYn()) || "Y".equals(scrapData.getOutB0001().getLicenceTruthYn())) {
                return CommonResponse.success(response);
            } else {
                return CommonResponse.fail(response, "FAIL");
            }
        }
    }

    public File transferDecryptDataToDestFile(String filePath, String fileName, String fileData) throws IOException {
        byte[] data = fileData.getBytes();
        String DecodeString = new String(data, "UTF-8");
        String[] removeDataString = DecodeString.split("base64,");
        byte[] decodedByte = null;
        String extension = ".jpg";
        if (DecodeString.indexOf("base64,") != -1) {
            decodedByte = Base64.decodeBase64(removeDataString[1]);
            String extensionHeaderString = removeDataString[0].toLowerCase();
            if (extensionHeaderString.indexOf("png") != -1) {
                extension = ".jpg";
            } else if (extensionHeaderString.indexOf("jpg") == -1 && extensionHeaderString.indexOf("jpeg") == -1) {
                if (extensionHeaderString.indexOf("pdf") != -1) {
                    extension = ".pdf";
                } else {
                    extension = ".tiff";
                }
            } else {
                extension = ".jpg";
            }
        } else {
            decodedByte = Base64.decodeBase64(removeDataString[0]);
        }

        File newDirectory = new File(filePath);
        if (!newDirectory.exists()) {
            newDirectory.mkdirs();
        }

        File destFile = new File(filePath + File.separator + fileName + extension);
        FileOutputStream stream = new FileOutputStream(destFile);

        try {
            stream.write(decodedByte);
        } finally {
            stream.close();
        }

        return destFile;
    }
    
    private String[] getSocialNumbers(String socialNumber) {
        String[] socialNumbers = new String[2];
        try {
			if(socialNumber.length() >= 6) {
			    socialNumbers[0] = socialNumber.substring(0,6);
			    socialNumbers[1] = socialNumber.substring(6,socialNumber.length() -1);
			} else {
			    socialNumbers[0] = socialNumber;
			    socialNumbers[1] = "";
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
        return socialNumbers;
    }

    private String[] getLicenseNumbers(String licenseNo) {
    	String[] licenseNumbers = new String[4];
    	if(licenseNo.contains("-")) {
    		licenseNumbers = licenseNo.split("-");
    	} else {
    		licenseNumbers[0] = licenseNo.substring(0,2);
    		licenseNumbers[1] = "";
    		licenseNumbers[2] = "";
    		licenseNumbers[3] = "";
    	}
        return licenseNumbers;
    }

    /**
     * 계약자의 구비서류 업로드 상태 업데이트
     */
    public void updateContractAttachment(ContractAttachmentDTO dto) {
        contractAttachmentMapper.updateUploadedAttachment(dto);
    }
}
