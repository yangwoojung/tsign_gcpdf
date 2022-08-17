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
        <h3>계약관리</h3>
        <fieldset>
            <legend>계약서 검색 입력폼</legend>
            <form name="searchForm" id="searchForm" method="post">
                <input type="hidden" id="page" name="page" value="${ searchData.page }"/>
                <input type="hidden" id="CONTRC_NO" name=CONTRC_NO value=""/>
                <table class="view">
                    <caption>계약서 검색 입력 테이블</caption>
                    <colgroup>
                        <col style="width:200px">
                        <col style="width:auto">
                        <col style="width:200px">
                        <col style="width:auto">
                    </colgroup>
                    <tbody>
                    <tr>
                        <th>서명인</th>
                        <td>
                            <p class="row_input">
                                <input type="text" name="searchWord" style="width:100%" maxlength="20"
                                       value="${param.searchWord}">
                            </p>
                        </td>
                        <th>상태</th>
                        <td>
                            <select id="searchProcess" name="searchProcess">
                                <option value="0">전체</option>
                                <option value="1">진행중</option>
                                <option value="2">완료</option>
                            </select>
                        </td>
                    </tr>
                    </tbody>
                </table>
            </form>
            <p class="text_r mt10"><a href="javascript:fnListSearch();" id="searchBtn"
                                      class="btn_default type_03">검색</a></p>
        </fieldset>
    </div>

    <div class="default_cell">

        <div class="list_data">
            <!-- ▼▼▼ 20181114 수정 ▼▼▼ -->
            <p class="list_total">조회결과 : ${result.pagingVO.total}</p>
            <!-- ▲▲▲ 20181114 수정 끝 ▲▲▲ -->
            <table class="list">
                <caption>계약 조회 결과 리스트 테이블</caption>
                <colgroup>
                    <col style="width:8%">
                    <col style="width:auto">
                    <col style="width:auto">
                </colgroup>
                <thead>
                <tr>
                    <th scope="col" rowspan="2">No</th>
                    <th scope="col" colspan="4">계약요청</th>
                    <th scope="col" colspan="2">계약완료</th>
                </tr>
                <tr>
                    <th scope="col">요청일시</th>
                    <th scope="col">계약번호</th>
                    <th scope="col">서식명</th>
                    <th scope="col">서명인</th>
                    <th scope="col">서명일시</th>
                    <th scope="col">계약서</th>
                </tr>
                </thead>
                <tbody>
                <c:set var="num"
                       value="${result.pagingVO.total - ((result.pagingVO.nowPage - 1) * result.pagingVO.cntPerPage)}"/>
                <c:forEach var="data" items="${result.list}">
                    <tr>
                        <td class="">${num }</td>
                        <td class="">${data.REG_DATE }</td>
                        <td class="">${data.CONTRC_NO }</td>
                        <td class="">${data.FORM_NM}</td>
                        <td class="">${data.USER_NM}</td>
                        <td class="">${data.IN_SIGN_DATE}</td>
                        <td class=""></td>
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