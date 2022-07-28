<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <script type="text/javascript">

        var fnCertResult_Pop = function () {
            var type = '${type}';
            var status = '${status}';

            if (type === 'idseed') {
                if (status === '0000') {
                    alert('휴대폰 본인 인증이 완료 되었습니다.');
                } else if (status === '0002') {
                    alert('개인신용정보조회동의를 하시는분과 휴대폰 명의자는 동일해야 합니다.');
                } else {
                    alert('휴대폰 본인 인증이 실패 하였습니다.');
                }
                window.opener.fnCertificationClose(status, type);
                self.close();
            } else {
                if (status === '0000') {
                    alert('계좌인증이 완료 되었습니다.');
                } else if (status === '0002') {
                    alert('개인신용정보조회동의를 하시는분과 계좌 명의자는 동일해야 합니다.');
                } else {
                    alert('계좌인증이 실패 하였습니다.');
                }
                window.opener.fnCertificationClose(status, type);
                self.close();
            }
        };

    </script>
</head>
<body onload="fnCertResult_Pop()">
</body>
</html>
