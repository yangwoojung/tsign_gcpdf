<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>


<!-- container -->
<div id="container">

    <!-- cont_area -->
    <div class="cont_area">
        <div class="txt_msg_box cont">개인 신용정보 <span class="point">수집·이용·제공·취급·위탁</span>에<br>대해 동의해 주세요.</div>
        <div class="progress">
            <div class="box-progress-bar">
                <span class="box-progress" style="width: 50%;"></span>
            </div>
            <div class="number">
                <span class="active">2</span>/4
            </div>
        </div>

        <!--체크전-->
        <div id="mt02_all_check">
            <div class="checkBox-wrap">
                <input type="checkbox" name="chk_t_all" class="checkBox" id="chk_all"
                       onclick="chkAll(this);">
                <label for="chk_all">
                    <span class="checkPoint"></span>
                    <ins><i>전체 동의</i></ins>
                </label>
            </div>
            <div class="popOpen">
                <a class="arrow arrowRight" href="javascript:;" onclick="fnPopOpen('0');"></a>
            </div>
        </div>
        <div class="cont a1">
            <!-- form_box -->
            <div class="box_ty">
                <ul class="list">
                    <li>
                        <div class="checkBox-wrap">
                            <input type="checkbox" name="chk_t" class="checkBox" id="chk01">
                            <label for="chk01">
                                <span class="checkPoint"></span>
                                <ins><i>(필수) 개인(신용)정보의 수집, 이용에 관한 사항</i></ins>
                            </label>
                        </div>
                        <div class="popOpen">
                            <a class="arrow arrowRight" href="javascript:;" onclick="fnPopOpen('1');"></a>
                        </div>
                    </li>
                    <li>
                        <div class="checkBox-wrap">
                            <input type="checkbox" name="chk_t" class="checkBox" id="chk02">
                            <label for="chk02">
                                <span class="checkPoint"></span>
                                <ins><i>(필수) 고유식별번호의 수집, 이용에 관한 사항</i></ins>
                            </label>
                        </div>
                        <div class="popOpen">
                            <a class="arrow arrowRight" href="javascript:;" onclick="fnPopOpen('2');"></a>
                        </div>
                    </li>
                    <li>
                        <div class="checkBox-wrap">
                            <input type="checkbox" name="chk_t" class="checkBox" id="chk03">
                            <label for="chk03">
                                <span class="checkPoint"></span>
                                <ins><i>(필수) 개인(신용)정보의 제3자 제공에 관한 사항</i></ins>
                            </label>
                        </div>
                        <div class="popOpen">
                            <a class="arrow arrowRight" href="javascript:;" onclick="fnPopOpen('3');"></a>
                        </div>
                    </li>
                    <li>
                        <div class="checkBox-wrap">
                            <input type="checkbox" name="chk_t" class="checkBox" id="chk04">
                            <label for="chk04">
                                <span class="checkPoint"></span>
                                <ins><i>(필수) 개인(신용)정보의 취급위탁에 관한 사항</i></ins>
                            </label>
                        </div>
                        <div class="popOpen">
                            <a class="arrow arrowRight" href="javascript:;" onclick="fnPopOpen('4');"></a>
                        </div>
                    </li>
                    <li>
                        <div class="checkBox-wrap">
                            <input type="checkbox" name="chk_t" class="checkBox" id="chk05">
                            <label for="chk05">
                                <span class="checkPoint"></span>
                                <ins><i>(선택) 개인(신용)정보의 수집, 이용에 관한 사항</i></ins>
                            </label>
                        </div>
                        <div class="popOpen">
                            <a class="arrow arrowRight" href="javascript:;" onclick="fnPopOpen('5');"></a>
                        </div>
                    </li>
                    <li>
                        <div class="checkBox-wrap">
                            <input type="checkbox" name="chk_t" class="checkBox" id="chk06">
                            <label for="chk06">
                                <span class="checkPoint"></span>
                                <ins><i>(선택) 개인(신용)정보의 제3자 제공에 관한 사항</i></ins>
                            </label>
                        </div>
                        <div class="popOpen">
                            <a class="arrow arrowRight" href="javascript:;" onclick="fnPopOpen('6');"></a>
                        </div>
                    </li>
                </ul>
            </div>
        </div>

        <div class="btn_area">
            <a href="javascript:;" class="btn_m btn_ty02 disabled">다음</a>
        </div>
   <%--     <p class="txt_msg">계약자 정보</p>

        <div class="cont">
            <!-- form_box -->
            <div class="form_box bg">
                <dl class="list">
                    <dt>성명</dt>
                    <dd>
                        <p>
                            <input id="userNm" type="text" class="input_ty" readonly value="${userNm }">
                        </p>
                    </dd>
                </dl>
                <dl class="list">
                    <dt>주민등록번호</dt>
                    <dd class="half">
                        <input id="inResidentNo1" type="text" class="input_ty" placeholder="6자리숫자" maxlength="6"
                               onkeydown="return onlyNumber(event)" onkeyup="removeChar(event)"/>
                        <input id="inResidentNo2" type="text" class="input_ty" placeholder="7자리숫자" maxlength="7"
                               onkeydown="return onlyNumber(event)" onkeyup="removeChar(event)"/>
                    </dd>
                </dl>
                <p class="t_point mt01">* 세금신고용도로 사용됩니다. </p>

                <dl class="list">
                    <dt>주소</dt>
                    <dd>
                        <p><input id="inAddr" type="text" class="input_ty" value="" placeholder="도로명 주소/동,호수까지 입력"></p>
                    </dd>
                </dl>
                <dl class="list">
                    <dt>계좌정보</dt>
                    <dd class="half03">
                        <p>
                            <select id="stlmAccBank">
                                <option value="" selected>은행선택</option>
                                <option value="003">기업은행</option>
                                <option value="004">국민은행</option>
                                <option value="005">외환은행</option>
                                <option value="007">수협은행</option>
                                <option value="011">농협은행</option>
                                <option value="020">우리은행</option>
                                <option value="081">KEB하나은행</option>
                                <option value="088">신한은행</option>
                                <option value="089">K뱅크</option>
                                <option value="090">카카오뱅크</option>
                                <option value="023">SC제일은행</option>
                                <option value="027">한국씨티은행</option>
                                <option value="031">대구은행</option>
                                <option value="032">부산은행</option>
                                <option value="034">광주은행</option>
                                <option value="035">제주은행</option>
                                <option value="037">전북은행</option>
                                <option value="039">경남은행</option>
                                <option value="045">새마을금고</option>
                                <option value="048">신협</option>
                                <option value="050">상호저축은행</option>
                                <option value="064">산림조합</option>
                                <option value="071">우체국</option>
                                <option value="001">한국은행</option>
                                <option value="002">산업은행</option>
                                <option value="076">신용보증기금</option>
                                <option value="077">기술보증기금</option>
                                <option value="102">대신저축은행</option>
                                <option value="103">에스비아이저축은행</option>
                                <option value="104">에이치케이저축은행</option>
                                <option value="105">웰컴저축은행</option>
                                <option value="209">유안타증권</option>
                                <option value="218">KB증권</option>
                                <option value="221">골든브릿지투자증권</option>
                                <option value="222">한양증권</option>
                                <option value="223">리딩투자증권</option>
                                <option value="224">BNK투자증권</option>
                                <option value="225">IBK투자증권</option>
                                <option value="227">KTB투자증권</option>
                                <option value="238">미래에셋대우</option>
                                <option value="240">삼성증권</option>
                                <option value="243">한국투자증권</option>
                                <option value="247">NH투자증권</option>
                                <option value="261">교보증권</option>
                                <option value="262">하이투자증권</option>
                                <option value="263">HMC증권</option>
                                <option value="264">키움증권</option>
                                <option value="265">이베스트투자증권</option>
                                <option value="266">SK증권</option>
                                <option value="267">대신증권</option>
                                <option value="269">한화투자증권</option>
                                <option value="270">하나금융투자</option>
                                <option value="278">신한금융투자</option>
                                <option value="279">동부증권</option>
                                <option value="280">유진투자증권</option>
                                <option value="287">메리츠종합금융증권</option>
                                <option value="290">부국증권</option>
                                <option value="291">신영증권</option>
                                <option value="292">케이프투자증권</option>
                                <option value="293">한국증권금융</option>
                                <option value="294">펀드온라인코리아</option>
                                <option value="295">우리종합금융</option>
                            </select>
                        </p>
                        <p>
                            <input type="text" class="input_ty" placeholder="-없이 숫자만 입력" maxlength="30"
                                   onkeydown="return onlyNumber(event)" onkeyup="removeChar(event)" id="stlmAccNo"/>
                        </p>
                    </dd>
                </dl>
                <dl class="list">
                    <dt>이메일</dt>
                    <dd>
                        <p>
                            <input type="text" value="${email }" class="input_ty"
                                   placeholder="이메일 입력(예 : ts@tsoft.co.kr)" maxlength="100"
                                   onkeyup="removeSpaces(event)" id="etaxEmail"/>
                        </p>
                    </dd>
                </dl>
                <p class="t_point mt01">* 해당 메일로 계약서 원본 발송 </p>
            </div>
            <!-- //form_box -->
        </div>
        <div class="btn_area">
            <button class="btn_s02 btn_ty02" id="btnAgreeInfoView">전자계약서 [보기]</button>
        </div>--%>
