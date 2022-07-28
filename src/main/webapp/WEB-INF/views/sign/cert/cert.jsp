<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="ko">
<body>
<!-- wrap -->
<div id="wrap">

    <!-- header -->
    <header>
        <h2 class="title">(주)티소프트 전자계약</h2>
    </header>
    <!-- //header -->

    <!-- container -->
    <div id="container">

        <!-- cont_area -->
        <div class="cont_area">
            <div class="cont" id="phoneDiv">
                <h3 class="t_tit">휴대폰 본인인증</h3>
                <div class="txt_msg_box">고객님 명의의 휴대폰으로 휴대폰 본인인증을 진행해 주세요.</div>
                <div class="btn_area">
                    <a href="javascript:void(0);" class="btn_m btn_ty02" id="btnCertPhone">휴대폰본인인증</a>
                </div>
            </div>

            <!-- 			<div class="cont"> -->
            <!-- 				<h3 class="t_tit">계좌인증</h3> -->
            <!-- 				<div class="txt_msg_box">회사의 계좌로 1원을 이체해 드립니다. 이체 시 기재된 “인증번호”로 계좌인증을 진행해 주세요. (개인사업자의 경우 개인계좌 가능)</div> -->
            <!-- 				<div class="btn_area"> -->
            <!-- 					<a href="javascript:void(0);" class="btn_m btn_ty01" id="btnCertAcc">계좌인증</a> -->
            <!-- 				</div> -->
            <!-- 			</div> -->

        </div>
        <!-- //cont_area -->
    </div>
    <!-- //container -->

</div>
<!-- //wrap -->
<!-- layer -->
<div class="layer_pop" id="loadingPop" style="display:none;">
    <div class="bg"></div>
    <div class="layer">
        <div class="pop_top">
            <h2>주의</h2>
        </div>
        <div class="pop_cont">
            <p class="loading"><img src="/images/layout/loading.gif" style="width:100%" alt="loading"></p>
            <p class="text mt02">
                계약서의 전자문서 원본을 생성하고<br>
                TSA 인증을 받고 있습니다.
            </p>
            <p class="t_text mt02">
                전송 완료 후 본 화면은 자동으로 닫힙니다.<br/>
                절대 화면을 강제로 닫으시면 안됩니다.<br/>
                (5초 ~ 최장 60초)
            </p>
        </div>
    </div>
</div>
<!-- //layer -->

</body>
<script type="text/javascript">

    var custType = '${custType}';

    $(function () {

        $('#btnCertPhone').click(certPhone);
// 	$('#btnCertAcc').click(certAccount);
        if (custType == '2') {
            $('#phoneDiv').hide();
            fnCertificationClose('0000', 'idseed');
        }
    });

    // 휴대폰 본인인증
    function certPhone() {
// 	if ($('#btnCertPhone').hasClass('btn_ty01')) {
// 		alert('계좌인증을 진행해 주세요.');
// 	} else {
        if ('${profilesActive}' == 'local') {
            fnCertificationClose('0000', 'idseed');
        } else if ('${profilesActive}' == 'dev') {
            fnCertificationClose('0000', 'idseed');
        } else {
            ComUtil.certPhone();
        }
// 	}
    }

    /* // 계좌인증
    function certAccount() {
        if ($('#btnCertAcc').hasClass('btn_ty01')) {
            alert('휴대폰본인인증을 먼저 진행해 주세요.');
        } else {
            if ('${profilesActive}' == 'local') {
			fnCertificationClose('0000', 'acseed');
// 		} else if ('${profilesActive}' == 'dev') {
// 			fnCertificationClose('0000', 'acseed');
		} else {
			ComUtil.certAccount();
		}
	}
} */

    // 본인인증 팝업 종료 시 응답 함수
    var fnCertificationClose = function (status, type) {
        if (type == 'idseed') {
            if (status == '0000') {
                $('#btnCertPhone').text('휴대폰본인인증 (인증완료)');
                $('#btnCertPhone').removeClass('btn_ty02').addClass('btn_ty01');
                $('#btnCertPhone').prop('onclick', null);
                $('#btnCertAcc').removeClass('btn_ty01').addClass('btn_ty02');
                $('#btnCertAcc').prop('onclick', null);
            } else if (status == '0001') {
                alert('등록된 고객정보와 인증한 정보가 서로 다릅니다.');
            }
        } else if (type == 'acseed') {
            if (status == '0000') {
                $('#loadingPop').show();
                setInterval(function () {
                    if ($('#loadingPop').is(':visible')) {
                        ComUtil.submit('/attach');
                    }
                }, 100);
            }
        }
    };

</script>
</html>
