<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!-- container -->
<div id="container">
	<div class="cont_area">
		<!-- txt_msg_box -->
		<h3 class="t_tit">사진촬영 및 업로드 절차 안내</h3>
		<dl class="txt_msg_box cont">
			<dt>아래 자료를 사진촬영(혹은 파일첨부)하시고 “제출하기”버튼을 누르시면 완료됩니다.</dt>
			<dd>
				<ul>
					<li>사진촬영 주의 : 이미지가 잘리거나, 흐릿하게 촬영이 된 경우에는 반드시 다시 촬영해 주세요.</li>
					<li>첨부 주의 : JPEG 형식만 첨부가 가능합니다.</li>
				</ul>
			</dd>
		</dl>
		<!-- //txt_msg_box -->
		<!-- accordion_ty -->
		<ul class="accordion_ty">
			<c:forEach items="${docList}" var="doc" varStatus="status">
				<!-- docCd : 구비서류 코드, subReq : 필수여부, docNm : 서류 이름 , maxCnt : 최대 첨부 개수 -->
				<li class="list parent" data-no="${status.count}" data-cd="${doc.docCd}" data-subReq="${doc.subReq}"
						data-title="${doc.docNm}" data-uploadaddcnt="${doc.maxCnt -1}" data-ocr-cnt="0" >
					<!-- front -->
					<div class="front">
						<div class="tit">
							<a href="javascript:void(0);" class="btn_add">추가</a><c:out value="${doc.docNm} "/>
						</div>
						<!-- file -->
						<ul class="file">
							<li class="btn_file">
								<input type="file" name="uploadfile" class="btn_file_up" accept="image/jpg, image/jpeg" />
							</li>
							<li class="btn_camera">
								<input type="file" name="uploadfile" class="btn_file_up" accept="image/*" capture="capture" />
							</li>
						</ul>
						<input type="hidden" name="uploadbinary" class="uploadbinary parent" data-cd="${doc.docCd}" data-subReq="${doc.subReq}" />
						<!-- //file -->
					</div>
					<!-- //front -->
					<!-- camera -->
					<div class="camera_container">
						<div class="video_container"></div>
						<button type="button" class="shutter"></button>
					</div>
					<!-- //camera -->
					<!-- view -->
					<div class="view"></div>
					<!-- //view -->
					
					<!-- 1. 신분증 [주민등록증] -->
					<div class="form_box bg" data-doc-num="1">
						<div class="page_tab">
							<ul>
								<li class="actived"><a href="javascript:void(0);">주민등록증</a></li>
								<li><a href="javascript:javascript:void(0);">운전면허증</a></li>
							</ul>
						</div>
						<dl class="list">
							<dt>성명</dt>
							<dd>
								<input type="text" class="input_ty" placeholder="성명" name="ownerNm">
							</dd>
						</dl>
						<dl class="list">
							<dt>주민등록번호</dt>
							<dd class="half">
								<input type="text" class="input_ty" placeholder="앞 6자리" maxlength="6"
									   onkeydown="return onlyNumber(event)" onkeyup="removeChar(event)" name="juminNo1">
								<input type="password" class="input_ty" placeholder="뒷 7자리" maxlength="7"
									   onkeydown="return onlyNumber(event)" onkeyup="removeChar(event)" name="juminNo2">
							</dd>
						</dl>
						<dl class="list">
							<dt>발급일자</dt>
							<dd>
								<input type="text" class="input_ty" placeholder="발급일자 (예 : 20200306)" maxlength="8"
									   onkeydown="return onlyNumber(event)" onkeyup="removeChar(event)" name="issueDt">
							</dd>
						</dl>
						<div class="li_on" data-name="form_box_btn_li">
							<div class="btn_area">
								<p class="btn01"><button class="btn_m btn_ty02" data-name="form_box_submit">확인하기</button></p>
								<p class="btn02"><button class="btn_m btn_ty03" data-name="form_box_reset">다시입력</button></p>
							</div>
							<input type="hidden" name="form_box_confirm" value="N" />
						</div>
						<p class="t_text li_on" data-name="form_box_result">* 정보를 올바르게 입력 후 “확인하기”를 누르세요</p>
					</div>		
									
					<!-- 2. 신분증 [운전면허증] -->
					<div class="form_box bg" data-doc-num="2">
						<div class="page_tab">
							<ul>
								<li><a href="javascript:javascript:void(0);">주민등록증</a></li>
								<li class="actived"><a href="javascript:void(0);">운전면허증</a></li>
							</ul>
						</div>
						<dl class="list">
							<dt>성명</dt>
							<dd>
								<input type="text" class="input_ty" placeholder="성명" name="ownerNm">
							</dd>
						</dl>
						<dl class="list">
							<dt>생년월일</dt>
							<dd>
								<input type="text" class="input_ty" placeholder="주민번호 앞6자리" maxlength="6"
									   onkeydown="return onlyNumber(event)" onkeyup="removeChar(event)" name="juminNo">
							</dd>
						</dl>
						<dl class="list">
							<dt>운전면허번호</dt>
							<dd class="driver">
								<p>
									<select name="licence01">
										<option value="" selected >선택</option>
											<option value="11">서울</option>
										<option value="13">경기</option>
										<option value="28">경기북부</option>
										<option value="13">경기남부</option>
										<option value="14">강원</option>
										<option value="15">충북</option>
										<option value="16">충남</option>
										<option value="17">전북</option>
										<option value="18">전남</option>
										<option value="19">경북</option>
										<option value="20">경남</option>
										<option value="21">제주</option>
										<option value="22">대구</option>
										<option value="23">인천</option>
										<option value="24">광주</option>
										<option value="25">대전</option>
										<option value="26">울산</option>
										<option value="12">부산</option> 
										<option value="11">11</option>
										<option value="12">12</option>
										<option value="13">13</option>
										<option value="14">14</option>
										<option value="15">15</option>
										<option value="16">16</option>
										<option value="17">17</option>
										<option value="18">18</option>
										<option value="19">19</option>
										<option value="20">20</option>
										<option value="21">21</option>
										<option value="22">22</option>
										<option value="23">23</option>
										<option value="24">24</option>
										<option value="25">25</option>
										<option value="26">26</option>
										<option value="28">28</option>
									</select>
								</p>
								<p>
									<input type="text" class="input_ty" placeholder="2자리" maxlength="2"
										   onkeydown="return onlyNumber(event)" onkeyup="removeChar(event)" name="licence02">
								</p>
								<p>
									<input type="text" class="input_ty" placeholder="6자리" maxlength="6"
										   onkeydown="return onlyNumber(event)" onkeyup="removeChar(event)" name="licence03">
								</p>
								<p>
									<input type="text" class="input_ty" placeholder="2자리" maxlength="2"
										   onkeydown="return onlyNumber(event)" onkeyup="removeChar(event)" name="licence04">
								</p>
							</dd>
						</dl>
						<div class="li_on" data-name="form_box_btn_li">
							<div class="btn_area">
								<p class="btn01"><button class="btn_m btn_ty02" data-name="form_box_submit">확인하기</button></p>
								<p class="btn02"><button class="btn_m btn_ty03" data-name="form_box_reset">다시입력</button></p>
							</div>
							<input type="hidden" name="form_box_confirm" value="N" />
						</div>
						<p class="t_text li_on" data-name="form_box_result">* 정보를 올바르게 입력 후 “확인하기”를 누르세요</p>
					</div>
					
					<!-- 2단일 경우 -->
					<ul class="dep"></ul>
					<!-- //2단일 경우 -->
				</li>
			</c:forEach>
		</ul>
		<!-- //accordion_ty -->
		<!-- btn_area -->
		<div class="btn_area">
			<button class="btn_m btn_ty01" id="btnSubmit">제출하기</button>
		</div>
		<!-- //btn_area -->
	</div>