<!--         <div class="btn_area"> -->
<!--             비활성화 -->
<!--             <a href="javascript:void(0);" class="btn_m btn_ty01" id="idBtnRequest" onclick="fnMoveNext();">본인인증</a> -->
<!--             활성화 -->
<!--             <a href="#" class="btn_m btn_ty02">다음 단계로 이동</a> -->
<!--         </div> -->
    </div>
    <!-- //cont_area -->
</div>
<!-- //container -->


<!-- <form action="/sign/pdf/view" id="viewForm" method="post"> -->
<form action="/sign/report/viewReport" id="reportForm" name="reportForm" target="report" method="post">
    <input type="hidden" name="contrcNo" id="contrcNo" value="${contrcNo}"/>
    <input type="hidden" name="inputResidentNo1" id="inputResidentNo1" value=""/>
    <input type="hidden" name="inputResidentNo2" id="inputResidentNo2" value=""/>
    <input type="hidden" name="inputBankCd" id="inputBankCd" value=""/>
    <input type="hidden" name="inputBankNm" id="inputBankNm" value=""/>
    <input type="hidden" name="inputAcnutNo" id="inputAcnutNo" value=""/>
    <input type="hidden" name="inputAddr" id="inputAddr" value=""/>
    <input type="hidden" name="inputUserNm" id="inputUserNm" value=""/>
    <input type="hidden" name="inputEmail" id="inputEmail" value=""/>
