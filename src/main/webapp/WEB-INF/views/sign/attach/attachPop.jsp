<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%-- <%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %> --%>
	<!-- container -->
	<div id="container">
		<div class="cont_area">
			<!-- txt_msg_box -->
			<h3 class="t_tit">사진촬영 및 업로드 절차안내</h3>
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

 						<!-- 1. 사업자등록증명원 -->
						<div class="form_box bg" data-doc-num="1">
							<dl class="list">
								<dt>발급번호</dt>
								<dd>
									<input type="text" class="input_ty" placeholder="-없이 입력" onkeyup="removeSymbol(this)" name="cerCvaIsnNo" />
								</dd>
							</dl>

							<dl class="list">
								<dt>사업자등록번호</dt>
								<dd>
									<input type="text" class="input_ty" placeholder="숫자 10자리 (-없이 입력)" maxlength="11"
										   onkeydown="return onlyNumber(event)" onkeyup="removeChar(event)" name="txprNo" />
								</dd>
							</dl>
							<dl class="list">
								<dt>발급일</dt>
								<dd>
									<input type="text" class="input_ty" placeholder="8자리 숫자로 입력 (예 : 20200324)" maxlength="8"
										   onkeydown="return onlyNumber(event)" onkeyup="removeChar(event)" name="yyyymmdd" />
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

						<!-- 2. 주민등록증 -->
						<div class="form_box bg" data-doc-num="2">
							<div class="page_tab">
								<ul>
									<li class="actived"><a href="javascript:void(0);">주민등록증</a></li>
									<li><a href="javascript:javascript:void(0);">운전면허증</a></li>
								</ul>
							</div>
							<dl class="list">
								<dt>성명</dt>
								<dd>
										<%-- 대표자명, 대리인명 고정 삽입 --%>
									<input type="text" class="input_ty" placeholder="성명" name="ownerNm"
										   <%--여기 구비서류 코드 수정--%>
<%-- 									<c:if test="${doc.docCd eq '008' && not empty repNm}">
										   value="<c:out value="${repNm}" />"
									</c:if>
									<c:if test="${doc.docCd eq '009' && not empty contNm}">
										   value="<c:out value="${contNm}" />"
									</c:if> --%>
									>
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

						<!-- 3. 운전면허증 -->
						<div class="form_box bg" data-doc-num="3">
							<div class="page_tab">
								<ul>
									<li><a href="javascript:javascript:void(0);">주민등록증</a></li>
									<li class="actived"><a href="javascript:void(0);">운전면허증</a></li>
								</ul>
							</div>
							<dl class="list">
								<dt>성명</dt>
								<dd>
									<!--0830 대표자명, 대리인명 고정으로 넣는 부분  -->
									<input type="text" class="input_ty" placeholder="성명" name="ownerNm"
<%-- 									<c:if test="${doc.docCd eq '008' && not empty repNm}">
										   value="<c:out value="${repNm}" />"
									</c:if>
									<c:if test="${doc.docCd eq '009' && not empty contNm}">
										   value="<c:out value="${contNm}" />"
									</c:if> --%>
									>
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

						<!-- 4. 등기사항전부증명서 (1개월이내) -->
						<div class="form_box bg" data-doc-num="4">
							<dl class="list">
								<dt>등록번호</dt>
								<dd class="half">
									<input type="text" class="input_ty" placeholder="앞자리" maxlength="6"
										   onkeydown="return onlyNumber(event)" onkeyup="removeChar(event)" name="regNo1">
									<input type="text" class="input_ty" placeholder="뒷자리" maxlength="7"
										   onkeydown="return onlyNumber(event)" onkeyup="removeChar(event)" name="regNo2">
								</dd>
							</dl>
							<dl class="list">
								<dt>발급일</dt>
								<dd>
									<input type="text" class="input_ty" placeholder="8자리 숫자로 입력 (예 : 20200324)" maxlength="8"
										   onkeydown="return onlyNumber(event)" onkeyup="removeChar(event)" name="yyyymmdd">
								</dd>
							</dl>
							<dl class="list">
								<dt>발급확인번호</dt>
								<dd class="registered">
									<p><input type="text" class="input_ty" placeholder="4자리" maxlength="4" name="issueNo1"></p>
									<p><input type="text" class="input_ty" placeholder="4자리" maxlength="4" name="issueNo2"></p>
									<p><input type="text" class="input_ty" placeholder="4자리" maxlength="4" name="issueNo3"></p>
								</dd>
							</dl>
							<div class="li_on" data-name="form_box_btn_li">
								<div class="btn_area">
									<p class="btn01"><button class="btn_m btn_ty02" data-name="form_box_submit">확인하기</button></p>
									<p class="btn02"><button class="btn_m btn_ty03" data-name="form_box_reset">다시입력</button></p>
								</div>
								<input type="hidden" name="form_box_confirm" value="N">
							</div>
							<p class="t_text li_on" data-name="form_box_result">* 정보를 올바르게 입력 후 “확인하기”를 누르세요</p>
						</div>

						<!-- 5. 법인인감증명서 (1개월이내) -->
						<div class="form_box bg" data-doc-num="5">
							<dl class="list">
								<dt>인감제출자</dt>
								<dd><input type="text" class="input_ty" placeholder="공백 포함 입력 (예 :대표이사 홍길동)" name="submitter"></dd>
							</dl>
							<dl class="list">
								<dt>주민번호</dt>
								<dd class="half">
									<input type="text" class="input_ty" placeholder="앞 6자리" maxlength="6"
										   onkeydown="return onlyNumber(event)" onkeyup="removeChar(event)" name="bizNo1">
									<input type="password" class="input_ty" placeholder="뒷 7자리" maxlength="7"
										   onkeydown="return onlyNumber(event)" onkeyup="removeChar(event)" name="bizNo2">
								</dd>
							</dl>
							<dl class="list">
								<dt>발급일</dt>
								<dd><input type="text" class="input_ty" placeholder="발급일자 (예 : 20200306)" maxlength="8" name="yyyymmdd"></dd>
							</dl>
							<dl class="list">
								<dt>발급확인번호</dt>
								<dd class="registered">
									<p><input type="text" class="input_ty" placeholder="4자리" maxlength="4" name="issueNo1"></p>
									<p><input type="text" class="input_ty" placeholder="4자리" maxlength="4" name="issueNo2"></p>
									<p><input type="text" class="input_ty" placeholder="4자리" maxlength="4" name="issueNo3"></p>
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

						<!-- 6. 개인인감증명서 (1개월이내) -->
						<div class="form_box bg" data-doc-num="6">
							<dl class="list">
								<dt>발급기관</dt>
								<dd class="half05">
									<p>
										<select name="selSido">
											<option value="">시도선택</option>
											<option value="01">서울특별시</option>
											<option value="02">부산광역시</option>
											<option value="03">대구광역시</option>
											<option value="04">인천광역시</option>
											<option value="05">광주광역시</option>
											<option value="06">대전광역시</option>
											<option value="07">울산광역시</option>
											<option value="08">경기도</option>
											<option value="09">강원도</option>
											<option value="10">충청북도</option>
											<option value="11">충청남도</option>
											<option value="12">세종특별자치시</option>
											<option value="13">전라북도</option>
											<option value="14">전라남도</option>
											<option value="15">경상북도</option>
											<option value="16">경상남도</option>
											<option value="17">제주특별자치도</option>
										</select>
									</p>
									<p>
										<select name="selSigungu">
											<option value="">시군구선택</option>
										</select>
									</p>
								</dd>
							</dl>
							<dl class="list">
								<dt>발급일</dt>
								<dd><input type="text" class="input_ty" placeholder="발급일자 (예 : 20200306)" maxlength="8" name="reqDt"></dd>
							</dl>
							<dl class="list">
								<dt>주민번호</dt>
								<dd class="half">
									<input type="text" class="input_ty" placeholder="앞 6자리" maxlength="6"
										   onkeydown="return onlyNumber(event)" onkeyup="removeChar(event)" name="bizNo1">
									<input type="password" class="input_ty" placeholder="뒷 7자리" maxlength="7"
										   onkeydown="return onlyNumber(event)" onkeyup="removeChar(event)" name="bizNo2">
								</dd>
							</dl>
							<dl class="list">
								<dt>발급확인번호</dt>
								<dd class="registered">
									<input type="text" class="input_ty" placeholder="-없이 숫자만 입력" maxlength="20" name="reqNo1">
								</dd>
							</dl>
							<div class="li_on" data-name="form_box_btn_li">
								<div class="btn_area">
									<p class="btn01"><button class="btn_m btn_ty02" data-name="form_box_submit">확인하기</button></p>
									<p class="btn02"><button class="btn_m btn_ty03" data-name="form_box_reset">다시입력</button></p>
								</div>
								<input type="hidden" name="form_box_confirm" value="N">
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

