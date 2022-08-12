<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

    <!-- container -->
    <div id="container">

        <!-- cont_area -->
        <div class="cont_area">
            <div class="txt_msg_box cont">계약자의 휴대폰 번호 <span class="point">뒤 4자리를 입력</span>하신 후<br>휴대폰 <span class="point">본인인증</span>을 해주세요.</div>
            <div class="progress">
                <div class="box-progress-bar">
                    <span class="box-progress" style="width: 25%;"></span>
                </div>
                <div class="number">
                    <span class="active">1</span>/4
                </div>
            </div>
            <div class="form_box sub">
                <dl class="list">
                    <dt>휴대폰번호</dt>
                    <dd>
                        <input id="cellNo" type="text" class="input_ty" readonly="readonly" />
                    </dd>
                </dl>
                <dl class="list">
                    <dt>뒤 4자리</dt>
                    <dd>
                        <input id="cellNoLast" name="cellNoLast" type="number" class="input_ty" maxlength="4"/>
                    </dd>
                </dl>
            </div>
            <div class="btn_area">
                <a href="javascript:" id="certCompleteBtn" class="btn_m btn_ty02 disabled" onclick="checkCellNo()">휴대폰 본인인증</a>
            </div>
        </div>
        <!-- //cont_area -->
    </div>
    <!-- //container -->

<script type="text/javascript">

    const maskedCellNo = '${user.CELL_NO_MASK }';

    $(document).ready(function() {
        $('#cellNo').val(phoneFormat(maskedCellNo));

        $('#cellNoLast').on('change keyup', function(){
            if(this.value.length === 4) {
                $('#certCompleteBtn').removeClass('disabled');
            } else {
                $('#certCompleteBtn').addClass('disabled');
            }
        });
    });

    const checkCellNo = () => {
        const cellNoLast = $('#cellNoLast').val();
        if(cellNoLast?.length !== 4) {
            return alert("휴대폰번호 뒷 4자리를 입력해주세요.");
        }

        const paramMap = { 'cellNoLast' : cellNoLast };
        const requestMap = {
            dataParam	: paramMap,
            url 		: '/sign/cert/checkCellNumber'
        };

        ComUtil.request(requestMap, function(data) {
            if(data?.resultCd == '0000'){
                $('#idPopup').tsPopup('open', '/pin/pinPop');
                ComUtil.certPhone();
                // fnCertificationClose('0000', 'idseed');
            } else {
                alert(data.resultMsg);
            }
        });

    }

    // 본인인증 팝업 종료 시 응답 함수
    const fnCertificationClose = (status, type) => {
        if (type == 'idseed') {
            if (status == '0000') {

                let newForm = $('<form></form>');
                newForm.attr("method","post");
                newForm.attr("action","/sign/authenticate");

                newForm.append($('<input/>', {type: 'hidden', name: 'c', value:'${user.CONTRC_NO}' }));
                newForm.append($('<input/>', {type: 'hidden', name: 'p', value:$('#cellNoLast').val() }));

                newForm.appendTo('body');

                // submit form
                newForm.submit();

            } else if (status == '0001') {
                alert('등록된 고객정보와 인증한 정보가 서로 다릅니다.');
            }
        }
    }

</script>
