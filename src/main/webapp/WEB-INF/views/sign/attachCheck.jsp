 <%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<header>
    <h2 class="title">정보 확인</h2>
</header>

<!-- container -->
<div id="container">
    <!-- cont_area -->
    <div class="cont_area">
<!--     <input type="submit" id="submitReportForm" class="hidden"/> -->
        <div class="txt_msg_box cont">
            본인의 신분증에 정보와
            아래의 <span class="point">정보가 일치하는지 확인</span>해 주세요.
        </div>
        <%--<div class="progress">
            <div class="box-progress-bar">
                <span class="box-progress" style="width: 100%;"></span>
            </div>
            <div class="number">
                <span class="active">3</span>/3
            </div>
        </div>--%>
	    <form id="idType1Form" method="post" action="/sign/info/update" onsubmit="return">
	        <div id="type1" style="display: none;">
	            <div class="exImg-wrap check">
	                <div class="exImg">
	                    <div class="imgConts">
	                        <div class="left">
	                            <div>주민등록증</div>
	                            <div class="name">
	                                <span id="userNmOnCard">박유진</span>
	                            </div>
	                            <div class="description">
	                                <span id="socialNo1OnCard">910710</span>-<span id="socialNo2OnCard">1063131</span>
	                            </div>
	                        </div>
	                        <div class="right">
	                            <span>😎</span>
	                        </div>
	                    </div>
	                    <div class="imgFooter">
	                        <span id="issueDtOnCard">2017. 11. 24</span>
	                    </div>
	                </div>
	            </div>
	            <div class="form_box typeSide">
	                <dl class="list">
	                    <dt>성명</dt>
	                    <dd>
	                        <%-- 대표자명, 대리인명 고정 삽입 --%>
	                        <input type="text" class="input_ty" placeholder="성명" name="userNm" id="userNm"/>
	                    </dd>
	                </dl>
	                <dl class="list">
	                    <dt>주민등록번호</dt>
	                    <dd class="half">
	                        <input type="text" class="input_ty" placeholder="앞 6자리" maxlength="6" id="socialNo1"
	                               onkeydown="return onlyNumber(event)" onkeyup="removeChar(event)" name="socialNo1">
	                        <input type="text" class="input_ty" placeholder="뒷 7자리" maxlength="7" id="socialNo2"
	                               onkeydown="return onlyNumber(event)" onkeyup="removeChar(event)" name="socialNo2">
	                    </dd>
	                </dl>
	                <dl class="list">
	                    <dt>발급일자</dt>
	                    <dd>
	                        <input type="text" class="input_ty" placeholder="발급일자 (예 : 20200306)" maxlength="8" id="issueDt"
	                               onkeydown="return onlyNumber(event)" onkeyup="removeChar(event)" name="issueDt">
	                    </dd>
	                </dl>
	            </div>
	        </div>
	    </form>
	    <!-- TODO : 폼 유효성검사 함수 추가 (onsubmit) -->
	    <form id="idType3Form" method="post" action="/sign/info/update" onsubmit="return"> 
	        <div id="type3" style="display: none;">
            <div class="exImg-wrap check">
                <div class="exImg">
                    <div class="imgConts">
                        <div class="top">
                            <div>자동차운전면허증</div>
                            <div class="no">
                            	<span id="type3_license01OnCard">11</span>-<span id="type3_license02OnCard">12</span>-<span id="type3_license03OnCard">051449</span>-<span id="type3_license04OnCard">11</span></div>
                        	</div>
                        <div>
                            <div class="right">
                                <span>🤔</span>
                            </div>
                            <div class="left">
                                <div class="name">
                                    <span id="type3_userNmOnCard">박유진</span>
                                </div>
                                <div class="description">
                                    <span id="type3_socialNo1OnCard">910710</span>-<span id="type3_socialNo2OnCard">*******</span>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <div class="form_box typeSide">
                <dl class="list">
                    <dt>성명</dt>
                    <dd>
                   		<input type="text" class="input_ty" placeholder="성명" name="type3_ownerNm" id="type3_ownerNm"/>
                    </dd>
                </dl>
                <dl class="list">
                    <dt>주민등록번호</dt>
                    <dd class="half">
                        <input type="text" class="input_ty" placeholder="주민번호 앞6자리" maxlength="6" id="juminNo"
                               onkeydown="return onlyNumber(event)" onkeyup="removeChar(event)" name="juminNo">
                        <input type="text" class="input_ty" placeholder="뒷 7자리" maxlength="7" id="socialNo2"
	                               onkeydown="return onlyNumber(event)" onkeyup="removeChar(event)" name="socialNo2">
                    </dd>
                </dl>
                <dl class="list">
                    <dt>운전면허번호</dt>
                    <dd class="driver">
                        <p>
                            <select name="license01" id="license01">
                                <option value="" selected>선택</option>
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
                            <input type="text" class="input_ty customPadding" placeholder="2자리" maxlength="2" 
                                   onkeydown="return onlyNumber(event)" onkeyup="removeChar(event)"
                                   name="license02" id="license02">
                        </p>
                        <p>
                            <input type="text" class="input_ty customPadding" placeholder="6자리" maxlength="6"
                                   onkeydown="return onlyNumber(event)" onkeyup="removeChar(event)"
                                   name="license03" id="license03">
                        </p>
                        <p>
                            <input type="text" class="input_ty customPadding" placeholder="2자리" maxlength="2"
                                   onkeydown="return onlyNumber(event)" onkeyup="removeChar(event)"
                                   name="license04" id="license04">
                        </p>
                    </dd>
                </dl>
            </div>
        </div>
   		</form>
    </div>
    <!-- //cont_area -->
