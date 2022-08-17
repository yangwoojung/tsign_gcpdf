package kr.co.tsoft.sign.service.admin;

import kr.co.tsoft.sign.mapper.admin.ContrcMapper;
import kr.co.tsoft.sign.util.MailHandler;
import kr.co.tsoft.sign.util.SendMessage;
import kr.co.tsoft.sign.vo.admin.ContractGridDto;
import kr.co.tsoft.sign.vo.common.TotalRowCount;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.List;

@Service
public class ContrcService {

    private final Logger Logger = LoggerFactory.getLogger(ContrcService.class);
    @Autowired
    ContrcMapper ContrcMapper;
    @Value("${spring.profiles.active}")
    private String active;
    @Autowired
    private SendMessage sendMessage;

    public HashMap<String, Object> selectContrcInfo(HashMap<String, Object> paramMap) {
        return ContrcMapper.selectContrcInfo(paramMap);
    }

    public List<ContractGridDto> selectContrcList(ContractGridDto searchVO) {
        return ContrcMapper.selectContrcList(searchVO);
    }

    public TotalRowCount countSelectContrcList(ContractGridDto searchVO) {
        return ContrcMapper.countSelectContrcList(searchVO);
    }

    public HashMap<String, Object> contrcReg(HashMap<String, Object> parameter) throws Exception {
        HashMap<String, Object> resultMap = new HashMap<String, Object>();
        // 계약 번호 생성
        //cmi : 핸드폰가운데번호 일시
        String match = "[^\uAC00-\uD7A3xfe0-9a-zA-Z\\s]";
        String sdate = ((String) parameter.get("SIGN_DUE_SDATE")).replaceAll(match, "");
        String edate = ((String) parameter.get("SIGN_DUE_EDATE")).replaceAll(match, "");

        Date today = new Date();
        SimpleDateFormat time = new SimpleDateFormat("yyyyMMddHHmmss");//등록일시

        String contrNo = time.format(today) + "_" + ((String) parameter.get("CELL_NO")).substring(3, 7);
        parameter.put("CONTRC_NO", contrNo);
        // TODO REG_ID
        parameter.put("SIGN_DUE_SDATE", sdate);
        parameter.put("SIGN_DUE_EDATE", edate);
        parameter.put("REG_ID", "admin");
        parameter.put("MOD_ID", "admin");

//		// TODO 계약 저장
        if (ContrcMapper.insertContrcReg(parameter) > 0) {
            Logger.debug("== 계약서 저장");
            resultMap.put("result", "success");
        } else {
            Logger.debug("== 계약서 저장 실패 ");
            resultMap.put("insert", "fail");
        }
        ;
		/*
		// TODO 문자 전송
		String custPhone = (String) parameter.get("CELL_NO");
		String contrcNo = (String) parameter.get("CONTRC_NO");
		try {
			if(active.equals("dev") || active.equals("local")) {
				String result = sendMessage.send(custPhone,
						String.format("[인증번호 : %s] 휴대폰(PIN) 인증을 위해 인증번호를 입력해 주세요."
								, contrcNo), "", "", "PIN인증");
				Logger.debug("== 문자 전송");
				Logger.debug("## result: {}", result);
			}
		} catch (Exception e) {
			Logger.debug("== 문자 전송 실패");
			// TODO: handle exception
		}
		*/
        // TODO 메일 전송
        try {
            Logger.debug("== 메일 전송");
            MailHandler mail = new MailHandler();
            String toMail = (String) parameter.get("EMAIL");
            String title = "(주)티소프트 전자계약을 진행해 주세요.";
            String content = "<html><body>(주)티소프트 전자계약을 진행해 주세요.<br/> https://sign.tsoft.co.kr/cmi/" + contrNo + "</body></html>";

            mail.send(toMail, title, content, null);
        } catch (Exception e) {
            Logger.debug("== 메일 전송 실패");
            e.printStackTrace();
        }

        return resultMap;
    }
}
