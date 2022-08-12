<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%-- <%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %> --%>


<!-- container -->
<div id="container">
	<!-- cont_area -->
	<div class="cont_area">
		<div class="txt_msg_box cont">
			  아래 구비서류를 제출해 주세요. 구비서류는 반드시 원본을 촬영(첨부)하여 제출해 주세요.
		</div>	
		<table class="normal">
			<colgroup><col style="width:20%"><col style="width:auto"></colgroup>
			<tbody>
				<tr>
					<th>구비서류</th>
					<td>
						<ul class="dot01">
							<c:forEach items="${docList}" var="doc" varStatus="status">
								<li>${status.count}. ${doc.docNm}</li>
							</c:forEach>
						</ul>
					</td>
				</tr>
			</tbody>
		</table>
		<!-- btn_area -->
		<div class="btn_area">
			<button class="btn_m btn_ty02" onclick="showCaution();">구비서류 촬영 및 제출</button>
		</div>
		<!-- //btn_area -->
	</div>
	<!-- //cont_area -->
</div>
<!-- //container -->

<div class="layer_pop" id="cautionPop" style="display:none;">
	<div class="bg"></div>
	<div class="layer">
		<div class="pop_top">
			<h2>촬영 시 유의사항</h2>
			<p class="close"><a href="javascript:closeCaution();" class="btn_close">닫기</a></p>
		</div>
		<div class="pop_cont t_l">
			<div class="mb02">
				<span class="t_color">여백은 최소화</span> 해주시고, <span class="t_color">원본이 잘리거나, 흐릿하게 촬영된 경우</span>에는 <span class="t_color">반드시 다시 촬영</span>해 주세요.
			</div>
			<div class="mb02">
				<h3 class="t_tit mb01">1. 신분증 촬영 예시</h3>
				<div class="photo_caution">
					<p class="text01">여백 최소화</p>
					<img src="/resources/sign/images/data/img_caution_ex01.jpg" style="width:100%; max-width:220px" alt="">
				</div>
			</div>
			<div class="mb02">
				<h3 class="t_tit mb01">2. 문서 촬영 예시</h3>
				<div class="photo_caution">
					<p class="text02">모서리가 잘리면 안 돼요~</p>
					<img src="/resources/sign/images/data/img_caution_ex02.jpg" style="width:100%; max-width:90px" alt="">
				</div>
			</div>
			<div class="mt01">
				<a href="javascript:fnIdentification();" class="btn_m btn_ty02">확인</a>
			</div>
		</div>
	</div>
</div>

<form id="reqAttachForm" name="reqAttachForm" method="post">
	<input type="hidden" name="idCardType" id="idCardType"  value="">
	<input type="hidden" name="accCnfDocType" id="accCnfDocType" value="">
</form>

<script type="text/javascript">

$(function() {

});

<%-- ! 상환 유예용 계약 끝나면 삭제 --%>

var showCaution = function(){
	$("#cautionPop").show();
};

var closeCaution = function(){
	$("#cautionPop").hide();
};

// 구비서류 촬영 및 제출 (팝업 열기)
var fnIdentification = function(){
	closeCaution();
	$('#idPopup').tsPopup('postOpen', {
		action: '/sign/attach/attachPop',
		formNm: 'reqAttachForm'
	});
};

// 신분증촬영 및 제출 (팝업 닫기)
var fnIdentificationClose = function(status){
	if (status !== 'success') {
		$('#idPopup').tsPopup('close');
	} else {
		location.replace(cpath + '/sign/done');
	}
};

</script>

</body>
</html>