</div>
<!-- //container -->
<!-- <form id="form" style="display: none"> -->
<!--     <input type="file" id="file" accept="image/jpg, image/jpeg"> -->
<!--     <input type="hidden" id="attachmentCd"/> -->
<!-- </form> -->

<footer>
    <div class="btn_area">
        <a href="javascript:" id="nextBtn" class="btn_m btn_ty02">확인</a>
    </div>
</footer>

<script>

    $(document).on('ready', function(){

        const USER = ${user};

        if(!USER.idType) {
            location.href = '/sign/error/401';
        }

        $('#type' + USER.idType).show();
        
        const linkTextOnCard = (el, cardId, sessionData) => {
        	const item = $('#'+el);
        	item.on('input', function() {
        		$('#'+cardId).html($(this).val());
        	});
        	item.val(sessionData).trigger('input');
        }
        
        if(USER.idType === '1') {
        	$('form').remove('#idType3Form');
	        linkTextOnCard('userNm','userNmOnCard',USER.userNm);
	        linkTextOnCard('socialNo1','socialNo1OnCard',USER.socialNo1);
	        linkTextOnCard('socialNo2','socialNo2OnCard',USER.socialNo2);
	        linkTextOnCard('issueDt','issueDtEl',USER.issueDt);

        } else if(USER.idType === '3') {
        	$('form').remove('#idType1Form');
        	linkTextOnCard('type3_ownerNm','type3_userNmOnCard',USER.userNm);
        	linkTextOnCard('juminNo','type3_socialNo1OnCard',USER.socialNo1);
	        linkTextOnCard('socialNo2','type3_socialNo2OnCard',USER.socialNo2);
	        linkTextOnCard('license01', 'type3_license01OnCard', USER.licenseNo1);
	        linkTextOnCard('license02', 'type3_license02OnCard', USER.licenseNo2);
	        linkTextOnCard('license03', 'type3_license03OnCard', USER.licenseNo3);
	        linkTextOnCard('license04', 'type3_license04OnCard', USER.licenseNo4);
        }

    });
    
    $('#nextBtn').on('click', function () {
    	updateInfo();
    });
    
	//TODO : 폼 제출 전 빈칸 유효성 검사
    
    //session update 진행 후 성공하면 scrap 호출
   // OCR 정보 세션에 업데이트
    const updateInfo = () => {
    	const USER = ${user};
    	let data;
    	
    	if(USER.idType === '1') {
    		data = $('#idType1Form').serializeObject();
    	} else if(USER.idType === '3') {
    		data = $('#idType3Form').serializeObject();
    	}

        $.ajax({
            url: cpath + '/sign/info/update',
            data: data,
            type: 'POST',
            async: false,
            success: function (response) {
                if (response.result === 'SUCCESS') {
                	scrapInfo(response.data);
                } else {
                    location.reload();
                }
            },
            error: function (jqXHR) {
                console.error(jqXHR);
            }
        });
    }
    
    //scrap 실행 함수
    const scrapInfo = (data) => {
    	$.ajax({
    		url : cpath + '/sign/attach/scrap',
    		data : data,
    		type: 'POST',
            async: false,
            success: function (response) {
                if (response.result === 'SUCCESS') {
                    location.href = '/sign/info';
                } else {
                	alert(response.message);
                }
            },
            error: function (jqXHR) {
                console.error(jqXHR);
            }
    	});
    }
</script>
