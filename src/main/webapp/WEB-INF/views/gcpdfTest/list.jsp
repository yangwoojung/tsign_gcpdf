<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>pdf viewer Page</title>
    <script>
    let urlList = [
    	{title : "원본(orgin)", url : "/gcpdfViewer_origin"},
    	{title : "폼 + 서명(editor)", url : "/gcpdfEditor"},
    	{title : "폼 + 서명(input)", url : "/gcpdfViewer"},
    	{title : "폼 + 서명 + data", url : "/gcpdfViewer_result"} 
    	]
    
    window.onload = function(){
    	const list = document.querySelector("#list");
    	console.log(list)
    	 
    	urlList.forEach((a, i) => {
    	
	    	const _li = document.createElement("li");
	    	const _a = document.createElement("a");
	    	_a.innerHTML = urlList[i].title;
	    	_a.href = urlList[i].url;
	    	_li.innerHtml = _a;
	    	_li.append(_a)
	    	document.querySelector("#list").append(_li); 
	    })
    	
	    
// 	    document.querySelector("#viewer").onload("/gcpdfViewer");
    	
    	importPage("viewerBox")
    }    
    
    async function fetchHtmlAsText(url) {
        return await (await fetch(url)).text();
    }

    async function importPage(url) {
//         document.querySelector('#' + target).innerHTML = await fetchHtmlAsText(target + '.html');
        document.querySelector('#viewer').innerHTML = await fetchHtmlAsText("/gcpdfEditor");
    }

	
    </script>
    <style>#viewer {border:1px solid #dcdcdc; width: 300px ; height:400px;}</style>
    
</head>
<body>
<h1>gcPDF </h1>
<ol id="list"></ol>
<div id="viewerBox"></div>
</body>
</html>
