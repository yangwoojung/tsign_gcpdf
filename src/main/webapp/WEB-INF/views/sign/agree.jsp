<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

<header>
    <h2 class="title">계약 확인</h2>
</header>

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
                <input type="checkbox" class="checkBox" id="chk_all">
                <label for="chk_all">
                    <span class="checkPoint"></span>
                    <ins><i>전체 동의</i></ins>
                </label>
            </div>
            <div class="popOpen">
                <a class="arrow arrowRight" href="javascript:" onclick="fnPopOpen('0');"></a>
            </div>
        </div>
        <div class="cont a1">
            <!-- form_box -->
            <div class="box_ty">
                <ul class="list">
                    <li>
                        <div class="checkBox-wrap">
                            <input type="checkbox" id="chk01" class="checkBox" required>
                            <label for="chk01">
                                <span class="checkPoint"></span>
                                <ins><i>(필수) 개인(신용)정보의 수집, 이용에 관한 사항</i></ins>
                            </label>
                        </div>
                        <div class="popOpen">
                            <a class="arrow arrowRight" href="javascript:" onclick="fnPopOpen('1');"></a>
                        </div>
                    </li>
                    <li>
                        <div class="checkBox-wrap">
                            <input type="checkbox" id="chk02" class="checkBox" required>
                            <label for="chk02">
                                <span class="checkPoint"></span>
                                <ins><i>(필수) 고유식별번호의 수집, 이용에 관한 사항</i></ins>
                            </label>
                        </div>
                        <div class="popOpen">
                            <a class="arrow arrowRight" href="javascript:" onclick="fnPopOpen('2');"></a>
                        </div>
                    </li>
                    <li>
                        <div class="checkBox-wrap">
                            <input type="checkbox" id="chk03" class="checkBox" required>
                            <label for="chk03">
                                <span class="checkPoint"></span>
                                <ins><i>(필수) 개인(신용)정보의 제3자 제공에 관한 사항</i></ins>
                            </label>
                        </div>
                        <div class="popOpen">
                            <a class="arrow arrowRight" href="javascript:" onclick="fnPopOpen('3');"></a>
                        </div>
                    </li>
                    <li>
                        <div class="checkBox-wrap">
                            <input type="checkbox" id="chk04" class="checkBox" required>
                            <label for="chk04">
                                <span class="checkPoint"></span>
                                <ins><i>(필수) 개인(신용)정보의 취급위탁에 관한 사항</i></ins>
                            </label>
                        </div>
                        <div class="popOpen">
                            <a class="arrow arrowRight" href="javascript:" onclick="fnPopOpen('4');"></a>
                        </div>
                    </li>
                    <li>
                        <div class="checkBox-wrap">
                            <input type="checkbox" id="chk05" class="checkBox">
                            <label for="chk05">
                                <span class="checkPoint"></span>
                                <ins><i>(선택) 개인(신용)정보의 수집, 이용에 관한 사항</i></ins>
                            </label>
                        </div>
                        <div class="popOpen">
                            <a class="arrow arrowRight" href="javascript:" onclick="fnPopOpen('5');"></a>
                        </div>
                    </li>
                    <li>
                        <div class="checkBox-wrap">
                            <input type="checkbox" id="chk06" class="checkBox">
                            <label for="chk06">
                                <span class="checkPoint"></span>
                                <ins><i>(선택) 개인(신용)정보의 제3자 제공에 관한 사항</i></ins>
                            </label>
                        </div>
                        <div class="popOpen">
                            <a class="arrow arrowRight" href="javascript:" onclick="fnPopOpen('6');"></a>
                        </div>
                    </li>
                </ul>
            </div>
        </div>
<<<<<<< HEAD

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

        <p class="txt_msg">계약자 정보</p>

        <div class="cont">
            <!-- form_box -->
            <div class="form_box bg">
                <dl class="list">
                    <dt>성명</dt>
                    <dd>
                        <p>
                            <input id="userNm" type="text" class="input_ty" readonly value="${user.userNm}">
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
                            <input type="text" value="${user.email}" class="input_ty"
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

        <div class="btn_area">
            <!-- 비활성화 -->
            <!-- 				<button class="btn_m btn_ty01" id="btnAgreeInfoView">전자계약서  [보기](pdf)</button> -->

            <!-- 활성화 -->
            <button class="btn_s02 btn_ty02" id="btnAgreeInfoView">전자계약서 [보기]</button>
        </div>