<form id="callbackForm" name="callbackForm" method="post">
</form>


<input type="hidden" id="ocrFailCnt"  name="ocrFailCnt" value="0" >
<input type="hidden" id="ocrValidImageTF"  name="ocrValidImageTF" value="" >
<input type="hidden" id="cust_rnno"  name="cust_rnno" value="" > 
<input type="hidden" id="CompareCnt"  name="CompareCnt" value="0" > 

</body>

<style>
.camera_container {
	display: none;
}
.customCssCamera {
	float:right;
	margin-right:10px;
	width: 40px;
	height: 31px;
	background-size: 230px 260px;
}
.customCssBtn_type4 {
	background-color: #555 !important;
}
</style>

<script type="text/javascript">

//사업자등록증명원용
var removeSymbol = function(el) {
	var returnStr = $(el).val();
	if(returnStr)
		returnStr = returnStr.replace(/[^0-9a-zA-Z]/gi, '');
	$(el).val(returnStr);
};


var base64ToBlob = function(base64) {
	var sliceSize = 1024;
	var fileType = base64.match(/data:([^;]+)/)[1];
	
	base64 = base64.replace(/^[^,]+,/g, '');
	var byteChars = window.atob(base64);
	var byteArrays = [];
	
	for (var offset = 0, len = byteChars.length; offset < len; offset += sliceSize) {
		var slice = byteChars.slice(offset, offset + sliceSize);

		var byteNumbers = new Array(slice.length);
		for (var i = 0; i < slice.length; i++) {
			byteNumbers[i] = slice.charCodeAt(i);
		}

		var byteArray = new Uint8Array(byteNumbers);
		byteArrays.push(byteArray);
	}

	return new Blob(byteArrays, {type: fileType});
}

// var createChildContainerSet = function() {
// 	var childContainerSet = '';
// 	childContainerSet += '<li class="list child">';
// 	childContainerSet += '<div class="front">';
// 	childContainerSet += '<div class="tit"><a href="#" class="btn_delete">삭제</a><span></span></div>';
// 	childContainerSet += '<ul class="file">';
// 	childContainerSet += '<li class="btn_file"><input type="file" accept="image/jpg, image/png, image/jpeg, application/pdf" name="uploadfile" class="btn_file_up"></li>';
// 	childContainerSet += '<li class="btn_camera"><input type="file" accept="image/*;capture=camera" name="uploadfile" class="btn_file_up"></li>';
// 	childContainerSet += '</ul>';
// 	childContainerSet += '<input type="hidden" name="uploadbinary" class="uploadbinary child" />';
// 	childContainerSet += '</div>';
// 	childContainerSet += '<div class="camera_container">';
// 	childContainerSet += '<div class="video_container"></div>';
// 	childContainerSet += '<button type="button" class="shutter"></button>';
// 	childContainerSet += '</div>';
// 	childContainerSet += '<div class="view"></div>';
// 	childContainerSet += '</li>';
// 	return childContainerSet;
// }

const createChildContainerSet = function(childContainer, nowAttachCnt) {
	const temp = document.createElement("li");
	temp.classList.add('list', 'child');
	temp.setAttribute('data-childno', nowAttachCnt+2);
	//<li class="list child">
	temp.innerHTML = `
				        <div class="front">
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
			//		  </li>`;
	childContainer.append(temp);
}


