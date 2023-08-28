// exported global methods:
var getViewerOptions, configureViewerUI;

(function () {
    // Graphical signature locations.
    // Note that the { x, y } origin is at the bottom left.
    var graphicalSignatureLocationsBottomLeft = {
        // The key is the name of the PDF file in lower case without extension.
        "tsoft_form_sign": [
            { pageIndex: 0, x: 187, y: 200, w: 80, h: 20, title: "Buyer1" },
            { pageIndex: 0, x: 480, y: 200, w: 80, h: 20, title: "Seller1", color: "#1234dd" },           
        ]
    };

    // Parameters for the "sign date" labels
    const signDateLabelParams = {
        // x offset from the position of the graphical signature
        offset_x: 70,
        // y offset from the position of the graphical signature
        offset_y: 0,
        // label width
        w: 58,
        // label height
        h: 14
    }
    
    getViewerOptions = function getViewerOptions() {
        return {        	
            supportApi: {
                apiUrl: "http://localhost:5004/api/pdf-viewer",  // e.g. "http://localhost:5004/api/pdf-viewer";
                token: "support-api-demo-net-core-token-2021", // e.g. "support-api-demo-net-core-token";
                webSocketUrl: false
            },
            restoreViewStateOnLoad: false
        };
    }

    configureViewerUI = function (viewer) {

//        viewer.addDefaultPanels();
//        viewer.addAnnotationEditorPanel();
//        viewer.addFormEditorPanel();
        viewer.onAfterOpen.register(function () {
            populateSignature(viewer);
        });
    }

    async function populateSignature(viewer) {
        viewer.__onSignatureLinkEvent = onSignatureLinkEvent;
        const locationsBottomLeft = graphicalSignatureLocationsBottomLeft[viewer.fileName.toLowerCase().replace(".pdf", "")];
        if (locationsBottomLeft) {
            for (let i = 0; i < locationsBottomLeft.length; i++) {
                const locationInfo = locationsBottomLeft[i];
                const pageIndex = parseInt(locationInfo.pageIndex);
                const signTitle = locationInfo.title;

                const rect = [locationInfo.x, locationInfo.y, locationInfo.x + locationInfo.w, locationInfo.y + locationInfo.h];
                const signUiId = "signui_" + i;

                const freeTextLabel = {
                    annotationType: 3, // AnnotationTypeCode.FREETEXT
                    subject: signUiId,
                    borderStyle: { width: 1, style: 2 },
                    fontSize: 6,
                    appearanceColor: "#fff59d",
                    color: locationInfo.color || "#f44336",
                    contents: "Sign Here",
                    textAlignment: 1,
                    rect: [rect[0], rect[3] - 12, rect[0] + 35, rect[3]]
                };
                await viewer.addAnnotation(pageIndex, freeTextLabel, { skipPageRefresh: true });
                const viewerSelector = "#" + viewer.hostElement.id;
                const linkAnnotation = {
                    annotationType: 2, // AnnotationTypeCode.LINK
                    subject: signUiId,
                    linkType: "js",
                    borderStyle: { width: 0, style: 5 },
                    color: "#2196f3",
                    jsAction: `if(app.viewerType == 'GcPdfViewer') {
					var viewer = GcPdfViewer.findControl("${viewerSelector}");
					viewer.__onSignatureLinkEvent(viewer, ${pageIndex}, "${signTitle}", "${signUiId}", ${rect[0]}, ${rect[1]}, ${(rect[2] - rect[0])}, ${(rect[3] - rect[1])});
				}`,
                    rect: rect,
                    title: signTitle
                };
                await viewer.addAnnotation(pageIndex, linkAnnotation, { skipPageRefresh: true });

            }
            viewer.repaint();
        }
    }

    function onSignatureLinkEvent(viewer, pageIndex, signTitle, signId, x, y, w, h) {
        viewer.showSignTool({
            subject: "AddGraphicalSignature", tabs: ["Type", "Draw","Image"],
            dialogLocation: "center",
            pageIndex: pageIndex,
            title: signTitle,
            location: { x: x, y: y },
            canvasSize: { width: w * 5, height: h * 5 },
            destinationScale: 1 / 5,
            convertToContent: true,
            afterAdd: function (result) {
                // remove current Sign UI and scroll to next one:
                removeSignature(viewer, signId).then(function () {
                    viewer.addAnnotation(pageIndex, {
                        annotationType: 3, borderStyle: { width: 0 },
                        fontSize: 10, contents: new Date().toLocaleDateString("en-US"),
                        rect: [x + signDateLabelParams.offset_x, y + signDateLabelParams.offset_y, x + signDateLabelParams.offset_x + signDateLabelParams.w, y + signDateLabelParams.offset_y + signDateLabelParams.h],
                        convertToContent: true
                    },
                        { skipPageRefresh: false }).then(function () {
                            scrollToNextSignature(viewer, signTitle);
                        });
                });
            }
        });
    }

    async function removeSignature(viewer, signId) {
        const annotations = await viewer.findAnnotations(signId, { findField: "subject", findAll: true });
        for (let data of annotations) {
            await viewer.removeAnnotation(data.pageIndex, data.annotation.id);
        }
    };

    async function scrollToNextSignature(viewer, signTitle) {
        const linkAnnotations = await viewer.findAnnotations(2, { findField: "annotationType", findAll: true });
        const data = linkAnnotations.find((el) => el.annotation.title === signTitle) || linkAnnotations[0];
        if(data) {
          viewer.scrollAnnotationIntoView(data.pageIndex, data.annotation, "smooth");        
        } else {
            alert("The document is fully signed.");
        }
    }

})();