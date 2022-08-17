<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<!-- contents -->
<section id="contents">

    <div class="default_cell">
        <h3>계약관리</h3>

        <table id="contractList" class="ui celled table" style="width:100%">
            <caption>계약 조회 결과 리스트 테이블</caption>
            <colgroup>
                <col style="width:8%">
                <col style="width:auto">
                <col style="width:auto">
            </colgroup>
            <thead>
            <tr>
                <th rowspan="2">No</th>
                <th colspan="4">계약요청</th>
                <th colspan="2">계약완료</th>
            </tr>
            <tr>
                <th>요청일시</th>
                <th>계약번호</th>
                <th>서식명</th>
                <th>서명인</th>
                <th>서명일시</th>
                <th>계약서</th>
            </tr>
            </thead>
        </table>
    </div>


</section>
<!-- //contents -->

<script>
    $(function () {
        initDataTable();
    });

    const initDataTable = () => {

        $('#contractList').DataTable({
            order: [0, 'desc'],
            ajax: {
                url: cpath + "/admin/contract/lists",
                type: "post",
                headers: {
                    'Accept': 'application/json',
                    'Content-Type': 'application/json'
                },
                data: function (data, settings) {

                    let orderBy = "";
                    for (let i = 0; i < data.order.length; i++) {
                        const {column, dir} = data.order[i];
                        orderBy = data.columns[column].name + " " + dir
                    }
                    data.orderBy = orderBy;

                    if (data.search.value) {
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
                    data: 'contrcSeq',
                    name: 'CONTRC_SEQ',
                },
                {
                    data: 'contrcNo',
                    name: 'CONTRC_NO',
                },
                {
                    data: 'regDate',
                    name: 'REG_DATE',
                },
                {
                    data: 'formNm',
                    name: 'FORM_NM',
                },
                {
                    data: 'userNm',
                    name: 'USER_NM',
                },
                {
                    data: 'signDueEdate',
                    name: 'SIGN_DUE_EDATE',
                },
                {
                    data: 'filePath',
                    name: 'FILE_PATH',
                },
            ]
        });

    }
</script>
