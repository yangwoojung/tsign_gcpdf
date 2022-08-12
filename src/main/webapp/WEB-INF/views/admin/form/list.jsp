<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<link rel="stylesheet" type="text/css" href="https://cdn.datatables.net/1.12.1/css/jquery.dataTables.css">
<link rel="stylesheet" type="text/css" href="https://cdnjs.cloudflare.com/ajax/libs/fomantic-ui/2.8.8/semantic.min.css">
<link rel="stylesheet" type="text/css" href="https://cdn.datatables.net/1.12.1/css/dataTables.semanticui.min.css">

<!-- contents -->
<section id="contents">

    <div class="default_cell">
        <h3>서식 조회</h3>
        <fieldset>
            <legend>서식 조회 폼</legend>
            <table id="formList" class="ui celled table" width="100%"></table>
        </fieldset>
    </div>

</section>
<!-- //contents -->
<script type="text/javascript" charset="utf8" src="https://cdn.datatables.net/1.12.1/js/jquery.dataTables.js"></script>
<script type="text/javascript" charset="utf8" src="https://cdn.datatables.net/1.12.1/js/dataTables.semanticui.min.js"></script>
<script type="text/javascript" charset="utf8" src="https://cdnjs.cloudflare.com/ajax/libs/fomantic-ui/2.8.8/semantic.min.js"></script>

<script>
    $(document).ready(function () {
        var table = $('#formList').DataTable({
            processing: false,
            language: {
                "loadingRecords": "<div class=\"spinner\"></div>"
            },
            serverSide: true,
            responsive: true,
            lengthChange: false,
            searching: true,
            scrollCollapse: true,
            deferRender: true,
            scrollX: true,
            scroller: {
                loadingIndicator: true
            },
            // order: [[ 0, 'asc' ], [ 1, 'asc' ]],
            dom: 'Bfrtip',
            ajax: {
                url: "${pageContext.request.contextPath}/admin/form/lists",
                type: "post",
                headers: {
                    'Accept': 'application/json',
                    'Content-Type': 'application/json'
                },
                data: function (data,settings) {
                    console.log(data)

                    sortColumns = [];
                    orderBy = "" ;
                    for (let i = 0; i < data.order.length; i++) {
                        col = data.order[i].column;
                        dir = data.order[i].dir;
                        sortColumns.push(data.columns[col].name + " " + dir);
                        orderBy = data.columns[col].name + " " + dir
                    }

                    // sortColumns.join(",");

                    console.log(sortColumns)
                    data.orderBy = orderBy;
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
            columnDefs: [
                {
                    defaultContent: "-",
                    "targets": "_all"
                },
            ],
            columns: [
                {
                    data: 'fileSeq',
                    name: 'FILE_SEQ',
                    title: '순번',
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
                },

            ]
        });
    })

</script>
