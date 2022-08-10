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
const eformkey = "${reportKey}";
const reportFileName = "${reportFileName}";

var onLoadReport = function (divIdName) {
	var eform = createImportJSPEForm('/report/view', eformkey, document.getElementById(divIdName));

	eform.setCloseReportEvent(function(){ window.close() });
	eform.setDefaultRatio("PageWidth");
	eform.setStyle("zoomIn", "left:350px;width:100px;");
	eform.setStyle("save_button","left:460px;width:60px;height:32px;");
	//eform.setStyle("print_button", "left:530px");
	eform.setStyle("print_button", "display:none;");
	eform.setStyle("doodle_button","display:none");
	eform.setStyle("close_button", "display:none");

	if(is_mobile){
		eform.setStyle("save_button","left:320px;width:80px;");
		//eform.setStyle("print_button", "display:none;");
		eform.setStyle("firstPage_button", "left:30px;z-index:3;visibility:visible;");
		eform.setStyle("prev_button", "left:80px;z-index:3;visibility:visible");
		eform.setStyle("input_box", "width:30px;font-size:10pt;text-align:right;");
		eform.setStyle("totalCount_box", "width:30px;font-size:10pt;text-align:center;");
		eform.setStyle("next_button", "left:220px;z-index:3;visibility:visible");
		eform.setStyle("lastPage_button", "left:270px;z-index:3;visibility:visible");
	}
	//필수값 미리 백그라운드 깔아주는 함수
	eform.setNecessaryEnabled(true);

	//report viewer의 저장이 끝났을 때 발생하는 이벤트 처리 함수
	eform.setEndSaveButtonEvent(function() {
		//getEFormData -> Eform 사용자가 입력한 데이터를 추출하는 함수
		var result = eform.getEFormData();
		savePdf(eform.getReportKey()); 
	});
	//리포트 실행
	eform.view();
}; // --- end onLoadReport();

 var savePdf = function(reportkey) {
	var requestMap = {
		url: '/report/makePDF',
		dataParam: {
			repKey: reportkey
		},
	};
	ComUtil.request(requestMap, function(data){
		if(data.resultCd == '0000') {
    		if(confirm('제출되었습니다. 전자 문서를 닫습니다.')) {
    			opener.closeReport('0000');
    			self.close();
    			window.location.href = '/done';
    		}
    	} else {
    		opener.closeReport('9999');
    		self.close();
    		window.location.href = '/sign/agree';
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