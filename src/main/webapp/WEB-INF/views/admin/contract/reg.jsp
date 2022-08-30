<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<link rel="stylesheet" type="text/css" href="https://cdnjs.cloudflare.com/ajax/libs/fomantic-ui/2.8.8/semantic.min.css">
<link rel="stylesheet" type="text/css" href="https://cdn.datatables.net/1.12.1/css/dataTables.semanticui.min.css">

<script type="text/javascript" src="https://cdn.datatables.net/1.12.1/js/jquery.dataTables.js"></script>
<script type="text/javascript" src="https://cdn.datatables.net/1.12.1/js/dataTables.semanticui.min.js"></script>
<script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/fomantic-ui/2.8.8/semantic.min.js"></script>

<!-- contents -->
<section id="contents">
    <form name="insertForm" id="insertForm">

        <table class="view">
            <caption>계약 등록/수정 테이블</caption>
            <caption>계약요청 테이블</caption>
            <colgroup>
                <col style="width:200px">
                <col style="width:auto">
            </colgroup>
            <tbody>
            <tr>
                <th>대상서식<span class="star">*</span></th>
                <td>
                     <a href="javascript:;" onclick="common.contentPopOpen('pop_formList');"
                        class="btn_small type_01">선택</a>
                     <input type="hidden" name="contractNo" value="${resultContract.contractNo}"/>
                     <input type="hidden" id="FILE_SEQ" name="fileSeq" value="${resultContract.fileSeq }"/>
                     <span id="FILE_SEQ_span">${resultContract.formNm }</span>
                </td>
            </tr>
            <tr>
                <th>서명기한<span class="star">*</span></th>
                <td>
                    <div class="row_input">
                        <div class="d_wrap">
                        	<input type="text" name="signDueSdate" id="SDATE"
                                  class="datepicker" style="width:120px"
                                  value="${resultContract.signDueSdate }"
                            />
                        </div>
                        <span class="char">~</span>
                        <div class="d_wrap">
                        	<input type="text" name="signDueEdate" id="EDATE"
                                   class="datepicker" style="width:120px"
                                   value="${resultContract.signDueEdate }"                                   
                            />
                        </div>
                    </div>
                </td>
            </tr>
            <tr>
                <th>성명<span class="star">*</span></th>
                <td>
                    <input type="text" name="userNm" id="USER_NM" 
                    		value="${resultContract.userNm }"                           
                    />
                </td>
            </tr>
            <tr>
                <th>휴대폰번호<span class="star">*</span></th>
                <td>
                    <input type="number" name="cellNo" id="CELL_NO" 
                    		value="${resultContract.cellNo }"
                    />
                </td>
            </tr>
            <tr>
                <th>이메일<span class="star">*</span></th>
                <td>
                    <input style="width:350px" type="text" name="email" id="EMAIL"
                           value="${resultContract.email }"
                    />
                </td>
            </tr>
            <tr>
                <th>구비서류<span class="star">*</span></th>
                <td>
                	<a href="javascript:;" onclick="fn_addAttachDiv();" style="vertical-align:top"
                        class="btn_small type_01">추가</a>
                        
                	<div style="display:inline-block" id="atachAddBox">
                		
					</div>
	                <div style="display:none" id="atachBox">
		                <div style="width:100%;">
		               		<input type="checkbox" name="atchRequired" value="필수">
		               		<label for="atchRequired">필수</label>
		                	<select>
		                	
		                		<c:forEach var="atchList" items="${attachmentList }">
			                    	<option value="${atchList.ATTACHMENT_CD}">${atchList.ATTACHMENT_NAME}</option>
								</c:forEach>
							</select>
						</div>
					</div>	
                    
                </td>
            </tbody>
        </table>
	
	    <div>
	        <div class="btn_page text_c">
	            <a href="/admin/contract/list" class="btn_default type_02">목록</a>
	            <c:choose>
	                <c:when test="${empty resultContract.contractSeq}">
	                    <input type="submit" value="등록" class="btn_default type_01"/>                    
	                </c:when>
	                <c:otherwise>
						<input type="submit" value="수정" class="btn_default type_01"/>
	                </c:otherwise>
	            </c:choose>
	        </div>
	    </div>
    </form>
