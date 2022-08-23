package kr.co.tsoft.sign.service.admin;

import kr.co.tsoft.sign.mapper.admin.ContrcMapper;
import kr.co.tsoft.sign.util.MailHandler;
import kr.co.tsoft.sign.util.SecurityUtil;
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

   
    public HashMap<String, Object> contrcReg(ContractGridDto paramVO) throws Exception {
        HashMap<String, Object> resultMap = new HashMap<String, Object>();
        
        // 계약 번호 생성
        //cmi : 핸드폰가운데번호 일시
        String match = "[^\uAC00-\uD7A3xfe0-9a-zA-Z\\s]";
        
        String sdate = ((String) paramVO.getSignDueSdate()).replaceAll(match, "");
        String edate = ((String) paramVO.getSignDueEdate()).replaceAll(match, "");

        Date today = new Date();
        SimpleDateFormat time = new SimpleDateFormat("yyyyMMddHHmmss");//등록일시

        String contrNo = time.format(today) + "_" + ((String) paramVO.getCellNo()).substring(3, 7);
        
        SecurityUtil su = new SecurityUtil();
        
        paramVO.setContractNo(contrNo);
        paramVO.setSignDueSdate(sdate);
        paramVO.setSignDueEdate(edate);
        paramVO.setRegId(su.getAdminUserDetails().getUsername());//로그인한 사용자 ID
        paramVO.setModId(su.getAdminUserDetails().getUsername());//로그인한 사용자 ID
        
//		// TODO 계약 저장
        if (ContrcMapper.insertContrcReg(paramVO) > 0) {
            Logger.debug("== 계약서 저장");
            resultMap.put("result", "success");
        } else {
            Logger.debug("== 계약서 저장 실패 ");
            resultMap.put("insert", "fail");
        }
        
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
            String toMail = (String) paramVO.getEmail();
            String title = "(주)티소프트 전자계약을 진행해 주세요.";
            String content = "<html><body>(주)티소프트 전자계약을 진행해 주세요.<br/> https://sign.tsoft.co.kr/cmi/" + contrNo + "</body></html>";

            mail.send(toMail, title, content, null);
        } catch (Exception e) {
            Logger.debug("== 메일 전송 실패");
        }

        return resultMap;
    }

	public HashMap<String, Object> contrcRegUpdate(ContractGridDto paramVO) {
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		/*
		 * 1. update : 기존 계약 USE_YN = 'N'
		 * 2. insert : 수정된 데이터로 새로운 계약 생성
		 */
		//TODO 테스트 필요
		//1. update : 기존 계약 USE_YN = 'N'
		SecurityUtil su = new SecurityUtil();
		paramVO.setModId(su.getAdminUserDetails().getUsername());//로그인한 사용자 ID
		if (ContrcMapper.updateContrcReg(paramVO) > 0) {
            Logger.debug("== 계약서 수정");
            try {
            	//2. insert : 수정된 데이터로 새로운 계약 생성
            	resultMap = contrcReg(paramVO);
			} catch (Exception e) {
				Logger.debug("== 계약 등록 실패 ");
			}
        } else {
            Logger.debug("== 계약 사용안함 수정 실패 ");
        }
        
		return resultMap;
	}

	/**
	 * 계약등록 화면
	 * 단건 조회 
	 * @param paramVO
	 * @return
	 */
	public ContractGridDto selectContrcInfo2(ContractGridDto paramVO) {
		return ContrcMapper.selectContrcInfo2(paramVO);
	}
}
