package kr.co.tsoft.sign.util;

import com.itextpdf.text.Document;
import com.itextpdf.text.DocumentException;
import com.itextpdf.text.pdf.PdfWriter;
import com.itextpdf.tool.xml.XMLWorker;
import com.itextpdf.tool.xml.XMLWorkerFontProvider;
import com.itextpdf.tool.xml.XMLWorkerHelper;
import com.itextpdf.tool.xml.css.CssFile;
import com.itextpdf.tool.xml.css.StyleAttrCSSResolver;
import com.itextpdf.tool.xml.html.CssAppliers;
import com.itextpdf.tool.xml.html.CssAppliersImpl;
import com.itextpdf.tool.xml.html.Tags;
import com.itextpdf.tool.xml.net.FileRetrieve;
import com.itextpdf.tool.xml.net.FileRetrieveImpl;
import com.itextpdf.tool.xml.parser.XMLParser;
import com.itextpdf.tool.xml.pipeline.css.CSSResolver;
import com.itextpdf.tool.xml.pipeline.css.CssResolverPipeline;
import com.itextpdf.tool.xml.pipeline.end.PdfWriterPipeline;
import com.itextpdf.tool.xml.pipeline.html.AbstractImageProvider;
import com.itextpdf.tool.xml.pipeline.html.HtmlPipeline;
import com.itextpdf.tool.xml.pipeline.html.HtmlPipelineContext;
import com.itextpdf.tool.xml.pipeline.html.LinkProvider;
import kr.co.tsoft.sign.service.ComService;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Component;

import java.io.*;
import java.nio.charset.Charset;
import java.util.HashMap;
import java.util.Iterator;
import java.util.LinkedList;

/**
 * create PDF in java
 *
 * @author george.mavrommatis
 */
@Component
public class ConvertHtmlToPdf {
    public static final String HTML = "src/main/webapp/pdf/template01.html";
    public static final String IMG_PATH = "../image";
    public static final String RELATIVE_PATH = "raw";
    public static final String CSS_DIR = "src/main/webapp/pdf/css/";
    private static final Logger logger = LoggerFactory.getLogger(ConvertHtmlToPdf.class);
    private static String OWNER_PASSWORD = "naveen";
    @Value("${config.upload.dir}")
    String uploadDir;
    @Value("${spring.profiles.active}")
    private String active;
    @Autowired
    private ComService comService;

    /**
     * @param args the command line arguments
     */
    public static void main(String[] args) throws IOException, DocumentException {
//        new ConvertHtmlToPdf().createPdf(DEST);
    }

