<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<!-- contents -->
<section id="contents">

    <div>
        <h3>서식</h3>
        <table id="formList" class="ui celled table" style="width:100%"></table>
    </div>

</section>
<!-- //contents -->

<!-- 서식리스트 조회, 선택 popup -->
<section id="content_pop" class="pop_wrap pop_formList">
    <div>
        <div>
            <div class="pop_data middle">
                <h3>서식등록</h3>
                <div class="detail_data">

                    <form name="insertForm" id="insertForm" method="post" action="/admin/form/reg_insert"
                          enctype="multipart/form-data">

                        <label>서식명
                            <input type="text" name="formNm" id="formNm" required>
                        </label>

                        <label>서식파일
                            <input id="file" type="file" name="file" multiple="multiple" accept="application/pdf"
                                   required>
                            <ins class="mt5 sm_text">* 10M 이하 crf만 업로드 가능합니다.</ins>
                        </label>
                    </form>

                    <div class="btn_page text_c">
                        <a href="javascript:" id="popClose" onclick="common.contentPopClose(this);"
                           class="btn_default type_01">닫기</a>
                    </div>
                </div>
                <a href="javascript:" onclick="common.contentPopClose(this);" class="btn_pop_close"></a>
            </div>
        </div>
    </div>
</section>
<!--// end 서식조회 선택 팝업 -->

<script>

    $(function () {
        initDataTable();

        $('#addFormBtn').on('click', function () {
            $('#content_pop').show();
        });
    });

    const initDataTable = () => {

        $('#formList').DataTable({
            order: [0, 'desc'],
            // dom: 'Bt',
            // buttons: [
            //     {
            //         text: '서식 추가',
            //         action: function ( e, dt, node, config ) {
            //             $('#content_pop').show();
            //         }
            //     },
            //     'copyHtml5', 'excelHtml5', 'pdfHtml5', 'csvHtml5'
            // ],
            ajax: {
                url: cpath + "/api/forms",
                type: "POST",
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
                {
                    data: 'fileSeq',
                    name: 'SAV_FILE_NM',
                    title: '',
                    orderable: false,
                    render: function (data, type, row, meta) {
                        return '<a href="javascript:" onclick="deleteRow(\'' + data + '\');">삭제</a>';
                    }
                },

            ]
        });

    }

    const deleteRow = (fileSeq) => {
        confirm2("경고", "삭제하시겠습니까?",
            () => Commons.ajaxDelete("/api/forms", {fileSeq:fileSeq}, () => alert2("삭제완료"))
        );
    }

</script>