</div>
<!-- //container -->
			
<div class="layer_pop" id="loadingScrPop" style="display:none;">
	<div class="bg"></div>
	<div class="layer">
		<div class="pop_top">
			<h2>주의</h2>
		</div>
		<div class="pop_cont">
			<p class="loading"><img src="/resources/sign/images/layout/loading.gif" style="width:100%" alt="loading"></p>
			<p class="text mt02">
				진위여부를 확인하고 있습니다.<br/>
				절대 화면을 닫으시면 안됩니다.<br/>
				(5초 ~ 최장 30초)
			</p>
		</div>
	</div>
</div>

<div class="layer_pop" id="loadingPop" style="display:none;">
			<div class="bg"></div>
			<div class="layer">
				<div class="pop_top">
					<h2>주의</h2>
				</div>
				<div class="pop_cont">
					<p class="loading"><img src="/images/layout/loading.gif" style="width:100%" alt="loading"></p>
					<p class="text mt02">
						KIS정보통신에 서류를<br/>제출하고 있습니다. (60초 이내)
					</p>
					<p class="t_text mt02">
						자료가 전송되면 자동으로 닫힙니다.
					</p>
				</div>
			</div>
		</div>

<form id="callbackForm" name="callbackForm" method="post"></form>

<input type="hidden" id="ocrFailCnt"  name="ocrFailCnt" value="0" >
<input type="hidden" id="ocrValidImageTF"  name="ocrValidImageTF" value="" >
<input type="hidden" id="cust_rnno"  name="cust_rnno" value="" > 
<input type="hidden" id="CompareCnt"  name="CompareCnt" value="0" > 

<script type="text/javascript">

