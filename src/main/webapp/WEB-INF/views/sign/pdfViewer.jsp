<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<!--
Copyright 2012 Mozilla Foundation

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.

Adobe CMap resources are covered by their own copyright but the same license:

Copyright 1990-2015 Adobe Systems Incorporated.

See https://github.com/adobe-type-tools/cmap-resources
-->
<html dir="ltr" mozdisallowselectionprint>
<head>
<meta charset="utf-8">
<meta name="viewport"
	content="width=device-width, initial-scale=1, maximum-scale=1">
<!--#if GENERIC || CHROME-->
<meta name="google" content="notranslate">
<!--#endif-->
	<title>(주)티소프트 전자계약</title>

<!--#if MOZCENTRAL-->
<!--#include viewer-snippet-firefox-extension.html-->
<!--#endif-->
<!--#if CHROME-->
<!--#include viewer-snippet-chrome-extension.html-->
<!--#endif-->

<link rel="stylesheet" href="/resources/sign/pdfjs/web/viewer.css">
<!--#if !PRODUCTION-->
<link rel="resource" type="application/l10n"
	href="/resources/sign/pdfjs/web/locale/locale.properties">
<!--#endif-->
<script type='text/javascript'
	src="/resources/sign/pdfjs/build/pdf.js"></script>
<script type='text/javascript'
	src="/resources/sign/pdfjs/build/pdf.worker.js"></script>
<script type='text/javascript'
	src="/resources/sign/pdfjs/web/viewer.js"></script>
<script src="/resources/sign/js/jquery-1.12.4.min.js"></script>
<!--#endif-->

<!--#if (GENERIC && !MINIFIED) -->
<!--#include viewer-snippet.html-->
<!--#endif-->

<!--#if !MINIFIED -->
<!--<script src="viewer.js"></script>-->
<!--#else-->
<!--#include viewer-snippet-minified.html-->
<!--#endif-->
<style>
.insertDataBox {
	position: absolute;
	width: 34%;
	top: 74%;
	right: 0;
	padding-right: 9%;
}

.insertBox_inner>* {
	display: block;
}

.insertBox_inner em+em {
	margin-top: 10px;
}

.userInfo {
	display: flex;
	justify-content: space-between;
	margin-top: 10px;
}

.userInfo img {
	width: 135px;
}

@media all and (max-width:560px) {
	.insertDataBox {
		width: 41%;
		top: 70%;
	}
	.insertBox_inner {
		scale: 0.6;
	}
	.insertBox_inner em {
		font-size: 10px;
		font-style: inherit;
		line-height: 1.3;
	}
	.textLayer {
		opacity: 1;
	}
	.userInfo img {
		width: 50px;
	}
}

a {
	text-decoration: none;
	vertical-align: top;
}

.btn_m {
	height: 46px;
	font-size: 15px;
	font-weight: 600;
	line-height: 46px;
	text-align: center;
}

.btn_ty02 {
	background: #e11f27;
	color: #fff;
	transition: all 0.4s;
	border-radius: 8px;
}

.btn_area a:only-child {
	display: block;
	width: calc(100% - 20px);
	margin: 0 10px;
}

.toolbar {
	display: none !important;
}

