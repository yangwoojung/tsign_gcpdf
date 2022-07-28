<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<!-- contents -->
<section id="contents">
    <form name="insertForm" id="insertForm" action="/admin/contract/reg_insert">

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
                    <input type="hidden" name="FILE_SEQ" id="FILE_SEQ"/>
                    <c:choose>
                        <c:when test="${resultContract.size() > 0 }">
                            <span>${resultContract.FORM_NM }</span>
                        </c:when>
                        <c:otherwise>
                            <a href="#" onclick="common.contentPopOpen('pop_formList');fnListSearch(1);"
                               class="btn_small type_01">선택</a>
                            <span id="selectFotmResult">선택된 서식</span>
                        </c:otherwise>
                    </c:choose>
                </td>
            </tr>
            <tr>
                <th>서명기한<span class="star">*</span></th>
                <td>
                    <div class="row_input">
                        <div class="d_wrap"><input type="text" name="SIGN_DUE_SDATE" required id="SDATE"
                                                   class="datepicker" style="width:120px"
                                                   value="${resultContract.SIGN_DUE_SDATE }"
                                                   <c:if test="${resultContract.size() > 0 }">readonly</c:if>></div>
                        <span class="char">~</span>
                        <div class="d_wrap"><input type="text" name="SIGN_DUE_EDATE" required id="EDATE"
                                                   class="datepicker" style="width:120px"
                                                   value="${resultContract.SIGN_DUE_EDATE }"
                                                   <c:if test="${resultContract.size() > 0 }">readonly</c:if>></div>
                    </div>
                </td>
            </tr>
            <tr>
                <th>성명<span class="star">*</span></th>
                <td>
                    <input type="text" name="USER_NM" placeholder="" required id="" value="${resultContract.USER_NM }"
                           <c:if test="${resultContract.size() > 0 }">readonly</c:if>
                    />
                </td>
            </tr>
            <tr>
                <th>휴대폰번호<span class="star">*</span></th>
                <td>
                    <input type="text" name="CELL_NO" placeholder="" required id="" value="${resultContract.CELL_NO }"
                           <c:if test="${resultContract.size() > 0 }">readonly</c:if>
                    />
                </td>
            </tr>
            <tr>
                <th>이메일<span class="star">*</span></th>
                <td>
                    <input width="300px" type="text" name="EMAIL" placeholder="" required id=""
                           value="${resultContract.EMAIL }"/>
                </td>
            </tr>
            </tbody>
        </table>
    </form>

    <div>
        <div class="btn_page text_c">
            <a href="/admin/contract/list" class="btn_default type_02">목록</a>
            <c:choose>
                <c:when test="${empty fileSeq}">
                    <a href="javascript:;" id="submit" class="btn_default type_01">저장</a>
                </c:when>
                <c:otherwise>
                    <a href="javascript:;" id="modify" class="btn_default type_01">수정</a>
                </c:otherwise>
            </c:choose>
        </div>
    </div>
</section>
<!-- //contents -->

<!-- 서식리스트 조회, 선택 popup -->
<section id="content_pop" class="pop_wrap pop_formList">
    <div>
        <div>
            <div class="pop_data middle">
                <h3>대상서식</h3>
                <div class="detail_data">
                    <form name="frm" id="frm">
                        <input type="hidden" id="page" name="page" value="1">
                        <input type="hidden" id="FILE_TP" name="FILE_TP" value="100">
                    </form>
                    <table class="list">
                        <caption>등록된 서식회 결과 리스트 테이블</caption>
                        <colgroup>
                            <col style="width:50px">
                            <col style="width:42%">
                            <col style="width:auto">
                            <col style="width:70px">
                        </colgroup>
                        <thead>
                        <tr>
                            <th scope="col">No</th>
                            <th scope="col">서식명</th>
                            <th scope="col">서식원본파일명</th>
                            <th scope="col">선택</th>
                        </tr>
                        </thead>
                        <tbody id="listBody">
                        <!-- ajax 리스트 조회 -->
                        </tbody>
                    </table>

                    <div class="paging_wrap">
                        <div class="paging"></div>
                    </div>

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

        //등록
        $("#submit").on("click", () => {
            checkVaild();

            if (confirm("저장하시겠습니까?")) {

                var formSerial = $("#insertForm").serialize();
// 				console.log(formSerial)

                $.ajax({
                    url: '/admin/contract/reg_insert',
                    data: formSerial,
                    type: 'POST',
                    success: function (data) {
                        if (data.result == "success") {
                            alert("저장하였습니다.");
                            href = "/admin/contract/list";
                        }
                    }, error: function (error) {
                        alert(error)
                    }, beforeSend: function () {
                        //로딩바
                    }, complete: function () {

                    }
                });

            }
        })
        //수정
        $("#modify").on("click", () => {
            checkVaild();

            if (confirm("수정하시겠습니까?")) {
                $("#insertForm").submit((result) => {
                    console.log(result);
                });
            }
        })

    })

    function checkVaild() {
        if ($("#formNm").val() == '') {
            alert("서식명은 필수입니다. ");
            $("#formNm").focus();
            return false;
        }

        if ($("#file").val() == '') {
            alert("파일 선택은 필수입니다. ");
            $("input[name='file']").focus();
            return false;
        }

    }

    /* 서식 선택 팝업 start */
    var gloItem = null;

    //1. 서식팝업에서 리스트 선택
    function popSelectItem(seq) {
        for (var i = 0; i < gloItem.length; i++) {
            if (gloItem[i].FILE_SEQ == seq) {
                $("#selectFotmResult").text(gloItem[i].FORM_NM + " / " + gloItem[i].ORG_FILE_NM);
                $("#FILE_SEQ").val(seq);
                break;
            }
        }
        $("#popClose").trigger("click")
    }

    //2. 서식 팝업내 리스트 조회(ajax)
    function fnListSearch(page) {
        $('#page').val(page);

        var formSerial = $("#frm").serialize();
        console.log(formSerial)

        $.ajax({
            url: '/admin/form/ajaxPopList',
            data: formSerial,
            type: 'POST',
            success: function (data) {
                ajaxPopListSuccess(data);
            }, error: function (error) {
                alert(error)
            }, beforeSend: function () {
                //로딩바
            }, complete: function () {

            }
        });

        function ajaxPopListSuccess(data) {
            $('#listBody').empty();
            var list = data.list;
            gloItem = list;
            var totalRow = data.pagingVO.total;
            var num = totalRow - (data.pagingVO.nowPage * (data.pagingVO.cntPerPage - 1));
            $.each(list, function (a, item) {
                var $tr = $('<tr/>');
                $tr.append('<td>' + num + '</td>')
                    .append('<td class="text_l">' + this.FORM_NM + '</td>')
                    .append('<td class="text_l">' + this.ORG_FILE_NM + '</td>')
                    .append('<td><a href="javascript:;" onclick="popSelectItem(' + this.FILE_SEQ + ');" class="btn_small type_03">선택</a></td>')
                $('#listBody').append($tr);
                num--;
            });
            $('#listBody').parents('div').show();

            if (totalRow > 0) {
                fnMakePagingForAjax(totalRow, data.pagingVO.cntPerPage, 10, data.pagingVO.nowPage, true, true, $('div.paging'));
                $('div.paging').find('a').click(function () {
                    var page = $(this).attr("data");
                    if (page) {
                        fnListSearch(page);
                    }
                });
            }
            return;
        }
    }

    /* 서식 선택 팝업 end */
</script>