<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>pdf viewer Page [원본]</title>
    <script src="/node_modules/@grapecity/gcpdfviewer/gcpdfviewer.js"></script>
    <script src="/node_modules/@grapecity/gcpdfviewer/init.js"></script>
    <script>
    window.onload = function(){
        const viewer = new GcPdfViewer("#viewer");    	
        if(!viewer.hasDocument) {
        	viewer.open("gcpdf/tsoft.pdf");
        	viewer.onAfterOpen.register(function() {
        		//TODO: 좌우 네비 컨트롤 하는 메서드 있을 텐데.... 임시로 구현...
        		const menu = document.getElementsByClassName("gcv-menu");
        		if (menu[0].classList.contains("gcv-menu")) 
	        		menu[0].classList.add("gcv-menu--hidden");
        		const header = document.getElementsByClassName("gcv-header-container");
        		if (header[0].classList.contains("gcv-header-container")) 
        			header[0].classList.add("gcv-header-container--sidebar-hidden","gcv-header-container--hidden");
        	})
        	
        } else {
        	alert("pdf 경로 확인해 주세요!!");
        }
    }
    </script>
</head>
<body>
<h1>pdf 원본 </h1>
<div id="viewer"></div>
</body>
</html>
