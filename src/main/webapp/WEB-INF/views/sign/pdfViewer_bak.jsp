<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/jspdf/1.5.3/jspdf.min.js"></script>
    <script type="text/javascript" src="https://html2canvas.hertzen.com/dist/html2canvas.min.js"></script>
    <link rel="resource" type="application/l10n" href="/resources/sign/pdfjs/locale/locale.properties">
    <script type='text/javascript' src="/resources/sign/pdfjs/build/pdf.js"></script>

    <style>

        #pdf-main-container {
            width: 600px;
            margin: 20px auto;
        }

        #pdf-loader {
            display: none;
            text-align: center;
            color: #999999;
            font-size: 13px;
            line-height: 100px;
            height: 100px;
        }

        #password-container {
            padding: 50px 0;
            box-sizing: border-box;
            text-align: center;
        }

        #pdf-password {
            border: 1px solid #cccccc;
            padding: 5px;
            margin: 0 10px 0 0;
            width: 100px;
        }

        #submit-password {
            background: none;
            border: 1px solid #cccccc;
            padding: 4px;
        }

        #password-message {
            text-align: center;
            color: red;
            margin: 10px 0 0 0;
            font-size: 13px;
        }

        #pdf-contents {
            display: none;
        }

        #pdf-meta {
            overflow: hidden;
            margin: 0 0 20px 0;
        }

        #pdf-buttons {
            float: left;
        }

        #page-count-container {
            float: right;
        }

        #pdf-current-page {
            display: inline;
        }

        #pdf-total-pages {
            display: inline;
        }

        #pdf-canvas {
            border: 1px solid rgba(0, 0, 0, 0.2);
            box-sizing: border-box;
        }

        #page-loader {
            height: 100px;
            line-height: 100px;
            text-align: center;
            display: none;
            color: #999999;
            font-size: 13px;
        }

        #dataBinding {
            width: 595px;
            height: 841px;
            background: yellow;
            opacity: 0.4;
            position: absolute;
            left: 50%;
            top: 50%;
            margin-left: -297.5px;
            margin-top: -437.5px;
            z-index: 90;
        }

        .page div[class^=insertDataBox] {
            position: absolute;
            left: 0;
            top: 0;
            right: 0;
            bottom: 0;
        }

        .insertBox_inner {
            position: relative;
            left: 0;
            top: 0;
            right: 0;
            bottom: 0;
        }

        .insertBox_inner em {
            position: absolute;
            z-index: 110;
            font-style: initial;
            background-color: #fff;
            padding: 1px;
        }

        .insertBox_inner img {
            position: absolute;
            z-index: 110;
            font-style: initial;
            padding: 1px;
            width: 135px;
        }
    </style>
<body>

<div id="pdf-main-container">
    <div id="pdf-loader">Loading document ...</div>
    <div id="password-container">
        <input type="password" id="pdf-password" autocomplete="off" placeholder="Password"/>
        <button id="submit-password">Submit</button>
        <div id="password-message"></div>
    </div>
    <div id="pdf-contents">
        <%--<div id="pdf-meta">
            <div id="pdf-buttons">
                <button id="pdf-prev">Previous</button>
                <button id="pdf-next">Next</button>
            </div>
            <div id="page-count-container">Page
                <div id="pdf-current-page"></div>
                of
                <div id="pdf-total-pages"></div>
            </div>
        </div>--%>
        <canvas id="pdf-canvas"></canvas>
        <div id="page-loader">Loading page ...</div>
    </div>
</div>

