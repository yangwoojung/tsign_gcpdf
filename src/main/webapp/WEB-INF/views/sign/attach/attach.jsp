<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<header>
    <h2 class="title">서류 제출</h2>
</header>

<!-- container -->
<div id="container">
    <!-- cont_area -->
    <div class="cont_area">
        <div class="txt_msg_box cont">
            주민등록증이나 운전면허증을 준비해주세요. <span class="point">반드시 원본을 촬영(첨부)</span>하여 제출해 주세요.
        </div>
        <div class="progress">
            <div class="box-progress-bar">
                <span class="box-progress" style="width: 100%;"></span>
            </div>
            <div class="number">
                <span class="active">3</span>/3
            </div>
        </div>
        <div class="exImg-wrap">
            <div class="frame">
                <div></div>
                <div></div>
                <div></div>
                <div></div>
            </div>
            <div class="exImg">
                <div class="imgConts">
                    <div class="left">
                        <div class="imgTitle"></div>
                        <div class="name">
                            <span></span>
                            <span></span>
                            <span></span>
                        </div>
                        <div class="description">
                            <div>
                            </div>
                            <div>
                            </div>
                        </div>
                    </div>
                    <div class="right">
                        <span>😎</span>
                    </div>
                </div>
                <div class="imgFooter">
                </div>
            </div>
            <div class="imgBar"></div>
        </div>

        <div class="imgDesc">
            <ul class="description">
                <li>여백을 최소화 해주세요.</li>
                <li>원본이 잘리거나 흐릿하게 촬영된 경우에는 반드시 다시 촬영해주세요.</li>
                <li>첨부는 JPEG 형식만 가능합니다.</li>
            </ul>
        </div>
    </div>
    <!-- //cont_area -->
</div>
<!-- //container -->

<footer>
    <div class="btn_area">
        <a href="javascript:" id="nextBtn" class="btn_m btn_ty02" disabled="">신분증 촬영하기</a>
    </div>
</footer>

<form id="reqAttachForm" name="reqAttachForm" method="post">
    <input type="hidden" name="idCardType" id="idCardType" value="">
    <input type="hidden" name="accCnfDocType" id="accCnfDocType" value="">
</form>

<script type="text/javascript">

    $(function () {

        $('#nextBtn').on('click', function(){

        });

    });

    // 신분증촬영 및 제출 (팝업 닫기)
    var fnIdentificationClose = function (status) {
        if (status !== 'success') {
            $('#idPopup').tsPopup('close');
        } else {
            location.replace(cpath + '/sign/done');
        }
    };

</script>
