package kr.co.tsoft.sign.service;

import com.sci.v2.pcc.secu.SciSecuManager;
import com.sci.v2.pcc.secu.hmac.SciHmac;
import kr.co.tsoft.sign.config.security.CommonUserDetails;
import kr.co.tsoft.sign.util.SecurityUtil;
import kr.co.tsoft.sign.util.SessionUtil;
import kr.co.tsoft.sign.vo.CertificationVO;
import kr.co.tsoft.sign.vo.common.CommonResponse;

import org.apache.commons.lang3.StringUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;

import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.HashMap;
import java.util.Map;
import java.util.Random;

@Service
public class CertificationService {

    private final Logger logger = LoggerFactory.getLogger(CertificationService.class);

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

        CommonUserDetails user = SessionUtil.getUser();
        user.setPhoneCert(reqNum);
        
        CertificationVO cert = CertificationVO.builder()
		        				.reqNum(reqNum)
		        				.reqInfo(reqInfo)
		        				.retUrl("32" + SERVICE_URL +  "/sign/cert/idseed")
		        				.build();

        return cert;
    }

    public CertificationVO getResultPhoneCert(String retInfo) {
    	
    	CommonUserDetails user = SessionUtil.getUser();
//        String phoneCert = (String) user.get("phoneCert");
        String phoneCert = user.getPhoneCert();

        if (user == null || StringUtils.isBlank(phoneCert)) {
            logger.error("휴대폰 본인 인증 복호화 키 미존재");
            throw new RuntimeException("휴대폰 본인 인증 실패.");
        }

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
            cert = CertificationVO.builder()
            						.cellNo(cellNo)
            						.certDate(certDate)
            						.ci(ci1)
            						.di(di)
            						.status("0000")
            						.type("idseed")
            						.build();

            if ("0000".equals(cert.getStatus())) {
            }

        }
        return cert;
    }

    public CommonResponse checkCellNumber(HashMap<String, Object> paramMap) {
    	
    	logger.info(" ##### certificationService > checkCellNumber #####");

        String userInput = (String) paramMap.get("cellNoLast");

        if(paramMap == null || StringUtils.isBlank(userInput)) {
        	return CommonResponse.fail("오류가 발생하였습니다.", "0001");
        }
        
        CommonUserDetails user =  SessionUtil.getUser();
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
}
