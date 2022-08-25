<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<header>
    <h2 class="title">서류 제출</h2>
</header>

<!-- container -->
<div id="container">
    <!-- cont_area -->
    <div class="cont_area">
        <div class="txt_msg_box cont">
            <span id="attachment_title"></span>
            <%--            <span id="attachment_title">주민등록증이나 운전면허증을 준비해주세요.</span>--%>
            <span class="point">반드시 원본을 촬영(첨부)</span>하여 제출해 주세요.
        </div>
        <div class="progress">
            <div class="box-progress-bar">
                <span class="box-progress" style="width: 100%;"></span>
            </div>
            <div class="number">
                <span class="active">3</span>/3
            </div>
        </div>
        <div class="exImg-wrap">
            <div class="frame">
                <div></div>
                <div></div>
                <div></div>
                <div></div>
            </div>
            <div class="exImg">
                <div class="imgConts">
                    <div class="left">
                        <div class="imgTitle"></div>
                        <div class="name">
                            <span></span>
                            <span></span>
                            <span></span>
                        </div>
                        <div class="description">
                            <div>
                            </div>
                            <div>
                            </div>
                        </div>
                    </div>
                    <div class="right">
                        <span>😎</span>
                    </div>
                </div>
                <div class="imgFooter">
                </div>
            </div>
            <div class="imgBar"></div>
        </div>

        <div class="imgDesc">
            <ul class="description">
                <li>여백을 최소화 해주세요.</li>
                <li>원본이 잘리거나 흐릿하게 촬영된 경우에는 반드시 다시 촬영해주세요.</li>
                <li>첨부는 JPEG 형식만 가능합니다.</li>
            </ul>
        </div>
    </div>
    <!-- //cont_area -->
</div>
<!-- //container -->

<form id="form" style="display: none">
    <input type="file" id="file" accept="image/jpg, image/jpeg">
    <input type="hidden" id="attachmentCd" />
</form>

<footer>
    <div class="btn_area">
        <a href="javascript:" id="nextBtn" class="btn_m btn_ty02">신분증 촬영하기</a>
    </div>
</footer>

