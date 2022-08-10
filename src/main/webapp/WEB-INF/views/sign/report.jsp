<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html lang="ko">
<head>
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=800, user-scalable=no">
<meta name="apple-mobile-web-app-capable" content="yes"/>
<meta name="apple-mobile-web-app-status-bar-style" content="black"/>

<meta charset="UTF-8">

<link rel="stylesheet" type="text/css" href="/clipreport5/css/font.css">
<link rel="stylesheet" type="text/css" href="/clipreport5/css/clipreport.css">
<link rel="stylesheet" type="text/css" href="/clipreport5/css/eform.css">
<link rel="stylesheet" type="text/css" href="/clipreport5/css/UserConfig.css">

<script type="text/javascript" src="/clipreport5/js/jquery-1.11.1.js"></script>
<script type="text/javascript" src="/clipreport5/js/clipreport.js"></script>
<script type="text/javascript" src="/clipreport5/js/clipviewerBridge.js"></script>
<script type="text/javascript" src="/clipreport5/js/UserConfig.js"></script>
<script src="/resources/sign/js/common.js"></script>

<script>
var report;
const reportkey = "${reportKey}";
const reportFileName = "${reportFileName}";
console.log(reportkey);
console.log(reportFileName);

var onLoadReport = function (divIdName) {
	report = createImportJSPEForm('/report/view', reportkey, document.getElementById(divIdName));

	report.setCloseReportEvent(function(){ window.close() });
	report.setDefaultRatio("PageWidth");
	report.setStyle("zoomIn", "left:350px;width:100px;");
	report.setStyle("save_button","left:460px;width:60px;height:32px;");
	//report.setStyle("print_button", "left:530px");
	report.setStyle("print_button", "display:none;");
	report.setStyle("doodle_button","display:none");
	report.setStyle("close_button", "display:none");

	if(is_mobile){
		report.setStyle("save_button","left:320px;width:80px;");
		//report.setStyle("print_button", "display:none;");
		report.setStyle("firstPage_button", "left:30px;z-index:3;visibility:visible;");
		report.setStyle("prev_button", "left:80px;z-index:3;visibility:visible");
		report.setStyle("input_box", "width:30px;font-size:10pt;text-align:right;");
		report.setStyle("totalCount_box", "width:30px;font-size:10pt;text-align:center;");
		report.setStyle("next_button", "left:220px;z-index:3;visibility:visible");
		report.setStyle("lastPage_button", "left:270px;z-index:3;visibility:visible");
	}
	//리포트 실행
	report.view();

	//report viewer의 저장이 끝났을 때 발생하는 이벤트 처리 함수
	report.setEndSaveButtonEvent(function() {
		// json 데이터 형식의 바깥 괄호
		var obj = {};
		//getEFormData -> Eform 사용자가 입력한 데이터를 추출하는 함수
		var result = report.getEFormData();
 		var reportEformData = dataRefine(result);

		savePdf(report.getReportKey(), reportEformData); 
	});
}; // --- end onLoadReport();

 var dataRefine = function(item) {
	const result = item;
	var yymmdd = String(result.CONT_DT_YY.data[0]) + String(result.CONT_DT_MM.data[0]) + String(result.CONT_DT_DD.data[0]);

	// json 데이터 형식의 바깥 괄호
	var obj = {};
	// 합친 날짜 추가
	obj['CONT_DT'] = parseInt(yymmdd);
	if('PG_MID_APL02' == reportFileName) {
		obj['REQ_DT'] = parseInt(yymmdd);		
	}

	for(key in result) {
		obj[key] = result[key].data[0];
	}
	
	//데이터 정제
	const reportField = {
			PG_MID_CONT01 : ['MID','AID','HOMEPAGE_ADDR','FAX_NO','BANK_NM','ACNT_NO','ACNT_NM','STMT_CYCLE_CD_01','RCPT_PRT_TYPE','VAT_CALC_TYPE','ACQ_CL_CD','ACQ_DAY','CC_PART_CL','CARD_BLOCK_FLG',
							'CARD_BLOCK_LIST','CARD_USE_FLG','CARD_USE_LIST','STMT_CYCLE_CD_02','CC_PART_CL_02','STMT_CYCLE_CD_03','VACNT_ISS_TYPE','VACNT_LMT_DAY','VACNT_BLOCK_FLG',
							'VACNT_BLOCK_LIST','VACNT_USE_FLG','VACNT_USE_LST','REFUND_USE_FLG','REFUND_USE_PARTIAL_FLG','REFUND_FEE','PREOCC_FLG','ID_CD','MS_USE_FLG',
							'AUTO_CAL_FLG','CRCT_AUTO_FLG','CRCT_CULT_FLG','MMS_PAY_FLG','SMS_PAY_FLG','URL_PAY_FLG','ORD_NO_DUP_FLG','BILL_FLG','EZP_USE_FLG','ESCROW_USE_FLG','OM_SETT_CL',
							'MEMO','CONT_DT','CO_NM','BIZ_PLACE_ADDR','CEO_NM','RNM_NO','CUSTOMER_ENG_NM','RLTACC_RNM_NO_DIV','RLTACC_RNM_NO_ETC','CREATE_DD','HDEPT_DTL_ADDR',
							'HDEPT_PHONE_NO','HDEPT_PHONE_COUNTRY_CD','BIZ_COUNTRY_CD','CEO_ENG_NM','CEO_RNM_NO','CEO_SEX_CD','CEO_ADDR_COUNTRY_CD','CEO_PHONE_NO','CEO_DTL_ADDR',
							'CEO_TEL_NO','ACCOUNT_NEW_PURPOSE_CD','ACCOUNT_NEW_PURPOSE_NM','TRAN_FUND_SOURCE_DIV','TRAN_FUND_SOURCE_OTHER','VIRTUAL_MONEY_HANDLE_CD','RNM_NO_DIV',
							'RNM_NO_DIV_ETC','LIVE_YN','CREATE_PURPOSE_DIV','CREATE_PURPOSE_ETC','CREATE_PURPOSE_DOC','COMPANY_SIZE_DIV','LSTNG_YN','LSTNG_DIV','STOCK_EXCH_NM',
							'REAL_OWNER_NM','REAL_OWNER_ENG_NM','REAL_OWNER_RNM_NO','REAL_OWNR_COUNTRY_CD','REAL_OWNR_DT_CD','REAL_OWNR_CHK_CD','REAL_OWNR_BIRTH_DD','REAL_OWNR_RATE',
							'AGENT_YN','AGENT_NM','AGENT_ENG_NM','AGENT_RNM_NO','AGENT_COUNTRY_CD','AGENT_HOME_ADDR','AGENT_SEX','AGENT_TEL_NO','AGENT_HP',
							'OPEN_AGENT_DIV','OPEN_AGENT_ETC','AGENT_RELA_DIV','AGENT_RELA_ETC'],
							
			PG_MID_APL01 : ['CUSTOMER_NM','CUSTOMER_NO','CUSTOMER_DIV','INDUSTRY_NM','MAIN_GOODS_NM','REP_NM','CEO_BIRTH_DD','BIZ_ADDR','HOMEPAGE_ADDR','EMAIL_ADDR',
							'TEL_NO','CONT_NM','CONT_HP','CONT_EMAIL','STMT_NM','STMT_HP','STMT_EMAIL','TECH_NM','TECH_HP','TECH_EMAIL','TAX_EMAIL',
							'PM_CD_01','SM_MBS_CD_00','SM_MBS_CD_A1','SM_MBS_CD_B1','SM_MBS_CD_B2','SM_MBS_CD_B3','PM_CD_02','MIN_FEE_02','FEE_02','PM_CD_03','FEE_03'],
							
			PG_MID_APL02 : ['UPD_REQ_MID','CORP_REG_NO','CUSTOMER_NM_REQ_YN','CUSTOMER_NM_REQ','BIZ_ADDR_REQ_YN','BIZ_ADDR_REQ','TEL_NO_REQ_YN','TEL_NO_REQ','REP_NM_REQ_YN',
							'REP_NM_REQ','CEO_PHONE_NO_REQ_YN','CEO_PHONE_NO_REQ','INDUSTRY_NM_REQ_YN','INDUSTRY_NM_REQ','HOMEPAGE_ADDR_REQ_YN','HOMEPAGE_ADDR_REQ','EMAIL_ADDR_REQ_YN',
							'EMAIL_ADDR_REQ','ACNT_NO_REQ_YN','ACNT_BANK_REQ','ACNT_NM_REQ','ACNT_NO_REQ','TAX_EMAIL_REQ_YN','TAX_EMAIL_REQ','ETC_REQ_YN','ETC_REQ_TITLE','ETC_REQ',
							'REQ_DT','CUSTOMER_ENG_NM','RLTACC_RNM_NO_DIV','RLTACC_RNM_NO_ETC','CREATE_DD','HDEPT_DTL_ADDR','HDEPT_PHONE_NO','HDEPT_PHONE_COUNTRY_CD','BIZ_COUNTRY_CD',
							'REP_ENG_NM','CEO_ENG_NM','CEO_RNM_NO','CEO_SEX_CD','CEO_ADDR_COUNTRY_CD','CEO_PHONE_NO','CEO_DTL_ADDR','CEO_TEL_NO','ACCOUNT_NEW_PURPOSE_CD',
							'ACCOUNT_NEW_PURPOSE_NM','TRAN_FUND_SOURCE_DIV','TRAN_FUND_SOURCE_OTHER','VIRTUAL_MONEY_HANDLE_CD','RNM_NO_DIV','RNM_NO','RNM_NO_DIV_ETC','LIVE_YN',
							'CREATE_PURPOSE_DIV','CREATE_PURPOSE_ETC','CREATE_PURPOSE_DOC','COMPANY_SIZE_DIV','LSTNG_YN','LSTNG_DIV','STOCK_EXCH_NM','REAL_OWNER_NM','REAL_OWNER_ENG_NM',
							'REAL_OWNER_RNM_NO','REAL_OWNR_COUNTRY_CD','REAL_OWNR_DT_CD','REAL_OWNR_CHK_CD','REAL_OWNR_BIRTH_DD','REAL_OWNR_RATE','AGENT_YN','AGENT_NM','AGENT_ENG_NM',
							'AGENT_RNM_NO','AGENT_COUNTRY_CD','AGENT_HOME_ADDR','AGENT_SEX','AGENT_TEL_NO','AGENT_HP','OPEN_AGENT_DIV','OPEN_AGENT_ETC','AGENT_RELA_DIV','AGENT_RELA_ETC','CONT_DT'],
			
			PG_AID_CONT01 : ['CONT_DT', 'SPON_NM', 'SPON_BIRTH_DD', 'SPON_ADDR', 'SPON_TEL', 'VGRP_ADDR', 'VGRP_REP_NM', 'CORP_REG_NO',
							'CONT_DIV','TECH_DIV', 'BANK_NM', 'ACNT_NO', 'ACNT_NM', 'AID', 'PAY_AMT_03', 'PAY_AMT_ETC']
	}

	var dataField = reportField[reportFileName];
	
	for(var key in obj) {
		if(!(dataField.includes(key))) {
			delete obj[key];
		}
	}
	return JSON.stringify(obj);
 }


 var savePdf = function(reportkey, result) {
	var requestMap = {
		url: '/report/makePDF',
		dataParam: {
			repKey: reportkey,
			repData : result,
		},
	};
	ComUtil.request(requestMap, function(data){
		if(data.resultCd == '0000') {
    		if(confirm('제출되었습니다. 전자 문서를 닫습니다.')) {
    			opener.closeReport('0000');
    			self.close();
    			window.location.href = '/cert';
    		}
    	} else {
    		opener.closeReport('9999');
    		self.close();
    		window.location.href = '/sign';
   		}
    });
	
}; // --- end savePdf(); 



</script>
</head>

<body onload="onLoadReport('targetDiv1')">
<div id='targetDiv1' style='position:absolute;top:5px;left:5px;right:5px;bottom:5px;'>
	<span style="visibility: hidden; font-family:나눔고딕">.</span>
	<span style="visibility: hidden; font-family:NanumGothic">.</span>
</div>
</body>

</html>