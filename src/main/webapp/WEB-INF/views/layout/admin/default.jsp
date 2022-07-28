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
    <link rel="stylesheet" type="text/css" href="/resources/admin/css/jquery-ui.css" media="all">
    <link rel="stylesheet" type="text/css" href="/resources/admin/css/common.css" media="all">
    <script src="/resources/admin/js/jquery.js"></script>
    <script src="/resources/admin/js/jquery-ui.min.js"></script>
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

<script src="/resources/admin/js/common.js"></script>
<script src="/resources/admin/js/function.js"></script>
</body>
</html>