</form>

<!-- default layout으로 이동 -->
<!-- <div id="idPopup" class="ts_popup"></div> -->
<script src="/resources/sign/js/fabric.js"></script>
<script type="text/javascript">
    var contrcNo = '${contrcNo}';

    var isView = false;
    /**
     const blank = document.createElement('canvas');
     var target = document.getElementById('signCan');
     blank.width = target.width;
     blank.height = target.height;
     **/
    $(function () {

        $('#chk01').click(fnCheckRaidoAll);

        $('#btnAgreeInfoView').click(viewReport);

    });

    // 팝업 열기
    function fnPopOpen(num) {
        $('#idPopup2').tsPopup('open', '/sign/agree/agreePop' + num);
    };

    var fnClose = function (status) {
        if (status !== '0000') {
            $('#idPopup2').tsPopup('close');
        } else {

        }
    }

    function fnCheckRaidoAll() {
        var checkNum = 0;
        for (var i = 1; i <= 6; i++) {
            if ($("input:checkbox[id='chk0" + i + "']").is(":checked")) {
                checkNum++;
            }
        }

        if (checkNum == 6) {
            $("#mt02_all_check").addClass("on");
            $('input[name=chk_t_all]').prop('checked', true).change();
        } else {
            $("#mt02_all_check").removeClass("on");
            $('input[name=chk_t_all]').prop('checked', false).change();
        }

        var checkNum = 0;
        for (var i = 1; i <= 4; i++) {
            if ($("input:checkbox[id='chk0" + i + "']").is(":checked")) {
                checkNum++;
            }
        }

        if (checkNum == 4) {
            $('#btnAgreeInfoView').removeClass('btn_ty01').addClass('btn_ty02');
            if (isOpenedView) {
                $('#idBtnRequest').removeClass('btn_ty01').addClass('btn_ty02');
            }
        } else {
            $('#btnAgreeInfoView').removeClass('btn_ty02').addClass('btn_ty01');
            $('#idBtnRequest').removeClass('btn_ty02').addClass('btn_ty01');
        }
    }

    var isOpenedView = false;

