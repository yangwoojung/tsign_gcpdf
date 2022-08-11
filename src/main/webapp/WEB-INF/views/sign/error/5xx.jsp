<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<body>
<!-- wrap -->
<div id="wrap">
	<!-- header -->
	<header>
		<h2 class="title">에러 - <c:out value="${errType}" /></h2>
	</header>
	<!-- //header -->
	
	<!-- container -->
	<div id="container">
		<!-- cont_area -->
		<div class="cont_area">
			<div class="error">
				<!-- <h3 class="tit">비 정상적으로 종료되었습니다.</h3> -->
				<h3 class="tit"><c:out value="${errTit}" /></h3>
				<p class="text"><c:out value="${errMsg}" escapeXml="false" /></p>
			</div>
			<div class="error_bg cont">
				<p class="tit">전자계약 관련 문의 <a href="tel:1800-8467">1800-8467</a></p>
			</div>
		</div>
		<!-- //cont_area -->
	</div>
	<!-- //container -->
</div>
<!-- //wrap -->
</body>

<script type="text/javascript">

$(function() {
	// TODO ... session clear
});

</script>

</html>
