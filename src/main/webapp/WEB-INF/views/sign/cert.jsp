<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

    <header>
        <h2 class="title">본인인증</h2>
    </header>

    <!-- container -->
    <div id="container">

        <!-- cont_area -->
        <div class="cont_area">
            <div class="txt_msg_box cont">계약자의 휴대폰 번호 <span class="point">뒤 4자리를 입력</span>하신 후<br>휴대폰 <span class="point">본인인증</span>을 해주세요.</div>
            <%--<div class="progress">
                <div class="box-progress-bar">
                    <span class="box-progress" style="width: 25%;"></span>
                </div>
                <div class="number">
                    <span class="active">1</span>/3
                </div>
            </div>--%>
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
                        <input id="cellNoLast" name="cellNoLast" type="tel" class="input_ty" maxlength="4"/>
                    </dd>
                </dl>
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


<script>
	
    const MAKSED_CELL_NO = '${user.cellNoMask}';
    const ACTIVE_PROFILE = '${profilesActive}';

    $(function() {

        // 추후 구비서류시 사용
        if (!document.createElement('canvas').getContext) {
            alert('사용하시는 브라우저는 일부 기능을 제공하지 않습니다. 다른 브라우저를 사용해 주시기바랍니다.');
            return false;
        }

        $('#cellNo').val(phoneFormat(MAKSED_CELL_NO));

        $('#cellNoLast').on('change keyup', function(){
            const isValid = this.value.length === 4;
            $('#nextBtn').attr('disabled', !isValid);

            if(isValid) ComUtil.hideKeyboard($(this));
        });

        $('#nextBtn').on('click', function(){
            if(ACTIVE_PROFILE === 'local') {
                fnCertificationClose('0000', 'idseed');
            } else {
                checkCellNo();
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
        	if(data?.result === 'SUCCESS'){
                ComUtil.certPhone();
            } else {
                alert(data.resultMsg);
            }
        });

    }

    // 본인인증 팝업 종료 시 응답 함수
    function fnCertificationClose(status, type) {
        if (type === 'idseed') {
            if (status === '0000') {

                let newForm = $('<form></form>');
                newForm.attr("method","post");
                newForm.attr("action","/sign/authenticate");

                newForm.append($('<input/>', {type: 'hidden', name: 'c', value:'${user.contractNo}' }));
                newForm.append($('<input/>', {type: 'hidden', name: 'p', value:$('#cellNoLast').val() }));

                newForm.appendTo('body');

                // submit form
                newForm.submit();

            } else if (status === '0001') {
                alert('등록된 고객정보와 인증한 정보가 서로 다릅니다.');
            }
        }
    }

</script>
