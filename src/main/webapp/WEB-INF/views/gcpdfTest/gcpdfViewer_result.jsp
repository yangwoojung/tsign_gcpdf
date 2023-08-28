<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>pdf editor Page</title>
    <script src="/node_modules/@grapecity/gcpdfviewer/gcpdfviewer.js"></script>
    <script src="/node_modules/@grapecity/gcpdfviewer/init.js"></script>
<!--     <script src="/gcpdf/js/config.js"></script> -->
    <script>
    window.onload = function(){
        const viewer = new GcPdfViewer("#viewer");
        viewer.addDefaultPanels();
        viewer.open("gcpdf/tsoft_form_sign_result.pdf");
        
        //TODO : 필드 수정 막기!! (readonly처리??)
                
        //필드 데이터 추출
        viewer.onAfterOpen.register(function() {
        	//TODO: 좌우 네비 컨트롤 하는 메서드 있을 텐데.... 임시로 구현...
    		const menu = document.getElementsByClassName("gcv-menu");
    		if (menu[0].classList.contains("gcv-menu")) 
        		menu[0].classList.add("gcv-menu--hidden");
    		const header = document.getElementsByClassName("gcv-header-container");
    		if (header[0].classList.contains("gcv-header-container")) 
    			header[0].classList.add("gcv-header-container--sidebar-hidden","gcv-header-container--hidden");
    		
        	alert("## 콘솔로 필드 데이터 추출 확인 !!")
            viewer.annotations.then(function(data) {
                console.log("data length "+ data.length)
                console.log(data[0].annotations[0].set)
                for(var i = 0; i < data.length; i++){
                  var pageAnnotationsData = data[i];
                  var pageIndex = pageAnnotationsData.pageIndex;
                  var annotations = pageAnnotationsData.annotations;
                  console.log("Page with index " + pageIndex + " contains " + annotations.length + " annotation(s)" );
                  for(var j = 0 ;j < annotations.length ; j++ ){
                    console.log(annotations[j]);
                    //form 데이터 키 밸류 추출
                    console.log("field name : " + annotations[j].fieldName + "/ field value : " + annotations[j].fieldValue);
                  }
                }
            });
            
          	//TODO :사인데이터 추출(SIGNATURE 27로 그렸을 때)
          	/*
            const signatureInfo = viewer.getSignatureInfo();
    		if(signatureInfo.signed) {
    		  const signatureValue = signatureInfo.signedByFields[0].signatureValue;
    		  const signerName = signatureValue.name;
    		  const location = signatureValue.location;
    		  const signDate = viewer.pdfStringToDate(signatureValue.modificationDate);
    		  alert("The document was signed using digital signature. Signed by: " + signerName + ", location: " + location + ", sign date: " + signDate.toString());
    		} else {
    		  alert("The document is not signed.");
    		}*/
    		
        })          
        
    }
    </script>
</head>
<body>
<h1>pdf Viewer 결과</h1>
<div id="viewer"></div>
</body>
</html>
