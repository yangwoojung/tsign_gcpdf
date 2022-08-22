<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<!-- contents -->
<section id="contents">

    <div>
        <h3>서식</h3>
        <button id="addFormBtn">서식 추가</button>
        <table id="formList" class="ui celled table" style="width:100%">
            <colgroup>
                <col style="width:3%">
                <col style="width:auto">
                <col style="width:auto">
                <col style="width:5%">
            </colgroup>
        </table>
    </div>

</section>
<!-- //contents -->

<!-- 서식리스트 조회, 선택 popup -->
<section id="content_pop" class="pop_wrap pop_formList">
    <div>
        <div>
            <div class="pop_data middle">
                <h3>서식등록</h3>
                <form name="form" id="form">
                    <input type="hidden" name="fileSeq" id="fileSeq">

                    <div class="detail_data">

                        <table class="view">
                            <colgroup>
                                <col style="width:200px">
                                <col style="width:auto">
                            </colgroup>
                            <tbody>
                            <tr>
                                <th>서식명</th>
                                <td>
                                    <input type="text" name="formNm" id="formNm" style="width: 100%">
                                </td>
                            </tr>
                            <tr>
                                <th>서식파일</th>
                                <td>
                                    <input id="file" type="file" name="file" style="width: 100%">
                                    <p class="mt5 sm_text">* 10M 이하 pdf만 업로드 가능합니다. </p>
                                </td>
                            </tr>
                            </tbody>
                        </table>

                        <div class="btn_page text_c">
                            <a href="javascript:" id="popClose" onclick="common.contentPopClose(this);"
                               class="btn_default">닫기</a>
                            <button type="submit" class="btn_default type_01">저장</button>
                        </div>
                    </div>
                </form>
                <a href="javascript:" onclick="common.contentPopClose(this);" class="btn_pop_close"></a>
            </div>
        </div>
    </div>
</section>
<!--// end 서식조회 선택 팝업 -->

<script>

    $(function () {
        initDataTable();
        initValidate();

        $('#addFormBtn').on('click', function () {
            openFormDetail();
        });
    });

    const initDataTable = () => {

        let $formTable = $('#formList');

        $formTable.DataTable({
            order: [0, 'desc'],
            // dom: 'Bfltip',
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
                    className: 'detail',
                    title: '서식명'
                },
                {
                    data: 'savFileNm',
                    name: 'SAV_FILE_NM',
                    className: 'detail',
                    title: '파일명'
                },
                {
                    data: 'fileSeq',
                    name: 'SAV_FILE_NM',
                    title: '',
                    orderable: false,
                    render: function (data, type, row, meta) {
                        return '<a href="javascript:" onclick="deleteForm(\'' + data + '\');">삭제</a>';
                    }
                },

            ]
        });

        $formTable.on('click', 'td.detail', function () {
            const data = $formTable.DataTable().row(this).data();
            openFormDetail(data);
        });

    }

    const openFormDetail = (data = null) => {
        const $form = $('#form')
        $form[0].reset();
        $form.find(':hidden').val('');

        if (data) {
            setValueFromObject($form, data);
        }

        $('#content_pop').show();
    }

    const FORMS_URL = '/admin/forms';

    const insertForm = (data) => {
        confirm2("저장", "저장하시겠습니까?",
            () => Commons.ajaxPostMutipart(FORMS_URL, data, (resp) => {
                console.log(resp);

                if(resp.result === 'SUCCESS') {
                    common.contentPopClose('#form');
                    $('#formList').DataTable().ajax.reload();
                }
            })
        );
    }

    const updateForm = (data) => {
        confirm2("수정", "수정하시겠습니까?",
            () => Commons.ajaxPut(FORMS_URL, data, (resp) => {
                console.log(resp)
            })
        );
    }

    const deleteForm = (fileSeq) => {
        confirm2("경고", "삭제하시겠습니까?",
            () => Commons.ajaxDelete(FORMS_URL, fileSeq, (resp) => {
                console.log(resp)
                alert2("삭제완료")
            })
        );
    }

    const initValidate = () => {
        $("#form").validate({

            submitHandler: function (form) {
                let formData = new FormData();
                formData.append("fileSeq", $('#fileSeq').val());
                formData.append("file", $("#file")[0].files[0]);
                formData.append("formNm", $("#formNm").val());

                if ($('#fileSeq').val()) {
                    updateForm(formData);
                } else {
                    insertForm(formData);
                }
            },
            // rules: {
            //     formNm: 'required'
            // },
            messages: {
                formNm: "서식명을 입력하세요.",
                file: "파일을 선택해주세요"
            }
        });
    }

</script>