var fnSelSidoChangeAction = function() {
	var formBox = $(this).closest('.form_box');
	var selSigungu = $(formBox).find('select[name=selSigungu]');
	
	var sido = $(this).find('option:selected').val();
	var sigunguArr;
	
	switch(sido) {
		case '01' : sigunguArr = ["종로구","중구","용산구","성동구","광진구","동대문구","중랑구","성북구","강북구","도봉구","노원구","은평구","서대문구","마포구","양천구","강서구","구로구","금천구","영등포구","동작구","관악구","서초구","강남구","송파구","강동구"]; break;
		case '02' : sigunguArr = ["중구","서구","동구","영도구","부산진구","동래구","남구","북구","해운대구","사하구","금정구","강서구","연제구","수영구","사상구","기장군"]; break;
		case '03' : sigunguArr = ["중구","동구","서구","남구","북구","수성구","달서구","달성군"]; break;
		case '04' : sigunguArr = ["중구","동구","미추홀구","연수구","남동구","부평구","계양구","서구","강화군","옹진군"]; break;
		case '05' : sigunguArr = ["동구","서구","남구","북구","광산구"]; break;
		case '06' : sigunguArr = ["동구","중구","서구","유성구","대덕구"]; break;
		case '07' : sigunguArr = ["중구","남구","동구","북구","울주군"]; break;
		case '08' : sigunguArr = ["수원시","성남시","의정부시","안양시","부천시","광명시","평택시","동두천시","안산시","고양시","과천시","구리시","남양주시","오산시","시흥시","군포시","의왕시","하남시","용인시","파주시","이천시","안성시","김포시","연천군","가평군","양평군","화성시","광주시","양주시","포천시","여주시"]; break;
		case '09' : sigunguArr = ["춘천시","원주시","강릉시","동해시","태백시","속초시","삼척시","홍천군","횡성군","영월군","평창군","정선군","철원군","화천군","양구군","인제군","고성군","양양군"]; break;
		case '10' : sigunguArr = ["충주시","제천시","보은군","옥천군","영동군","진천군","괴산군","음성군","단양군","증평군","청주시"]; break;
		case '11' : sigunguArr = ["천안시","공주시","보령시","아산시","서산시","논산시","금산군","부여군","서천군","청양군","홍성군","예산군","태안군","계룡시","당진시"]; break;
		case '12' : sigunguArr = []; break;
		case '13' : sigunguArr = ["전주시","군산시","익산시","정읍시","남원시","김제시","완주군","진안군","무주군","장수군","임실군","순창군","고창군","부안군"]; break;
		case '14' : sigunguArr = ["목포시","여수시","순천시","나주시","광양시","담양군","곡성군","구례군","고흥군","보성군","화순군","장흥군","강진군","해남군","영암군","무안군","함평군","영광군","장성군","완도군","진도군","신안군"]; break;
		case '15' : sigunguArr = ["포항시","경주시","김천시","안동시","구미시","영주시","영천시","상주시","문경시","경산시","군위군","의성군","청송군","영양군","영덕군","청도군","고령군","성주군","칠곡군","예천군","봉화군","울진군","울릉군"]; break;
		case '16' : sigunguArr = ["진주시","통영시","사천시","김해시","밀양시","거제시","양산시","의령군","함안군","창녕군","고성군","남해군","하동군","산청군","함양군","거창군","합천군","창원시"]; break;
		case '17' : sigunguArr = ["제주시","서귀포시"]; break;
	}
	
	$(selSigungu).empty().append('<option value="">시군구선택</option>');
	for (var i = 0; i < sigunguArr.length; i++) {
		$(selSigungu).append('<option value="">' + sigunguArr[i] + '</option>');
	}
	
};

var fnSelSidoSelect = function (sido, gungu, item) {
	var sigunguArr=[];
	switch(sido) {
		case '01' : sigunguArr = ["종로구","중구","용산구","성동구","광진구","동대문구","중랑구","성북구","강북구","도봉구","노원구","은평구","서대문구","마포구","양천구","강서구","구로구","금천구","영등포구","동작구","관악구","서초구","강남구","송파구","강동구"]; break;
		case '02' : sigunguArr = ["중구","서구","동구","영도구","부산진구","동래구","남구","북구","해운대구","사하구","금정구","강서구","연제구","수영구","사상구","기장군"]; break;
		case '03' : sigunguArr = ["중구","동구","서구","남구","북구","수성구","달서구","달성군"]; break;
		case '04' : sigunguArr = ["중구","동구","미추홀구","연수구","남동구","부평구","계양구","서구","강화군","옹진군"]; break;
		case '05' : sigunguArr = ["동구","서구","남구","북구","광산구"]; break;
		case '06' : sigunguArr = ["동구","중구","서구","유성구","대덕구"]; break;
		case '07' : sigunguArr = ["중구","남구","동구","북구","울주군"]; break;
		case '08' : sigunguArr = ["수원시","성남시","의정부시","안양시","부천시","광명시","평택시","동두천시","안산시","고양시","과천시","구리시","남양주시","오산시","시흥시","군포시","의왕시","하남시","용인시","파주시","이천시","안성시","김포시","연천군","가평군","양평군","화성시","광주시","양주시","포천시","여주시"]; break;
		case '09' : sigunguArr = ["춘천시","원주시","강릉시","동해시","태백시","속초시","삼척시","홍천군","횡성군","영월군","평창군","정선군","철원군","화천군","양구군","인제군","고성군","양양군"]; break;
		case '10' : sigunguArr = ["충주시","제천시","보은군","옥천군","영동군","진천군","괴산군","음성군","단양군","증평군","청주시"]; break;
		case '11' : sigunguArr = ["천안시","공주시","보령시","아산시","서산시","논산시","금산군","부여군","서천군","청양군","홍성군","예산군","태안군","계룡시","당진시"]; break;
		case '12' : sigunguArr = []; break;
		case '13' : sigunguArr = ["전주시","군산시","익산시","정읍시","남원시","김제시","완주군","진안군","무주군","장수군","임실군","순창군","고창군","부안군"]; break;
		case '14' : sigunguArr = ["목포시","여수시","순천시","나주시","광양시","담양군","곡성군","구례군","고흥군","보성군","화순군","장흥군","강진군","해남군","영암군","무안군","함평군","영광군","장성군","완도군","진도군","신안군"]; break;
		case '15' : sigunguArr = ["포항시","경주시","김천시","안동시","구미시","영주시","영천시","상주시","문경시","경산시","군위군","의성군","청송군","영양군","영덕군","청도군","고령군","성주군","칠곡군","예천군","봉화군","울진군","울릉군"]; break;
		case '16' : sigunguArr = ["진주시","통영시","사천시","김해시","밀양시","거제시","양산시","의령군","함안군","창녕군","고성군","남해군","하동군","산청군","함양군","거창군","합천군","창원시"]; break;
		case '17' : sigunguArr = ["제주시","서귀포시"]; break;
	}

	var formBox = $(item).find(".form_box:eq(5)");
	var selSigungu = $(formBox).find("select[name=selSigungu]");
	$(selSigungu).empty().append('<option value="">시군구선택</option>');

	for (var i = 0; i < sigunguArr.length; i++) {
		var selectedStr = "";
		if(sigunguArr[i] == gungu) selectedStr = "selected";
		$(selSigungu).append('<option value="" '+selectedStr+' >'+sigunguArr[i]+'</option>');
	}
};

<%-- 주민등록증(2), 운전면허증(3) 구분 --%>
var fnToggleKeyInId = function (e) {
	var formBox = $(this).closest('.form_box');
	var docNum = $(formBox).attr('data-doc-num');
	var targetContainer = $(this).parents('li.list:eq(0)');
	if (docNum == 2) {
		$(targetContainer).find(".form_box:eq(1)").hide();
		$(targetContainer).find(".form_box:eq(2)").show();
	} else if (docNum == 3) {
		$(targetContainer).find(".form_box:eq(1)").show();
		$(targetContainer).find(".form_box:eq(2)").hide();
	}	
};

var fnPopClose = function(val) {
	parent.fnIdentificationClose(val);
}

