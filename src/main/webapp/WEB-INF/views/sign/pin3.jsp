<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<script type="text/javascript">
    var s = location.search;
    if (s.indexOf('failure') > 0) {
        alert('Pin 인증 실패');
    } else if (s.indexOf('expired') > 0) {
        alert('다른 곳에서 Pin 로그인하여 로그인 해제');
    }
    var s = location.search;
    if (s.indexOf('failure') > 0) {
        alert('Pin 인증 실패');
    } else if (s.indexOf('expired') > 0) {
        alert('다른 곳에서 Pin 로그인하여 로그인 해제');
    }
    //20200906154749_2853
</script>

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
                    <input type="text" class="input_ty" id="hpNo" readonly="readonly"/>
                    <a href="javascript:void(0);" onclick="fnReqPinNumber('R')" class="btn_ty04 btn">재발송</a>
                </dd>
            </dl>
            <dl class="list">
                <dt>인증번호입력</dt>
                <dd>
                    <input type="number" id="idPinNo" class="input_ty" maxlength="6" style="ime-mode: disabled;"
                           placeholder="숫자 6자리"
                           onkeyup="fnBtnRequestCtr();" onkeypress="return cm.input.check(this);"
                           oninput="cm.input.slice(this);"
                    />
                    <p id="idTime" class="time">00:00</p>
                </dd>
            </dl>
        </div>
        <p class="t_text">* 유효시간이 경과되면 “재발송”을 통해 인증번호를 다시 받으셔야 합니다.</p>

        <div class="btn_area">
            <!-- 			<a href="javascript:void(0);" class="btn_m btn_ty01" id="idBtnConfirm" onclick="fnChkPinNumber();">확인</a> -->
        </div>
    </div>

    <form name='f' action="/sign/authenticate" method='POST'>
        <table>
            <tr>
                <td>계약번호(hidden):</td>
                <td><input type='text' name='c' value=''></td>
            </tr>
            <tr>
                <td>Pin:</td>
                <td><input type='password' name='p' value=""/></td>
            </tr>
            <tr>
                <td><input name="submit" type="submit" value="submit"/></td>
            </tr>
        </table>
    </form>
    <!-- //cont_area -->
</div>
<!-- //container -->
<script type="text/javascript">

    var callType;
    var PIN_TIME_LIMIT = '5';

    $(function () {

        $('#hpNo').val(phoneFomatter($('#hpNo').val()));

        //pin번호 발송
        fnReqPinNumber();// send

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

        ComUtil.sendPinCode(fnReqPinNumberCallback);

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

        var paramMap = {pinCode: $('#idPinNo').val()};
        var requestMap = {
            dataParam: paramMap,
            url: '/pin/check'
        };
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