</section>
<!-- //contents -->

<!-- 서식리스트 조회, 선택 popup -->
<section id="content_pop" class="pop_wrap pop_formList">
    <div>
        <div>
            <div class="pop_data middle">
                <h3>대상서식</h3>
                <div class="detail_data">
                    <table id="popFormList" class="ui celled table hover" style="width:100%"></table>
                   
                    <div class="btn_page text_c">
                        <a href="#" id="popClose" onclick="common.contentPopClose(this);"
                           class="btn_default type_01">닫기</a>
                    </div>
                </div>
                <a href="javascript:;" onclick="common.contentPopClose(this);" class="btn_pop_close"></a>
            </div>
        </div>
    </div>
</section>
<!--// end 서식조회 선택 팝업 -->

<script>
	
	/* 기본이 되는 구비서류 리스트 */
	let attachmentBaseArr = new Array();
	
    $(function () {
        // 달력
        var seq = "<c:out value='${resultContract.contractSeq}'/>";
        common.datepicker("#SDATE", 0, null);
        common.datepicker("#EDATE", null, "+10D");
        
        //서식조회 팝업 내 ajax 테이블 조회
        initDataTable();
		
        //input validation
	    initValidate();
        
        //기본이 되는 구비서류 리스트 
        <c:forEach items="${attachmentList }" var ="item">
    	attachmentBaseArr.push(
    			{attachmentCd: "${item.ATTACHMENT_CD }",
    			attachmentName: "${item.ATTACHMENT_NAME }",
    			attachmentSeq: "${item.ATTACHMENT_SEQ }"})    		
    	</c:forEach>
    	console.log(attachmentBaseArr);
    	
    	//신분증 필수 추가 !!!
    	fn_addAttachDiv();
    	
    })
    
    /* 구비서류 추가버튼 클릭 */
    const fn_addAttachDiv = () => {
    	/* 이전 셀렉박스 disabled처리 */
    	$("#atachAddBox select").last().attr("disabled", "disabled");
    	
    	var selectLen = $("#atachAddBox select").length;
    	if (attachmentBaseArr.length == selectLen) {
    		alert("더이상 추가할 구비서류가 없습니다.");
    		return false;
    	}
    	
    	var addHtml = ""
        	addHtml += '<div style="width:100%;margin-bottom:5px">';
    		addHtml += '<select style="width:200px" onchange="fn_changeAttachSelectbox();">';
    		for (var i = 0; i < attachmentBaseArr.length; i++ ){
    			if (selectLen > 0) {
	    			for (var j = 0; j < selectLen; j++) {
	       	    		if ($("#atachAddBox select").eq(j).val() == attachmentBaseArr[i].attachmentCd) {
							console.log("같은 구비서류가 있어서 스킵")
	       	    		} else {
			    			addHtml += '<option value="'+attachmentBaseArr[i].attachmentCd+'">'+attachmentBaseArr[i].attachmentName+'</option>';
	       	    		}
	       	    	}
    			} else {
    				addHtml += '<option value="'+attachmentBaseArr[i].attachmentCd+'">'+attachmentBaseArr[i].attachmentName+'</option>';    				
    			}    	    		
        	}
       		addHtml += '</select>';
    		addHtml += '<input type="checkbox" name="attachReq" value="1">';
    		addHtml += '<label for="attachReq">필수</label>';
       		addHtml += '<em class="delBtn" style="display:inline-block;width:18px;height:18px;text-align:center;cursor:pointer;border:1px solid #dcdcdc;margin:5px;">X</em></div>';
   		$("#atachAddBox").append(addHtml);
   		
        /* 삭제버튼 이벤트 추가 */
    	$(".delBtn").last().on("click", function() {
    		$(this).parent().remove();
    	})
    	/* 첫번째 셀렉박스 이벤트 주기  */
    	if ($("#atachAddBox select").length == 1) {
    		$("#atachAddBox select").first().trigger("change");
    	}
    }
    
    /* 구비서류 셀렉박스 체인지 이벤트 */
   	const fn_changeAttachSelectbox = () => {
   		var selectLen = $("#atachAddBox select").length;
   		for (var i = 0 ;i < selectLen; i++) {
   			if($("#atachAddBox select").eq(i).attr("disabled") != "disabled") {
   				if ($("#atachAddBox select").eq(i).val() == "001") {
   					//신분증 필수 
   					$("#atachAddBox input[type='checkbox']").eq(i).prop("checked", true);
   					$("#atachAddBox input[type='checkbox']").eq(i).attr("disabled", "disabled");
   					$("#atachAddBox select").eq(i).attr("disabled", "disabled");
   					$("#atachAddBox em.delBtn").eq(i).remove();
	   				break;
   				}
   			}
   		}
   	} 
   	
   	/* 선택한 구비서류 jsonObj  */
    const fn_selectedAttachJson = () => {
    	var selectLen = $("#atachAddBox select").length;
    	/* 사용자가 선택하는 구비서류 셀렉박스 선택시 push */
    	let usrAttachList = new Array();//초기화
    	for (var i = 0 ;i < attachmentBaseArr.length; i++) {
	    	var atachObj = {};
    		for (var j = 0; j < selectLen; j++) {
	    		if ($("#atachAddBox select").eq(j).val() == attachmentBaseArr[i].attachmentCd) {
	    			atachObj["attachmentCd"] = attachmentBaseArr[i].attachmentCd;
	    			atachObj["attachmentName"] = attachmentBaseArr[i].attachmentName;
	    			atachObj["attachmentSeq"] = attachmentBaseArr[i].attachmentSeq;
	    			if($("#atachAddBox input[name='attachReq']").eq(i).prop('checked')) {
	    				atachObj["requiredYn"] = "Y";
	    			} else {
	    				atachObj["requiredYn"] = "N";
	    			}   
	    			usrAttachList.push(atachObj);
	    		}   		
    		}
    	}
    	return usrAttachList;
    }
    const fn_submit = (btnType) => {
    	
		var formJsonObj = $('#insertForm').serializeObject();
		if (btnType == "등록") {
			btnUrl = "reg_insert"; 
		} else if (btnType == "수정") {
			btnUrl = "reg_update";
		}
		/* 계약정보 + 선택된 구비서류 */
		formJsonObj["selectedAttach"] = fn_selectedAttachJson();
		console.log("formJsonObj : " + JSON.stringify(formJsonObj));
		alert(1)
        $.ajax({
            url: '/admin/contract/' + btnUrl,
            data: JSON.stringify(formJsonObj),
            contentType: 'application/json',
            type: 'POST',
            success: function (data) {
                if (data.result == "success") {
                    alert("저장하였습니다.");
                    href = "/admin/contract/list";
                } else {
                	alert("저장에 실패하였습니다.");
                }
            }, error: function (error) {
                alert(error)
            }, beforeSend: function () {
                //로딩바
            }, complete: function () {

            }
        });
    }
    
    const initValidate = () => {
    	$("#insertForm").validate({
			
           /**
           * submitHandler : form 양식이 유효한 경우 실질적인 
           * submit을 하기 위한 콜백 핸들러. 
           * 유효성이 확인된 후 Ajax를 통해 처리하기에 적합하다.
           */
           submitHandler: function(form) {
        	   console.log("submitHandler")
        	   var btnType = $("input[type='submit']").val();
               var f = confirm(btnType +"을 하시겠습니까?");

               if(f){
             	   fn_submit(btnType);
               } else {
                   return false;
               }
           		
           },
           ignore : "", 
           // 체크할 항목들의 룰 설정
           rules: {
        	   fileSeq: {
                   required : true,
                   //remote: "/check_id.jsp"
               },
               signDueSdate: {
                   required : true,
                   date: true
               },
               signDueEdate: {
                   required : true,
                   date: true
               },
               userNm : {
            	   required : true,
            	   minlength : 2,
               },
               cellNo : {
            	   required : true,
            	   minlength : 11,
            	   maxlength : 11, 
            	   phone : true
               },
               email: {
                   required : true,
                   minlength : 2,
                   email : true
               },
               attachReq: {
                   required : true
               }
           },
           //규칙체크 실패시 출력될 메시지
           messages : {
        	   fileSeq: {
                   required : "서식을 선택하세요.",
                   //remote : "존재하는 아이디입니다"
               },
               userNm : {
            	   required : "성명을 입력하세요.",
            	   minlength : "최소 {0}글자이상이어야 합니다",
               },
               cellNo : {
            	   required : "휴대폰번호를 입력하세요.",
            	   minlength : "최소 {0}글자이상이어야 합니다",
            	   maxlength : "최대 {0}글자이상이어야 합니다",
               },
               email: {
                   required : "이메일을 입력하세요",
                   minlength : "최소 {0}글자이상이어야 합니다",
                   email : "메일규칙에 어긋납니다"
               },
               attachReq: {
                   required : "구비서류는 필수 입니다."
               }
           }
       });
    }
	//서식 선택 팝업(datatable사용) 20220816
    let dataTb = new Object();
   	const initDataTable = () => {

		dataTb = $('#popFormList').DataTable({
			responsive: true,
			order: [0, 'desc'],
			ajax: {
				url: cpath + "/admin/forms",
				type: "GET",
                headers: {
                    'Accept': 'application/json',
                    'Content-Type': 'application/json'
                },
		    	data: function (data, settings) {
		    		let orderBy = "";
                    for (let i = 0; i < data?.order.length; i++) {
                        const {column, dir} = data?.order[i];
                        orderBy = data?.columns[column].name + " " + dir
                    }
                    data.orderBy = orderBy;

                    return {
                        fileTp: '100',
                        draw: data.draw,
                        orderBy: orderBy,
                        searchWord: data.search.value
                    };
				},//END data
				cache: false,
				contentType: 'application/json;charset=UTF-8',
				dataType: 'json',
				error: function (xhr, status, error) {
					if (xhr.status === 403) {
						alert(error);
					}
				},//END error
			},//END ajax
			columns: [
	             {
	                 data: 'fileSeq',
	                 name: 'FILE_SEQ',
	                 title: 'No',
	             },
	             {
	                 data: 'formNm',
	                 name: 'FORM_NM',
	                 title: '서식명'
	             },
	             {
	                 data: 'savFileNm',
	                 name: 'SAV_FILE_NM',
	                 title: '파일명'
	             }
	
			],//END columns
	        createdRow : function(row, data, dataIndex, cells ) {
				console.log("createdRow")
			},//END createdRow
			fnDrawCallback: function () { 
				console.log("fnDrawCallback")

     	        $('#popFormList tbody tr').click(function () {  
     	      		
     	            // get position of the selected row  
     	            var position = $('#popFormList').dataTable().fnGetPosition(this)  
     	            // value of the first column (can be hidden)  
     	            console.log($('#popFormList').dataTable().fnGetData(position));
     	            console.log($('#popFormList').dataTable());
     	            
     	            var fileSeq = $('#popFormList').dataTable().fnGetData(position).fileSeq
     	            var formNm = $('#popFormList').dataTable().fnGetData(position).formNm
     	            var savFileNm = $('#popFormList').dataTable().fnGetData(position).savFileNm
     	 			$("#FILE_SEQ_span").text(formNm + " / " + savFileNm);
                   	$("#FILE_SEQ").val(fileSeq);
                   	
                   	//서식 선택 후 팝업 닫기 
                   	common.contentPopClose('#popFormList');
     	            
     	        })       
            }// END fnDrawCallback
       	})//END DataTable Object

    }//END initDataTable
</script>
