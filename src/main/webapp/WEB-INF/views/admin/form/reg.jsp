<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<!-- contents -->
<section id="contents">
    <form name="insertForm" id="insertForm" method="post" action="/admin/form/reg_insert" enctype="multipart/form-data">
        <input type="hidden" id="AF10_SEQS" name="AF10_SEQS" value=""/>
        <input type="hidden" id="fileSeq" name="fileSeq" value=""/>

        <table class="view">
            <caption>서식등록/수정 테이블</caption>
            <colgroup>
                <col style="width:150px">
                <col style="width:auto">
            </colgroup>
            <tbody>
            <tr>
                <th scope="col">서식명</th>
                <td><input type="text" name="formNm" id="formNm" value="${ item.FORM_NM }" required style="width:100%">
                </td>
            </tr>
            <tr>
                <th scope="col"><p class="txt">서식파일<br><!-- <span class="sm_text">(다중선택 가능)</span> --></p></th>
                <td>
                    <p><input id="file" type="file" name="file" multiple="multiple" accept="application/pdf"
                              onchange="fnCheckSize(this)"> <!--필요한경우사용--></p>
                    <p class="mt5 sm_text">* 10M 이하 pdf만 업로드 가능합니다. </p>
                    <c:forEach var="data" items="${ fileList }">
                        <p>${ data.AF10_ONAME } <a href="javascript:;" onclick="<!-- fnDelSeqSet(this) -->"
                                                   data-seq="${ data.INSERT_SEQ }" class="btn_del">X</a></p>
                    </c:forEach>
                </td>
            </tr>
            </tbody>
        </table>
    </form>

    <div>
        <div class="btn_page text_c">
            <a href="/admin/form/list" class="btn_default type_02">목록</a>
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

<script>
    $(function () {

        //등록
        $("#submit").on("click", () => {
            checkVaild();

            if (confirm("저장하시겠습니까?")) {
                var formData = new FormData();
                formData.append("file", $("input[name='file']")[0].files[0]);
                formData.append("formNm", $("#formNm").val());

                $.ajax({
                    url: '/admin/form/reg_insert',
                    data: formData,
                    processData: false,
                    contentType: false,
                    type: 'POST',
                    encType: 'multipart/form-data',
                    cache: false,
                    async: false,
                    timeout: 15000,
                    success: function (data) {
                        if (data.result == "success") {
                            alert("저장하였습니다.");
                            href = "/admin/form/list";
                        }
                    }, error: function (data) {
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

    var FILE_SIZE = '10485760'//10MB = 10,485,760B
    //3MB => 3,145,728

    // 첨부 파일 삭제
    function fnDelSeqSet(obj) {
        var seq = $('#AF10_SEQS').val();
        if (seq == '') {
            $('#AF10_SEQS').val($(obj).data('seq'));
        } else {
            $('#AF10_SEQS').val(seq + ',' + $(obj).data('seq'));
        }

        $(obj).parent().remove();
    }

    // 파일 사이즈 체크
    var totalSize = 0;

    function fnCheckSize(obj) {
        var files = obj.files;

        totalSize = 0;
        $.each(files, function () {
            totalSize += this.size;
        });

        if (totalSize > FILE_SIZE) {
            alert('업로드 가능한 용량이 초과되었습니다.선택파일용량[' + Math.round(totalSize / 1024) + 'KB]');
        }
    }

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
</script>