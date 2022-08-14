<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<link rel="stylesheet" type="text/css" href="https://cdnjs.cloudflare.com/ajax/libs/fomantic-ui/2.8.8/semantic.min.css">
<link rel="stylesheet" type="text/css" href="https://cdn.datatables.net/1.12.1/css/dataTables.semanticui.min.css">

<!-- contents -->
<section id="contents">

    <div>
        <h3>서식 조회</h3>
            <table id="formList" class="ui celled table" style="width:100%"></table>
    </div>

</section>
<!-- //contents -->
<script type="text/javascript" src="https://cdn.datatables.net/1.12.1/js/jquery.dataTables.js"></script>
<script type="text/javascript" src="https://cdn.datatables.net/1.12.1/js/dataTables.semanticui.min.js"></script>
<script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/fomantic-ui/2.8.8/semantic.min.js"></script>

<script>

    $(function() {
        initDataTable();
    });

    const initDataTable = () => {

        $('#formList').DataTable({
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
                    },

                ]
            });

    }

</script>
