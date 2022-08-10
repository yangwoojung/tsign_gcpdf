package kr.co.tsoft.sign.service;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;


@Service
public class PdfService {

	private final Logger logger = LoggerFactory.getLogger(PdfService.class);

//	@Value("${spring.profiles.active}")
//	private String active;
//
//	@Value("${config.upload.dir}")
//	private String uploadDir;
//
//	@Autowired
//	private SendMessage sendMessage;
//
//	@Autowired
//	private PdfMapper pdfMapper;
//
//	@Autowired
//	private JsonUtil jsonUtil;
//
//	@Autowired
//	private ConvertHtmlToPdf convertHtmlToPdf;

	//test
//	public Map<String, Object> selectAdmin(HashMap<String, String> paramMap) {
//		return pdfMapper.selectAdmin(paramMap);
//	}
//
//	/**
//	 * @param paramMap
//	 * @return
//	 */
//	public Map<String, Object> selectContrcInfoByContrcNo(HashMap<String, String> paramMap) {
//		return pdfMapper.selectContrcInfoByContrcNo(paramMap);
//	}
//
//
//	/**
//	 * @return
//	 * @Method Name : createHistPdf
//	 * @작성일 : 2020. 9. 4
//	 * @작성자 : TSOFT01
//	 * @변경이력 :
//	 * @Method 설명 : 추적표 생성, 최종 계약서 메일로 전송
//	 */
//	public HashMap<String, Object> createHistPdf(String contrcNo) {
//
//		HashMap<String, Object> result = new HashMap<String, Object>();
//		try {
//			//이력
//			SecurityUtil su = new SecurityUtil();
//
//			LinkedList<HashMap<String, String>> selectHistList = su.getSignUserDetails().getHistoryList();
//
//			// 추적표 생성
//			result = convertHtmlToPdf.createPdf(contrcNo, selectHistList);
//
//			//메일 전송(본인인증 후)
//			try {
//				MailHandler mail = new MailHandler();
//				String toMail = su.getSignUserDetails().getEmail();//세션값
//				String title = "(주)티소프트 전자계약이 완료되었습니다.";
//				String content = "<html><body>(주)티소프트 전자계약이 완료되었습니다.<br/> https://sign.tsoft.co.kr/cmi/" + contrcNo + "</body></html>";
//				ArrayList<String> attachFile = new ArrayList<String>();
//				String contrcFileNm = "(계약서)" + su.getSignUserDetails().getUserNm() + "_" + contrcNo + ".pdf";
//				attachFile.add(uploadDir + File.separatorChar + contrcNo + File.separatorChar + contrcFileNm);//계약서
//				String histFileNm = "(추적표)" + su.getSignUserDetails().getUserNm() + "_" + contrcNo + ".pdf";
//				attachFile.add(uploadDir + File.separatorChar + contrcNo + File.separatorChar + histFileNm);//추적표
//
//				mail.send(toMail, title, content, attachFile);
//				result.put("message", "메일발송 성공하였습니다. ");
//				logger.debug("첨부 메일발송 성공");
//			} catch (Exception e) {
//				result.put("message", "첨부 메일발송 실패하였습니다.");
//				logger.debug("첨부 메일발송 실패");
//				System.out.println(e);
//			}
//		} catch (Exception e) {
//			result.put("message", "추적표 pdf 생성에 실패하였습니다. ");
//			System.out.println(e);
//		}
//
//		return result;
//	}

}
