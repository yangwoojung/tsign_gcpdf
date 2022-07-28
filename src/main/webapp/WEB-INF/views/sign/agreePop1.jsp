<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="ko">
<!-- head -->
<head>
    <%@ include file="/WEB-INF/views/layout/sign/header.jsp" %>
</head>
<!-- //head -->
<body class="pop">
<!-- wrap -->
<div id="wrap">
    <!-- header -->
    <header>
        <h2 class="title">개인(신용)정보의 수집, 이용에 관한 사항</h2>
        <a href="javascript:void(0);" onclick="fnPopClose();" class="btn_close">닫기</a>
    </header>
    <!-- //header -->

    <!-- container -->
    <div id="container">
        <div class="cont_area">
            <div class="privacy_inner">
                <table class="normal">
                    <colgroup>
                        <col style="width:20%">
                        <col style="width:auto">
                    </colgroup>
                    <thead>
                    <tr>
                        <th>구분</th>
                        <th>(정보통신서비스 등)-필수동의사항</th>
                    </tr>
                    </thead>
                    <tbody>
                    <tr>
                        <th>수집, 이용 목적</th>
                        <td>
                            <ul class="dot02">
                                <li>이지페이 이용 신청에 따른 서비스의 제공·유지·이행·관리</li>
                                <li>(매출)정보의 분석, 통계자료 활용</li>
                                <li>사고조사, 분쟁해결, 민원처리, 전화상담업무</li>
                                <li>부가서비스 제공·유지·이행·관리</li>
                            </ul>
                        </td>
                    </tr>
                    <tr>
                        <th>수집, 이용할 정보의 내용</th>
                        <td>
                            <ul class="dot02">
                                <li>개인식별정보 : 성명, 국적, 생년월일, 성별, 주소(자택), 이메일, 연락처(휴대폰, 자택)</li>
                                <li>가맹점정보 : 상호명, 국적, 사업자등록번호, 업태, 종목, 사업장주소, 연락처(휴대폰, 사업장), 팩스번호, 통장계좌정보, 영업개시일, 주요
                                    판매품목, 평균 배송주기
                                </li>
                                <li>거래정보 : 매출정보(신용, 체크, 선불, 휴대폰 소액결제, 간편결제, 가상계좌, 계좌이체, 현금, 현금IC 등),</li>
                                <li>기타 계약 및 서비스의 체결·유지·이행·관리·개선 등과 관련하여 본인이 제공한 정보</li>
                            </ul>
                        </td>
                    </tr>
                    <tr>
                        <th>보유 및 이용기간</th>
                        <td>
                            <ul class="dot02">
                                <li>거래종료(가맹점 계약해지)일로부터 5년까지 (단, 관련 법령에 별도 규정이 명시되어있는 경우 그 기간에 따름)</li>
                            </ul>
                        </td>
                    </tr>
                    <tr>
                        <th>거부권 및 거부 시 불이익</th>
                        <td>
                            <ul class="dot02">
                                <li>동의가 없을 경우 계약 체결 및 이에 따른 서비스 제공 또는 유지가 불가</li>
                            </ul>
                        </td>
                    </tr>
                    </tbody>
                </table>
            </div>

            <!-- btn_area -->
            <div class="btn_area">
                <button class="btn_m btn_ty02" onclick="fnPopClose();">확인</button>
            </div>
            <!-- //btn_area -->
        </div>
        <!-- //cont_area -->
    </div>
    <!-- //container -->

</div>
<!-- //wrap -->

<script type="text/javascript">

    // 팝업 창 닫기
    var fnPopClose = function () {
        parent.fnClose();
    };

</script>

</body>

</html>