<%-- 구비서류 사이즈 공통 값 --%>
var FILE = {
	checkFileSize: true,
	limitPdfSize: 1024*1024,
	maxImgSize: 1280, 
};

//시작시 이벤트
$(function() {
	<%-- 최초 페이지 로드시 무조건 로딩 이미지 노출 --%>
	setTimeout(function() {
		$('#attachLoading').fadeOut(250, function() {
			$('#attachLoading').hide();
		});
	}, 150);
	
	addClickEvents();

	<%-- 키인 --%>
	$('.form_box').hide();
	$('.form_box [name=selSido]').off('change').on('change', fnSelSidoChangeAction);
	$('.form_box .page_tab ul li').not('li.actived').off('click').on('click', fnToggleKeyInId);
	$('.form_box [data-name=form_box_submit]').off('click').on('click', fnFormBoxSubmit);
	$('.form_box [data-name=form_box_reset]').off('click').on('click', fnFormBoxReset);

});


/* 정수형 숫자(초 단위)를 "시:분:초" 형태로 표현하는 함수 */
var fnConvertHourMinSec = function(t){
	var hour, min, sec;

	// 정수로부터 남은 시, 분, 초 단위 계산
	hour = Math.floor(t / 3600);
	min = Math.floor( (t-(hour*3600)) / 60 );
	sec = t - (hour*3600) - (min*60);

	// hh:mm:ss 형태를 유지하기 위해 한자리 수일 때 0 추가
	if(hour < 10) hour = "0" + hour;
	if(min < 10) min = "0" + min;
	if(sec < 10) sec = "0" + sec;
	
	if(hour == 0){
		return(min + ":" + sec);
	}

	return(hour + ":" + min + ":" + sec);
};
/* 시작페이지로 이동  */
var fnGoFirstPage = function(){
	fnWait(1);
	location.href = '/cmi/'+contNo;
};
var fnWait = function(sec){
	let start = Date.now(), now = start;
	while(now - start < sec *1000){
		now = Date.now();
	}
}

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



<%-- 구비서류 추가시 타이틀 변경 --%>
// var resignChildTitle = function (targetContainer) {
// 	var parentTitle = $(targetContainer).attr('data-title');
// 	var childList = $(targetContainer).find('ul.dep li.child');
// 	var subReq = $(targetContainer).attr('data-subreq');
// 	var hidden = $(targetContainer).find('ul.dep input.uploadbinary');

// 	for (var i = 0; i < childList.length; i++) {
// 		var childNo = i + 2;
// 		var childTitle = parentTitle + ' - ' + childNo;
// 		$(childList[i]).attr('data-childno', childNo);
// 		$(childList[i]).find('div.tit span').html(childTitle);
// 		$(hidden[i]).attr('data-subreq', subReq);
// 	}
// }
var resignChildTitle = function (targetContainer, childContainer, nowAttachCnt) {
// 	var parentTitle = $(targetContainer).attr('data-title');
// 	var childList = $(targetContainer).find('ul.dep li.child');
// 	var subReq = $(targetContainer).attr('data-subreq');
// 	var hidden = $(targetContainer).find('ul.dep input.uploadbinary');

// 	for (var i = 0; i < childList.length; i++) {
// 		var childNo = i + 2;
// 		var childTitle = parentTitle + ' - ' + childNo;
// 		$(childList[i]).attr('data-childno', childNo);
// 		$(childList[i]).find('div.tit span').html(childTitle);
// 		$(hidden[i]).attr('data-subreq', subReq);
// 	}
	const title = targetContainer.getAttribute('data-title');
	const subReq = targetContainer.getAttribute('data-subreq');

	const titleArea = childContainer.querySelectorAll('span');
	
		titleArea.forEach((item, index) => {
			const hiddenArea = item.parentNode.parentNode.querySelector('.uploadbinary.child');
			if(nowAttachCnt <= index) {
				const childNo = nowAttachCnt + 2;
				item.append(title + " - " + childNo);
				hiddenArea.setAttribute('data-subreq', subReq);
			}
		});
};

<%-- 구비서류 추가 --%>
var btnAddFileAction = function(e) {
//	var targetContainer = $(this).parents('.list:eq(0)');
   const targetContainer = this.closest('li.list');
// 	var uploadAddCnt = $(targetContainer).attr('data-uploadaddcnt');
   const uploadAddCnt = targetContainer.getAttribute('data-uploadaddcnt');
//	var childNo = $(targetContainer).find('ul.dep').children().length;
	const childContainer = targetContainer.querySelector('.dep');
	const nowAttachCnt = childContainer.children.length;

// 	if(parseInt(uploadAddCnt) == parseInt(childNo)) {
// 		alert('해당 첨부 파일은 더이상 추가할 수 없습니다.');
// 		return false;
// 	}
   if(uploadAddCnt == nowAttachCnt) {
	   alert('해당 첨부파일은 더이상 추가할 수 없습니다.');
	   return false;
   }
	
//	var title = $(targetContainer).attr('data-title');
	
	const title = targetContainer.getAttribute('data-title');
//	var childContainerSet = createChildContainerSet();
//	$(targetContainer).find('ul.dep').append(childContainerSet);
	createChildContainerSet(childContainer, nowAttachCnt);
	
//	resignChildTitle(targetContainer);
	resignChildTitle(targetContainer, childContainer, nowAttachCnt);
	chkSelectedDocumentFile();
	addClickEvents();
	
	alert(title + '이(가) 추가되었습니다.');
};

<%-- 구비서류 삭제 --%>
var btnDeleteFileAction = function(e) {
//	var targetContainer = $(this).parents('.parent');
	const targetContainer = this.closest('li.parent');
//	var childNoCnt = $(targetContainer).find('ul.dep').children().length;
//	console.log(childNoCnt);
	const childContainer = targetContainer.querySelector('.dep');
	const nowAttachCnt = childContainer.children.length;
	
//	var childNo = $(this).parents('.child').attr('data-childno');
	const childNo = this.closest('.list.child').getAttribute('data-childno');
//	var title = $(targetContainer).attr('data-title');
	const title = targetContainer.getAttribute('data-title');
	
	if(nowAttachCnt != childNo -1) {
		alert('마지막 ' + title + '부터 삭제해 주세요.');
		return false;
	}
	
//	$(this).parents('.child').remove();
	const child = this.closest('.list.child');
	
//	child.remove();
	this.closest('.list.child').remove();
	resignChildTitle(targetContainer, childContainer, nowAttachCnt);
	chkSelectedDocumentFile();
	
	alert(title + '이(가) 삭제되었습니다');
};
	
	
	
