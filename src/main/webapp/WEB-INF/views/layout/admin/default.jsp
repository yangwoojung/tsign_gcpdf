<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="tiles" %>
<!DOCTYPE html>
<html>
<head>
    <title>티소프트 전자계약 ADMIN</title>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge"/>
    <meta name="viewport" content="width=1280">
    <link rel="shortcut icon" type="image/x-icon" href="../images/content/favicon.ico"/>
    <link rel="icon" href="../images/content/favicon.png">

    <!-- 	<link rel="stylesheet" type="text/css" href="admin/css/base.css" media="all"> -->
    <link rel="stylesheet" type="text/css" href="/resources/admin/css/reset.css" media="all">
    <!--     <link rel="stylesheet" type="text/css" href="/resources/admin/css/jquery-ui.css" media="all"> -->
    <link rel="stylesheet" type="text/css" href="/resources/admin/css/common.css" media="all">

    <!--     // jQuery UI CSS파일  -->
    <link rel="stylesheet" href="http://code.jquery.com/ui/1.8.18/themes/base/jquery-ui.css" type="text/css"/>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/sweetalert2@11.4.28/dist/sweetalert2.min.css" type="text/css"/>

    <%--<link rel="stylesheet" type="text/css" href="https://cdn.datatables.net/1.12.1/css/jquery.dataTables.min.css">--%>
    <link rel="stylesheet" type="text/css"
          href="https://cdn.datatables.net/buttons/2.2.3/css/buttons.dataTables.min.css">
    <link rel="stylesheet" type="text/css"
          href="https://cdnjs.cloudflare.com/ajax/libs/fomantic-ui/2.8.8/semantic.min.css">
    <link rel="stylesheet" type="text/css" href="https://cdn.datatables.net/1.12.1/css/dataTables.semanticui.min.css">
	<link rel="stylesheet" type="text/css" href="/resources/admin/css/custom.css" media="all">

    <!-- // jQuery 기본 js파일 -->
    <script src="http://ajax.googleapis.com/ajax/libs/jquery/1.7.1/jquery.min.js"></script>
    <!-- // jQuery UI 라이브러리 js파일 -->
    <script src="http://code.jquery.com/ui/1.8.18/jquery-ui.min.js"></script>
    <!-- // jQuery validation 플러그인 -->
	<script src="/resources/admin/js/jquery.validate.min.js"></script>
	<script src="/resources/admin/js/additional-methods.min.js"></script>
</head>
<body>
<header id="header">
    <tiles:insertAttribute name="header"/>
</header>
<section id="container">
    <tiles:insertAttribute name="nav"/>
    <tiles:insertAttribute name="container"/>
</section>
<footer id="footer">
    <tiles:insertAttribute name="footer"/>
</footer>

<script type="text/javascript" src="https://cdn.datatables.net/1.12.1/js/jquery.dataTables.js"></script>
<script type="text/javascript" src="https://cdn.datatables.net/buttons/2.2.3/js/dataTables.buttons.min.js"></script>
<script type="text/javascript" src="https://cdn.datatables.net/1.12.1/js/dataTables.semanticui.min.js"></script>
<script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/fomantic-ui/2.8.8/semantic.min.js"></script>
<script type="text/javascript" src="https://cdn.datatables.net/buttons/1.4.1/js/buttons.html5.min.js"></script>
<script type="text/javascript" src="https://cdn.datatables.net/buttons/1.4.1/js/buttons.print.min.js"></script>
<script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/jszip/3.10.1/jszip.min.js"></script>
<script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/pdfmake/0.2.5/pdfmake.min.js"></script>
<script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/pdfmake/0.1.66/vfs_fonts.min.js"></script>
<script type="text/javascript"
        src="https://cdn.jsdelivr.net/npm/sweetalert2@11.4.28/dist/sweetalert2.min.js"></script>

<script src="/resources/admin/js/common.js"></script>
<script src="/resources/admin/js/common_ajax.js"></script>
<script src="/resources/admin/js/function.js"></script>


<script>
    const cpath = "${pageContext.request.contextPath}";
</script>
</body>
</html>
