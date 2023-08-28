<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>pdf viewer Page</title>
    <script src="/node_modules/@grapecity/gcpdfviewer/gcpdfviewer.js"></script>
    <script src="/node_modules/@grapecity/gcpdfviewer/init.js"></script>
    <script>
    window.onload = function(){
    	const viewer = new GcPdfViewer("#viewer", getViewerOptions());
    	configureViewerUI(viewer);
    	
        //상단 툴바 커스텀
    	viewer.toolbarLayout.viewer = { 
            default: ['open', 'save', '$navigation', '$split', 'text-selection', '$zoom', 'print', 'rotate', 'hide-annotations', 'doc-properties', ], 
            mobile: ['open', 'save', '$navigation', '$split', 'text-selection', '$zoom', 'print', 'rotate', 'hide-annotations', 'doc-properties', ], 
            fullscreen: ['$fullscreen', 'open', 'save', '$navigation', '$split', 'text-selection',  '$zoom', 'print', 'rotate', 'hide-annotations', 'doc-properties', ]
        };
    	viewer.applyToolbarLayout();
    	
    	viewer.currentUserName = "우정";
        console.log(viewer.currentUserName);
        viewer.open("gcpdf/tsoft_form_sign.pdf");
               
    }
    </script>
    <script src="/gcpdf/js/config.js"></script>    
</head>
<body>
<h1>pdf field 값 입력, 서명 입력</h1>
<div id="viewer"></div>
</body>
</html>
