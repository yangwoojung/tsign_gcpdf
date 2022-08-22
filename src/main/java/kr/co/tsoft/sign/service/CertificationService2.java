package kr.co.tsoft.sign.service;

import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.HashMap;
import java.util.Map;
import java.util.Random;

import org.apache.commons.lang3.StringUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.sci.v2.pcc.secu.SciSecuManager;
import com.sci.v2.pcc.secu.hmac.SciHmac;

import kr.co.tsoft.sign.util.SessionUtil;
import kr.co.tsoft.sign.vo.CertificationVO;
import kr.co.tsoft.sign.vo.ContrcMgmtVO;
import kr.co.tsoft.sign.vo.common.CommonResponse;

@Service
public class CertificationService2 {

    private final Logger logger = LoggerFactory.getLogger(CertificationService2.class);

    @Value("${cert.phone.custid}")
    private String CERT_PHONE_CUSTID;

    @Value("${cert.phone.servno}")
    private String CERT_PHONE_SERVNO;

    @Value("${cert.acc.custid}")
    private String CERT_ACC_CUSTID;

    @Value("${cert.acc.servcd}")
    private String CERT_ACC_SERVCD;

    @Value("${service.url}")
    private String SERVICE_URL;
    
    @Autowired
    ObjectMapper objectMapper;
    
//    public HashMap<String, String> initPhoneCert() {
//
//        Calendar today = Calendar.getInstance();
//        SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMddHHmmss");
//        String day = sdf.format(today.getTime());
//
//        // reqNum은 최대 40byte 까지 사용 가능
//        Random rnd = new Random();
//        String reqNum = day + String.format("%06d", rnd.nextInt(999999));
//
//        // 01. 암호화 모듈 선언
//        SciSecuManager seed = new SciSecuManager();
//
//        String separator = "^";
//
//        // 02. 1차 암호화
//        StringBuffer sb = new StringBuffer();
//        sb.append(CERT_PHONE_CUSTID);
//        sb.append(separator);
//        sb.append(CERT_PHONE_SERVNO);
//        sb.append(separator);
//        sb.append(reqNum);
//        sb.append(separator);
//        sb.append(day);
//        sb.append(separator);
//        sb.append("H");
//        sb.append(separator);
//        sb.append("hcheck=y");
//        sb.append(separator);
//        sb.append("0000000000000000");
//        logger.debug("===== 암호화 전 : " + sb);
//        String reqInfo = sb.toString(); // 데이터 암호화
//
//        logger.debug("===== Phone Cert reqInfo 1차 암호화 : " + reqInfo);
//        String encStr = seed.getEncPublic(reqInfo);
//
//        // 03. 위변조 검증 값 생성
//        String hmacMsg = SciHmac.HMacEncriptPublic(encStr);
//
//        // 03. 2차 암호화
//        sb = new StringBuffer();
//        sb.append(encStr);
//        sb.append(separator);
//        sb.append(hmacMsg);
//        sb.append(separator);
//        sb.append("0000000000000000");
//        reqInfo = seed.getEncPublic(sb.toString()); // 2차암호화
//        logger.debug("===== Phone Cert reqInfo 2차 암호화  : " + reqInfo);
//
////        SecurityUtil su = new SecurityUtil();
////        CommonUserDetails userVo = su.getSignUserDetails();
////		UserDetailVO userVo = SessionUtil.getUserDetailVO();
////        if (userVo != null) {
////            userVo.setPhoneCert(reqNum);
////        }
//
//        Map<String, Object> user = SessionUtil.getUser();
//        user.put("phoneCert", reqNum);
//
//        HashMap<String, String> resultMap = new HashMap<String, String>();
//        resultMap.put("reqNum", reqNum);
//        resultMap.put("reqInfo", reqInfo);
//        resultMap.put("retUrl", "32" + SERVICE_URL +  "/sign/cert/idseed");//"32https://sign.tsoft.co.kr/cert/idseed"
//        logger.debug("===== resultMap : " + resultMap);
//        return resultMap;
//    }
    
