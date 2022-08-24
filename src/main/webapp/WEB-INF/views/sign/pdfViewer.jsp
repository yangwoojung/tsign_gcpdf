<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">
    <meta name="google" content="notranslate">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <title>PDF.js viewer</title>
<%--    <link rel="stylesheet" type="text/css" href="/resources/sign/pdfjs/pdfviewer.css">--%>
    <script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/jspdf/1.5.3/jspdf.min.js"></script>
    <script type="text/javascript" src="https://html2canvas.hertzen.com/dist/html2canvas.min.js"></script>

    <!-- This snippet is used in production (included from viewer.html) -->
    <link rel="resource" type="application/l10n" href="/resources/sign/pdfjs/locale/locale.properties">
    <script type='text/javascript' src="/resources/sign/pdfjs/build/pdf.js"></script>
<%--    <script type='text/javascript' src="/resources/sign/pdfjs/build/pdf.worker.js"></script>--%>
    <%--    <script type='text/javascript' src="/resources/sign/pdfjs/pdfviewer.js"></script>--%>
    <script src="/resources/sign/js/jquery-1.12.4.min.js"></script>

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
    </style>

</head>
<body>

<div id="pdf-main-container">
    <div id="pdf-loader">Loading document ...</div>
    <div id="password-container">
        <input type="password" id="pdf-password" autocomplete="off" placeholder="Password"/>
        <button id="submit-password">Submit</button>
        <div id="password-message"></div>
    </div>
    <div id="pdf-contents">
        <div id="pdf-meta">
            <div id="pdf-buttons">
                <button id="pdf-prev">Previous</button>
                <button id="pdf-next">Next</button>
            </div>
            <div id="page-count-container">Page
                <div id="pdf-current-page"></div>
                of
                <div id="pdf-total-pages"></div>
            </div>
        </div>
        <canvas id="pdf-canvas" width="600"></canvas>
        <div id="page-loader">Loading page ...</div>
    </div>
</div>

</body>
<script>

    var __PDF_DOC,
        __CURRENT_PAGE,
        __TOTAL_PAGES,
        __PAGE_RENDERING_IN_PROGRESS = 0,
        __CANVAS = $('#pdf-canvas').get(0),
        __CANVAS_CTX = __CANVAS.getContext('2d');

    const PDF_FILE_PATH = '${user.pdfPath}' + '${user.pdfFileNm}';
    console.log("PDF_FILE_PATH == " + PDF_FILE_PATH);
    const contrcNo = '${user.contrcNo}';

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
            var scale_required = __CANVAS.width / page.getViewport({scale : 1}).width;
            // Get viewport of the page at required scale
            var viewport = page.getViewport({scale : scale_required});

            // Set canvas height
            __CANVAS.height = viewport.height;

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

</script>
</html>
