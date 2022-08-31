package kr.co.tsoft.sign.controller;

import com.clipsoft.lowagie.text.DocumentException;
import com.clipsoft.org.apache.commons.io.FileUtils;
import kr.co.tsoft.sign.config.security.CommonUserDetails;
import kr.co.tsoft.sign.service.ComService;
import kr.co.tsoft.sign.service.admin.FormService;
import kr.co.tsoft.sign.util.SessionUtil;
import kr.co.tsoft.sign.vo.FileDTO;
import kr.co.tsoft.sign.vo.common.CommonResponse;
import lombok.RequiredArgsConstructor;
import org.apache.commons.codec.binary.Base64;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import java.io.File;
import java.io.IOException;
import java.util.HashMap;
import java.util.Map;

@Controller
@RequiredArgsConstructor
@RequestMapping(value = {"/sign/pdf"})
public class PdfController {

    private final Logger logger = LoggerFactory.getLogger(getClass());

    private final ComService comService;
    private final FormService formService;

    @Value("${config.upload.dir}")
    private String uploadDir;
    @Value("${config.pdf.temp.dir}")
    private String pdfTempDir;

    @RequestMapping("/view")
    public ModelAndView viewReport() throws Exception {
        logger.debug("===== /pdf/view 이동  ======");
        ModelAndView mv = new ModelAndView();

        CommonUserDetails user = SessionUtil.getUser();

        user.setBankName("국민은행");
        user.setBankAccountNo("593502-01-238928");
        user.setAddress("서울 구로구 개봉동 170-1 개봉대상아파트 101동 104호");
        user.setSocialNo1("910710");
        user.setSocialNo2("1063131");

        //서식 원본 조회
        FileDTO fileDTO = FileDTO.builder()
                .contractNo(user.getContractNo())
                .fileType("100")
                .build();

        FileDTO formInfoInDB = formService.selectContrcFormInfo(fileDTO);
        if (null == formInfoInDB) {
            throw new Exception("서식파일이 존재하지 않습니다.");
        }

        String lastPath = "form";

        String fileFullName = formInfoInDB.getFilePath() + formInfoInDB.getSavFileNm();
        File oriFile = new File(fileFullName);

        //상대경로에 pdf가 존재해야 하는 이유로 temp파일로 복사해서 사용
        String newFileFullName = pdfTempDir + File.separator;
        File copyFile = new File(newFileFullName);

        logger.debug("어드민에서 저장한 서식 경로 : " + oriFile);
        logger.debug("유저쪽에서 사용할 복사된 서식 경로 : " + copyFile);

        FileUtils.copyFileToDirectory(oriFile, copyFile);

        mv.addObject("file", formInfoInDB);
        mv.addObject("user", user);

        mv.setViewName("sign/pdfViewer");

        return mv;
    }

    /*
     * 생성된 계약서 업로드 */
    @RequestMapping("/createPdfUpload")
    @ResponseBody
    public CommonResponse<?> upload(@RequestParam String base64File) throws Exception {
    	
    	CommonUserDetails user = SessionUtil.getUser();
    	String contractNo = user.getContractNo();
    	String userNm = user.getUserNm();

        String filePath = uploadDir + File.separatorChar + contractNo;
        File file = new File(filePath + File.separatorChar + userNm + ".pdf");
        
        logger.info("### 계약서 경로 " + file.getAbsoluteFile());

        FileUtils.writeByteArrayToFile(file, Base64.decodeBase64(base64File.getBytes()));

        return CommonResponse.success();
    }

    @RequestMapping("/completeContract")
    @ResponseBody
    public HashMap<String, Object> createPdf(@RequestParam Map<String, String> parameter
    ) throws IOException, DocumentException {
//		HashMap<String, Object> resultMap = new HashMap<String, Object>();
//		
//		covertPdf.test();

        // 추적표 조회&생성 => 메일전송
//		HashMap<String, Object> resultMap = pdfService.createHistPdf(parameter.get("contrcNo"));

//		return resultMap;
        return null;
    }

    public void mkdir(String contrcNo) {
        String path = uploadDir + File.separatorChar + contrcNo; //폴더 경로
        File Folder = new File(path);

        // 해당 디렉토리가 없을경우 디렉토리를 생성합니다.
        if (!Folder.exists()) {
            try {
                Folder.mkdir(); //폴더 생성합니다.
                logger.info("폴더가 생성되었습니다.");
            } catch (Exception e) {
                e.getStackTrace();
            }
        } else {
            logger.info("이미 폴더가 생성되어 있습니다.");
        }
    }

}