</style>
<script>

        const PDF_FILE_PATH = "/upload/temp/" + '${file.savFileNm}';
        let PDF_PAGES_COUNT;
        
        $(document).on('ready', function () {

            PDFViewerApplicationOptions.set('defaultUrl', PDF_FILE_PATH);

            // Wait for the PDFViewerApplication to initialize
            PDFViewerApplication.initializedPromise.then(function() {
                // Do whatever startup code you need to here, now that the EventBus
                // is read. For example:
                PDFViewerApplication.eventBus.on('pagerendered', function (e) {
                    console.log('pagerendered promise', arguments, PDFViewerApplication)
                    const {pageNumber} = arguments[0];
                    console.log(pageNumber)

                    if (pageNumber === 1) {
                        // var box_w = $(".page").css("width");
                        // var box_h = $(".page").css("height");
                        // console.log("box_w==" + box_w);
                        // console.log("box_h==" + box_h);
                        var encodingSigImg = '${user.signCanvasDataUrl}';
                        // var encodingSigImg64 = 'data:image/jpeg;base64,' + encodingSigImg
                        // $(".page:eq(0) .textLayer").append("<div class='insertDataBox' style='width:" + box_w + ";height:" + box_h + "'><div class='insertBox_inner'></div></div>")
                        $(".page:eq(0) .textLayer").append("<div class='insertDataBox'><div class='insertBox_inner'></div></div>")
                        //주민등록번호
                        $(".insertDataBox .insertBox_inner").append("<em class='socialNo'>${user.socialNo1}-${user.socialNo2}</em>")
                        //주소
                        $(".insertDataBox .insertBox_inner").append("<em class='address'>${user.address}</em>")
                        //계좌
                        $(".insertDataBox .insertBox_inner").append("<em class='bankAccount'>${user.bankName}/${user.bankAccountNo}</em>")
                        //성명 //사인 이미지
                        $(".insertDataBox .insertBox_inner").append("<div class='userInfo'><em class='userName'>${user.userNm}</em><img class='sign' src='" + encodingSigImg + "'/></div>")
                    }

                });

                PDFViewerApplication.eventBus.on("documentloaded", (e) => {
                    console.log("The document has now been loaded");
                    
                    console.log(PDFViewerApplication.pagesCount);
                    PDF_PAGES_COUNT = PDFViewerApplication.pagesCount;
                    

                });

                PDFViewerApplication.eventBus.on("pagechanging", (e) => {
                    console.log('pagechanging, from ' + e.previous + ' to ' + e.pageNumber);

                });

                PDFViewerApplication.eventBus.on("scalechanging", (e) => {
                    console.log('scalechanging, scale ' + e.scale);
                });

            });

        });

    </script>

</head>

