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
import kr.co.tsoft.sign.vo.common.CommonResponse;
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
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Service
@RequiredArgsConstructor
public class AttachService {

    private final Logger logger = LoggerFactory.getLogger(AttachService.class);

    private final ApiService apiService;
    private final ContrcService contrcService;
    private final ContractAttachmentMapper contractAttachmentMapper;

    @Value("${config.upload.dir}")
    private String CONTRACT_PATH;


    public List<Map<String, Object>> docList() {
        List<Map<String, Object>> docList = new ArrayList<Map<String, Object>>();
        Map<String, Object> map = new HashMap<>();
        Map<String, Object> map2 = new HashMap<>();

        map.put("docNm", "신분증");
        map.put("maxCnt", "5");
        map.put("docCd", "001");
        map.put("subReq", "1");

        map2.put("docNm", "통장사본");
        map2.put("maxCnt", "5");
        map2.put("docCd", "002");
        map2.put("subReq", "1");

        docList.add(map);
        docList.add(map2);

        return docList;
    }

    @Transactional
    public CommonResponse<?> uploadAttachFile(ContractAttachmentDTO contractAttachmentDTO) throws Exception {

        logger.info("##### [attach > uploadAttachFile Service] #####");

        CommonUserDetails user = SessionUtil.getUser();
        String contractNo = user.getContractNo();

        String attachmentCd = contractAttachmentDTO.getAttachmentCd();
        String imgNm = contractNo + "_" + attachmentCd;
        String img = contractAttachmentDTO.getFile();

        String savePath = CONTRACT_PATH + contractNo + File.separator + "attach" + File.separator;

        switch (attachmentCd) {
            case "001":
                savePath = savePath + "신분증";
                break;
            case "002":
                savePath = savePath + "통장사본";
                break;
        }

        File uploadedFile = transferDecryptDataToDestFile(savePath, imgNm, img);



        // OCR 연결
        if ("001".equals(attachmentCd)) {
            MultipartBody.Part filePart = MultipartBody.Part.createFormData("file", uploadedFile.getName(),
                    okhttp3.RequestBody.create(MediaType.parse("image/*"), uploadedFile));

            ApiRequest.Ocr ocrRequest = ApiRequest.Ocr.builder()
                    .token("WuL299MCpJEwTs5ArcpoYJB4GaQ0PQ") // 운영토큰
                    .file(filePart).build();

            logger.info("### OCR API Request : {} ", ocrRequest);
            ApiResponse<ApiResponseData.Ocr> ocrResponse = apiService.processOcr(ocrRequest);
            logger.info("### OCR API Response : {} ", ocrResponse);

            // OCR API 통신 성공시 "0000"
            if ("0000".equals(ocrResponse.getCode())) {
                ApiResponseData<ApiResponseData.Ocr> ocr = ocrResponse.getData().get(0);
                // OCR 성공시 "0000"
                if ("0000".equals(ocr.getCode())) {
                    ApiResponseData.Ocr data = ocr.getData();

                    // OCR 성공시 스크랩 진행하여 진위여부 확인
                    // 주민등록번호의 경우 IdType : 1
                    if ("1".equals(data.getIdType())) {
                        ApiRequest.Scrap scrapRequest = ApiRequest.Scrap.builder()
                                .token("fc2yilEkhclyP1xGnWRNVFFIptXTLd")
                                .type(attachmentCd)
                                .col1(data.getName())
                                .col2(data.getSocialNo())
                                .col3(data.getIssueDt())
                                .build();

                        logger.info("#### Scrap API Request : {} ", scrapRequest);
                        ApiResponse<ApiResponseData.Scrap> scrapResponse = apiService.processScrap(scrapRequest);
                        logger.info("#### Scrap API Response : {} ", scrapResponse);
                    }

                }

            }

        } else {
            //TODO: 디렉토리가 존재하면 FAIL 처리 ?
            File Directory = new File(savePath);
            if (Directory.exists()) {
                return CommonResponse.fail("S", "0000");
            }
        }

        // 계약자의 구비서류 업로드 완료처리
        // TODO: OCR 또는 스크랩 체크가 필요한 경우 전부 완료되었을때 업로드 완료 처리 할수있도록 함
        ContractAttachmentDTO updateContractAttachment = ContractAttachmentDTO.builder()
                .contractNo(contractNo)
                .attachmentCd(attachmentCd)
                .uploadedFile(uploadedFile.getAbsolutePath())
                .uploadedYn("Y")
                .build();

        updateContractAttachment(updateContractAttachment);

        // TODO: RESPONSE DATA 공통처리 필요
        // 예) OCR 성공후 스크랩 실패의 경우 별도로 화면에서 추가 작성할 수 있도록 함
        return CommonResponse.success();
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
    public CommonResponse<?> getContractAttachmentsToBeUploaded() {
        CommonUserDetails user = SessionUtil.getUser();
        List<ContractAttachmentDTO> list = contractAttachmentMapper.selectContractAttachmentToBeUploaded(user.getContractNo());

        return CommonResponse.success(list);
    }

    /**
     * 계약자의 구비서류 업로드 상태 업데이트
     */
    public void updateContractAttachment(ContractAttachmentDTO dto) {
        contractAttachmentMapper.updateUploadedContractAttachment(dto);
    }
}
