<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

<!-- container -->
<div id="container">
    <!-- cont_area -->
    <div class="cont_area">
        <a href="/sign/logout">로그아웃</a>
        <div class="txt_msg_box cont">개인 신용정보 수집·이용·제공·취급·위탁에 대해 동의해 주세요.</div>

        <div class="cont a1">
            <h3 class="t_tit">개인 신용정보 수집·이용·제공·취급·위탁에 대한 필수적 동의</h3>
            <!-- form_box -->
            <div class="box_ty">
                <ul class="list">
                    <li>
                        <div class="tit">
                            <div class="ez-checks">
                                <input type="checkbox" name="chk_t" class="chk_ty ca_li ez-hide" id="chk01"/>
                                <label for="chk01">개인(신용)정보의 수집, 이용에 관한 사항</label>
                            </div>
                        </div>
                        <div class="btn">
                            <a href="#" href="javascript:;" onclick="fnPopOpen('1');">전체보기</a>
                        </div>
                    </li>
                    <li>
                        <div class="tit">
                            <div class="ez-checks">
                                <input type="checkbox" name="chk_t" class="chk_ty ca_li ez-hide" id="chk02"/>
                                <label for="chk02">고유식별번호의 수집, 이용에 관한 사항</label>
                            </div>
                        </div>
                        <div class="btn">
                            <a href="#" href="javascript:;" onclick="fnPopOpen('2');">전체보기</a>
                        </div>
                    </li>
                    <li>
                        <div class="tit">
                            <div class="ez-checks">
                                <input type="checkbox" name="chk_t" class="chk_ty ca_li ez-hide" id="chk03"/>
                                <label for="chk03">개인(신용)정보의 제3자 제공에 관한 사항</label>
                            </div>
                        </div>
                        <div class="btn">
                            <a href="#" href="javascript:;" onclick="fnPopOpen('3');">전체보기</a>
                        </div>
                    </li>
                    <li>
                        <div class="tit">
                            <div class="ez-checks">
                                <input type="checkbox" name="chk_t" class="chk_ty ca_li ez-hide" id="chk04"/>
                                <label for="chk04">개인(신용)정보의 취급위탁에 관한 사항</label>
                            </div>
                        </div>
                        <div class="btn">
                            <a href="#" href="javascript:;" onclick="fnPopOpen('4');">전체보기</a>
                        </div>
                    </li>
                </ul>
            </div>
        </div>

        <div class="cont a1">
            <h3 class="t_tit">개인 신용정보 수집·이용·제공에 대한 선택적 동의</h3>
            <!-- form_box -->
            <div class="box_ty">
                <ul class="list">
                    <li>
                        <div class="tit">
                            <div class="ez-checks">
                                <input type="checkbox" name="chk_t" class="chk_ty ca_li ez-hide" id="chk05"/>
                                <label for="chk05">개인(신용)정보의 수집, 이용에 관한 사항</label>
                            </div>
                        </div>
                        <div class="btn">
                            <a href="#" href="javascript:;" onclick="fnPopOpen('5');">전체보기</a>
                        </div>
                    </li>
                    <li>
                        <div class="tit">
                            <div class="ez-checks">
                                <input type="checkbox" name="chk_t" class="chk_ty ca_li ez-hide" id="chk06"/>
                                <label for="chk06">개인(신용)정보의 제3자 제공에 관한 사항</label>
                            </div>
                        </div>
                        <div class="btn">
                            <a href="#" href="javascript:;" onclick="fnPopOpen('6');">전체보기</a>
                        </div>
                    </li>
                </ul>
            </div>

            <!--체크전-->
            <div class="mt02 all_check" id="mt02_all_check">
                <div class="ez-checks">
                    <input type="checkbox" name="chk_t_all" class="chk_ty ca_all ez-hide" id="chk_all"
                           onclick="chkAll(this);">
                    <label for="chk_all">전체동의합니다.</label>
                </div>
            </div>
            <!-- //form_box -->
            <script>
                /* 전체 동의 */
                function chkAll(obj) {
                    var objName = $(obj).closest('.cont.a1').find('.ca_li').attr('name');
                    if ($(obj).is(':checked')) {
                        $("#mt02_all_check").addClass("on");
                        $('input[name=' + objName + ']').prop('checked', true).change();
                        $('#btnAgreeInfoView').removeClass('btn_ty01').addClass('btn_ty02');
                        if (isOpenedView) {
                            $('#idBtnRequest').removeClass('btn_ty01').addClass('btn_ty02');
                        }
                    } else {
                        $("#mt02_all_check").removeClass("on");
                        $('input[name=' + objName + ']').prop('checked', false).change();
                        $('#btnAgreeInfoView').removeClass('btn_ty02').addClass('btn_ty01');
                        $('#idBtnRequest').removeClass('btn_ty02').addClass('btn_ty01');
                    }
                }
            </script>
        </div>


        <p class="txt_msg">사업자 및 정산계좌정보</p>

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

        <!-- sign_area -->
        <div class="sign_area">
            <canvas id="signCan" width="740" height="280">
            </canvas>
        </div>
        <!-- //sign_area -->
        <p class="t_text">
            * 위 서명란에 자필서명해 주세요 (예 : 홍길동)<br/>
        </p>


        <!-- txt_msg -->
        <div class="btn_area">
            <!-- 비활성화 -->
            <button class="btn_m btn_ty01" id="btnAgreeInfoView">전자계약서 [보기](pdf)</button>

            <!-- 활성화 -->
            <!-- <button class="btn_s02 btn_ty02">전자계약서  [보기]</button>-->
        </div>


        <div class="btn_area">
            <!-- 비활성화 -->
            <a href="javascript:void(0);" class="btn_m btn_ty01" id="idBtnRequest" onclick="fnMoveNext();">다음 단계로 이동</a>
            <!-- 활성화 -->
            <!-- <a href="#" class="btn_m btn_ty02">다음 단계로 이동</a> -->
        </div>
    </div>
    <!-- //cont_area -->
