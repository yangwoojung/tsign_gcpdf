<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
  <br/>
  <br/>
  <br/>
  <br/>
  <br/>
  <br/>
  <input type="text" id="contNo">
  <button id="mkdir">저장경로에 디렉토리 생성</button>
  <br/>
  <br/>
  <button id="deldir">파일 삭제 테스트</button>
  
  <script type="text/javascript">
    $('#mkdir').on('click', function(e) {
    	let contNo = $('#contNo').val();
    	const paramMap = {'contNo' : contNo};
    	const requestMap = {
    			dataParam : paramMap,
    			url : '/test/file/mkdir'
    	};
    	ComUtil.request(requestMap, function(data) {
    		alert(data.result);
    	})
    })
    
    $('#deldir').on('click', function(e) {
    	let contNo = $('#contNo').val();
    	const paramMap = {'contNo' : contNo};
      const requestMap = {
           dataParam : paramMap,
           url : '/test/file/deldir'
       };
       ComUtil.request(requestMap, function(data) {
         alert(data.result);
       })
    });
  </script>
</body>
</html>