<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>pdf editor Page</title>
    <script src="/node_modules/@grapecity/gcpdfviewer/gcpdfviewer.js"></script>
    <script src="/node_modules/@grapecity/gcpdfviewer/init.js"></script>
    
    <script>
    window.onload = function(){
    	const viewer = new GcPdfViewer("#viewer", getViewerOptions());
    	configureViewerUI(viewer);
    	
    	viewer.addDefaultPanels();
        viewer.addAnnotationEditorPanel();
        viewer.addFormEditorPanel();
    	viewer.layoutMode = 2;//필드 에디팅을 위해 form editor 왼쪽 네비게이션 열어두기
        //상단 툴바 커스텀
    	viewer.toolbarLayout.viewer = { 
            default: ['open', 'save', 'form-filler', '$navigation', '$split', 'text-selection', 'pan', '$zoom', 'print', 'rotate', 'hide-annotations', 'doc-properties', 'about'], 
            mobile: ['open', 'save', 'form-filler', '$navigation', '$split', 'text-selection', 'pan', '$zoom', 'print', 'rotate', 'hide-annotations', 'doc-properties', 'about'], 
            fullscreen: ['$fullscreen', 'open', 'save', 'form-filler', '$navigation', '$split', 'text-selection', 'pan', '$zoom', 'print', 'rotate', 'hide-annotations', 'doc-properties', 'about']
        };
    	viewer.applyToolbarLayout();
        viewer.open("gcpdf/tsoft_form_sign.pdf");
        
        // TODO:pdf 서명 위치를 위해 우클릭시 좌표 추출 (좌표 추출 메서드 확인 불가..)
        // TODO:저장 버튼 커스텀(파일서버로 경로 변경)
        
    }
    </script>
    <script src="/gcpdf/js/config.js"></script>
</head>
<body>
<h1>pdf Editor 작업자  (서명 위치 지정)</h1>
<div id="viewer"></div>

</body>
</html>