<%-- btnCameraAction --%>
var btnCameraAction = function(e) {
	console.log('btnCameraAction');
	
	var targetContainer = $(this).parents('li.list:eq(0)');

	$(targetContainer).find('.uploadbinary:eq(0)').val('');
	$(targetContainer).find('.view:eq(0)').hide();
	$(targetContainer).find('.view:eq(0) p').remove();
	
	Webcam.set({
		width: 640,
		height: 480,
		image_format: 'jpeg',
		jpeg_quality: 100,
		constraints: {
			deviceId: {exact: cameraDeviceId}
		},
	});

	var container = $(targetContainer).find('.video_container:eq(0)').get(0);
	Webcam.attach(container);

	$(targetContainer).find('.camera_container:eq(0)').show();

};

<%-- btnShutterAction --%>
var btnShutterAction = function() {
	console.log('btnShutterAction');
	
	var targetContainer = $(this).parents('li.list:eq(0)');
	
	Webcam.snap(function(data_uri) {
		$(targetContainer).find('.uploadbinary:eq(0)').val(data_uri);
		
		fnUploadFile($(targetContainer), 'snap');

		var itemEl = getDisplayItem(data_uri, 'img');
		$(targetContainer).find('.view:eq(0)').prepend(itemEl);
		$(targetContainer).find('.camera_container:eq(0)').hide();
		$(targetContainer).find('.view:eq(0)').show();
		$(targetContainer).addClass('on');

	});
	
};


<%-- 사진 업로드 --%>
var btnFileChangeAction = function(e) {
//	var targetContainer = $(this).parents('li.list:eq(0)');
	const targetContainer = e.target.closest('li.list');
	console.log(targetContainer);
//  	var file = this.files[0];
	const file = e.target.files[0];
	console.log(file);

	if(!file.type.match(/image.*|application.*pdf/)) {
		alert('JPEG 형식만 첨부 가능합니다.');
		return false;
	}
	
	if(FILE.checkFileSize && file.type.match(/application.*pdf/) && file.size > FILE.limitPdfSize) {
		alert('파일의 용량은 ' + (FILE.limitPdfSize / 1024) + 'KB를 초과할 수 없습니다.');
		return false;
	}
	
	resizingImage(targetContainer, file);
	selectedFile(targetContainer, this);
};	

var resizingImage = function (targetContainer, file) {
	
	if(!document.createElement('canvas').getContext) {
		alert('사용하시는 브라우저는 일부 기능을 제공하지 않습니다. 다른 브라우저를 사용해 주시기바랍니다.');
	}
	// html5 canvas + img 
	if(file.type.match(/image.*/)) { 
		var reader = new FileReader();
		reader.readAsDataURL(file);
		
		reader.onload = function(readerEvent) {
			var base64 = readerEvent.target.result;
			window.URL = window.URL || window.webkitURL;
			var blobUrl = window.URL.createObjectURL(base64ToBlob(base64));
			
			var image = new Image();
			image.src = blobUrl;
			
			image.onload = function(imageEvent) {
				var width = image.width;
				var height = image.height;
				var maxSize = FILE.maxImgSize;
				
				if(width > height && width > maxSize) {
					if(width > maxSize) {
						height *= maxSize / width;
						width = maxSize;
					}
				} else {
					if(height > maxSize) {
						width *= maxSize / height;
						height = maxSize;
					}
				}
				
				var canvas = document.createElement('canvas');	
				canvas.width = width;
				canvas.height = height;
	
				var ctx = canvas.getContext('2d');
				ctx.drawImage(image, 0, 0, width, height);
				base64 = canvas.toDataURL('image/jpeg');
		//		$(targetContainer).find('.uploadbinary:eq(0)').val(base64);
				targetContainer.querySelector('.uploadbinary').value = base64;				
				fnUploadFile(targetContainer);
	
			}; // -- end image
		}; // -- end reader 
	}
	
	// pdf
	if(file.type.match(/application.*pdf/)) {
		var fileReader = new FileReader();
		fileReader.readAsDataURL(file);
		
		fileReader.onload = function(readerEvent) {
			var pdfbase64 = readerEvent.target.result;
			$(targetContainer).find(".uploadbinary:eq(0)").val(pdfbase64);
			fnUploadFile($(targetContainer));
		};
	}
	
};

var getDisplayItem = function (item, type) {
	var itemEl;
	if(type == 'txt') {
		itemEl = '<p class="txt">' + item + '</p>';
	} else { 
		itemEl = '<p class="img"><img src="' + item + '" alt=""></p>';
	}
	return itemEl;
}

var selectedFile = function(targetContainer, fileObject) {
	var itemEl = '';

	if(fileObject.files[0].type.match(/image.*/)) {
	    itemEl = getDisplayItem(URL.createObjectURL(fileObject.files[0]), 'img');
	} else {
	    itemEl = getDisplayItem(fileObject.files[0].name, 'txt');
	}
	
	$(targetContainer).find('.view:eq(0)').empty().prepend(itemEl);
	$(targetContainer).find('.camera_container:eq(0)').hide();
	$(targetContainer).find('.view:eq(0)').show();
	$(targetContainer).addClass('on');
	
};	
	

<%-- 필수 서류만 파일 이름 반환  --%>
var getNotSelectedFileName = function () {
	var uploadbinary = $('input:hidden[name=uploadbinary]');
	var parentList = $('li.parent');
	
	for (var i = 0; i < parentList.length; i++) {
		if($(parentList[i]).find('.uploadbinary.parent').val().trim() == '' && $(parentList[i]).attr('data-subreq') == 1) {
			return $(parentList[i]).attr('data-title');
		}
		var childList = $(parentList[i]).find('li.child');
		for (var j = 0; j < childList.length; j++) {
			if ($(childList[j]).find('.uploadbinary.child').val().trim() == '' && $(parentList[i]).attr('data-subreq') == 1) {
				return $(parentList[i]).attr('data-title');
			}
		}
	}
	return '';
};

<%-- 파일 정보 반환 --%>
var getAttrData = function(item, attrName) {
	var attrData;
	if ($(item).hasClass('parent')) {
		attrData = $(item).attr(attrName);
	} else {
		attrData = $(item).closest('li.list.parent').attr(attrName);
	}
	return attrData;
};

<%-- 파일 정보 업데이트 --%>
var setAttrData = function(item, attrName, val) {
	if ($(item).hasClass('parent')) {
		$(item).attr(attrName, val);
	} else {
		$(item).closest('li.list.parent').attr(attrName, val);
	}
};

