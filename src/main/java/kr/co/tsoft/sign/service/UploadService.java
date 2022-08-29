package kr.co.tsoft.sign.service;

import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.util.List;

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

        //Info - ocr : Y, scrap : Y
        if(Constant.REQUIRED_VALUE.equals(attachInfoInDB.getOcrYn()) && Constant.REQUIRED_VALUE.equals(attachInfoInDB.getScrapYn())) {
            response = verifyTheFile(uploadedFile, user);
            logger.debug("uploadAttachFile > response : {}", response);
        }
        //TODO:구비서류 업로드 완료 처리
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
            return CommonResponse.fail("API 통신 실패", "0001");
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
                    return CommonResponse.fail("module 미지정","0002");
                }
            }
            RequiredApiResponseDTO response = requiredApiResponseDtoMapper.of(ocrData);
            logger.debug(" ### response : {} ###",response);

            if(ocrData != null) {
                if("1".equals(response.getIdType())) {
                    String[] socialNumbers = getSocialNumbers(ocrData.getSocialNo());

                    response.setSocialNo1(socialNumbers[0]);
                    response.setSocialNo2(socialNumbers[1]);

                } else if("3".equals(response.getIdType())) {
                    String[] licenseNumbers = getLicenseNumbers(ocrData.getLicenseNo());

                    response.setLicenseNo1(licenseNumbers[0]);
                    response.setLicenseNo2(licenseNumbers[1]);
                    response.setLicenseNo3(licenseNumbers[2]);
                    response.setLicenseNo4(licenseNumbers[3]);
                }
                sessionDTOMapper.updateUserDetails(user, response);
            } else {
                return CommonResponse.fail("OCR 데이터 미존재", "0002");
            }

            //스크래핑 성공
            if(scrapData != null) {
                return CommonResponse.success();
            } else {
                return CommonResponse.fail("scrap 데이터 미존재","0003");
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

    //try catch로
    private String[] getSocialNumbers(String socialNumber) {
        String[] socialNumbers = new String[2];


        if(socialNumber.length() >= 6) {
            socialNumbers[0] = socialNumber.substring(0,6);
            socialNumbers[1] = socialNumber.substring(6,socialNumber.length() -1);
        } else {
            socialNumbers[0] = socialNumber;
            socialNumbers[1] = "";
        }

        return socialNumbers;
    }

    private String[] getLicenseNumbers(String licenseNo) {
        String[] licenseNumbers = licenseNo.split("-");
        return licenseNumbers;
    }

}
