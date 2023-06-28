<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>관리자 - 로그인 Page</title>
    <script type="text/javascript">
        var s = location.search;
        if (s.indexOf('failure') > 0) {
            alert('관리자 로그인 실패');
        } else if (s.indexOf('expired') > 0) {
            alert('다른 곳에서 로그인하여 로그인 해제');
        } else if (s.indexOf('logout') > 0) {
            alert('관리자 로그아웃 성공');
        }
        $(function () {
            // 로그인 실행
            $("#submit").on("click", () => {
                $("#loginForm").submit();
            })
            /* // 추후 삭제
            $("input[name=i]").val("tsoft");
            $("input[name=p]").val("1111");
            $("#submit").trigger("click"); */
        })
    </script>
</head>
<body>

<!-- wrap -->
<section id="wrap">

    <form id="loginForm" name='f' action="/admin/authenticate" method='POST'>
        <div class="login_wrap">
            <div class="d_t">
                <div class="d_c">
                    <fieldset>
                        <legend>로그인 입력 폼</legend>
                        <div class="login_input">
                            <h1>ADMIN - JENKINS</h1>
                            <p class="cell"><input type='text' name='i' value='' placeholder="아이디"></p>
                            <p class="cell"><input type='password' name='p' placeholder="비밀번호"/></p>
                            <p class="btn"><a id="submit" href="#">로그인</a></p>
                        </div>
                    </fieldset>
                </div>
            </div>
        </div>
    </form>

</section>
<!-- //wrap -->
</body>
</html>
