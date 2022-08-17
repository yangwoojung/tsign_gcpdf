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
                    <c:choose>
                        <c:when test="${resultContract.size() > 0 }">
                            <span>${resultContract.FORM_NM }</span>
                        </c:when>
                        <c:otherwise>
                            <a href="javascript:;" onclick="common.contentPopOpen('pop_formList');"
                               class="btn_small type_01">선택</a>
                            <input type="hidden" id="FILE_SEQ" name="FILE_SEQ"/>
                            <span id="FILE_SEQ_span"></span>
                        </c:otherwise>
                    </c:choose>
                </td>
            </tr>
            <tr>
                <th>서명기한<span class="star">*</span></th>
                <td>
                    <div class="row_input">
                        <div class="d_wrap">
                        	<input type="text" name="SIGN_DUE_SDATE" id="SDATE"
                                  class="datepicker" style="width:120px"
                                  value="${resultContract.SIGN_DUE_SDATE }"
                            />
                        </div>
                        <span class="char">~</span>
                        <div class="d_wrap">
                        	<input type="text" name="SIGN_DUE_EDATE" id="EDATE"
                                   class="datepicker" style="width:120px"
                                   value="${resultContract.SIGN_DUE_EDATE }"                                   
                            />
                        </div>
                    </div>
                </td>
            </tr>
            <tr>
                <th>성명<span class="star">*</span></th>
                <td>
                    <input type="text" name="USER_NM" id="USER_NM" 
                    		value="${resultContract.USER_NM }"                           
                    />
                </td>
            </tr>
            <tr>
                <th>휴대폰번호<span class="star">*</span></th>
                <td>
                    <input type="number" name="CELL_NO" id="CELL_NO" 
                    		value="${resultContract.CELL_NO }"
                    />
                </td>
            </tr>
            <tr>
                <th>이메일<span class="star">*</span></th>
                <td>
                    <input style="width:350px" type="text" name="EMAIL" id="EMAIL"
                           value="${resultContract.EMAIL }"
                    />
                </td>
            </tr>
            </tbody>
        </table>
	
	    <div>
	        <div class="btn_page text_c">
	            <a href="/admin/contract/list" class="btn_default type_02">목록</a>
	            <c:choose>
	                <c:when test="${empty fileSeq}">
	                    <input type="submit" value="저장" class="btn_default type_01"/>                    
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
                    <table id="popFormList" class="ui celled table" style="width:100%"></table>
                   
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
	
    $(function () {
        // 달력
        common.datepicker("#SDATE", 0, null);
        common.datepicker("#EDATE", null, "+10D")
		
        //서식조회 팝업 내 ajax 테이블 조회
        initDataTable();
		
        //input validation
	    initValidate();
        
    })
    
    var fn_submit = function () {
    	var formSerial = $("#insertForm").serialize();
//			console.log(formSerial)

        $.ajax({
            url: '/admin/contract/reg_insert',
            data: formSerial,
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
        	   
        	   var btnType = $("input[type='submit']").val();
               var f = confirm(btnType +"을 하시겠습니까?");
               if(f){
            	   //form.submit();            	   
            	   if ($("input[type='submit']").val() == "저장") {
						//insert
        		   		fn_submit();
            	   } else {
            			//update
            	   }
               } else {
                   return false;
               }
           },
           ignore : "", 
           // 체크할 항목들의 룰 설정
           rules: {
        	   FILE_SEQ: {
                   required : true,
                   //remote: "/check_id.jsp"
               },
               SIGN_DUE_SDATE: {
                   required : true,
                   date: true
               },
               SIGN_DUE_EDATE: {
                   required : true,
                   date: true
               },
               USER_NM : {
            	   required : true,
            	   minlength : 2,
               },
               CELL_NO : {
            	   required : true,
            	   minlength : 11,
            	   maxlength : 11, 
            	   phone : true
               },
               EMAIL: {
                   required : true,
                   minlength : 2,
                   email : true
               }
           },
           //규칙체크 실패시 출력될 메시지
           messages : {
        	   FILE_SEQ: {
                   required : "서식을 선택하세요.",
                   //remote : "존재하는 아이디입니다"
               },
               USER_NM : {
            	   required : "성명을 입력하세요.",
            	   minlength : "최소 {0}글자이상이어야 합니다",
               },
               CELL_NO : {
            	   required : "휴대폰번호를 입력하세요.",
            	   minlength : "최소 {0}글자이상이어야 합니다",
            	   maxlength : "최대 {0}글자이상이어야 합니다",
               },
               EMAIL: {
                   required : "이메일을 입력하세요",
                   minlength : "최소 {0}글자이상이어야 합니다",
                   email : "메일규칙에 어긋납니다"
               },
           }
       });
    }
	//서식 선택 팝업(datatable사용) 20220816
   	const initDataTable = () => {
        $('#popFormList').DataTable({
              order: [0, 'desc'],
              ajax: {
                  url: "${pageContext.request.contextPath}/admin/form/lists",
                  type: "post",
                  headers: {
                      'Accept': 'application/json',
                      'Content-Type': 'application/json'
                  },
                  data: function (data, settings) {

                      data.fileTp = '100';

                      let orderBy = "";
                      for (let i = 0; i < data.order.length; i++) {
                          const {column, dir} = data.order[i];
                          orderBy = data.columns[column].name + " " + dir
                      }
                      data.orderBy = orderBy;

                      if(data.search.value){
                          data.searchWord = data.search.value;
                      }

                      return JSON.stringify(data);
                  },
                  cache: false,
                  contentType: 'application/json;charset=UTF-8',
                  dataType: 'json',
                  error: function (xhr, status, error) {
                      if (xhr.status === 403) {
                          alert(error);
                      }
                  },
              },
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

              ],
             fnDrawCallback: function () { 
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
             	
             }
        });
        
    }
</script>