<%-- 파일 첨부 체크 --%>
 var chkSelectedDocumentFile = function() {
	var requiredAttachCnt = 0;
	var uploadAttachCnt = 0;
	var check = false;
	
	var uploadbinary = $('input:hidden[name=uploadbinary]');
 	
 	for(var i = 0; i < uploadbinary.length; i++) {
		//필수로 첨부해야 하는 서류 개수
 		if($(uploadbinary[i]).attr('data-subreq') != "1") continue; 
			requiredAttachCnt++;
		
		//실제로 업로드 한 첨부 파일 개수
 		if($(uploadbinary[i]).val() != "") {
 			uploadAttachCnt++;
 		}
 	}

	if(requiredAttachCnt <= uploadAttachCnt) {
		for(var i = 0; i < uploadbinary.length; i++) {
			if($(uploadbinary[i]).attr('data-subreq') == "1" && $(uploadbinary[i]).val() != "") {
				check = true;		
			} 
		}
	} else {
		check = false;
	}
	
	if(check) {
		$('#btnSubmit').removeAttr('disabled');
		$('#btnSubmit').removeClass('btn_ty01').addClass('btn_ty02');		
	} else {
		$('#btnSubmit').removeClass('btn_ty02').addClass('btn_ty01');
	}

	return check;
}; 


<%-- 파일 삭제 --%>
var fnUploadFileFormReset = function(item) {
	var uploadFileForm = $(item).find('.uploadFileForm');
	$(uploadFileForm)[0].reset();
	$(uploadFileForm).find('.uploadbinary.parent').val('');
	
	var fileView = $(item).find('.view');
	$(fileView).hide();
	
	<%-- 서버에서 삭제 안됐음 --%>
};


<%-- 파일 업로드 --%>
var fnUploadFile = function(item, attachCd, attachId) {
	var base64 = $(item).find('.uploadbinary:eq(0)').val();
	var childDataNo = $(item).attr('data-childno');
	console.log(childDataNo);
	
	if(ComUtil.isNull(childDataNo)) {
		childDataNo = 1;
	}

	var formData = new FormData();
	formData.append('attach_cd', getAttrData(item, 'data-cd'));
	formData.append('attach_id', getAttrData(item, 'data-no'));
	formData.append('attach_child_id', childDataNo);
	formData.append('fileData', base64);
	
	<%-- 2021.12.22 OCR 실패 횟수 추가 --%>
	var ocrCnt = getAttrData(item, 'data-ocr-cnt');
	
	$.ajax({
		url: cpath + '/sign/attach/upload',
		data: formData,
		processData: false,
		contentType: false,
		type: 'POST',
		encType: 'multipart/form-data',
		cache: false,
		success: function(data) {
			$('#attachLoading').hide();
			if(data.result && data.resultMessage == 'S' && !(data.ocrResult)) {
				fnToggleOcrForm(item, data);
			} else if(data.result && data.resultMessage == 'S' && data.ocrResult != 'N') {
				fnToggleOcrForm(item, data);
				
			<%-- OCR 실패했으나 마지막 파일 사용 --%>
			} else if(data.result && data.ocrResult == 'N' && ocrCnt == 0) {
				fnToggleOcrForm(item, data);
				
			} else if(data.result && data.ocrResult == 'N' && ocrCnt > 0) {
				ocrCnt--;
				setAttrData(item, 'data-ocr-cnt', ocrCnt);
				fnUploadFileFormReset(item);
				alert('OCR 판독 실패 - 다시 촬영(첨부)해 주세요\n장시간 미사용 상태거나, 인터넷이 끊기신 경우 처음부터 진행해 주세요.');

			} else {
				fnUploadFileFormReset(item);
				alert('파일 첨부 실패 - 다시 촬영(첨부)해 주세요\n장시간 미사용 상태거나, 인터넷이 끊기신 경우 처음부터 진행해 주세요.');
			}
			chkSelectedDocumentFile();
		}, error:function(xhr, data) {
			$('#attachLoading').hide();
			alert('[e] 파일 첨부 실패 - 다시 촬영(첨부)해 주세요\n장시간 미사용 상태거나, 인터넷이 끊기신 경우 처음부터 진행해 주세요.');
			if(xhr.status == 403) {
				location.href = '/sign/error/401';
			}
			fnUploadFileFormReset(item);
			
		}, beforeSend:function() {
			$('#attachLoading').show();
			fnCaseShowAlert( getAttrData(item, 'data-cd'), childDataNo );
		},
	});
	
};

var fnCaseShowAlert = function(cd, childDataNo) {
	var show = false;
	switch(cd){
		case "001": show=true;	break;   	//신분증
		default : show=false;						//기타:
	}
	if(childDataNo>1) show = false;
	if(show) alert('OCR을 판독하고 있습니다.\n(5초~최장 30초)');
}



<%-- 키인 등록 폼 --%>
var removeEx = function(str) {
	var returnStr = str;
	var regx = /[^0-9]/g;
	if(regx.test(returnStr)) returnStr = '';
	return returnStr;
};

var removeKor = function(str) {
	var returnStr = str;
	var regx = /[ㄱ-ㅎ가-힣]/g;
	if(regx.test(returnStr)) returnStr = '';
	return returnStr;
};