    public CertificationVO initPhoneCert() {

        Calendar today = Calendar.getInstance();
        SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMddHHmmss");
        String day = sdf.format(today.getTime());

        // reqNum은 최대 40byte 까지 사용 가능
        Random rnd = new Random();
        String reqNum = day + String.format("%06d", rnd.nextInt(999999));

        // 01. 암호화 모듈 선언
        SciSecuManager seed = new SciSecuManager();

        String separator = "^";

        // 02. 1차 암호화
        StringBuffer sb = new StringBuffer();
        sb.append(CERT_PHONE_CUSTID);
        sb.append(separator);
        sb.append(CERT_PHONE_SERVNO);
        sb.append(separator);
        sb.append(reqNum);
        sb.append(separator);
        sb.append(day);
        sb.append(separator);
        sb.append("H");
        sb.append(separator);
        sb.append("hcheck=y");
        sb.append(separator);
        sb.append("0000000000000000");
        logger.debug("===== 암호화 전 : " + sb);
        String reqInfo = sb.toString(); // 데이터 암호화

        logger.debug("===== Phone Cert reqInfo 1차 암호화 : " + reqInfo);
        String encStr = seed.getEncPublic(reqInfo);

        // 03. 위변조 검증 값 생성
        String hmacMsg = SciHmac.HMacEncriptPublic(encStr);

        // 03. 2차 암호화
        sb = new StringBuffer();
        sb.append(encStr);
        sb.append(separator);
        sb.append(hmacMsg);
        sb.append(separator);
        sb.append("0000000000000000");
        reqInfo = seed.getEncPublic(sb.toString()); // 2차암호화
        logger.debug("===== Phone Cert reqInfo 2차 암호화  : " + reqInfo);

//        SecurityUtil su = new SecurityUtil();
//        CommonUserDetails userVo = su.getSignUserDetails();
//		UserDetailVO userVo = SessionUtil.getUserDetailVO();
//        if (userVo != null) {
//            userVo.setPhoneCert(reqNum);
//        }

        Map<String, Object> user = (Map<String, Object>) SessionUtil.getUser();
        user.put("phoneCert", reqNum);
        
        CertificationVO cert = CertificationVO.builder()
		        				.reqNum(reqNum)
		        				.reqInfo(reqInfo)
		        				.retUrl("32" + SERVICE_URL +  "/sign/cert/idseed")
		        				.build();

//        HashMap<String, String> resultMap = new HashMap<String, String>();
//        resultMap.put("reqNum", reqNum);
//        resultMap.put("reqInfo", reqInfo);
//        resultMap.put("retUrl", "32" + SERVICE_URL +  "/sign/cert/idseed");//"32https://sign.tsoft.co.kr/cert/idseed"
//        logger.debug("===== resultMap : " + resultMap);
        return cert;
    }
	/*
	public HashMap<String, String> initAccCert(HashMap<String, String> paramMap, String callbackUrl) throws Exception {
		IBCipher cipher = new IBCipher();
		URLCodec codec = new URLCodec();

		Calendar today = Calendar.getInstance();
		SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMddHHmmss");
		String day = sdf.format(today.getTime());

		Random rnd = new Random();
		String req_code = day + String.format("%06d", rnd.nextInt(999999));

		logger.debug("===== Account Cert req_code : " + req_code);

		String requestParam = "id=" + CERT_ACC_CUSTID;
		requestParam = requestParam + "&svc_code=" + CERT_ACC_SERVCD;
		requestParam = requestParam + "&req_code=" + req_code; // 요청번호-암호화된 결과의 복호화에 사용되는 값으로 요청시마다 발급되어야 함
		requestParam = requestParam + "&bank_holder_number=" + paramMap.get("accNo");

		// requestParam = requestParam + "&name=" + paramMap.get("userName");

		String req_info = codec.encode(cipher.pubEncode(requestParam)); // 요청값들을 암호화 및 url encoding

		UserDetailVO userVo = SessionUtil.getUserDetailVO();
		if (userVo != null) {
			userVo.setAccCert(req_code);
		}

		HashMap<String, String> resultMap = new HashMap<String, String>();
		resultMap.put("req_code", req_code);
		resultMap.put("req_info", req_info);
		resultMap.put("call_back", SERVICE_URL + callbackUrl); // 인증결과 암호화 회신 PAGE (POPUP창 내에서 redirect 되는 URL)
		return resultMap;
	}
	*/

//    public HashMap<String, String> getResultPhoneCert(String retInfo) {
////		UserDetailVO userVo = SessionUtil.getUserDetailVO();
//
////        SecurityUtil su = new SecurityUtil();
////        CommonUserDetails userVo = su.getSignUserDetails();
//        Map<String, Object> user = SessionUtil.getUser();
//        String phoneCert = (String) user.get("phoneCert");
//
//        if (user == null || StringUtils.isBlank(phoneCert)) {
//            logger.error("휴대폰 본인 인증 복호화 키 미존재");
//            throw new RuntimeException("휴대폰 본인 인증 실패.");
//        }
//
////        String phoneCert = userVo.getPhoneCert();//SessionUtil.getUserDetailVO().getPhoneCert();
//
//        // 1. 암호화 모듈 (jar) Loading
//        SciSecuManager sciSecuMg = new SciSecuManager();
//        // 쿠키에서 생성한 값을 Key로 생성 한다.
//        retInfo = sciSecuMg.getDec(retInfo, phoneCert);
//
//        logger.debug("===== phone cert result retInfo : " + retInfo);
//
//        // 2.1차 파싱---------------------------------------------------------------
//        String[] aRetInfo1 = retInfo.split("\\^");
//        logger.debug("aRetInfo1: {}", aRetInfo1.toString());
//
//        String encPara = aRetInfo1[0]; // 암호화된 통합 파라미터
//        String encMsg = aRetInfo1[1]; // 암호화된 통합 파라미터의 Hash값
//        String encMsg2 = sciSecuMg.getMsg(encPara);
//        logger.debug("encMsg2: {}", encMsg2);
//
//        // 3.위/변조 검증 ---------------------------------------------------------------
//        if (encMsg2.equals(encMsg))
//            logger.debug("위/변조 검증 성공");
//        else
//            logger.debug("위/변조 검증 실패");
//
//        // 복호화 및 위/변조 검증 ---------------------------------------------------------------
//        retInfo = sciSecuMg.getDec(encPara, phoneCert);
//        logger.debug("## retInfo: {}", retInfo);
//
//        String[] aRetInfo = retInfo.split("\\^");
//
//        String name = aRetInfo[0];
//        String birYMD = aRetInfo[1];
//        String sex = aRetInfo[2];
//        String fgnGbn = aRetInfo[3];
//        String di = aRetInfo[4];
//        String ci1 = aRetInfo[5];
//        String ci2 = aRetInfo[6];
//        String civersion = aRetInfo[7];
//        String reqNum = aRetInfo[8];
//        String result = aRetInfo[9];
//        String certGb = aRetInfo[10];
//        String cellNo = aRetInfo[11];
//        String cellCorp = aRetInfo[12];
//        String certDate = aRetInfo[13];
//        String addVar = aRetInfo[14];
//        logger.debug("name		: {}", name);
//        logger.debug("birYMD	: {}", birYMD);
//        logger.debug("sex		: {}", sex);
//        logger.debug("fgnGbn	: {}", fgnGbn);
//        logger.debug("di		: {}", di);
//        logger.debug("ci1		: {}", ci1);
//        logger.debug("ci2		: {}", ci2);
//        logger.debug("civersion	: {}", civersion);
//        logger.debug("reqNum	: {}", reqNum);
//        logger.debug("result	: {}", result);
//        logger.debug("certGb	: {}", certGb);
//        logger.debug("cellNo	: {}", cellNo);
//        logger.debug("cellCorp	: {}", cellCorp);
//        logger.debug("certDate	: {}", certDate);
//        logger.debug("addVar	: {}", addVar);
//
//        HashMap<String, String> resultMap = new HashMap<String, String>();
//
//        String status = "0001";
//        if ("Y".equals(result)) {
//            status = "0000";
//            resultMap.put("cellNo", cellNo);
//            resultMap.put("certDate", certDate);
//            resultMap.put("ci", ci1);
//            resultMap.put("di", di);
//
////			historyService.insertHistory("AUTH_FLAG/C/인증방법-휴대폰본인인증");
////			historyService.insertHistory("CI/" + ci1);
////			historyService.insertHistory("DI/" + di);
////
////			UserDetailVO user = SessionUtil.getUserDetailVO();
////			if(user.getContSignerType() != null && "1".equals(user.getContSignerType())) {	// 대표자 서명
////				if(user.getCustRegNo() == null || "".equals(user.getCustRegNo()) || user.getCustRegNo().length() < 6) {
////					su.setHistoryList("STEP_3/Y/휴대폰본인인증[완료]");
////				}else {
////            if (!birYMD.substring(2, birYMD.length()).equals(userVo.getInResidentNo().substring(0, 6))) {
////                status = "0001";
////                su.setHistoryList("STEP_3/N/휴대폰본인인증[불일치]");
////					}else {
////                su.setHistoryList("STEP_3/Y/휴대폰본인인증[완료]");
////            }
////				}
////			}else {
////				su.setHistoryList("STEP_3/Y/휴대폰본인인증[완료]");
////			}
//
//            if (status.equals("0000")) {
////                su.setHistoryList("STEP_5/Y/제출[완료]");
//
////	wj			us11Service.insertUs11(Constant.SV10_CODE_HP);
////				us10Service.updateOnAccountIdseed("C", ci1, di);
//            }
//
//        }
//
//        resultMap.put("status", status);
//        resultMap.put("type", "idseed");
//
//        return resultMap;
//    }
    
