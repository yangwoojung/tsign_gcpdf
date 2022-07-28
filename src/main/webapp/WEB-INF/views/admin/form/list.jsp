<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<script>
    var FORM_ID = "searchListForm";
</script>
<!-- contents -->
<section id="contents">

    <div class="default_cell">
        <h3>서식 조회</h3>
        <fieldset>
            <legend>서식 조회 폼</legend>
            <table class="view">
                <caption>서식 조회 테이블</caption>
                <colgroup>
                    <col style="width:200px">
                    <col style="width:auto">
                    <col style="width:200px">
                    <col style="width:auto">
                </colgroup>
                <tbody>
                <tr>
                    <th>서식명</th>
                    <td>
                        <p class="row_input">
                        <form id="searchListForm" action="/admin/form/list">
                            <input type="hidden" value="1" id="page" name="page">
                            <input type="text" value="${param.searchWord}" name="searchWord" style="width:150px">
                            <a href="javascript:;" id="searchBtn" class="btn_small type_03">검색</a>
                        </form>
                        </p>
                    </td>
                </tr>
                </tbody>
            </table>
        </fieldset>
    </div>

    <div class="default_cell">

        <div class="list_data">
            <!-- ▼▼▼ 20181114 수정 ▼▼▼ -->
            <p class="list_total">조회결과 : ${result.pagingVO.total}</p>
            <!-- ▲▲▲ 20181114 수정 끝 ▲▲▲ -->
            <table class="list">
                <caption>사용자 조회 결과 리스트 테이블</caption>
                <colgroup>
                    <col style="width:8%">
                    <col style="width:auto">
                    <col style="width:auto">
                </colgroup>
                <thead>
                <tr>
                    <th scope="col">No</th>
                    <!-- ▼▼▼ 20181130 수정 ▼▼▼ -->
                    <th scope="col">서식명</th>
                    <!-- ▲▲▲ 20181130 수정 끝 ▲▲▲ -->
                    <th scope="col">서식파일</th>
                </tr>
                </thead>
                <tbody>
                <c:set var="num"
                       value="${result.pagingVO.total - ((result.pagingVO.nowPage - 1) * result.pagingVO.cntPerPage)}"/>
                <c:forEach var="data" items="${result.list}">
                    <tr>
                        <td class="">${num }</td>
                        <td class="">${data.FORM_NM }</td>
                        <td class="">${data.ORG_FILE_NM}</td>
                    </tr>
                    <c:set var="num" value="${num - 1}"/>
                </c:forEach>
                <c:if test="${pageVo.totalRecord == 0 }">
                    <tr>
                        <td colspan="3">등록된 글이 없습니다.</td>
                    </tr>
                </c:if>
                </tbody>
            </table>
        </div>
        <div class="paging_wrap">
            <div class="paging">
                <!-- 공통에서 페이징 블럭 생성 fnMakePaging()-->
            </div>
        </div>
    </div>

</section>
<!-- //contents -->
<script>
    $(function () {
        var totalRecord = '${result.pagingVO.total}';
        if (totalRecord > 0) {
            fnMakePaging(totalRecord, ${result.pagingVO.cntPerPage}, 10, ${result.pagingVO.nowPage}, true, true, $('.paging'))
        }

        $("#searchBtn").on("click", () => {
            $("#" + FORM_ID).submit();
        })
    })
</script>