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
        <div class="txt_msg_box cont">
            본인의 신분증에 정보와
            아래의 <span class="point">정보가 일치하는지 확인</span>해 주세요.
        </div>
        <div class="progress">
            <div class="box-progress-bar">
                <span class="box-progress" style="width: 100%;"></span>
            </div>
            <div class="number">
                <span class="active">3</span>/3
            </div>
        </div>
        <div>
            <div class="exImg-wrap check">
                <div class="exImg">
                    <div class="imgConts">
                        <div class="left">
                            <div>주민등록증</div>
                            <div class="name">
                                <span>박유진</span>
                            </div>
                            <div class="description">
                                <span>910710</span>-<span>1063131</span>
                            </div>
                        </div>
                        <div class="right">
                            <span>😎</span>
                        </div>
                    </div>
                    <div class="imgFooter">
                        <span>2017</span>. <span>11</span>. <span>24</span>.
                    </div>
                </div>
            </div>

            <dt>성명</dt>
            <dd>
                <%-- 대표자명, 대리인명 고정 삽입 --%>
                <input type="text" class="input_ty" placeholder="성명" name="ownerNm"/>
            </dd>
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
        </div>
    </div>
    <!-- //cont_area -->
</div>
<!-- //container -->
<form id="form" style="display: none">
    <input type="file" id="file" accept="image/jpg, image/jpeg">
    <input type="hidden" id="attachmentCd"/>
</form>

<footer>
    <div class="btn_area">
        <a href="javascript:" id="nextBtn" class="btn_m btn_ty02">확인</a>
    </div>
</footer>

<script>

</script>
