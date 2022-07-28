/**
 * Copyright 2016 Google Inc.
 * <p>
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 * <p>
 * http://www.apache.org/licenses/LICENSE-2.0
 * <p>
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

package kr.co.tsoft.sign.util;

import javax.activation.DataHandler;
import javax.activation.DataSource;
import javax.activation.FileDataSource;
import javax.mail.*;
import javax.mail.internet.*;
import java.io.File;
import java.util.ArrayList;
import java.util.Iterator;
import java.util.Properties;
// [END multipart_includes]

//시작함수는 아래쪽에 있습니다.
public class MailHandler {

    public void send(String toMail, String title, String content, ArrayList<String> attachFileName) {

        String mailProtocol = "smtp";
        String mailHost = "smtp.gmail.com";
        String mailPort = "587";
        Boolean debugMode = false;
        String authMode = "true";

        try {
            /*
             * //메일 환경 변수 설정입니다. Properties props = new Properties(); //메일 프로토콜은 gmail를 이용할
             * 것이기 때문에 smtp로 사용합니다. props.setProperty("mail.transport.protocol", "smtp");
             * //메일 호스트 주소를 설정합니다. props.setProperty("mail.host", "smtp.gmail.com"); //ID,
             * Password 설정이 필요합니다. props.put("mail.smtp.auth", "true"); //port는 465입니다.
             * props.put("mail.smtp.port", "465");
             */
            Properties mailProps = new Properties();

            mailProps.put("mail.smtp.starttls.enable", "true");

            mailProps.setProperty("mail.transport.protocol", mailProtocol);

            mailProps.put("mail.debug", debugMode);

            mailProps.put("mail.smtp.host", mailHost);

            mailProps.put("mail.smtp.port", mailPort);

            mailProps.put("mail.smtp.connectiontimeout", "5000");

            mailProps.put("mail.smtp.timeout", "5000");

            mailProps.put("mail.smtp.auth", authMode);
            //ssl를 사용할 경우 설정합니다.
            //		props.put("mail.smtp.socketFactory.port", "465");
            //		props.put("mail.smtp.socketFactory.class", "javax.net.ssl.SSLSocketFactory");
            //		props.put("mail.smtp.socketFactory.fallback", "false");
            //		props.setProperty("mail.smtp.quitwait", "false");

            //id와 password를 설정하고 session을 생성합니다.
            Session session = Session.getInstance(mailProps, new Authenticator() {
                protected PasswordAuthentication getPasswordAuthentication() {
                    return new PasswordAuthentication("woojung4554@gmail.com", "@Dnwjd3233");
                }
            });
            //디버그 모드입니다.
            session.setDebug(debugMode);
            //메일 메시지를 만들기 위한 클래스를 생성합니다.
            MimeMessage message = new MimeMessage(session);
            //송신자 설정
            message.setFrom(getAddress("woojung4554@gmail.com"));
            //수신자 설정
            message.addRecipients(Message.RecipientType.TO, getAddresses(toMail));
            //참조 수신자 설정
//			message.addRecipients(Message.RecipientType.CC, getAddresses("nowonbun@gmail.com"));
            //숨은 참조 수신자 설정
//			message.addRecipients(Message.RecipientType.BCC, getAddresses("nowonbun@gmail.com"));
            //메일 제목을 설정합니다.
            message.setSubject(title);
            //메일 내용을 설정을 위한 클래스를 설정합니다.
            message.setContent(new MimeMultipart());
            //메일 내용을 위한 Multipart클래스를 받아온다. (위 new MimeMultipart()로 넣은 클래스입니다.)
            Multipart mp = (Multipart) message.getContent();
            //html 형식으로 본문을 작성해서 바운더리에 넣습니다.
//			mp.addBodyPart(getContents("<html><head></head><body><p>(주)티소프트 전자계약이 완료 완료되었습니다.</p><br><img src='cid:image1' ></body></html>"));
            mp.addBodyPart(getContents(content));
            //첨부 파일을 추가합니다.
            if (attachFileName != null) {
                Iterator<String> iterator = attachFileName.iterator();
                while (iterator.hasNext()) {
                    mp.addBodyPart(getFileAttachment(iterator.next()));
                }
            }
//			mp.addBodyPart(getFileAttachment("D:/result1.pdf"));
            //추적표
//			mp.addBodyPart(getFileAttachment("D:/result2.pdf"));
            //첨부 이미지 파일을 추가해서 contextId를 설정합니다. contextId는 위 본문 내용의 cid로 링크가 설정 가능합니다.
//			mp.addBodyPart(getImage("C:/Users/TSOFT01/eclipse-workspace/cmi_pdf/src/main/webapp/upload/form/testSignImg.png", "image1"));
            //메일을 보냅니다.
            Transport.send(message);
        } catch (Throwable e) {
            e.printStackTrace();
        }
    }


    //이미지를 로컬로 부터 읽어와서 BodyPart 클래스로 만든다. (바운더리 변환)
    private BodyPart getImage(String filename, String contextId) throws MessagingException {
        //파일을 읽어와서 BodyPart 클래스로 받는다.
        BodyPart mbp = getFileAttachment(filename);
        if (contextId != null) {
            //ContextId 설정
            mbp.setHeader("Content-ID", "<" + contextId + ">");
        }
        return mbp;
    }

    //파일을 로컬로 부터 읽어와서 BodyPart 클래스로 만든다. (바운더리 변환)
    private BodyPart getFileAttachment(String filename) throws MessagingException {
        //BodyPart 생성
        BodyPart mbp = new MimeBodyPart();
        //파일 읽어서 BodyPart에 설정(바운더리 변환)
        File file = new File(filename);
        DataSource source = new FileDataSource(file);
        mbp.setDataHandler(new DataHandler(source));
        mbp.setDisposition(Part.ATTACHMENT);
        mbp.setFileName(file.getName());
        return mbp;
    }

    //메일의 본문 내용 설정
    private BodyPart getContents(String html) throws MessagingException {
        BodyPart mbp = new MimeBodyPart();
        //setText를 이용할 경우 일반 텍스트 내용으로 설정된다.
        //mbp.setText(html);
        //html 형식으로 설정
        mbp.setContent(html, "text/html; charset=utf-8");
        return mbp;
    }

    //String으로 된 메일 주소를 Address 클래스로 변환
    private Address getAddress(String address) throws AddressException {
        return new InternetAddress(address);
    }

    //String으로 된 복수의 메일 주소를 콤마(,)의 구분으로 Address array형태로 변환
    private Address[] getAddresses(String addresses) throws AddressException {
        String[] array = addresses.split(",");
        Address[] ret = new Address[array.length];
        for (int i = 0; i < ret.length; i++) {
            ret[i] = getAddress(array[i]);
        }
        return ret;
    }

}