//시작시 이벤트
$(function() {
	//최초 페이지 로드시 무조건 로딩 이미지 노출
	setTimeout(function() {
		$('#attachLoading').fadeOut(250, function() {
			$('#attachLoading').hide();
		});
	}, 150);
	
	addClickEvents();

	//키인
	$('.form_box').hide();
	$('.form_box [name=selSido]').off('change').on('change', fnSelSidoChangeAction);
	$('.form_box .page_tab ul li').not('li.actived').off('click').on('click', fnValidateIDCardTab);
	$('.form_box [data-name=form_box_submit]').off('click').on('click', fnFormBoxSubmit);
	$('.form_box [data-name=form_box_reset]').off('click').on('click', fnFormBoxReset);

});

//구비서류 공통값
const FILE = {
   checkFileSize: true,
   limitPdfSize: 1024*1024,
   maxImgSize: 1280, 
};

//display none(hide), block(show) 함수
//다른 곳에서도 jQuery 대신 써먹을 수 있는 방법??
const fnHideAndShow = (item, type, fn) => {
   if(type != null) {
      const selectContainer = item.querySelector('[data-doc-num="' + type + '"]');
      selectContainer.style.display = fn;
   }
}

//주민등록증(data-doc-num=1) / 운전면허증(data-doc-num=2) 토글박스 구분
const fnValidateIDCardTab = (e) => {
   const idCardBox = e.target.closest(".form_box");
   const docNum = idCardBox.getAttribute('data-doc-num');
   const parentContainer = this.closest('li.list');

   const socialDocNum = 1;
   const licenseDocNum = 2;

   if(docNum == socialDocNum) {
      fnHideAndShow(parentContainer, socialDocNum, 'none');
      fnHideAndShow(parentContainer, licenseDocNum, 'block');
   } else if (docNum == licenseDocNum) {
      fnHideAndShow(parentContainer, socialDocNum, 'block');
      fnHideAndShow(parentContainer, licenseDocNum, 'none');
   };
};

var addClickEvents = function() {
	<%-- 구비 서류 추가/삭제 이벤트 --%>
	$('li.list .btn_add').off('click').on('click', btnAddFileAction);
	$('li.list .btn_delete').off('click').on('click', btnDeleteFileAction);
	
	<%-- 사진-미사용 --%>
	$('li.list input[type="button"].btn_file_up').off('click').on('click', btnCameraAction);
	$('li.list .shutter').off('click').on('click', btnShutterAction);
	
	<%-- 파일 업로드 --%>
	$('li.list input[type="file"].btn_file_up').off('change').on('change', btnFileChangeAction);
	$('#btnSubmit').off('click').on('click', btnSubmitAction);
};

//구비서류 첨부란 추가
const bntAddFileAction = (e) => {
   const targetContainer = this.closest('li.list');
   const childAttachArea = targetContainer.querySelector('.dep');
   
   const maxAttachCnt = targetContainer.getAttribute('data-uploadaddcnt');
   const nowAttachCnt = childAttachArea.children.length;
   
   if(maxAttachCnt == nowAttachCnt) {
	   alert('해당 첨부파일은 더이상 추가할 수 없습니다.');
	   return false;
   } else {
	   const title = targetContainer.getAttribute('data-title');
	   createChildContainer(childAttachArea);
	   changeChildContainerAttr(targetContainer, childAttachArea, nowAttachCnt);
	   //파일첨부 체크
   }
};

//구비서류 추가 시 자식 컨테이너 생성
const createChildContainer = (childContainer, nowAttachCnt) => {
	const li = document.createElement("li");
	li.classList.add('list', 'child');
	li.setAttribute('data-childno', nowAttachCnt+2);
	
	li.innerHTML = `<div class="front">
				    	<div class="tit"><a href="#" class="btn_delete">삭제</a><span></span></div>
			    		<ul class="file">
					        <li class="btn_file"><input type="file" accept="image/jpg, image/png, image/jpeg, application/pdf" name="uploadfile" class="btn_file_up"></li>
					        <li class="btn_camera"><input type="file" accept="image/*;capture=camera" name="uploadfile" class="btn_file_up"></li>
				        </ul>
			       		<input type="hidden" name="uploadbinary" class="uploadbinary child" />
				 	</div>
			     	<div class="camera_container">
				        <div class="video_container"></div>
				        <button type="button" class="shutter"></button>
			     	</div>
				    <div class="view"></div>`;
	childContainer.append(li);
};

//생성된 자식 컨테이너의 속성 변경
const changeChildContainerAttr = (targetContainer, childContainer, nowAttachCnt) => {
	const title = targetContainer.getAttribute('data-title');
	const subReq = targetContainer.getAtttribute('data-subreq');
	
	const titleArea = childContainer.querySelectorAll('span');
	
	titleArea.forEach((item, index) => {
		const hiddenArea = item.parentNode.parentNode.querySelector('.uploadbinary.child');
		
		if(nowAttachCnt <= index) {
			const childNo = nowAttachCnt + 2;
			item.append(title + " - " + childNo);
			hiddenArea.setAttribute('data-subreq', subReq);
		}
	})
};

//구비서류 삭제

</script>