<script>

    var __PDF_DOC,
        __CURRENT_PAGE,
        __TOTAL_PAGES,
        __PAGE_RENDERING_IN_PROGRESS = 0,
        __CANVAS = $('#pdf-canvas').get(0),
        __CANVAS_CTX = __CANVAS.getContext('2d');

    const PDF_FILE_PATH = "/upload/temp/" + '${file.savFileNm}';
    console.log("PDF_FILE_PATH == " + PDF_FILE_PATH);
    const contrcNo = '${user.contractNo}';

    function showPDF(password) {
        $("#pdf-loader").show();
        $("#password-container").hide();

        const loadingTask = pdfjsLib.getDocument({url: PDF_FILE_PATH, password: password});
        loadingTask.promise.then(function (pdf_doc) {

            __PDF_DOC = pdf_doc;
            __TOTAL_PAGES = __PDF_DOC.numPages;

            // Hide the pdf loader and show pdf container in HTML
            $("#pdf-loader").hide();
            $("#password-container").hide();
            $("#pdf-contents").show();
            $("#pdf-total-pages").text(__TOTAL_PAGES);

            // Show the first page
            showPage(1);

            var box_w = $(".page").css("width");
            var box_h = $(".page").css("height");
            console.log("box_w==" + box_w);
            console.log("box_h==" + box_h);
            <%--var encodingSigImg = '${info.signCanvasDataUrl}';--%>
            // var encodingSigImg64 = 'data:image/jpeg;base64,' + encodingSigImg
            $(".page").eq(0).append("<div class='insertDataBox0' style='width:" + box_w + ";height:" + box_h + "'><div class='insertBox_inner'></div></div>")
            //주민등록번호
            $(".insertDataBox0 .insertBox_inner").append("<em class='insertData' style='left: 560px;top: 829px;'>${user.socialNo1}-${user.socialNo2}</em>")
            //주소
            $(".insertDataBox0 .insertBox_inner").append("<em class='insertData' style='left: 500px;top: 854px;'>${user.address}</em>")
            //계좌
            $(".insertDataBox0 .insertBox_inner").append("<em class='insertData' style='left: 500px;top: 915px;'>${user.bankName}/${user.bankAccountNo}</em>")
            //성명
            $(".insertDataBox0 .insertBox_inner").append("<em class='insertData' style='left: 500px;top: 941px;'>${user.userNm}</em>")
            //사인 이미지
            // $(".insertDataBox0 .insertBox_inner").append("<img class='insertData' src='" + encodingSigImg + "' style='position:absolute;right: 56px;top: 926px;'/>")

        }).catch(function (error) {
            console.log(error)
            $("#pdf-loader").hide();

            // if (error.name == 'PasswordException') {}
            $("#password-container").show();
            $("#pdf-password").val('');
            $("#password-message").text(error.code === 2 ? error.message : '');
            alert(error.message);

        });
    }

    function showPage(page_no) {
        __PAGE_RENDERING_IN_PROGRESS = 1;
        __CURRENT_PAGE = page_no;

        // Disable Prev & Next buttons while page is being loaded
        $("#pdf-next, #pdf-prev").attr('disabled', 'disabled');

        // While page is being rendered hide the canvas and show a loading message
        $("#pdf-canvas").hide();
        $("#page-loader").show();

        // Update current page in HTML
        $("#pdf-current-page").text(page_no);

        // Fetch the page
        __PDF_DOC.getPage(page_no).then(function (page) {

            // As the canvas is of a fixed width we need to set the scale of the viewport accordingly

            __CANVAS.style.height = window.innerHeight + 'px'
            __CANVAS.style.width = window.innerWidth + 'px'

            console.log("canvas.style.height=" + __CANVAS.style.height);
            console.log("canvas.style.width=" + __CANVAS.style.width);

            console.log("canvas.height=" + __CANVAS.height);
            console.log("canvas.width=" + __CANVAS.width);

            console.log("canvas.width=" + page.getViewport({scale: 1}).width);

            var scale_required = __CANVAS.width / page.getViewport({scale: 1}).width;

            // Get viewport of the page at required scale
            var viewport = page.getViewport({scale: 1});

            __CANVAS.height = viewport.height;
            __CANVAS.width = viewport.width;

            // Set canvas height
            // __CANVAS.height = viewport.height;

            console.log("canvas.height=" + __CANVAS.height);
            console.log("canvas.width=" + __CANVAS.width);

            var renderContext = {
                canvasContext: __CANVAS_CTX,
                viewport: viewport
            };

            var renderTask = page.render(renderContext);
            // Render the page contents in the canvas
            renderTask.promise.then(function () {
                __PAGE_RENDERING_IN_PROGRESS = 0;

                // Re-enable Prev & Next buttons
                $("#pdf-next, #pdf-prev").removeAttr('disabled');

                // Show the canvas and hide the page loader
                $("#pdf-canvas").show();
                $("#page-loader").hide();
            });
        });
    }

    //데이터 바인딩 (jsp에서 할일)
    //위치조정, font조정
    /*$("#htmlexport").on("click", function () {
       var box_w = $(".page").css("width");
                    var box_h = $(".page").css("height");
                    console.log("box_w==" + box_w);
                    console.log("box_h==" + box_h);
                    <%--var encodingSigImg = '${info.signCanvasDataUrl}';--%>
                    // var encodingSigImg64 = 'data:image/jpeg;base64,' + encodingSigImg
                    $(".page").eq(0).append("<div class='insertDataBox0' style='width:" + box_w + ";height:" + box_h + "'><div class='insertBox_inner'></div></div>")
                    //주민등록번호
                    $(".insertDataBox0 .insertBox_inner").append("<em class='insertData' style='left: 560px;top: 829px;'>${user.socialNo1}-${user.socialNo2}</em>")
                    //주소
                    $(".insertDataBox0 .insertBox_inner").append("<em class='insertData' style='left: 500px;top: 854px;'>${user.address}</em>")
                    //계좌
                    $(".insertDataBox0 .insertBox_inner").append("<em class='insertData' style='left: 500px;top: 915px;'>${user.bankName}/${user.bankAccountNo}</em>")
                    //성명
                    $(".insertDataBox0 .insertBox_inner").append("<em class='insertData' style='left: 500px;top: 941px;'>${user.userNm}</em>")
                    //사인 이미지
                    // $(".insertDataBox0 .insertBox_inner").append("<img class='insertData' src='" + encodingSigImg + "' style='position:absolute;right: 56px;top: 926px;'/>")

    });*/

    $("#submit-password").on('click', function () {
        showPDF($("#pdf-password").val());
    });

    // Previous page of the PDF
    $("#pdf-prev").on('click', function () {
        if (__CURRENT_PAGE != 1)
            showPage(--__CURRENT_PAGE);
    });

    // Next page of the PDF
    $("#pdf-next").on('click', function () {
        if (__CURRENT_PAGE != __TOTAL_PAGES)
            showPage(++__CURRENT_PAGE);
    });

    $(document).on('ready', function () {

    })

</script>