<body tabindex="1">
	<div id="outerContainer">

		<div id="sidebarContainer">
			<div id="toolbarSidebar">
				<div id="toolbarSidebarLeft">
					<div id="sidebarViewButtons" class="splitToolbarButton toggled"
						role="radiogroup">
						<button id="viewThumbnail" class="toolbarButton toggled"
							title="Show Thumbnails" tabindex="2" data-l10n-id="thumbs"
							role="radio" aria-checked="true" aria-controls="thumbnailView">
							<span data-l10n-id="thumbs_label">Thumbnails</span>
						</button>
						<button id="viewOutline" class="toolbarButton"
							title="Show Document Outline (double-click to expand/collapse all items)"
							tabindex="3" data-l10n-id="document_outline" role="radio"
							aria-checked="false" aria-controls="outlineView">
							<span data-l10n-id="document_outline_label">Document
								Outline</span>
						</button>
						<button id="viewAttachments" class="toolbarButton"
							title="Show Attachments" tabindex="4" data-l10n-id="attachments"
							role="radio" aria-checked="false" aria-controls="attachmentsView">
							<span data-l10n-id="attachments_label">Attachments</span>
						</button>
						<button id="viewLayers" class="toolbarButton"
							title="Show Layers (double-click to reset all layers to the default state)"
							tabindex="5" data-l10n-id="layers" role="radio"
							aria-checked="false" aria-controls="layersView">
							<span data-l10n-id="layers_label">Layers</span>
						</button>
					</div>
				</div>

				<div id="toolbarSidebarRight">
					<div id="outlineOptionsContainer" class="hidden">
						<div class="verticalToolbarSeparator"></div>

						<button id="currentOutlineItem" class="toolbarButton"
							disabled="disabled" title="Find Current Outline Item"
							tabindex="6" data-l10n-id="current_outline_item">
							<span data-l10n-id="current_outline_item_label">Current
								Outline Item</span>
						</button>
					</div>
				</div>
			</div>
			<div id="sidebarContent">
				<div id="thumbnailView"></div>
				<div id="outlineView" class="hidden"></div>
				<div id="attachmentsView" class="hidden"></div>
				<div id="layersView" class="hidden"></div>
			</div>
			<div id="sidebarResizer"></div>
		</div>
		<!-- sidebarContainer -->

		<div id="mainContainer">
			<div class="findbar hidden doorHanger" id="findbar">
				<div id="findbarInputContainer">
					<input id="findInput" class="toolbarField" title="Find"
						placeholder="Find in document…" tabindex="91"
						data-l10n-id="find_input" aria-invalid="false">
					<div class="splitToolbarButton">
						<button id="findPrevious" class="toolbarButton"
							title="Find the previous occurrence of the phrase" tabindex="92"
							data-l10n-id="find_previous">
							<span data-l10n-id="find_previous_label">Previous</span>
						</button>
						<div class="splitToolbarButtonSeparator"></div>
						<button id="findNext" class="toolbarButton"
							title="Find the next occurrence of the phrase" tabindex="93"
							data-l10n-id="find_next">
							<span data-l10n-id="find_next_label">Next</span>
						</button>
					</div>
				</div>

				<div id="findbarOptionsOneContainer">
					<input type="checkbox" id="findHighlightAll" class="toolbarField"
						tabindex="94"> <label for="findHighlightAll"
						class="toolbarLabel" data-l10n-id="find_highlight">Highlight
						All</label> <input type="checkbox" id="findMatchCase" class="toolbarField"
						tabindex="95"> <label for="findMatchCase"
						class="toolbarLabel" data-l10n-id="find_match_case_label">Match
						Case</label>
				</div>
				<div id="findbarOptionsTwoContainer">
					<input type="checkbox" id="findMatchDiacritics"
						class="toolbarField" tabindex="96"> <label
						for="findMatchDiacritics" class="toolbarLabel"
						data-l10n-id="find_match_diacritics_label">Match
						Diacritics</label> <input type="checkbox" id="findEntireWord"
						class="toolbarField" tabindex="97"> <label
						for="findEntireWord" class="toolbarLabel"
						data-l10n-id="find_entire_word_label">Whole Words</label>
				</div>

				<div id="findbarMessageContainer" aria-live="polite">
					<span id="findResultsCount" class="toolbarLabel"></span> <span
						id="findMsg" class="toolbarLabel"></span>
				</div>
			</div>
			<!-- findbar -->

			<div class="editorParamsToolbar hidden doorHangerRight"
				id="editorFreeTextParamsToolbar">
				<div class="editorParamsToolbarContainer">
					<div class="editorParamsSetter">
						<label for="editorFreeTextColor" class="editorParamsLabel"
							data-l10n-id="editor_free_text_color">Color</label> <input
							type="color" id="editorFreeTextColor" class="editorParamsColor"
							tabindex="100">
					</div>
					<div class="editorParamsSetter">
						<label for="editorFreeTextFontSize" class="editorParamsLabel"
							data-l10n-id="editor_free_text_size">Size</label> <input
							type="range" id="editorFreeTextFontSize"
							class="editorParamsSlider" value="10" min="5" max="100" step="1"
							tabindex="101">
					</div>
				</div>
			</div>

			<div class="editorParamsToolbar hidden doorHangerRight"
				id="editorInkParamsToolbar">
				<div class="editorParamsToolbarContainer">
					<div class="editorParamsSetter">
						<label for="editorInkColor" class="editorParamsLabel"
							data-l10n-id="editor_ink_color">Color</label> <input type="color"
							id="editorInkColor" class="editorParamsColor" tabindex="102">
					</div>
					<div class="editorParamsSetter">
						<label for="editorInkThickness" class="editorParamsLabel"
							data-l10n-id="editor_ink_thickness">Thickness</label> <input
							type="range" id="editorInkThickness" class="editorParamsSlider"
							value="1" min="1" max="20" step="1" tabindex="103">
					</div>
					<div class="editorParamsSetter">
						<label for="editorInkOpacity" class="editorParamsLabel"
							data-l10n-id="editor_ink_opacity">Opacity</label> <input
							type="range" id="editorInkOpacity" class="editorParamsSlider"
							value="100" min="1" max="100" step="1" tabindex="104">
					</div>
				</div>
			</div>

			<div id="secondaryToolbar"
				class="secondaryToolbar hidden doorHangerRight">
				<div id="secondaryToolbarButtonContainer">
					<button id="secondaryPresentationMode"
						class="secondaryToolbarButton visibleLargeView"
						title="Switch to Presentation Mode" tabindex="51"
						data-l10n-id="presentation_mode">
						<span data-l10n-id="presentation_mode_label">Presentation
							Mode</span>
					</button>

					<!--#if GENERIC-->
					<button id="secondaryOpenFile"
						class="secondaryToolbarButton visibleLargeView" title="Open File"
						tabindex="52" data-l10n-id="open_file">
						<span data-l10n-id="open_file_label">Open</span>
					</button>
					<!--#endif-->

					<button id="secondaryPrint"
						class="secondaryToolbarButton visibleMediumView" title="Print"
						tabindex="53" data-l10n-id="print">
						<span data-l10n-id="print_label">Print</span>
					</button>

					<button id="secondaryDownload"
						class="secondaryToolbarButton visibleMediumView" title="Download"
						tabindex="54" data-l10n-id="download">
						<span data-l10n-id="download_label">Download</span>
					</button>

					<a href="#" id="secondaryViewBookmark"
						class="secondaryToolbarButton visibleSmallView"
						title="Current view (copy or open in new window)" tabindex="55"
						data-l10n-id="bookmark"> <span data-l10n-id="bookmark_label">Current
							View</span>
					</a>

					<div class="horizontalToolbarSeparator visibleLargeView"></div>

					<button id="firstPage" class="secondaryToolbarButton"
						title="Go to First Page" tabindex="56" data-l10n-id="first_page">
						<span data-l10n-id="first_page_label">Go to First Page</span>
					</button>
					<button id="lastPage" class="secondaryToolbarButton"
						title="Go to Last Page" tabindex="57" data-l10n-id="last_page">
						<span data-l10n-id="last_page_label">Go to Last Page</span>
					</button>

					<div class="horizontalToolbarSeparator"></div>

					<button id="pageRotateCw" class="secondaryToolbarButton"
						title="Rotate Clockwise" tabindex="58"
						data-l10n-id="page_rotate_cw">
						<span data-l10n-id="page_rotate_cw_label">Rotate Clockwise</span>
					</button>
					<button id="pageRotateCcw" class="secondaryToolbarButton"
						title="Rotate Counterclockwise" tabindex="59"
						data-l10n-id="page_rotate_ccw">
						<span data-l10n-id="page_rotate_ccw_label">Rotate
							Counterclockwise</span>
					</button>

					<div class="horizontalToolbarSeparator"></div>

					<div id="cursorToolButtons" role="radiogroup">
						<button id="cursorSelectTool"
							class="secondaryToolbarButton toggled"
							title="Enable Text Selection Tool" tabindex="60"
							data-l10n-id="cursor_text_select_tool" role="radio"
							aria-checked="true">
							<span data-l10n-id="cursor_text_select_tool_label">Text
								Selection Tool</span>
						</button>
						<button id="cursorHandTool" class="secondaryToolbarButton"
							title="Enable Hand Tool" tabindex="61"
							data-l10n-id="cursor_hand_tool" role="radio" aria-checked="false">
							<span data-l10n-id="cursor_hand_tool_label">Hand Tool</span>
						</button>
					</div>

					<div class="horizontalToolbarSeparator"></div>

					<div id="scrollModeButtons" role="radiogroup">
						<button id="scrollPage" class="secondaryToolbarButton"
							title="Use Page Scrolling" tabindex="62"
							data-l10n-id="scroll_page" role="radio" aria-checked="false">
							<span data-l10n-id="scroll_page_label">Page Scrolling</span>
						</button>
						<button id="scrollVertical" class="secondaryToolbarButton toggled"
							title="Use Vertical Scrolling" tabindex="63"
							data-l10n-id="scroll_vertical" role="radio" aria-checked="true">
							<span data-l10n-id="scroll_vertical_label">Vertical
								Scrolling</span>
						</button>
						<button id="scrollHorizontal" class="secondaryToolbarButton"
							title="Use Horizontal Scrolling" tabindex="64"
							data-l10n-id="scroll_horizontal" role="radio"
							aria-checked="false">
							<span data-l10n-id="scroll_horizontal_label">Horizontal
								Scrolling</span>
						</button>
						<button id="scrollWrapped" class="secondaryToolbarButton"
							title="Use Wrapped Scrolling" tabindex="65"
							data-l10n-id="scroll_wrapped" role="radio" aria-checked="false">
							<span data-l10n-id="scroll_wrapped_label">Wrapped
								Scrolling</span>
						</button>
					</div>

					<div class="horizontalToolbarSeparator"></div>

					<div id="spreadModeButtons" role="radiogroup">
						<button id="spreadNone" class="secondaryToolbarButton toggled"
							title="Do not join page spreads" tabindex="66"
							data-l10n-id="spread_none" role="radio" aria-checked="true">
							<span data-l10n-id="spread_none_label">No Spreads</span>
						</button>
						<button id="spreadOdd" class="secondaryToolbarButton"
							title="Join page spreads starting with odd-numbered pages"
							tabindex="67" data-l10n-id="spread_odd" role="radio"
							aria-checked="false">
							<span data-l10n-id="spread_odd_label">Odd Spreads</span>
						</button>
						<button id="spreadEven" class="secondaryToolbarButton"
							title="Join page spreads starting with even-numbered pages"
							tabindex="68" data-l10n-id="spread_even" role="radio"
							aria-checked="false">
							<span data-l10n-id="spread_even_label">Even Spreads</span>
						</button>
					</div>

					<div class="horizontalToolbarSeparator"></div>

					<button id="documentProperties" class="secondaryToolbarButton"
						title="Document Properties…" tabindex="69"
						data-l10n-id="document_properties"
						aria-controls="documentPropertiesDialog">
						<span data-l10n-id="document_properties_label">Document
							Properties…</span>
					</button>
				</div>
			</div>
			<!-- secondaryToolbar -->

			<div class="toolbar">
				<div id="toolbarContainer">
					<div id="toolbarViewer">
						<div id="toolbarViewerLeft">
							<button id="sidebarToggle" class="toolbarButton"
								title="Toggle Sidebar" tabindex="11"
								data-l10n-id="toggle_sidebar" aria-expanded="false"
								aria-controls="sidebarContainer">
								<span data-l10n-id="toggle_sidebar_label">Toggle Sidebar</span>
							</button>
							<div class="toolbarButtonSpacer"></div>
							<button id="viewFind" class="toolbarButton"
								title="Find in Document" tabindex="12" data-l10n-id="findbar"
								aria-expanded="false" aria-controls="findbar">
								<span data-l10n-id="findbar_label">Find</span>
							</button>
							<div class="splitToolbarButton hiddenSmallView">
								<button class="toolbarButton" title="Previous Page"
									id="previous" tabindex="13" data-l10n-id="previous">
									<span data-l10n-id="previous_label">Previous</span>
								</button>
								<div class="splitToolbarButtonSeparator"></div>
								<button class="toolbarButton" title="Next Page" id="next"
									tabindex="14" data-l10n-id="next">
									<span data-l10n-id="next_label">Next</span>
								</button>
							</div>
							<input type="number" id="pageNumber" class="toolbarField"
								title="Page" value="1" size="4" min="1" tabindex="15"
								data-l10n-id="page" autocomplete="off"> <span
								id="numPages" class="toolbarLabel"></span>
						</div>
						<div id="toolbarViewerRight">
							<button id="presentationMode"
								class="toolbarButton hiddenLargeView"
								title="Switch to Presentation Mode" tabindex="31"
								data-l10n-id="presentation_mode">
								<span data-l10n-id="presentation_mode_label">Presentation
									Mode</span>
							</button>

							<!--#if GENERIC-->
							<button id="openFile" class="toolbarButton hiddenLargeView"
								title="Open File" tabindex="32" data-l10n-id="open_file">
								<span data-l10n-id="open_file_label">Open</span>
							</button>
							<!--#endif-->

							<button id="print" class="toolbarButton hiddenMediumView"
								title="Print" tabindex="33" data-l10n-id="print">
								<span data-l10n-id="print_label">Print</span>
							</button>

							<button id="download" class="toolbarButton hiddenMediumView"
								title="Download" tabindex="34" data-l10n-id="download">
								<span data-l10n-id="download_label">Download</span>
							</button>
							<a href="#" id="viewBookmark"
								class="toolbarButton hiddenSmallView"
								title="Current view (copy or open in new window)" tabindex="35"
								data-l10n-id="bookmark"> <span data-l10n-id="bookmark_label">Current
									View</span>
							</a>

							<div class="verticalToolbarSeparator hiddenSmallView"></div>

							<div id="editorModeButtons"
								class="splitToolbarButton toggled hidden" role="radiogroup">
								<button id="editorFreeText" class="toolbarButton"
									disabled="disabled" title="Add FreeText Annotation"
									role="radio" aria-checked="false" tabindex="36"
									data-l10n-id="editor_free_text">
									<span data-l10n-id="editor_free_text_label">FreeText
										Annotation</span>
								</button>
								<button id="editorInk" class="toolbarButton" disabled="disabled"
									title="Add Ink Annotation" role="radio" aria-checked="false"
									tabindex="37" data-l10n-id="editor_ink">
									<span data-l10n-id="editor_ink_label">Ink Annotation</span>
								</button>
							</div>

							<!-- Should be visible when the "editorModeButtons" are visible. -->
							<div id="editorModeSeparator"
								class="verticalToolbarSeparator hidden"></div>

							<button id="secondaryToolbarToggle" class="toolbarButton"
								title="Tools" tabindex="48" data-l10n-id="tools"
								aria-expanded="false" aria-controls="secondaryToolbar">
								<span data-l10n-id="tools_label">Tools</span>
							</button>
						</div>
						<div id="toolbarViewerMiddle">
							<div class="splitToolbarButton">
								<button id="zoomOut" class="toolbarButton" title="Zoom Out"
									tabindex="21" data-l10n-id="zoom_out">
									<span data-l10n-id="zoom_out_label">Zoom Out</span>
								</button>
								<div class="splitToolbarButtonSeparator"></div>
								<button id="zoomIn" class="toolbarButton" title="Zoom In"
									tabindex="22" data-l10n-id="zoom_in">
									<span data-l10n-id="zoom_in_label">Zoom In</span>
								</button>
							</div>
							<span id="scaleSelectContainer" class="dropdownToolbarButton">
								<select id="scaleSelect" title="Zoom" tabindex="23"
								data-l10n-id="zoom">
									<option id="pageAutoOption" title="" value="auto"
										selected="selected" data-l10n-id="page_scale_auto">Automatic
										Zoom</option>
									<option id="pageActualOption" title="" value="page-actual"
										data-l10n-id="page_scale_actual">Actual Size</option>
									<option id="pageFitOption" title="" value="page-fit"
										data-l10n-id="page_scale_fit">Page Fit</option>
									<option id="pageWidthOption" title="" value="page-width"
										data-l10n-id="page_scale_width">Page Width</option>
									<option id="customScaleOption" title="" value="custom"
										disabled="disabled" hidden="true"></option>
									<option title="" value="0.5" data-l10n-id="page_scale_percent"
										data-l10n-args='{ "scale": 50 }'>50%</option>
									<option title="" value="0.75" data-l10n-id="page_scale_percent"
										data-l10n-args='{ "scale": 75 }'>75%</option>
									<option title="" value="1" data-l10n-id="page_scale_percent"
										data-l10n-args='{ "scale": 100 }'>100%</option>
									<option title="" value="1.25" data-l10n-id="page_scale_percent"
										data-l10n-args='{ "scale": 125 }'>125%</option>
									<option title="" value="1.5" data-l10n-id="page_scale_percent"
										data-l10n-args='{ "scale": 150 }'>150%</option>
									<option title="" value="2" data-l10n-id="page_scale_percent"
										data-l10n-args='{ "scale": 200 }'>200%</option>
									<option title="" value="3" data-l10n-id="page_scale_percent"
										data-l10n-args='{ "scale": 300 }'>300%</option>
									<option title="" value="4" data-l10n-id="page_scale_percent"
										data-l10n-args='{ "scale": 400 }'>400%</option>
							</select>
							</span>
						</div>
					</div>
					<div id="loadingBar">
						<div class="progress">
							<div class="glimmer"></div>
						</div>
					</div>
				</div>
			</div>

			<div id="viewerContainer" tabindex="0">
				<div id="viewer" class="pdfViewer"></div>
			</div>

			<!--#if !MOZCENTRAL-->
			<div id="errorWrapper" hidden='true'>
				<div id="errorMessageLeft">
					<span id="errorMessage"></span>
					<button id="errorShowMore" data-l10n-id="error_more_info">
						More Information</button>
					<button id="errorShowLess" data-l10n-id="error_less_info"
						hidden='true'>Less Information</button>
				</div>
				<div id="errorMessageRight">
					<button id="errorClose" data-l10n-id="error_close">Close</button>
				</div>
				<div id="errorSpacer"></div>
				<textarea id="errorMoreInfo" hidden='true' readonly="readonly"></textarea>
			</div>
			<!--#endif-->
		</div>
		<!-- mainContainer -->

		<div id="dialogContainer">
			<dialog id="passwordDialog">
			<div class="row">
				<label for="password" id="passwordText"
					data-l10n-id="password_label">Enter the password to open
					this PDF file:</label>
			</div>
			<div class="row">
				<input type="password" id="password" class="toolbarField">
			</div>
			<div class="buttonRow">
				<button id="passwordCancel" class="dialogButton">
					<span data-l10n-id="password_cancel">Cancel</span>
				</button>
				<button id="passwordSubmit" class="dialogButton">
					<span data-l10n-id="password_ok">OK</span>
				</button>
			</div>
			</dialog>
			<dialog id="documentPropertiesDialog">
			<div class="row">
				<span id="fileNameLabel"
					data-l10n-id="document_properties_file_name">File name:</span>
				<p id="fileNameField" aria-labelledby="fileNameLabel">-</p>
			</div>
			<div class="row">
				<span id="fileSizeLabel"
					data-l10n-id="document_properties_file_size">File size:</span>
				<p id="fileSizeField" aria-labelledby="fileSizeLabel">-</p>
			</div>
			<div class="separator"></div>
			<div class="row">
				<span id="titleLabel" data-l10n-id="document_properties_title">Title:</span>
				<p id="titleField" aria-labelledby="titleLabel">-</p>
			</div>
			<div class="row">
				<span id="authorLabel" data-l10n-id="document_properties_author">Author:</span>
				<p id="authorField" aria-labelledby="authorLabel">-</p>
			</div>
			<div class="row">
				<span id="subjectLabel" data-l10n-id="document_properties_subject">Subject:</span>
				<p id="subjectField" aria-labelledby="subjectLabel">-</p>
			</div>
			<div class="row">
				<span id="keywordsLabel" data-l10n-id="document_properties_keywords">Keywords:</span>
				<p id="keywordsField" aria-labelledby="keywordsLabel">-</p>
			</div>
			<div class="row">
				<span id="creationDateLabel"
					data-l10n-id="document_properties_creation_date">Creation
					Date:</span>
				<p id="creationDateField" aria-labelledby="creationDateLabel">-</p>
			</div>
			<div class="row">
				<span id="modificationDateLabel"
					data-l10n-id="document_properties_modification_date">Modification
					Date:</span>
				<p id="modificationDateField"
					aria-labelledby="modificationDateLabel">-</p>
			</div>
			<div class="row">
				<span id="creatorLabel" data-l10n-id="document_properties_creator">Creator:</span>
				<p id="creatorField" aria-labelledby="creatorLabel">-</p>
			</div>
			<div class="separator"></div>
			<div class="row">
				<span id="producerLabel" data-l10n-id="document_properties_producer">PDF
					Producer:</span>
				<p id="producerField" aria-labelledby="producerLabel">-</p>
			</div>
			<div class="row">
				<span id="versionLabel" data-l10n-id="document_properties_version">PDF
					Version:</span>
				<p id="versionField" aria-labelledby="versionLabel">-</p>
			</div>
			<div class="row">
				<span id="pageCountLabel"
					data-l10n-id="document_properties_page_count">Page Count:</span>
				<p id="pageCountField" aria-labelledby="pageCountLabel">-</p>
			</div>
			<div class="row">
				<span id="pageSizeLabel"
					data-l10n-id="document_properties_page_size">Page Size:</span>
				<p id="pageSizeField" aria-labelledby="pageSizeLabel">-</p>
			</div>
			<div class="separator"></div>
			<div class="row">
				<span id="linearizedLabel"
					data-l10n-id="document_properties_linearized">Fast Web View:</span>
				<p id="linearizedField" aria-labelledby="linearizedLabel">-</p>
			</div>
			<div class="buttonRow">
				<button id="documentPropertiesClose" class="dialogButton">
					<span data-l10n-id="document_properties_close">Close</span>
				</button>
			</div>
			</dialog>
			<!--#if !MOZCENTRAL-->
			<dialog id="printServiceDialog" style="min-width: 200px;">
			<div class="row">
				<span data-l10n-id="print_progress_message">Preparing
					document for printing…</span>
			</div>
			<div class="row">
				<progress value="0" max="100"></progress>
				<span data-l10n-id="print_progress_percent"
					data-l10n-args='{ "progress": 0 }' class="relative-progress">0%</span>
			</div>
			<div class="buttonRow">
				<button id="printCancel" class="dialogButton">
					<span data-l10n-id="print_progress_close">Cancel</span>
				</button>
			</div>
			</dialog>
			<!--#endif-->
			<!--#if CHROME-->
			<!--#include viewer-snippet-chrome-overlays.html-->
			<!--#endif-->
		</div>
		<!-- dialogContainer -->

	</div>
	<!-- outerContainer -->
	<div id="printContainer"></div>

	<!--#if GENERIC-->
	<input type="file" id="fileInput" class="hidden">
	<!--#endif-->

	<footer>
		<div class="btn_area">
			<a href="javascript:" id="nextBtn" class="btn_m btn_ty02">다음</a>
		</div>
	</footer>
