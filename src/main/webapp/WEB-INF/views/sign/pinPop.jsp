<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="ko">
<!-- head -->
<head>
    <script src="/js/common/ui.js"></script>
    <script src="/js/common/template.js"></script>
</head>
<!-- //head -->
<body>
<div id="wrap">
    <!-- header -->
    <header>
        <h2 class="title">휴대폰 PIN인증</h2>
        <a href="javascript:void(0);" onclick="fnPopClose();" class="btn_close">닫기</a>
    </header>
    <!-- //header -->

    <!-- container -->
    <div id="container">

        <!-- cont_area -->
        <div class="cont_area">
            <div class="txt_msg_box cont">문자로 수신하신 인증번호 6자리 숫자를 입력하신 후 [확인]버튼을 눌러주세요.</div>
            <div class="form_box sub">
                <dl class="list">
                    <dt>휴대폰번호</dt>
                    <dd class="btn_t">
                        <input type="text" class="input_ty" id="hpNo" value="${user.CELL_NO_MASK}" readonly="readonly"/>
                        <a href="javascript:void(0);" onclick="fnReqPinNumber('R')" class="btn_ty04 btn">재발송</a>
                    </dd>
                </dl>
                <dl class="list">
                    <dt>인증번호입력</dt>
                    <dd>
                        <input type="number" id="idPinNo" class="input_ty" maxlength="6" style="ime-mode: disabled;"
                               placeholder="숫자 6자리"
                               onkeyup="fnBtnRequestCtr();" onkeypress="return cm.input.check(this);"
                               oninput="cm.input.slice(this);"/>
                        <p id="idTime" class="time">00:00</p>
                    </dd>
                </dl>
            </div>
            <p class="t_text">* 유효시간이 경과되면 “재발송”을 통해 인증번호를 다시 받으셔야 합니다.</p>

            <div class="btn_area">
                <a href="javascript:void(0);" class="btn_m btn_ty01" id="idBtnConfirm"
                   onclick="fnChkPinNumber();">확인</a>
            </div>
        </div>
        <!-- //cont_area -->
    </div>
    <!-- //container -->

</div>
<!-- //wrap -->

<script type="text/javascript">

    var callType;
    var PIN_TIME_LIMIT = '5';//pin유효시간 5분

    $(function () {

        $('#hpNo').val(phoneFomatter($('#hpNo').val()));

        fnReqPinNumber();

        $("#idPinNo").keyup(function (event) {
            if (event.keyCode == 13) {
                fnChkPinNumber();
            }
        });

    });

    // PIN 인증번호 요청
    var fnReqPinNumber = function (type) {
        if (type === 'R') {
            var ct = (PIN_TIME_LIMIT * 60) - _timeout;
            if (ct < 30) {
                alert('재인증은 ' + (30 - ct) + '초 이후 가능합니다.');
                return;
            }
            callType = 'R';
        }

        clearTimeout(_fnPrintClock);
        var contrcNo = '${user.CONTRC_NO}'
        ComUtil.sendPinCode({contrcNo: '${user.CONTRC_NO}'}, fnReqPinNumberCallback);

    };

    // PIN 인증번호 요청 콜백
    var fnReqPinNumberCallback = function (data) {
        if (ComUtil.isNull(data)) {
            return;
        }
        if (data['resultCd'] !== '0000') {
            if (data['resultCd'] === '0003') {
                alert('횟수 초과로 인증에 실패하셨습니다.');
                fnPopClose();
            } else {
                alert('오류가 발생 하였습니다.');
            }
            return;
        }

        if (callType === 'R') {
            alert('정상적으로 재인증 요청되었습니다.');
            callType = '';
        } else {
            alert('고객님의 휴대폰으로 인증번호를 발송해 드렸습니다.');

            if ('${profilesActive}' == 'dev') {
                alert('pin : ' + data['pin']);
            }
        }

        _timeout = PIN_TIME_LIMIT * 60;
        fnPrintClock();
    };

    // 요청 버튼 컨트롤
    var fnBtnRequestCtr = function () {
        var c = cm.validator.number($('#idPinNo').val(), 6);
        $('#idBtnConfirm').removeClass(c ? 'btn_ty01' : 'btn_ty02').addClass(c ? 'btn_ty02' : 'btn_ty01');
    };

    // PIN 인증번호 검증
    var fnChkPinNumber = function () {
        if (!$('#idBtnConfirm').hasClass('btn_ty02')) {
            return;
        }

        if (_timeout === 0) {
            alert('유효시간이 경과되었습니다. "재인증" 을 통해 다시 인증해 주세요.');
            return;
        }

        var paramMap = {pinCode: $('#idPinNo').val(), contrcNo: '${user.CONTRC_NO}'};
        var requestMap = {
            dataParam: paramMap,
            url: '/sign/pin/check'
        };
        //인증번호 검증시 마다 시큐리티 pin번호 value change
        $('#pinForm input[name=p]').val($('#idPinNo').val());
        ComUtil.request(requestMap, fnChkPinNumberCallback);
    };

    // PIN 인증번호 검증 콜백
    var fnChkPinNumberCallback = function (data) {
        if (ComUtil.isNull(data)) {
            return;
        }
        if (data['resultCd'] != '0000') {
            alert('인증번호가 올바르지 않습니다.');
            return;
        }

        alert('정상적으로 인증되었습니다.');
        parent.fnClose('0000');
    };

    // 유효시간 표시
    var _timeout;
    var _fnPrintClock;
    var fnPrintClock = function () {
        var $t = $('#idTime');
        var m = parseInt(_timeout / 60);
        var s = _timeout % 60;
        $t.text(cm.str.lpad(m, 2) + ':' + cm.str.lpad(s, 2));

        if (_timeout === 0) {
            clearTimeout(_fnPrintClock);
            return;
        }

        _timeout--;
        _fnPrintClock = setTimeout('fnPrintClock()', 1000);
    };

    // 팝업 창 닫기
    var fnPopClose = function () {
        parent.fnClose();
    };

    function phoneFomatter(num, type) {
        var formatNum = '';
        if (num.length == 11) {
            if (type == 0) {
                formatNum = num.replace(/(\d{3})(\d{4})(\d{4})/, '$1-****-$3');
            } else {
                formatNum = num.replace(/(\d{3})(\d{4})(\d{4})/, '$1-$2-$3');
            }
        } else if (num.length == 8) {
            formatNum = num.replace(/(\d{4})(\d{4})/, '$1-$2');
        } else {
            if (num.indexOf('02') == 0) {
                if (type == 0) {
                    formatNum = num.replace(/(\d{2})(\d{4})(\d{4})/, '$1-****-$3');
                } else {
                    formatNum = num.replace(/(\d{2})(\d{4})(\d{4})/, '$1-$2-$3');
                }
            } else {
                if (type == 0) {
                    formatNum = num.replace(/(\d{3})(\d{3})(\d{4})/, '$1-***-$3');
                } else {
                    formatNum = num.replace(/(\d{3})(\d{3})(\d{4})/, '$1-$2-$3');
                }
            }
        }
        return formatNum;
    }

</script>

</body>

</html>