    /**
     * Creates a PDF with the words "Hello World"
     *
     * @param file
     * @throws IOException
     * @throws DocumentException
     */
    public HashMap<String, Object> createPdf(String contrcNo, LinkedList<HashMap<String, String>> selectHistList) throws Exception {
        // step 1
        Document document = new Document();
        //계약번호에 해당하는 폴더 생성
        String path = mkdir(contrcNo);
        // 결과 path + 파일명
        SecurityUtil su = new SecurityUtil();

        String fileNm = "(추적표)" + su.getSignUserDetails().getUserNm() + "_" + contrcNo + ".pdf";
        // step 2
        PdfWriter writer = PdfWriter.getInstance(document, new BufferedOutputStream(new FileOutputStream(path + File.separatorChar + fileNm)));
        String userPassword = su.getSignUserDetails().getInResidentNo().substring(0, 6);//암호화 될 비번(주민번호 앞 6자리)
        logger.info(" ==- pdf password : " + userPassword);
        writer.setEncryption(userPassword.getBytes(), OWNER_PASSWORD.getBytes(), PdfWriter.ALLOW_PRINTING, PdfWriter.ENCRYPTION_AES_128);
        //암호화
        // step 3
        document.open();
        // step 4

        // CSS
        CSSResolver cssResolver = new StyleAttrCSSResolver();
        CssFile cssBase = XMLWorkerHelper.getCSS(new FileInputStream(CSS_DIR + "base.css"));
        CssFile cssCommon = XMLWorkerHelper.getCSS(new FileInputStream(CSS_DIR + "common.css"));
        CssFile cssContents = XMLWorkerHelper.getCSS(new FileInputStream(CSS_DIR + "contents.css"));

        cssResolver.addCss(cssBase);
        cssResolver.addCss(cssCommon);
        cssResolver.addCss(cssContents);

        XMLWorkerFontProvider fontProvider = new XMLWorkerFontProvider(XMLWorkerFontProvider.DONTLOOKFORFONTS);
//		fontProvider.registerDirectory("C:\\Users\\TSOFT01\\Documents\\workspace-spring-tool-suite-4-4.7.1.RELEASE\\sign\\font");
        fontProvider.register("src/main/webapp/font/NanumGothic-Regular.ttf", "NanumGothic");
        CssAppliers cssAppliers = new CssAppliersImpl(fontProvider);

        HtmlPipelineContext htmlContext = new HtmlPipelineContext(cssAppliers);
        //CSSResolver cssResolver =  XMLWorkerHelper.getInstance().getDefaultCssResolver(false);
        FileRetrieve retrieve = new FileRetrieveImpl(CSS_DIR);
        cssResolver.setFileRetrieve(retrieve);

        // HTML
        //HtmlPipelineContext htmlContext = new HtmlPipelineContext(null);
        htmlContext.setTagFactory(Tags.getHtmlTagProcessorFactory());
        htmlContext.setImageProvider(new AbstractImageProvider() {
            public String getImageRootPath() {
                return IMG_PATH;
            }
        });
        htmlContext.setLinkProvider(new LinkProvider() {
            public String getLinkRoot() {
                return RELATIVE_PATH;
            }
        });

        // Pipelines
        PdfWriterPipeline pdf = new PdfWriterPipeline(document, writer);
        HtmlPipeline html = new HtmlPipeline(htmlContext, pdf);
        CssResolverPipeline css = new CssResolverPipeline(cssResolver, html);

        // XML Worker
        XMLWorker worker = new XMLWorker(css, true);
        XMLParser xmlParser = new XMLParser(worker, Charset.forName("UTF-8"));
//        xmlParser.parse(new FileInputStream(HTML));
        if (selectHistList != null) {
            Iterator<HashMap<String, String>> iterator = selectHistList.iterator();
            int listSize = selectHistList.size();
            int first = 0;
            String htmlStr = "<table><tbody>";
            htmlStr += "<tr><td colspan='3' style='font-size:20px;font-weight:bold;height:60px'>계 약 추 적 표</td></tr>";
            htmlStr += "<tr><td rowspan='5' style='width:160px'>일반사항</td><td style='width:180px'>계약명</td><td class='textleft'>계약명~~</td></tr>";
            htmlStr += "<tr><td>계약번호</td><td class='textleft'>" + su.getSignUserDetails().getContractNo() + "</td></tr>";
            htmlStr += "<tr><td>기준시간</td><td class='textleft'></td></tr>";
            htmlStr += "<tr><td>페이지수</td><td class='textleft'>3</td></tr>";
            htmlStr += "<tr><td>계약일자</td><td class='textleft'>" + su.getSignUserDetails().getInSignDate() + "</td></tr>";

            htmlStr += "<tr><td rowspan='2'>계약자</td><td>위임인</td>"
                    + "<td class='textleft'>상호명 : 티소프트<br/>"
                    + "대표번호 : 1800-8467<br/>"
                    + "이메일 : info@tsoft.co.kr</td></tr>";
//	        htmlStr += "<tr><td>대표번호 : 1800-8467</td></tr>";
//	        htmlStr += "<tr><td>이메일 : info@tsoft.co.kr</td></tr>";

            htmlStr += "<tr><td>수임인</td>"
                    + "<td id='signImg' class='textleft'>성명 : " + su.getSignUserDetails().getUserNm() + "<br/>"
                    + "주민등록번호 : " + su.getSignUserDetails().getInResidentNo() + "<br/>"
                    + "계좌 : (" + su.getSignUserDetails().getInBankNm() + ")" + su.getSignUserDetails().getInAccountNo() + ""
                    + "<img src='D:\\git\\workspace\\tsign\\src\\main\\webapp\\upload\\temp\\testSignImg.png'/></td></tr>";
//	        htmlStr += "<tr><td>주민등록번호 : "+su.getSignUserDetails().getInResidentNo()+"</td></tr>";
//	        htmlStr += "<tr><td>계좌 : ("+ su.getSignUserDetails().getInBankNm() +")"+ su.getSignUserDetails().getInAccountNo()+" "
//	        		+ "	<image src='C:\\Users\\TSOFT01\\Documents\\workspace-spring-tool-suite-4-4.7.1.RELEASE\\sign\\src\\main\\webapp\\upload\\temp\\testSignImg.png'/></td></tr>";

            while (iterator.hasNext()) {
                HashMap<String, String> item = iterator.next();
                htmlStr += "<tr>";
                if (first == 0) {
                    htmlStr += "<td rowspan='" + listSize + "'>진행이력</td>";
                    first++;
                } else {
                }
                htmlStr += "<td>" + item.get("time") + "</td>";
                htmlStr += "<td class='textleft'>" + item.get("log") + "</td>";
                htmlStr += "</tr>";
            }
            htmlStr += "</tbody></table>";
            System.out.println(htmlStr);

            StringReader histListHtml = new StringReader(htmlStr);
            xmlParser.parse(histListHtml);
        }
        // step 5
        document.close();
        //자원사용종료
        writer.close();

        HashMap<String, String> fileInfo = new HashMap<String, String>();
        fileInfo.put("CONTRC_NO", contrcNo);
        fileInfo.put("FILE_TP", "103");
        fileInfo.put("ORG_FILE_NM", fileNm);
        fileInfo.put("SAV_FILE_NM", fileNm);
        fileInfo.put("FILE_PATH", path);
        fileInfo.put("user", contrcNo);
        fileInfo.put("user", contrcNo);

        HashMap<String, Object> result = new HashMap<String, Object>();
        // db에 파일 저장 위치 저장
        if (comService.insertFileUpload(fileInfo) > 0) {
            result.put("message", "계약서를 전송하였습니다.");
        } else {
            result.put("message", "계약서를 전송에 실패하였습니다.");
        }
        ;

        return result;
    }

    private String mkdir(String ContrcNo) {
        String path = uploadDir + File.separatorChar + ContrcNo; //폴더 경로
        File Folder = new File(path);

        // 해당 디렉토리가 없을경우 디렉토리를 생성합니다.
        if (!Folder.exists()) {
            try {
                Folder.mkdir(); //폴더 생성합니다.
                System.out.println("폴더가 생성되었습니다.");
            } catch (Exception e) {
                e.getStackTrace();
            }
        } else {
            System.out.println("이미 폴더가 생성되어 있습니다.");
        }
        return path;
    }


    public void test() {
        // TODO Auto-generated method stub
        logger.info("test => uploadDir : " + uploadDir);
        logger.info("return => " + mkdir("contrcNo"));
    }


}