//     // pdf 파일 열기
//     function fnViewAgreeInfo() {
// // 	var checkM = true;
// // 	if(!$('#chk01').is(':checked')){
// // 		checkM = false;
// // 	}
// // 	if(!checkM){
// // 		alert('필수 동의 후 계약서 보기가 가능합니다.');
// // 		return;
// // 	}

//         if (fnValidateInput()) {
//             $('#inputResidentNo1').val($('#inResidentNo1').val());
//             $('#inputResidentNo2').val($('#inResidentNo2').val());
//             $('#inputBankCd').val($('#stlmAccBank option:selected').val());
//             $('#inputBankNm').val($('#stlmAccBank option:selected').text());
//             $('#inputAcnutNo').val($('#stlmAccNo').val());
//             $('#inputAddr').val($('#inAddr').val());
//             $('#inputUserNm').val($('#userNm').val());
//             $('#inputEmail').val($('#etaxEmail').val());

//             isOpenedView = true;
//             var opt = {'formNm': 'viewForm', 'action': '/sign/pdf/view'};

//             var canvas = document.getElementById('signCan');
//             var dataUrl = canvas.toDataURL('image/png');
//             console.log("canvas dataUrl ==" + dataUrl);
//             dataUrl = dataUrl.substring(dataUrl.indexOf('base64,') + 7, dataUrl.length);
//             console.log("canvas dataUrl 222==" + dataUrl);
//             $('#inputSignCan').val(dataUrl);

//             $('#idPopup2').tsPopup('postOpen', opt);
//             $('#idBtnRequest').removeClass('btn_ty01').addClass('btn_ty02');
//         }

