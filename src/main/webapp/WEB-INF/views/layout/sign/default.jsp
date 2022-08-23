<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="tiles" %>
<!doctype html>
<html lang="ko">
<head>
    <meta charset="utf-8">
    <meta name="viewport"
          content="width=device-width,initial-scale=1.0,minimum-scale=1.0,maximum-scale=1.0,user-scalable=no">
    <meta name="format-detection" content="telephone=no">
    <meta name="theme-color" content="#fff">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <title>(주)티소프트 전자계약</title>
    <link rel="shortcut icon" href="/resources/sign/images/layout/favicon.ico" type="image/x-icon">
    <link rel="apple-touch-icon" href="/resources/sign/images/layout/apple-touch-icon.png">
    <link rel="stylesheet" type="text/css" href="/resources/sign/css/style.css">
    <link rel="stylesheet" type="text/css" href="/resources/sign/css/tsoft.css">
    <script src="/resources/sign/js/jquery-1.12.4.min.js"></script>
    <script src="/resources/sign/js/jquery-ui.js"></script>
    <script src="/resources/sign/js/ui.js"></script>
    <script src="/resources/sign/js/common.js"></script>
    <script src="/resources/sign/js/template.js"></script>
    <script src="/resources/sign/js/tsoft.js"></script>
    <script src="/resources/sign/js/sweetalert2.all.min.js"></script>
    <script src="https://unpkg.com/axios/dist/axios.min.js"></script>
</head>
<body>
<!-- wrap -->
<div id="wrap">
    <section id="contents">
        <tiles:insertAttribute name="container"/>
    </section>
</div>
<!-- //wrap -->
<tiles:insertAttribute name="footer"/>

<div id="idPopup" class="ts_popup">
    <script type="text/javascript">
        $(function() {
            $("#idPopup").tsPopup();
        });
    </script>
</div>
<div id="idPopup2" class="ts_popup"></div>

<script>
    /* jshint esversion: 6 */
    const cpath = '${pageContext.request.contextPath}';

    history.pushState(null, null, location.href);
    window.onpopstate = function() {
        history.go(1);
    };

    let vh = window.innerHeight * 0.01;
    document.documentElement.style.setProperty('--vh', `${vh}px`);

    window.addEventListener('resize', () => {
        console.log('resize');
        const vh = window.innerHeight * 0.01;
        document.documentElement.style.setProperty('--vh', `${vh}px`);
    });

</script>
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
</html>