    public CertificationVO getResultPhoneCert(String retInfo) {
//		UserDetailVO userVo = SessionUtil.getUserDetailVO();

//        SecurityUtil su = new SecurityUtil();
//        CommonUserDetails userVo = su.getSignUserDetails();
    	
        Map<String, Object> user = (Map<String, Object>) SessionUtil.getUser();
        String phoneCert = (String) user.get("phoneCert");

        if (user == null || StringUtils.isBlank(phoneCert)) {
            logger.error("휴대폰 본인 인증 복호화 키 미존재");
            throw new RuntimeException("휴대폰 본인 인증 실패.");
        }

//        String phoneCert = userVo.getPhoneCert();//SessionUtil.getUserDetailVO().getPhoneCert();

        // 1. 암호화 모듈 (jar) Loading
        SciSecuManager sciSecuMg = new SciSecuManager();
        // 쿠키에서 생성한 값을 Key로 생성 한다.
        retInfo = sciSecuMg.getDec(retInfo, phoneCert);

        logger.debug("===== phone cert result retInfo : " + retInfo);

        // 2.1차 파싱---------------------------------------------------------------
        String[] aRetInfo1 = retInfo.split("\\^");
        logger.debug("aRetInfo1: {}", aRetInfo1.toString());

        String encPara = aRetInfo1[0]; // 암호화된 통합 파라미터
        String encMsg = aRetInfo1[1]; // 암호화된 통합 파라미터의 Hash값
        String encMsg2 = sciSecuMg.getMsg(encPara);
        logger.debug("encMsg2: {}", encMsg2);

        // 3.위/변조 검증 ---------------------------------------------------------------
        if (encMsg2.equals(encMsg))
            logger.debug("위/변조 검증 성공");
        else
            logger.debug("위/변조 검증 실패");

        // 복호화 및 위/변조 검증 ---------------------------------------------------------------
        retInfo = sciSecuMg.getDec(encPara, phoneCert);
        logger.debug("## retInfo: {}", retInfo);

        String[] aRetInfo = retInfo.split("\\^");

        String name = aRetInfo[0];
        String birYMD = aRetInfo[1];
        String sex = aRetInfo[2];
        String fgnGbn = aRetInfo[3];
        String di = aRetInfo[4];
        String ci1 = aRetInfo[5];
        String ci2 = aRetInfo[6];
        String civersion = aRetInfo[7];
        String reqNum = aRetInfo[8];
        String result = aRetInfo[9];
        String certGb = aRetInfo[10];
        String cellNo = aRetInfo[11];
        String cellCorp = aRetInfo[12];
        String certDate = aRetInfo[13];
        String addVar = aRetInfo[14];
        logger.debug("name		: {}", name);
        logger.debug("birYMD	: {}", birYMD);
        logger.debug("sex		: {}", sex);
        logger.debug("fgnGbn	: {}", fgnGbn);
        logger.debug("di		: {}", di);
        logger.debug("ci1		: {}", ci1);
        logger.debug("ci2		: {}", ci2);
        logger.debug("civersion	: {}", civersion);
        logger.debug("reqNum	: {}", reqNum);
        logger.debug("result	: {}", result);
        logger.debug("certGb	: {}", certGb);
        logger.debug("cellNo	: {}", cellNo);
        logger.debug("cellCorp	: {}", cellCorp);
        logger.debug("certDate	: {}", certDate);
        logger.debug("addVar	: {}", addVar);
        
        CertificationVO cert = new CertificationVO();


        if ("Y".equals(result)) {
//            status = "0000";
//            resultMap.put("cellNo", cellNo);
//            resultMap.put("certDate", certDate);
//            resultMap.put("ci", ci1);
//            resultMap.put("di", di);
            
            cert = CertificationVO.builder()
            						.cellNo(cellNo)
            						.certDate(certDate)
            						.ci(ci1)
            						.di(di)
            						.status("0000")
            						.type("idseed")
            						.build();

//			historyService.insertHistory("AUTH_FLAG/C/인증방법-휴대폰본인인증");
//			historyService.insertHistory("CI/" + ci1);
//			historyService.insertHistory("DI/" + di);
//
//			UserDetailVO user = SessionUtil.getUserDetailVO();
//			if(user.getContSignerType() != null && "1".equals(user.getContSignerType())) {	// 대표자 서명
//				if(user.getCustRegNo() == null || "".equals(user.getCustRegNo()) || user.getCustRegNo().length() < 6) {
//					su.setHistoryList("STEP_3/Y/휴대폰본인인증[완료]");
//				}else {
//            if (!birYMD.substring(2, birYMD.length()).equals(userVo.getInResidentNo().substring(0, 6))) {
//                status = "0001";
//                su.setHistoryList("STEP_3/N/휴대폰본인인증[불일치]");
//					}else {
//                su.setHistoryList("STEP_3/Y/휴대폰본인인증[완료]");
//            }
//				}
//			}else {
//				su.setHistoryList("STEP_3/Y/휴대폰본인인증[완료]");
//			}

            if ("0000".equals(cert.getStatus())) {
//                su.setHistoryList("STEP_5/Y/제출[완료]");

//	wj			us11Service.insertUs11(Constant.SV10_CODE_HP);
//				us10Service.updateOnAccountIdseed("C", ci1, di);
            }

        }

//        resultMap.put("status", status);
//        resultMap.put("type", "idseed");

        return cert;
    }