</body>
<script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/jspdf/1.5.3/jspdf.min.js"></script>
<script type="text/javascript" src="https://html2canvas.hertzen.com/dist/html2canvas.min.js"></script>
<script>
	$(document).on('ready', function(){
		
		$("#nextBtn").on('click', function(){
			
			 createPdf ();
			 
		});
			
	});
	
	function createPdf (){
        //pdf_wrap을 canvas객체로 변환
        console.log("PDF_PAGES_COUNT ==" + PDF_PAGES_COUNT);
        
        var doc = new jsPDF('p', 'mm', 'a4'); //jspdf객체 생성
        var imgWidth = doc.internal.pageSize.getWidth();
        var pageHeight = doc.internal.pageSize.getHeight();

        var mkpdfCount = 0;
        while (mkpdfCount < PDF_PAGES_COUNT) {
            var pdfPageX = 0;
            //시점차이 발생으로 변수 선언 html2canvas 로딩이 오래걸려서 while 먼저 돌고 canvas가 나중에 생성됨
            console.log("mkpdfCount==" + mkpdfCount);
            
            html2canvas($('.page')[mkpdfCount]).then(function (canvas) {
                console.log(canvas)
                console.log("pdfPageX==" + pdfPageX);
                var imgData = canvas.toDataURL('image/png'); //캔버스를 이미지로 변환
                
                if (pdfPageX < PDF_PAGES_COUNT) {
                    doc.addImage(imgData, 'PNG', 0, 0, null, null, null, 'fast'); //이미지를 기반으로 pdf생성 , imgWidth, pageHeight
//				doc.addPage();
                }

                //마지막장
                if ((pdfPageX + 1) == PDF_PAGES_COUNT) {
                    var pdf = doc.output("datauristring");
                    var base64 = "base64,";
                    var idx = pdf.indexOf(base64) + base64.length;
                    pdf = pdf.substring(idx);
                    $.ajax({
                        method: "POST",
                        url: "/sign/pdf/createPdfUpload",
                        data: {
                            'base64File' : pdf
                        },
                    }).done(function (data) {
                    	if(data.result === 'SUCCESS'){
                    		location.href = '/sign/attach'	
                    	} else {
                    		alert(data.message);
                    		location.reload();
                    	}
                        
                    });
                } else {
                    doc.addPage();
                }
                pdfPageX++;
            })
            mkpdfCount++;
        }
    };
</script>
</html>