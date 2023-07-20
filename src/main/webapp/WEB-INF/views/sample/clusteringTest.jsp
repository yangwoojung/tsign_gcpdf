<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>Session Test</title>
</head>
<body>
<table border=1 bordercolor="gray" cellspacing=1 cellpadding=0 width="50%" align="center">
        <tr bgcolor="gray">
                <td colspan=2 align="center"><font color="white"><b>Session Info</b></font></td>
        </tr>
        <tr>
                <td>Server HostName</td>
                <td>${sessionInfo.hostName}</td>
        </tr>
        <tr>
                <td>Server IP</td>
                <td>${sessionInfo.addrIp}</td>
        </tr>
        <tr>
                <td>Request SessionID</td>
                <td>${sessionInfo.reqSessionId}</td>
        </tr>
        <tr>
                <td>SessionID</td>
                <td>${sessionInfo.sessionId}</td>
        </tr>
        <tr>
                <td>isNew</td>
                <td>${sessionInfo.bIsNew}</td>
        </tr>
        <tr>
                <td>Creation Time</td>
                <td>${sessionInfo.createdTime}</td>
        </tr>
        <tr>
                <td>Last Accessed Time</td>
                <td>${sessionInfo.lastTime}</td>
        </tr>
        <tr>
                <td>Used Time</td>
                <td>${sessionInfo.usedTime} min</td>
        </tr>
        <tr>
                <td>Max Inactive Interval</td>
                <td>${sessionInfo.inactive} sec</td>
        </tr>



</table>
</body>
</html>