    public CommonResponse checkCellNumber(HashMap<String, Object> paramMap) {
    	
    	logger.info(" ##### certificationService > checkCellNumber #####");

        HashMap<String, String> result = new HashMap<>();
        String userInput = (String) paramMap.get("cellNoLast");

        if(paramMap == null || StringUtils.isBlank(userInput)) {
        	return CommonResponse.fail("오류가 발생하였습니다.", "0001");
        }
        
        ContrcMgmtVO user = (ContrcMgmtVO) SessionUtil.getUser();
//        String cellNo = (String) user.get("CELL_NO");
        String cellNo = user.getCellNo();

        if(user == null) {
        	if(StringUtils.isBlank(cellNo)) {
        		return CommonResponse.fail("세션이 만료되었습니다.", "0003");
        	}
        	return CommonResponse.fail("세션이 만료되었습니다.", "0002");
        }

        String lastFourDigits = cellNo.substring(cellNo.length() - 4);

        if(userInput.equals(lastFourDigits)){
            return CommonResponse.success();
        } else {
        	return CommonResponse.fail("뒤 4자리 번호가 일치하지 않습니다.", "0004");
        }
    }

	/*public HashMap<String, String> getResultAccCert(String retInfo) throws Exception {
		SecurityUtil su = new SecurityUtil();
		CommonUserDetails userVo = su.getSignUserDetails();
		
		if (userVo == null || userVo.getAccCert() == null) {
			logger.error("계좌 인증 복호화 키 미존재");
			throw new RuntimeException("계좌 본인 인증 실패.");
		}

		String phoneCert = SessionUtil.getUserDetailVO().getAccCert();

		IBCipher cipher = new IBCipher(phoneCert); // 요청시 생성한 요청코드 (복호화)
		URLCodec codec = new URLCodec();

		String decData = cipher.aesDecode(codec.decode(retInfo)); // 복호화
		logger.debug("===== account cert decData : " + decData);

		Map<String, String> map = new HashMap<String, String>();
		String[] datas = decData.split("&");
		for (String data : datas) {
			int idx = data.indexOf("=");
			map.put(data.substring(0, idx), data.substring(idx + 1));
		}
		HashMap<String, String> resultMap = new HashMap<String, String>();

		String status = "0001"; // 0000(성공) 0001(실패, 오류) 0002(인증자와 고객 다름)
		if ("1".equals(map.get("result"))) {
			status = "0000";
			resultMap.put("accName", map.get("holder_name"));
			resultMap.put("bankName", map.get("bank_name"));
			resultMap.put("accNo", map.get("holder_number"));
			SimpleDateFormat dateFormat = new SimpleDateFormat("yyyyMMddHHmmss");
			String systemDTM = dateFormat.format(System.currentTimeMillis());
			resultMap.put("certDate", systemDTM);

			String bankNo = map.get("holder_number");
			if (StringUtils.isNotBlank(bankNo) && 5 < bankNo.length()) {
				String m1 = bankNo.substring(0, 3);
				String m2 = bankNo.substring(3, 6);
				String m3 = bankNo.substring(6);
				m2 = "***";
				bankNo = m1 + m2 + m3;
			}

			historyService.insertHistory("AUTH_FLAG/A/인증방법-계좌인증");
			historyService.insertHistory("BANK_NAME/" + map.get("bank_name"));
			historyService.insertHistory("BANK_NO/" + bankNo);
			historyService.insertHistory("STEP_3/Y/계좌본인인증[완료]");
			historyService.insertHistory("STEP_5/Y/제출[완료]");

//		wj	us11Service.insertUs11(Constant.SV10_CODE_ACC);
//
//			us10Service.updateOnAccountAcseed("A", map.get("bank_code"), map.get("bank_name"), map.get("holder_name"), map.get("holder_number"));
		
			// 이름(예금주) 비교
			if (user.getUs10Name().equals(map.get("holder_name"))) {
				status = "success";

				user.setUs10AuthFlag("A");
				user.setUs10BankCd(map.get("bank_code"));
				user.setUs10BankName(map.get("bank_name"));
				user.setUs10AccountName(map.get("holder_name"));
				user.setUs10AccountNameMask(StringUtils.mask(map.get("holder_name"), "^(.)(.)(.*)$", 2, '*'));
				user.setUs10AccountNo(map.get("holder_number"));
				user.setUs10AccountNoMask(StringUtils.mask(map.get("holder_number"), "^(.{3})(.{4})(.*)$", 2, '*'));
				Us10 updt = us10Repository.save(user);
				log.debug("## updt(U): {}", updt);
				log.debug("## user(U): {}", user);

			} else {
				status = "nomatch";

				Tr10 auth = new Tr10();
				auth.setTr10Log("AUTH_FLAG/A/인증방법-계좌인증");
				auth.setUs10Seq(user.getUs10Seq());
				Tr10 hist = new Tr10();
				hist.setTr10Log("STEP_3/N/계좌본인인증[불일치]");
				hist.setUs10Seq(user.getUs10Seq());

				List<Tr10> hists = Arrays.asList(auth, hist);
				tr10Repository.save(hists);
				log.debug("## hists: {}", hists);
			}
		}

		resultMap.put("status", status);
		resultMap.put("type", "acseed");

		return resultMap;
	}*/

}