<script type="text/javascript">

    $(function () {

        setupContractAttachments();
        addClickEvents();

    });

    const setupContractAttachments = () => {

        // 1. 업로드 해야할 계약자의 구비서류 데이터 우선순위에 따라 가져오기
        const contractAttachments = fetchContractAttachments();
        console.log(contractAttachments)

        // 2. 업로드 해야할 구비서류가 더 이상 없다면 제출하기 시도 (유효성 검사는 서버에서 진행)
        if (contractAttachments.length === 0) submitAttachment();

        // 3. 우선순위에 따라 첫번째 구비서류에 대한 내용 표출
        const selectedContractAttachment = contractAttachments[0];
        const {attachmentCd, attachmentName, attachmentDescription} = selectedContractAttachment;

        $('#attachment_title').html(attachmentDescription);
        $('#nextBtn').html(attachmentName + " 촬영하기");

        $('#form')[0].reset();
        $('#attachmentCd').val(attachmentCd);

    }

    const addClickEvents = () => {

        // 촬영하기 클릭 이벤트
        $('#nextBtn').on('click', function () {
            $('#file').trigger('click');
        });

        // 파일 업로드
        $('input[type="file"]').off('change').on('change', btnFileChangeAction);
        // $('#btnSubmit').off('click').on('click', btnSubmitAction);
    };

    // 구비서류 사이즈 공통 값
    const FILE = {
        checkFileSize: true,
        limitPdfSize: 1024 * 1024,
        maxImgSize: 1280,
    };

    function btnFileChangeAction(e) {

        const file = this.files[0];

        // 유효성 검사
        if (!validateImage(file)) return;

        // 파일 리사이징
        resizingImage(file);

    };

    const validateImage = (file) => {

        // TODO: 웹사이트 진입시점에 알려주는것이 좋지 않을까 ?
        if (!document.createElement('canvas').getContext) {
            alert('사용하시는 브라우저는 일부 기능을 제공하지 않습니다. 다른 브라우저를 사용해 주시기바랍니다.');
            return false;
        }

        console.log(file)
        console.log(file.type)

        if (!file.type.match(/image.*|application.*pdf/)) {
            alert('JPEG 형식만 첨부 가능합니다.');
            return false;
        }

        // if (FILE.checkFileSize && file.type.match(/application.*pdf/) && file.size > FILE.limitPdfSize) {
        //     alert('파일의 용량은 ' + (FILE.limitPdfSize / 1024) + 'KB를 초과할 수 없습니다.');
        //     return false;
        // }

        return true;
    }

    const resizingImage = (file) => {

        // const file = e.target.files[0];

        // html5 canvas + img
        if (file.type.match(/image.*/)) {
            var reader = new FileReader();
            reader.readAsDataURL(file);

            reader.onload = function (readerEvent) {
                var base64 = readerEvent.target.result;
                window.URL = window.URL || window.webkitURL;
                var blobUrl = window.URL.createObjectURL(base64ToBlob(base64));

                var image = new Image();
                image.src = blobUrl;

                image.onload = function (imageEvent) {
                    var width = image.width;
                    var height = image.height;
                    var maxSize = FILE.maxImgSize;

                    if (width > height && width > maxSize) {
                        if (width > maxSize) {
                            height *= maxSize / width;
                            width = maxSize;
                        }
                    } else {
                        if (height > maxSize) {
                            width *= maxSize / height;
                            height = maxSize;
                        }
                    }

                    var canvas = document.createElement('canvas');
                    canvas.width = width;
                    canvas.height = height;

                    var ctx = canvas.getContext('2d');
                    ctx.drawImage(image, 0, 0, width, height);
                    base64 = canvas.toDataURL('image/jpeg');
                    // $(targetContainer).find('.uploadbinary:eq(0)').val(base64);

                    // 파일 업로드
                    fnUploadFile(base64);

                }; // -- end image
            }; // -- end reader
        }

        // pdf
        // if (file.type.match(/application.*pdf/)) {
        //     var fileReader = new FileReader();
        //     fileReader.readAsDataURL(file);
        //
        //     fileReader.onload = function (readerEvent) {
        //         var pdfbase64 = readerEvent.target.result;
        //         $(targetContainer).find(".uploadbinary:eq(0)").val(pdfbase64);
        //         fnUploadFile($(targetContainer));
        //     };
        // }

    };

    // 파일 업로드
    const fnUploadFile = (base64) => {

        const formData = new FormData();
        formData.append('attachmentCd', $('#attachmentCd').val());
        formData.append('file', base64);

        $.ajax({
            url: cpath + '/sign/attach/upload',
            data: formData,
            processData: false,
            contentType: false,
            type: 'POST',
            encType: 'multipart/form-data',
            cache: false,
            success: function (response) {
                // $('#attachLoading').hide();
                if (response.result === 'SUCCESS') {
                    setupContractAttachments();
                }
            }, error: function (xhr, data) {
                // $('#attachLoading').hide();
                alert('[e] 파일 첨부 실패 - 다시 촬영(첨부)해 주세요\n장시간 미사용 상태거나, 인터넷이 끊기신 경우 처음부터 진행해 주세요.');
                if (xhr.status === 403) {
                    location.href = '/sign/error/401';
                }

            }, beforeSend: function () {
                // $('#attachLoading').show();
            }, complete: function () {
                // $('#attachLoading').hide();
            }

        });

    };

    var base64ToBlob = function (base64) {
        var sliceSize = 1024;
        var fileType = base64.match(/data:([^;]+)/)[1];

        base64 = base64.replace(/^[^,]+,/g, '');
        var byteChars = window.atob(base64);
        var byteArrays = [];

        for (var offset = 0, len = byteChars.length; offset < len; offset += sliceSize) {
            var slice = byteChars.slice(offset, offset + sliceSize);

            var byteNumbers = new Array(slice.length);
            for (var i = 0; i < slice.length; i++) {
                byteNumbers[i] = slice.charCodeAt(i);
            }

            var byteArray = new Uint8Array(byteNumbers);
            byteArrays.push(byteArray);
        }

        return new Blob(byteArrays, {type: fileType});
    }

    const fetchContractAttachments = () => {
        let data;

        $.ajax({
            url: cpath + '/sign/attach/list',
            type: 'GET',
            async: false,
            success: function (response) {
                console.log(response)
                if (response.result === 'SUCCESS') data = response?.data
            },
            error: function (jqXHR) {
                console.error(jqXHR);
            }
        });

        return data;
    }

    // 구비서류 제출
    const submitAttachment = () => {

        // TODO: 서버에서 계약자 구비서류 파일 존재하는지 확인하며 전부 완료됬는지 유효성 체크

        alert('계약서류를 구비서류와 함께 해당 기관에 제출하고 있습니다.\n!!주의!!\n전송 완료 후 본 화면은 자동으로 닫힙니다. 절대 화면을 강제로 닫으시면 안됩니다. (5초 ~ 최장 60초)');

        $.ajax({
            url: '/sign/attach/submission',
            type: 'POST',
            cache: false,
            success: function (data) {
                if ('0000' == data.resCd) {
                    alert('제출을 완료했습니다');
                    window.parent.fnIdentificationClose('success');
                } else {
                    alert('[' + data.resCd + '] 제출에 실패하였습니다. 다시 진행해 주세요.');
                }

            }, error: function (xhr, data) {
                alert('[' + data.resCd + '] 제출에 실패하였습니다. 다시 진행해 주세요.');
                if (xhr.status == 403) {
                    location.href = '/sign/error/401';
                }
            }, beforeSend: function () {
                $('#nextBtn').attr('disabled', true);
            },
        });

    };

</script>