</div>
<!-- //container -->
<script>
    //팝업 열기
    function fnPopOpen(num) {
        $('#idPopup').tsPopup('open', '/agree/agreePop' + num);
    };

    var fnClose = function (status) {
        if (status !== '0000') {
            $('#idPopup').tsPopup('close');
        } else {

        }
    }
    var isOpenedView = false;

    // pdf 파일 열기
    function fnViewAgreeInfo() {
        var checkM = true;
        if (!$('#chk01').is(':checked')) {
            checkM = false;
        }
        if (!$('#chk02').is(':checked')) {
            checkM = false;
        }
        if (!$('#chk03').is(':checked')) {
            checkM = false;
        }
        if (!$('#chk04').is(':checked')) {
            checkM = false;
        }
        if (!checkM) {
            alert('필수 동의 후 가맹점 신청 보기가 가능합니다.');
            return;
        }

        if (fnValidateInput()) {
            $('#inputResidentNo1').val($('#inResidentNo1').val());
            $('#inputResidentNo2').val($('#inResidentNo2').val());
            $('#inputBankCd').val($('#stlmAccBank option:selected').val());
            $('#inputBankNm').val($('#stlmAccBank option:selected').text());
            $('#inputAcnutNo').val($('#stlmAccNo').val());
            $('#inputAddr').val($('#inAddr').val());
            $('#inputUserNm').val($('#userNm').val());
            $('#inputEmail').val($('#etaxEmail').val());

            isOpenedView = true;
            var opt = {'formNm': 'viewForm', 'action': '/pdf/view'};

            var canvas = document.getElementById('signCan');
            var dataUrl = canvas.toDataURL('image/png');
            console.log("canvas dataUrl ==" + dataUrl);
            dataUrl = dataUrl.substring(dataUrl.indexOf('base64,') + 7, dataUrl.length);
            console.log("canvas dataUrl 222==" + dataUrl);
            $('#inputSignCan').val(dataUrl);

            $('#idPopup').tsPopup('postOpen', opt);
            $('#idBtnRequest').removeClass('btn_ty01').addClass('btn_ty02');
        }

    }

    function fnValidateInput() {//개발중 true
        var result = true;
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

    var blank;
    (function () {
        if (custType == '1') {
            $('#crpDiv').hide();
            $('#psnDiv').show();
        } else if (custType == '2') {
            $('#crpDiv').show();
            $('#psnDiv').hide();
        }

        if (contSignerType == '1') {
            $('#agentDiv').hide();
        } else if (contSignerType == '2') {
            $('#agentDiv').show();
        }

        var canvas = this.__canvas = new fabric.Canvas('signCan', {
            isDrawingMode: true
        });

        canvas.freeDrawingBrush = new fabric['PencilBrush'](canvas);
        canvas.freeDrawingBrush.color = '#000000';
        canvas.freeDrawingBrush.width = 5;
        canvas.freeDrawingBrush.shadow = new fabric.Shadow({
            blur: 0,
            offsetX: 0,
            offsetY: 0,
            affectStroke: true,
            color: '#005E7A',
        });

        fabric.Object.prototype.transparentCorners = false;
        $('#delSign').on('click', function () {
            var targetCan = document.getElementById('signCan');
            if (blank == targetCan.toDataURL()) {
                alert('입력된 자필서명이 없습니다.');
            } else {
                alert('입력된 자필서명이 삭제되었습니다.');
            }
            canvas.clear();
        });

        if (fabric.PatternBrush) {
            var vLinePatternBrush = new fabric.PatternBrush(canvas);
            vLinePatternBrush.getPatternSrc = function () {

                var patternCanvas = fabric.document.createElement('canvas');
                patternCanvas.width = patternCanvas.height = 10;
                var ctx = patternCanvas.getContext('2d');

                ctx.strokeStyle = this.color;
                ctx.lineWidth = 5;
                ctx.beginPath();
                ctx.moveTo(0, 5);
                ctx.lineTo(10, 5);
                ctx.closePath();
                ctx.stroke();
                return patternCanvas;
            };

            var hLinePatternBrush = new fabric.PatternBrush(canvas);
            hLinePatternBrush.getPatternSrc = function () {
                var patternCanvas = fabric.document.createElement('canvas');
                patternCanvas.width = patternCanvas.height = 10;
                var ctx = patternCanvas.getContext('2d');

                ctx.strokeStyle = this.color;
                ctx.lineWidth = 5;
                ctx.beginPath();
                ctx.moveTo(5, 0);
                ctx.lineTo(5, 10);
                ctx.closePath();
                ctx.stroke();
                return patternCanvas;
            };

            var squarePatternBrush = new fabric.PatternBrush(canvas);
            squarePatternBrush.getPatternSrc = function () {
                var squareWidth = 10, squareDistance = 2;
                var patternCanvas = fabric.document.createElement('canvas');
                patternCanvas.width = patternCanvas.height = squareWidth + squareDistance;
                var ctx = patternCanvas.getContext('2d');

                ctx.fillStyle = this.color;
                ctx.fillRect(0, 0, squareWidth, squareWidth);
                return patternCanvas;
            };

            var diamondPatternBrush = new fabric.PatternBrush(canvas);
            diamondPatternBrush.getPatternSrc = function () {
                var squareWidth = 10, squareDistance = 5;
                var patternCanvas = fabric.document.createElement('canvas');
                var rect = new fabric.Rect({
                    width: squareWidth,
                    height: squareWidth,
                    angle: 45,
                    fill: this.color
                });

                var canvasWidth = rect.getBoundingRect().width;

                patternCanvas.width = patternCanvas.height = canvasWidth + squareDistance;
                rect.set({left: canvasWidth / 2, top: canvasWidth / 2});

                var ctx = patternCanvas.getContext('2d');
                rect.render(ctx);

                return patternCanvas;
            };
            var texturePatternBrush = new fabric.PatternBrush(canvas);

            /**
             var img = new Image();
             img.src = '../assets/honey_im_subtle.png';
             texturePatternBrush.source = img;
             **/
        }

        blank = document.getElementById('signCan').toDataURL();
    })();
</script>