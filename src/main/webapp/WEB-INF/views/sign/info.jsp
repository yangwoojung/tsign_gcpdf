<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

<header>
    <h2 class="title">계약자 정보</h2>
</header>

<!-- container -->
<div id="container">

    <!-- cont_area -->
    <div class="cont_area">
        <div class="txt_msg_box cont">개인 신용정보 <span class="point">수집·이용·제공·취급·위탁</span>에<br>대해 동의해 주세요.</div>
<%--        <div class="progress">--%>
<%--            <div class="box-progress-bar">--%>
<%--                <span class="box-progress" style="width: 66.6666%;"></span>--%>
<%--            </div>--%>
<%--            <div class="number">--%>
<%--                <span class="active">2</span>/3--%>
<%--            </div>--%>
<%--        </div>--%>

        <div class="cont">
            <!-- form_box -->
            <form id="reportForm" method="post" action="/sign/pdf/view" onsubmit="return fnMoveNext()">
                <input type="hidden" name="contractNo" value="${user.contractNo}"/>
                <input type="hidden" name="signCanvasDataUrl" id="signCanvasDataUrl" value=""/>
                <input type="submit" id="submitReportForm" class="hidden"/>

                <div class="form_box typeSide">
                    <dl class="list">
                        <dt>성명</dt>
                        <dd>
                            <p>
                                <input id="userNm" name="userNm" type="text" class="input_ty focusNone"
                                       value="${user.userNm}"
                                       autocomplete="off"
                                       readonly required>
                            </p>
                        </dd>
                    </dl>
                    <%--                    <dl class="list">--%>
                    <%--                        <dt>주민등록번호</dt>--%>
                    <%--                        <dd class="half">--%>
                    <%--                            <input id="inResidentNo1" name="residentNo1" type="tel" class="input_ty focusNone" placeholder="6자리숫자"--%>
                    <%--                                   maxlength="6"--%>
                    <%--                                   onkeydown="return onlyNumber(event)" onkeyup="removeChar(event)" autocomplete="off"--%>
                    <%--                                   required/>--%>
                    <%--                            <input id="inResidentNo2" name="residentNo2" type="tel" class="input_ty focusNone" placeholder="7자리숫자"--%>
                    <%--                                   maxlength="7"--%>
                    <%--                                   onkeydown="return onlyNumber(event)" onkeyup="removeChar(event)" autocomplete="off"--%>
                    <%--                                   required/>--%>
                    <%--                        </dd>--%>
                    <%--                    </dl>--%>
                    <dl class="list">
                        <dt>주소</dt>
                        <dd>
                            <textarea id="addr1" name="address" type="text" class="input_ty focusNone"
                                      placeholder="도로명 주소/동,호수까지 입력"
                                      autocomplete="off" required></textarea>
                        </dd>
                    </dl>
                    <%--                    <dl class="list">--%>
                    <%--                        <dt>은행 선택</dt>--%>
                    <%--                        <dd class="half03">--%>
                    <%--                            <p>--%>
                    <%--                                <select id="stlmAccBank" name="bankAccountNo" required>--%>
                    <%--                                    <option value="" selected>은행선택</option>--%>
                    <%--                                    <option value="003">기업은행</option>--%>
                    <%--                                    <option value="004">국민은행</option>--%>
                    <%--                                    <option value="005">외환은행</option>--%>
                    <%--                                    <option value="007">수협은행</option>--%>
                    <%--                                    <option value="011">농협은행</option>--%>
                    <%--                                    <option value="020">우리은행</option>--%>
                    <%--                                    <option value="081">KEB하나은행</option>--%>
                    <%--                                    <option value="088">신한은행</option>--%>
                    <%--                                    <option value="089">K뱅크</option>--%>
                    <%--                                    <option value="090">카카오뱅크</option>--%>
                    <%--                                    <option value="023">SC제일은행</option>--%>
                    <%--                                    <option value="027">한국씨티은행</option>--%>
                    <%--                                    <option value="031">대구은행</option>--%>
                    <%--                                    <option value="032">부산은행</option>--%>
                    <%--                                    <option value="034">광주은행</option>--%>
                    <%--                                    <option value="035">제주은행</option>--%>
                    <%--                                    <option value="037">전북은행</option>--%>
                    <%--                                    <option value="039">경남은행</option>--%>
                    <%--                                    <option value="045">새마을금고</option>--%>
                    <%--                                    <option value="048">신협</option>--%>
                    <%--                                    <option value="050">상호저축은행</option>--%>
                    <%--                                    <option value="064">산림조합</option>--%>
                    <%--                                    <option value="071">우체국</option>--%>
                    <%--                                    <option value="001">한국은행</option>--%>
                    <%--                                    <option value="002">산업은행</option>--%>
                    <%--                                    <option value="076">신용보증기금</option>--%>
                    <%--                                    <option value="077">기술보증기금</option>--%>
                    <%--                                    <option value="102">대신저축은행</option>--%>
                    <%--                                    <option value="103">에스비아이저축은행</option>--%>
                    <%--                                    <option value="104">에이치케이저축은행</option>--%>
                    <%--                                    <option value="105">웰컴저축은행</option>--%>
                    <%--                                    <option value="209">유안타증권</option>--%>
                    <%--                                    <option value="218">KB증권</option>--%>
                    <%--                                    <option value="221">골든브릿지투자증권</option>--%>
                    <%--                                    <option value="222">한양증권</option>--%>
                    <%--                                    <option value="223">리딩투자증권</option>--%>
                    <%--                                    <option value="224">BNK투자증권</option>--%>
                    <%--                                    <option value="225">IBK투자증권</option>--%>
                    <%--                                    <option value="227">KTB투자증권</option>--%>
                    <%--                                    <option value="238">미래에셋대우</option>--%>
                    <%--                                    <option value="240">삼성증권</option>--%>
                    <%--                                    <option value="243">한국투자증권</option>--%>
                    <%--                                    <option value="247">NH투자증권</option>--%>
                    <%--                                    <option value="261">교보증권</option>--%>
                    <%--                                    <option value="262">하이투자증권</option>--%>
                    <%--                                    <option value="263">HMC증권</option>--%>
                    <%--                                    <option value="264">키움증권</option>--%>
                    <%--                                    <option value="265">이베스트투자증권</option>--%>
                    <%--                                    <option value="266">SK증권</option>--%>
                    <%--                                    <option value="267">대신증권</option>--%>
                    <%--                                    <option value="269">한화투자증권</option>--%>
                    <%--                                    <option value="270">하나금융투자</option>--%>
                    <%--                                    <option value="278">신한금융투자</option>--%>
                    <%--                                    <option value="279">동부증권</option>--%>
                    <%--                                    <option value="280">유진투자증권</option>--%>
                    <%--                                    <option value="287">메리츠종합금융증권</option>--%>
                    <%--                                    <option value="290">부국증권</option>--%>
                    <%--                                    <option value="291">신영증권</option>--%>
                    <%--                                    <option value="292">케이프투자증권</option>--%>
                    <%--                                    <option value="293">한국증권금융</option>--%>
                    <%--                                    <option value="294">펀드온라인코리아</option>--%>
                    <%--                                    <option value="295">우리종합금융</option>--%>
                    <%--                                </select>--%>
                    <%--                            </p>--%>
                    <%--                        </dd>--%>
                    <%--                    </dl>--%>
                    <%--                    <dl class="list">--%>
                    <%--                        <dt>계좌 번호</dt>--%>
                    <%--                        <dd class="half03">--%>
                    <%--                            <input type="tel" name="tel" class="input_ty focusNone" placeholder="-없이 숫자만 입력" maxlength="30"--%>
                    <%--                                   onkeydown="return onlyNumber(event)" onkeyup="removeChar(event)" id="stlmAccNo"--%>
                    <%--                                   autocomplete="off" required/>--%>
                    <%--                        </dd>--%>
                    <%--                    </dl>--%>
                    <dl class="list">
                        <dt>이메일</dt>
                        <dd>
                            <p>
                                <input type="email" name="email" value="${user.email}" class="input_ty focusNone"
                                       disabled required/>
                                <%--
                                                                <input type="email" name="email" value="${user.email}" class="input_ty focusNone"
                                                                       placeholder="이메일 입력(예 : ts@tsoft.co.kr)" maxlength="100"
                                                                       onkeyup="removeSpaces(event)" id="etaxEmail" autocomplete="off" required/>
                                --%>
                            </p>
                        </dd>
                    </dl>
                    <ul class="description">
                        <%--                        <li>기재한 주민등록번호는 세금신고용도로 사용됩니다.</li>--%>
                        <li>기재되어 있는 메일로 계약서 원본 발송됩니다.</li>
                    </ul>

                    <div class="sign_area" id="sign_area">
                        <canvas id="signCanvas"></canvas>
                    </div>
                    <ul class="description">
                        <li>위 서명란에 자필서명해 주세요 (예 : 홍길동)</li>
                    </ul>
                </div>
            </form>
            <!-- //form_box -->
        </div>
    </div>
    <!-- //cont_area -->
