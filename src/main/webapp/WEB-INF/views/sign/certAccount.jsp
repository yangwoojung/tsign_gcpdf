<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

    <header>
        <h2 class="title">본인인증</h2>
    </header>

    <!-- container -->
    <div id="container">

        <!-- cont_area -->
        <div class="cont_area">
            <div class="txt_msg_box cont">계약자의 <span class="point">계좌번호를 입력</span>하신 후<br><span class="point">계좌인증</span>을 해주세요.</div>
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
	                    <dt>은행 선택</dt>
	                    <dd>
	         				<p>
		                       <select id="bankName" name="bankName" required>
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
	                    </dd>
	                </dl>
	                <dl class="list">
	                    <dt>계좌번호</dt>
	                    <dd>
	                        <input id="bankAccountNo" name="bankAccountNo" class="input_ty" maxlength="16"/>
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
	
$(function() {
	
	$('#nextBtn').on('click', function() {
		checkAccount();
	});
	
});

const checkAccount = () => {
	const bankName = $('#bankName').val();
	const accountNo = $('#bankAccountNo').val();
	
	const paramMap = {'bankName' : bankName,
					  'accountNo' : accountNo}
	const requestMap = {
		dataParam : paramMap,
		url : '/sign/cert/initAcc'
	};
	
	ComUtil.request(requestMap, function(data) {
		if(data?.result === 'SUCCESS') {
		}
	})
}

</script>
   