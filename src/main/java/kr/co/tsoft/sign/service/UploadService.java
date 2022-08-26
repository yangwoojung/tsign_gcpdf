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
import kr.co.tsoft.sign.vo.ContractAttachmentDTO;
import kr.co.tsoft.sign.vo.RequiredApiRequestDTO;
import kr.co.tsoft.sign.vo.ApiResponseData.Verify;
import kr.co.tsoft.sign.vo.common.CommonResponse;
import kr.co.tsoft.sign.vo.common.Constant;
import okhttp3.MediaType;
import okhttp3.MultipartBody;

@Service
public class UploadService {
	
	private final Logger logger = LoggerFactory.getLogger(AttachService.class);

	private ContractAttachmentMapper contractAttachmentMapper;
	private ApiService apiService;
	
    @Value("${config.upload.dir}")
    private String CONTRACT_PATH;

	@Transactional
    public CommonResponse<?> uploadAttachFile(ContractAttachmentDTO contractAttachmentDTO) throws Exception {

        logger.info("##### [uploadService ] #####");
        
        CommonUserDetails user = SessionUtil.getUser();
        String contractNo = user.getContractNo(); //계약번호

        String attachmentCd = contractAttachmentDTO.getAttachmentCd(); //서류코드
        
        ContractAttachmentDTO attachInfoInDB = contractAttachmentMapper.selectAttachInfoByAttachCd(attachmentCd); //attachmentInfo 
        
        String savePath = CONTRACT_PATH + contractNo + File.separator + "attach";
        //파일  업로드
        File uploadedFile = transferDecryptDataToDestFile(savePath, contractNo + "_" + attachmentCd, contractAttachmentDTO.getFile());
        
        //ocr : Y, scrap : Y
        if(Constant.REQUIRED_VALUE.equals(attachInfoInDB.getOcrYn()) && Constant.REQUIRED_VALUE.equals(attachInfoInDB.getScrapYn())) {
        	
        }
        
		return null;
	}
	
    public CommonResponse<?> verifyingIdentificationCard(File uploadedFile) {
    	
    	MultipartBody.Part filePart = MultipartBody.Part.createFormData("file", uploadedFile.getName(),
                okhttp3.RequestBody.create(MediaType.parse("image/*"), uploadedFile));
    	
    	ApiRequest.Verify verifyRequest = ApiRequest.Verify.builder()
	        												.token("yBnwrSX4mGfOMd11IUf4KyuwnsVZ5I")
	        												.file(filePart).build();
    	
    	ApiResponse<ApiResponseData.Verify> verifyResponse = apiService.processVerify(verifyRequest);
    	logger.info("### Verify API Response : {} ", verifyResponse);
    	
    	Verify apiResponseData = verifyResponse.getData().get(0).getData();
    	
//	       	RequiredApiRequestDTOBuilder requiredApiRequestDTOBuilder = RequiredApiRequestDTO.builder()
//	       																					.token(requiredApiRequestDTO.getToken());
       	
    	return null;
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
}
