package kr.co.tsoft.sign.service;

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
import kr.co.tsoft.sign.vo.RequiredApiResponseDTO;
import kr.co.tsoft.sign.vo.common.CommonResponse;
import kr.co.tsoft.sign.vo.common.Constant;
import lombok.RequiredArgsConstructor;
import okhttp3.MediaType;
import okhttp3.MultipartBody;
import org.apache.commons.codec.binary.Base64;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.util.ArrayList;
import java.util.Map;
import java.util.Optional;

@Service
@RequiredArgsConstructor
public class AttachService {

    private final Logger logger = LoggerFactory.getLogger(AttachService.class);

    private final ApiService apiService;
    private final ContrcService contrcService;
    private final ContractAttachmentMapper contractAttachmentMapper;

    @Value("${config.upload.dir}")
    private String CONTRACT_PATH;

    @Transactional
    public CommonResponse<?> uploadAttachFile(ContractAttachmentDTO contractAttachmentDTO) throws Exception {

        logger.info("##### [attach > uploadAttachFile Service] #####");
        
        CommonUserDetails user = SessionUtil.getUser();
        String contractNo = user.getContractNo(); //계약번호

        String attachmentCd = contractAttachmentDTO.getAttachmentCd(); //서류코드
        
        ContractAttachmentDTO attachInfoInDB = contractAttachmentMapper.selectAttachInfoByAttachCd(attachmentCd); //attachmentInfo

        String savePath = CONTRACT_PATH + contractNo + File.separator + "attach";
        File uploadedFile = transferDecryptDataToDestFile(savePath, contractNo + "_" + attachmentCd, contractAttachmentDTO.getFile());
        
        RequiredApiResponseDTO response = new RequiredApiResponseDTO();

        //ocrYn과 scrapYn이 둘 다 필수값인 경우 진위확인으로 진행
        if(Constant.REQUIRED_VALUE.equals(attachInfoInDB.getOcrYn()) && Constant.REQUIRED_VALUE.equals(attachInfoInDB.getScrapYn())) {
        	MultipartBody.Part filePart = MultipartBody.Part.createFormData("file", uploadedFile.getName(),
                    okhttp3.RequestBody.create(MediaType.parse("image/*"), uploadedFile));
        	
        	ApiRequest.Verify verifyRequest = ApiRequest.Verify.builder()
        												.token("yBnwrSX4mGfOMd11IUf4KyuwnsVZ5I")
        												.file(filePart).build();
        	
        	ApiResponse<ApiResponseData.Verify> verifyResponse = apiService.processVerify(verifyRequest);
        	logger.info("### Verify API Response : {} ", verifyResponse);
        	
        	//OCR 실패
        	if(!"0000".equals(verifyResponse.getData().get(0).getCode())) {
        		//에러코드 정해야 함
        		return CommonResponse.fail("OCR 실패", "0001");
        	} else {
        		response.builder()
    			.name(verifyResponse.getData().get(0).getData().getName())
    			.idType(verifyResponse.getData().get(0).getData().getIdType())
    			.socialNo(verifyResponse.getData().get(0).getData().getSocialNo())
    			.issueDt(verifyResponse.getData().get(0).getData().getIssueDt())
    			.licenseNo(verifyResponse.getData().get(0).getData().getLicenseNo())
    			.build();
        		//스크래핑 실패
        		if(!"0000".equals(verifyResponse.getData().get(1).getCode())) {
        			// TODO: RESPONSE DATA 공통처리 필요
        	        // 예) OCR 성공후 스크랩 실패의 경우 별도로 화면에서 추가 작성할 수 있도록 함
        			//fail시에도  객체 보낼 수 있어야 할듯
        			return CommonResponse.success(response, "scrap 실패");
        		} else if("0000".equals(verifyResponse.getCode())) {
        			// 계약자의 구비서류 업로드 완료처리
        	        // TODO: OCR 또는 스크랩 체크가 필요한 경우 전부 완료되었을때 업로드 완료 처리 할수있도록 함
        	        ContractAttachmentDTO updateContractAttachment = ContractAttachmentDTO.builder()
        	                .contractNo(contractNo)
        	                .attachmentCd(attachmentCd)
        	                .uploadedFile(uploadedFile.getAbsolutePath())
        	                .uploadedYn("Y")
        	                .build();

        	        updateContractAttachment(updateContractAttachment);
        			return CommonResponse.success(response);
        		} else {
        			return CommonResponse.fail("일시적 오류", "0001");
        		}
        	}
        }
        return CommonResponse.fail("일시적 오류", "0001");
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

    public ApiResponse<ApiResponseData.Scrap> scrapping(Map<String, Object> param) {
        logger.info("#### [attachService > scrapping] start ##### ");
        logger.info("#### [attachService > scrapping] param : {} ##### ", param);

        ApiRequest.Scrap request = ApiRequest.Scrap.builder().token("fc2yilEkhclyP1xGnWRNVFFIptXTLd")
                .type((String) param.get("type")).col1((String) param.get("col1")).col2((String) param.get("col2"))
                .col3((String) param.get("col3")).col4((String) param.get("col4")).col5((String) param.get("col5"))
                .col6((String) param.get("col6")).build();

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
     * 계약자의 구비서류 업로드 상태 업데이트
     */
    public void updateContractAttachment(ContractAttachmentDTO dto) {
        contractAttachmentMapper.updateUploadedAttachment(dto);
    }
}