//     }
    
    //클립소프트 crf 전자서식으로 오픈
    /** 전자 서명 */
    var viewReport = function () {
    	if (fnValidateInput()) {
            $('#inputResidentNo1').val($('#inResidentNo1').val());
            $('#inputResidentNo2').val($('#inResidentNo2').val());
            $('#inputBankCd').val($('#stlmAccBank option:selected').val());
            $('#inputBankNm').val($('#stlmAccBank option:selected').text());
            $('#inputAcnutNo').val($('#stlmAccNo').val());
            $('#inputAddr').val($('#inAddr').val());
            $('#inputUserNm').val($('#userNm').val());
            $('#inputEmail').val($('#etaxEmail').val());

	        isView = true;
			//report popup
	        var popup = window.open('', 'report');	
	        //리포트 호출할 주소 연결
	        document.reportForm.submit();
        }
    };
    
    var closeReport = function (status) {
        if (status === '0000') {
            ComUtil.submit('/sign/attach');
        } else {
            alert('다시 진행해주시기 바랍니다.');
        }
    };

    // 다음 단계로 이동
    function fnMoveNext() {
        // 핸드폰 본인인증
// 	var checkM = true;
        if (!$('#chk01').is(':checked')) {
            return;
        }

        if (!isOpenedView) {
            alert('\'계약서pdf[보기]\'를 클릭 후 진행해 주세요.');
            return;
        }

        ComUtil.submit('/sign/cert', paramMap);//휴대폰 본인인증
        return;

// 	if (fnValidateInput()) {
        if (true) {
            var paramMap_dev = {
                agree: $('input:checkbox[id="chk01"]').is(':checked') ? 'Y' : 'N',
                inResidentNo1: "920322",//$('#inResidentNo1').val(),
                inResidentNo2: "2222222",//$('#inResidentNo2').val(),
                inBankCd: "007",//$('#stlmAccBank option:selected').val(),
                inBankNm: "수협은행",//$('#stlmAccBank option:selected').text(),
                inAcnutNo: "92853455445",//$('#stlmAccNo').val(),
                inAddr: "서울시 종로구 이화동",// $("#inAddr").val()
                userNm: $('#userNm').val(),
                email: $("#etaxEmail").val(),
            };
            var paramMap = {
                agree: $('input:checkbox[id="chk01"]').is(':checked') ? 'Y' : 'N',
                inResidentNo1: $('#inResidentNo1').val(),
                inResidentNo2: $('#inResidentNo2').val(),
                inBankCd: $('#stlmAccBank option:selected').val(),
                inBankNm: $('#stlmAccBank option:selected').text(),
                inAcnutNo: $('#stlmAccNo').val(),
                inAddr: $("#inAddr").val(),
                userNm: $('#userNm').val(),
                email: $("#etaxEmail").val(),
            };
            var requestMap = {
                dataParam: paramMap_dev,
                url: '/agree/updateAgreeInfo'
            };
            ComUtil.request(requestMap, function (data) {

                if (data.result == "success") {
// 				ComUtil.submit('/sign', null, 'post');

                    var canvas = document.getElementById('signCan');
                    var dataUrl = canvas.toDataURL();

                    dataUrl = dataUrl.substring(dataUrl.indexOf('base64,') + 7, dataUrl.length);
                    paramMap['signImgHash'] = dataUrl;
                    ComUtil.submit('/cert', paramMap);//휴대폰 본인인증
                    console.log("본인인증 ", paramMap);
                } else {
                    alert(data.resMsg);
                }
            }, function () {
                alert("입력된 정보를 확인하신 후 다시 시도해주세요.");
            });
        }
    };

    function fnValidateInput() {//개발중 true
        var result = false;
        if (ComUtil.isNull($('#inResidentNo1').val()) || $('#inResidentNo1').val().length != 6) {
            $('#inResidentNo1').focus();
            alert("주민등록번호를 올바르게 입력해 주세요");
        } else if (ComUtil.isNull($('#inResidentNo2').val()) || $('#inResidentNo2').val().length != 7) {
            $('#inResidentNo2').focus();
            alert("주민등록번호를 올바르게 입력해 주세요");
        } else if (ComUtil.isNull($('#inAddr').val())) {
            $('#inAddr').focus();
            alert("주소를 올바르게 입력해 주세요");
        } else if (ComUtil.isNull($('#stlmAccBank option:selected').val())) {
            $('#stlmAccBank').focus();
            alert("계좌 은행을 선택해주세요.");
        } else if (ComUtil.isNull($('#stlmAccNo').val())) {
            $('#stlmAccNo').focus();
            alert("계좌정보를 올바르게 입력해 주세요");
        } else if (ComUtil.isNull($('#etaxEmail').val()) || !matchEmail($('#etaxEmail').val())) {
            $('#etaxEmail').focus();
            alert("계약서 수신 EMAIL을 올바르게 입력해 주세요");
        } else {
            result = true;
        }
        return result;
    }

    function chkBizNo1(obj) {
        if (!ComUtil.isNull($(obj).val()) && $(obj).val().length == 3) {
            $('#bizNo2').focus();
            chkNextBtn();
        }
    }

    function chkBizNo2(obj) {
        if (!ComUtil.isNull($(obj).val()) && $(obj).val().length == 2) {
            $('#bizNo3').focus();
            chkNextBtn();
        }
    }

    function chkBizNo3(obj) {
        chkNextBtn();
    }

    function chkNextBtn() {
        if ($('#chk_all').is(':checked') && $('input:radio[name="apply"]:checked').length != 0
            && $('#bizNo1').val().length == 3 && $('#bizNo2').val().length == 2
            && $('#bizNo3').val().length == 5) {
            $('#idBtnRequest').removeClass('btn_ty01').addClass('btn_ty02');
        } else {
            $('#idBtnRequest').removeClass('btn_ty02').addClass('btn_ty01');
        }
    }

    function matchEmail(str) {
        var returnBool = false;
        if (str) {
            var emailRegx = /^[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*@[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*.[a-zA-Z]{2,3}$/i;
            returnBool = str.match(emailRegx) == null ? false : true;
        }
        return returnBool;
    }

//     var blank;
//     (function () {
// // 	if(custType == '1'){
// // 		$('#crpDiv').hide();
// // 		$('#psnDiv').show();
// // 	}else if(custType == '2'){
// // 		$('#crpDiv').show();
// // 		$('#psnDiv').hide();
// // 	}

// // 	if(contSignerType == '1'){
// // 		$('#agentDiv').hide();
// // 	}else if(contSignerType == '2'){
// // 		$('#agentDiv').show();
// // 	}

//         var canvas = this.__canvas = new fabric.Canvas('signCan', {
//             isDrawingMode: true
//         });

//         canvas.freeDrawingBrush = new fabric['PencilBrush'](canvas);
//         canvas.freeDrawingBrush.color = '#000000';
//         canvas.freeDrawingBrush.width = 5;
//         canvas.freeDrawingBrush.shadow = new fabric.Shadow({
//             blur: 0,
//             offsetX: 0,
//             offsetY: 0,
//             affectStroke: true,
//             color: '#005E7A',
//         });

//         fabric.Object.prototype.transparentCorners = false;
//         $('#delSign').on('click', function () {
//             var targetCan = document.getElementById('signCan');
//             if (blank == targetCan.toDataURL()) {
//                 alert('입력된 자필서명이 없습니다.');
//             } else {
//                 alert('입력된 자필서명이 삭제되었습니다.');
//             }
//             canvas.clear();
//         });

//         if (fabric.PatternBrush) {
//             var vLinePatternBrush = new fabric.PatternBrush(canvas);
//             vLinePatternBrush.getPatternSrc = function () {

//                 var patternCanvas = fabric.document.createElement('canvas');
//                 patternCanvas.width = patternCanvas.height = 10;
//                 var ctx = patternCanvas.getContext('2d');

//                 ctx.strokeStyle = this.color;
//                 ctx.lineWidth = 5;
//                 ctx.beginPath();
//                 ctx.moveTo(0, 5);
//                 ctx.lineTo(10, 5);
//                 ctx.closePath();
//                 ctx.stroke();
//                 return patternCanvas;
//             };

//             var hLinePatternBrush = new fabric.PatternBrush(canvas);
//             hLinePatternBrush.getPatternSrc = function () {
//                 var patternCanvas = fabric.document.createElement('canvas');
//                 patternCanvas.width = patternCanvas.height = 10;
//                 var ctx = patternCanvas.getContext('2d');

//                 ctx.strokeStyle = this.color;
//                 ctx.lineWidth = 5;
//                 ctx.beginPath();
//                 ctx.moveTo(5, 0);
//                 ctx.lineTo(5, 10);
//                 ctx.closePath();
//                 ctx.stroke();
//                 return patternCanvas;
//             };

//             var squarePatternBrush = new fabric.PatternBrush(canvas);
//             squarePatternBrush.getPatternSrc = function () {
//                 var squareWidth = 10, squareDistance = 2;
//                 var patternCanvas = fabric.document.createElement('canvas');
//                 patternCanvas.width = patternCanvas.height = squareWidth + squareDistance;
//                 var ctx = patternCanvas.getContext('2d');

//                 ctx.fillStyle = this.color;
//                 ctx.fillRect(0, 0, squareWidth, squareWidth);
//                 return patternCanvas;
//             };

//             var diamondPatternBrush = new fabric.PatternBrush(canvas);
//             diamondPatternBrush.getPatternSrc = function () {
//                 var squareWidth = 10, squareDistance = 5;
//                 var patternCanvas = fabric.document.createElement('canvas');
//                 var rect = new fabric.Rect({
//                     width: squareWidth,
//                     height: squareWidth,
//                     angle: 45,
//                     fill: this.color
//                 });

//                 var canvasWidth = rect.getBoundingRect().width;

//                 patternCanvas.width = patternCanvas.height = canvasWidth + squareDistance;
//                 rect.set({left: canvasWidth / 2, top: canvasWidth / 2});

//                 var ctx = patternCanvas.getContext('2d');
//                 rect.render(ctx);

//                 return patternCanvas;
//             };
//             var texturePatternBrush = new fabric.PatternBrush(canvas);

//             /**
//              var img = new Image();
//              img.src = '../assets/honey_im_subtle.png';
//              texturePatternBrush.source = img;
//              **/
//         }

//         blank = document.getElementById('signCan').toDataURL();
//     })();

</script>

</body>

</html>