var fnToggleOcrForm = function(item, data) {
	var dataCd = getAttrData(item, 'data-cd'); 
// 	$(item).find('.form_box.bg [name][name!=ownerNm]').val('');

	// 신분증 
	if(dataCd == '001') {
		if(data.ocrResult && data.code == '0000') {
			$(item).find('.form_box:eq(1), .form_box:eq(2)').hide();
			
			if(data.ocrResult.encodeOcrFile) {
				var cutimgname = 'data:image/jpeg;base64,';
				cutimgname += data.ocrResult.encodeOcrFile;
				$(item).find('.view img').attr('src',cutimgname);
			} else {
				alert('[스크래핑 실패] 다시 촬영(첨부)해 주세요.');
				$(item).find('.view img').attr('src','');
				$(item).find('.view').hide();
			}
			
			if(data.ocrResult.socialNo) {
				var regNo = data.ocrResult.socialNo;
				regNo = regNo.replace(/\D/g, '');
				var juminNo1 = regNo.substring(0, 6);
				var juminNo2 = regNo.substring(6);
			}
			
			if(data.ocrResult.idType) {
				if(data.ocrResult.idType == '1') {
					$(item).find('.form_box:eq(1) [name="ownerNm"]').val(data.ocrResult.name);
					$(item).find('.form_box:eq(1) [name="juminNo1"]').val(removeEx(juminNo1));
					$(item).find('.form_box:eq(1) [name="juminNo2"]').val(removeEx(juminNo2));
					if(data.ocrResult.issueDt) {
						data.ocrResult.issueDt = (data.ocrResult.issueDt).replace(/\D/g,'');
						$(item).find('.form_box:eq(1) [name="issueDt"]').val(removeEx(data.ocrResult.issueDt));
					} 
					$(item).find('.form_box').eq(1).show();
					$(item).find('.form_box').eq(2).hide();
				} else if(data.ocrResult.idType == '3') {
					$(item).find('.form_box:eq(2) [name="ownerNm"]').val(data.ocrResult.name);
					$(item).find('.form_box:eq(2) [name="juminNo"]').val(removeEx(juminNo1));
					var licNum = data.ocrResult.licenseNo;
					var licNumArr = licNum.split('-');
					$(item).find(".form_box:eq(2) [name='licence01'] option:contains('"+licNumArr[0]+"')").prop("selected", "selected");
					$(item).find(".form_box:eq(2) [name='licence02']").val(removeEx(licNumArr[1]));
					$(item).find(".form_box:eq(2) [name='licence03']").val(removeEx(licNumArr[2]));
					$(item).find(".form_box:eq(2) [name='licence04']").val(removeEx(licNumArr[3]));	
					$(item).find('.form_box').eq(1).hide();
					$(item).find('.form_box').eq(2).show();
				}
			}
			
		<%-- OCR 실패 --%>
		} else {
			$(item).find('.form_box').eq(1).show();
			$(item).find('.form_box').eq(2).hide();
		}
	}
	
	// 법인등기부등본
	if (dataCd == '004') {
		if(data.ocrResult && data.ocrResult != 'N') {
			var resultArr = (data.ocrResult).split('^');
			var regNo = resultArr[4];
			if(regNo) {
				var regNoArr = regNo.split('-');
				if(regNoArr.length>0) $(item).find('[name="regNo1"]').val(removeEx(regNoArr[0]));
				if(regNoArr.length>1) $(item).find('[name="regNo2"]').val(removeEx(regNoArr[1]));
			}
			var issueNo = resultArr[5];
			if(issueNo) {
				var issueNoArr = issueNo.split('-');
				if(issueNoArr.length>0) $(item).find('[name="issueNo1"]').val(removeKor(issueNoArr[0]));
				if(issueNoArr.length>1) $(item).find('[name="issueNo2"]').val(removeKor(issueNoArr[1]));
				if(issueNoArr.length>2) $(item).find('[name="issueNo3"]').val(removeKor(issueNoArr[2]));
			}
			$(item).find('[name="yyyymmdd"]').val(resultArr[6]);
		}
		$(item).find('.form_box').eq(3).show();
	}
	
	// 법인인감증명서, 개인 인감증명서
	if(dataCd == "003") {
		if(data.ocrResult && data.ocrResult != 'N') {
			var resultArr = (data.ocrResult).split('^');
			$(item).find('[name="submitter"]').val(resultArr[5]);
			var bizNo = resultArr[6];
			if(bizNo){
				var bizNoArr = bizNo.split('-');
				if(bizNoArr.length>0) $(item).find('[name="bizNo1"]').val(removeEx(bizNoArr[0]));	
				if(bizNoArr.length>1) $(item).find('[name="bizNo2"]').val(removeEx(bizNoArr[1]));	
			}
			var issueNo = resultArr[4];
			if(issueNo) {
				var issueNoArr = issueNo.split("-");
				if(issueNoArr.length>0) $(item).find('[name="issueNo1"]').val(removeKor(issueNoArr[0]));	
				if(issueNoArr.length>1) $(item).find('[name="issueNo2"]').val(removeKor(issueNoArr[1]));	
				if(issueNoArr.length>2) $(item).find('[name="issueNo3"]').val(removeKor(issueNoArr[2]));	
			}		
			$(item).find('[name="yyyymmdd"]').val(resultArr[8]);
		}
		$(item).find('.form_box').eq(4).show();
	}
};

<%-- 키인 재입력 --%>
var fnFormBoxReset = function(e) {

	var formBox = $(this).closest('.form_box');
	
	$(formBox).find('input[name!=ownerNm]').each(function() {
	    $(this).val('');
	    $(this).attr('readonly', false);
	});

};

<%-- 키인 스크래핑 --%>
var fnFormBoxSubmit = function() {
	var formBox = $(this).closest('.form_box');
	var docNum = $(formBox).attr('data-doc-num');
	
	var targetUrl = '';
	var formData = new FormData();

	<%-- (신분증) 주민등록증, 운전면허증 --%>
 		if(docNum == '2' || docNum == '3') {
		targetUrl = '/sign/attach/scrap';
			formData.append('col1', $(formBox).find('input[name=ownerNm]').val());
			if(docNum == '2') {
				formData.append('type', '001');
				formData.append('col2', $(formBox).find('input[name=juminNo1]').val() + $(formBox).find('input[name=juminNo2]').val());
				formData.append('col3', $(formBox).find('input[name=issueDt]').val());
			} else if(docNum = '3') {
				formData.append('type', '002');
				formData.append('col2', $(formBox).find('input[name=juminNo]').val());
				formData.append('col3', $(formBox).find('select[name=licence01] option:selected').val());
				formData.append('col4', $(formBox).find('input[name=licence02]').val());
				formData.append('col5', $(formBox).find('input[name=licence03]').val());
				formData.append('col6', $(formBox).find('input[name=licence04]').val());
			}
			
	<%-- 법인등기부등본 --%>
	} else if(docNum == '4') {
		targetUrl = '/scrap/corpRgst';	
		formData.append('regNo', $(formBox).find('input[name=regNo1]').val() + $(formBox).find('input[name=regNo2]').val());
		formData.append('yyyymmdd', $(formBox).find('input[name=yyyymmdd]').val());
		formData.append('issueNo', $(formBox).find('input[name=issueNo1]').val()
		        + $(formBox).find('input[name=issueNo2]').val() + $(formBox).find('input[name=issueNo3]').val());

	<%-- 법인인감증명서 --%>
	} else if (docNum == '5') {
	    targetUrl = '/scrap/corpSeal';
	    formData.append('submitter', $(formBox).find('input[name=submitter]').val());
	    formData.append('bizNo', $(formBox).find('input[name=bizNo1]').val() + $(formBox).find('input[name=bizNo2]').val());
	    formData.append('yyyymmdd', $(formBox).find('input[name=yyyymmdd]').val());
	    formData.append('issueNo', $(formBox).find('input[name=issueNo1]').val()
	            + $(formBox).find('input[name=issueNo2]').val() + $(formBox).find('input[name=issueNo3]').val());
	    
	<%-- 개인인감증명서 --%>
	} else if (docNum == '6') {
	    targetUrl = '/scrap/psnlSeal';
	    formData.append('sido', $(formBox).find('select[name=selSido] option:selected').text());
	    formData.append('sigg', $(formBox).find('select[name=selSigungu] option:selected').text());
	    formData.append('reqDt', $(formBox).find('input[name=reqDt]').val());
	    formData.append('bizNo', $(formBox).find('input[name=bizNo1]').val() + $(formBox).find('input[name=bizNo2]').val());
	    formData.append('reqNo', $(formBox).find('input[name=reqNo1]').val());
	}
	
	for(var pair of formData.entries()) {
		if(pair[1] == '') {
			alert('값을 정확하게 입력해주세요.');
			return false;
		}
	}
	
	alert('문서의 진위여부를 확인합니다.\n(5초~최장 30초)');

	$.ajax({
		url: targetUrl,
		data: formData,
		processData: false,
		contentType: false,
		type: 'POST',
		cache: false,
		//async : false,
		success: function(data) {
			$('#attachLoading').hide();
			checkScrapping(data, docNum, formBox);
		},
		error: function(data) {
			$('#attachLoading').hide();
			console.error(data);
			alert('[e] 일시적으로 오류가 발생하였습니다. 다시 시도해주세요.');
		},
		beforeSend: function() {
			$('#attachLoading').show();
		},
	});
	
};