<!--         <div class="btn_area"> -->
<!--             비활성화 -->
<!--             <a href="javascript:void(0);" class="btn_m btn_ty01" id="idBtnRequest" onclick="fnMoveNext();">본인인증</a> -->
<!--             활성화 -->
<!--             <a href="#" class="btn_m btn_ty02">다음 단계로 이동</a> -->
<!--         </div> -->
=======
>>>>>>> b6de373ff4a2323481c8429aeb95d13ecd81b474
    </div>
    <!-- //cont_area -->
</div>
<!-- //container -->

<script>

<<<<<<< HEAD
<form action="/sign/pdf/view" id="viewForm" method="post">
<%--<form action="/sign/report/viewReport" id="reportForm" name="reportForm" target="report" method="post">--%>
    <input type="hidden" name="contrcNo" id="contrcNo" value="${user.contrcNo}"/>
    <input type="hidden" name="inputResidentNo1" id="inputResidentNo1" value=""/>
    <input type="hidden" name="inputResidentNo2" id="inputResidentNo2" value=""/>
    <input type="hidden" name="inputBankCd" id="inputBankCd" value=""/>
    <input type="hidden" name="inputBankNm" id="inputBankNm" value=""/>
    <input type="hidden" name="inputAcnutNo" id="inputAcnutNo" value=""/>
    <input type="hidden" name="inputAddr" id="inputAddr" value=""/>
    <input type="hidden" name="inputUserNm" id="inputUserNm" value=""/>
    <input type="hidden" name="inputEmail" id="inputEmail" value=""/>
    <input type="hidden" name="inputSignCan" id="inputSignCan" value=""/>
</form>

<!-- default layout으로 이동 -->
<!-- <div id="idPopup" class="ts_popup"></div> -->
<script src="/resources/sign/js/fabric.js"></script>
<script type="text/javascript">
    var contrcNo = '${user.contrcNo}';

    var isView = false;
    /**
     const blank = document.createElement('canvas');
     var target = document.getElementById('signCan');
     blank.width = target.width;
     blank.height = target.height;
     **/
=======
>>>>>>> b6de373ff4a2323481c8429aeb95d13ecd81b474
    $(function () {

        $('#chk_all').on('change', function () {
            $('.checkBox').prop('checked', this.checked);
        });

        $('.checkBox').on('change', function () {
            const isValid = $('.checkBox:checked:required').length === $('.checkBox:required').length;
            $('#nextBtn').attr('disabled', !isValid);
            const isAllChecked = $('.checkBox:checked:not(#chk_all)').length === $('.checkBox:not(#chk_all)').length;
            $('#chk_all').prop('checked', isAllChecked);
        });

        $('#nextBtn').on('click', function(){
            if ($('.checkBox.required:checked').length !== $('.checkBox.required').length) return alert("필수 동의여부를 확인해주세요.");
            location.href= '/sign/info';
            // fnMoveNext();
        });

    })

    // 팝업 열기
    const fnPopOpen = num => {
        $('#idPopup2').tsPopup('open', '/sign/agree/agreePop' + num);
    };

    // iframe 에서 parent 의 함수 호출시 keyword 로 function 사용해야함
    function fnClose(type) {
        $('#idPopup2').tsPopup('close');

        if(type) {
            $('#chk0' +type).prop('checked',true);
        }
    }

    // TODO: 필수/선택에 따른 데이터 저장 확인필요
    const fnMoveNext = () => {

        var paramMap_dev = {
            agree: $('input:checkbox[id="chk01"]').is(':checked') ? 'Y' : 'N',
        };
        var paramMap = {
            agree: $('input:checkbox[id="chk01"]').is(':checked') ? 'Y' : 'N',
        };
        var requestMap = {
            dataParam: paramMap_dev,
            url: '/agree/updateAgreeInfo'
        };
        ComUtil.request(requestMap, function (data) {

            if (data.result === "success") {
                ComUtil.submit('/info', null, 'post');
            } else {
                alert(data.resMsg);
            }
        }, function () {
            alert("입력된 정보를 확인하신 후 다시 시도해주세요.");
        });
    }


</script>