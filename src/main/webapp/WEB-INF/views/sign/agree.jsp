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
                <input type="checkbox" class="checkBox" id="checkAll">
                <label for="checkAll">
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
                            <input type="checkbox" id="chk01" class="checkBox required">
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
                            <input type="checkbox" id="chk02" class="checkBox required">
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
                            <input type="checkbox" id="chk03" class="checkBox required">
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
                            <input type="checkbox" id="chk04" class="checkBox required">
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

        <div class="btn_area">
            <a href="javascript:" id="agreeCompleteBtn" class="btn_m btn_ty02 disabled">다음</a>
        </div>
    </div>
    <!-- //cont_area -->
</div>
<!-- //container -->

<script type="text/javascript">

    // 팝업 열기
    const fnPopOpen = num => {
        $('#idPopup2').tsPopup('open', '/sign/agree/agreePop' + num);
    };
    const fnClose = status => {
        if (status !== '0000') {
            $('#idPopup2').tsPopup('close');
        } else {

        }
    }

    $('#checkAll').change(function () {
        $('.checkBox').prop('checked', this.checked);
    });

    $('.checkBox').change(function () {
        if ($('.checkBox.required:checked').length === $('.checkBox.required').length) {
            $('#agreeCompleteBtn').removeClass('disabled');
        } else {
            $('#agreeCompleteBtn').addClass('disabled');
        }

        if ($('.checkBox:checked:not(#checkAll)').length === $('.checkBox:not(#checkAll)').length) {
            $('#checkAll').prop('checked', true);
        } else {
            $('#checkAll').prop('checked', false);
        }
    });

    $('#agreeCompleteBtn').on('click', function(){
        if ($('.checkBox.required:checked').length !== $('.checkBox.required').length) return alert("필수 동의여부를 확인해주세요.");



    });


    // 다음 단계로 이동
    function fnMoveNext() {

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

            if (data.result == "success") {
                ComUtil.submit('/info', null, 'post');
            } else {
                alert(data.resMsg);
            }
        }, function () {
            alert("입력된 정보를 확인하신 후 다시 시도해주세요.");
        });
    }


</script>