var checkScrapping = function(data, docNum, formBox) {
	
	console.log(data);
	console.log(data.data[0]);
	console.log(docNum);
	console.log(formBox);

	var formBoxConfirm = '';
	var errMsg = '';
	
	const responseData = data.data[0].data.outB0001;
	
	if (data.code = '0000') {
		if (docNum == "2") {
			// 신분증 - 주민등록증
			if (responseData.errYn == "N") {
				if (responseData.truthYn == "Y") {
					formBoxConfirm = "Y";
				} else {
					errMsg = responseData.truthMsg;
				}
			} else {
				errMsg = responseData.errMsg;
			}
		} else if (docNum == "3") {
			// 신분증 - 운전면허증
			if (responseData.errYn == "N") {
				if (responseData.licenceTruthYn == "Y") {
					formBoxConfirm = "Y";
				} else {
					errMsg = responseData.licenceTruthMsg;
				}
			} else {
				errMsg = responseData.errMsg;
			}
		} else if (docNum == "4") {
			// 법인등기부등본
			if (data.outB0004.errYn == "N") {
				if (data.outB0004.printYn == "Y") {
					formBoxConfirm = "Y";
				} else {
					errMsg = data.outB0004.printMsg;
				}
			} else {
				errMsg = data.outB0004.errMsg;
			}
		} else if (docNum == "5") {
			// 법인인감증명서
			if (data.outB0005.errYn == "N") {
				if (data.outB0005.printYn == "Y") {
					formBoxConfirm = "Y";
				} else {
					errMsg = data.outB0005.printMsg;
				}
			} else {
				errMsg = data.outB0005.errMsg;
			}
		} else if (docNum == "6" || docNum == "22") {
			// 개인인감증명서
			if (data.outC0004.errYn == "N") {
				if (data.outC0004.truthYn == "Y") {
					formBoxConfirm = "Y";
				} else {
					errMsg = data.outC0004.truthMsg;
				}
			} else {
				errMsg = data.outC0004.errMsg;
			}
		}
	} else {
		errMsg = data.errMsg;
		if(docNum == "6" && data.errMsg==""){
			if(data && data.outC0004) errMsg = data.outC0004.errMsg;
		}
	}

	if(formBoxConfirm == 'Y') {
		$(formBox).find('div[data-name=form_box_btn_li]').removeClass('li_on').addClass('li_off');
		$(formBox).find('p[data-name=form_box_result]').removeClass('li_off').addClass('li_on');
		$(formBox).find('p[data-name=form_box_result]').text('* 정상적으로 진위 여부가 확인되었습니다.').css('color','red');
		$(formBox).find('input[name=form_box_confirm]').val(formBoxConfirm);
		$(formBox).find('input').each(function() {
		    $(this).attr('readonly', true);
		});
		$(formBox).parent().find('input[type="file"].btn_file_up').attr('disabled','disabled');
		$(formBox).parent().find('input[type="button"].btn_file_up').attr('disabled','disabled');
		
		alert('정상적으로 확인되었습니다.');
		
	} else {
		errMsg ? alert(errMsg) : alert('진위여부 확인에 실패하였습니다. 다시 시도해 주세요.');
	}
	
}

var chkScrapData = function() {
	var parentList = $('li.parent');
	for (var i = 0; i < parentList.length; i++) {
		var formBoxList = $(parentList[i]).find('.form_box');
		for (var j = 0; j < formBoxList.length; j++) {
			if($(formBoxList[j]).is(':visible')) {
				var confirmYn = ($(formBoxList[j]).find('input[name=form_box_confirm]').val());
				if(confirmYn != 'Y') 
					return $(parentList[i]).attr('data-title');
			}
		}		
	}
	return '';
};



<%-- 구비서류 최종 업로드 --%>
var btnSubmitAction = function(e) {
	
		if(chkSelectedDocumentFile() == false) {
			var fileName = getNotSelectedFileName();
			if(fileName != '') {
				alert( fileName + '파일을 촬영(첨부)해 주세요.');
			}
			return false;
		}
		// 구비서류 스크래핑 체크
		var notConfirmedData = chkScrapData();
		if(notConfirmedData != '') {
			alert(notConfirmedData + ' 정보 확인을 완료해 주세요.');
			return false;
		}
	
	var parentList = $('li.parent');
	var docList = [];
	
	for (var i = 0; i < parentList.length; i++) {
		var parent = $(parentList[i]);
		if($(parent).is(':visible')) {
			var childDataNo = $(parent).find('ul.dep li.child').last().attr('data-childno'); 

			if(ComUtil.isNull(childDataNo)) {
				childDataNo = 1;
			}
			var doc_list = {};
			doc_list.docCd=$(parent).attr('data-cd');
			doc_list.docNm=$(parent).attr('data-title');
			doc_list.ppr_nos=childDataNo;
			docList.push(doc_list);			
		}
	}
	
	var formData = new FormData();
	formData.append('docList', JSON.stringify(docList));
	
	alert('계약서류를 구비서류와 함께 해당 기관에 제출하고 있습니다.\n!!주의!!\n전송 완료 후 본 화면은 자동으로 닫힙니다. 절대 화면을 강제로 닫으시면 안됩니다. (5초 ~ 최장 60초)');

	$.ajax({
	    url: '/sign/attach/submission',
	    data: formData,
	    processData: false,
	    contentType: false,
	    type: 'POST',
	    cache: false,
	    //async : false,
	    success: function(data) {
	        if ('0000' == data.resCd) {
	            alert('제출을 완료했습니다');
	            window.parent.fnIdentificationClose('success');
	        } else {
	            alert('[' + data.resCd + '] 제출에 실패하였습니다. 다시 진행해 주세요.');
	            fnPopClose();
	        }
	        
	    }, error:function(xhr, data) {
            alert('[' + data.resCd + '] 제출에 실패하였습니다. 다시 진행해 주세요.');
			if(xhr.status == 403) {
				location.href = '/sign/error/401';
			}
            fnPopClose();

	    }, beforeSend:function() {
	        $('#btnSubmit').attr('disabled', 'disabled'); 
	    }, 
	});

};

</script>
</html>