</div>
<!-- //container -->

<footer>
    <div class="btn_area">
        <a href="javascript:" id="nextBtn" class="btn_m btn_ty02" disabled="">다음</a>
    </div>
</footer>

<script src="${pageContext.request.contextPath}/resources/sign/js/fabric.js"></script>
<script>

    $(function () {

        $('#nextBtn').on('click', function () {
            $('#submitReportForm').trigger('click');
            // location.href = '/sign/attach'
        });

        initSignCanvas();

        $('textarea').on('keyup keydown change', function (e) {
            if(this.scrollHeight > 30) {
                $(this).css('height', 'auto');
                $(this).height(this.scrollHeight);
            }
        });

    });


    // 다음 단계로 이동
    function fnMoveNext() {

        const canvas = document.getElementById('signCanvas');

        if (isCanvasBlank(canvas)) {
            alert("입력된 자필서명이 없습니다.");
            return false;
        }

        $('#signCanvasDataUrl').val(canvas.toDataURL());

        const data = $('#reportForm').serializeObject();
        console.log(data);

        return true;
    }

    const initSignCanvas = () => {

        const canvas = new fabric.Canvas('signCanvas', {
            isDrawingMode: true,
            width: document.getElementById('sign_area').clientWidth,
            height: document.getElementById('sign_area').clientHeight,
        });

        canvas.freeDrawingBrush = new fabric['PencilBrush'](canvas);
        canvas.freeDrawingBrush.color = '#000000';
        canvas.freeDrawingBrush.width = 2;


        $('#delSign').on('click', function () {
            canvas.clear();
            $('#nextBtn').attr('disabled', true);
        });

    }

    // returns true if all color channels in each pixel are 0 (or "blank")
    function isCanvasBlank(canvas) {
        return !canvas.getContext('2d')
            .getImageData(0, 0, canvas.width, canvas.height).data
            .some(channel => channel !== 0);
    }

    // var closeReport = function (status) {
    //     if (status === '0000') {
    //         ComUtil.submit('/sign/attach');
    //     } else {
    //         alert('다시 진행해주시기 바랍니다.');
    //     }
    // };

</script>
