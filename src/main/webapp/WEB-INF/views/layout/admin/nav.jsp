<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!-- nav -->
<nav id="gnb">
    <!--
    //	@gnb
    //
    //	- gnb > li 태그에 actived 클래스 추가시 활성화(기본으로 열림);
    -->
    <ul>
        <!-- <li class="actived">
            <a href="#">사용자관리</a>
            <div class="snb">
                <ul>

                    //	@snb
                    //
                    //	- snb > li 태그에 actived 클래스 추가시 활성화

                    <li class="actived"><a href="#">사용자조회</a></li>
                    <li><a href="#">사용자등록</a></li>
                </ul>
            </div>
        </li>  -->
        <li>
            <a href="/admin/test">test</a>
        </li>
        <li>
            <a href="/admin/forms">서식관리</a>
            <%--<div class="snb">
                <ul>
                    <li><a href="/admin/forms">서식리스트</a></li>
                    <li><a href="/admin/form/reg">서식등록</a></li>
                </ul>
            </div>--%>
        </li>
        <li>
            <a href="/admin/contracts">계약관리</a>
            <div class="snb">
                <ul>
                    <li><a href="/admin/contract/list">계약리스트</a></li>
                    <li><a href="/admin/contract/reg">계약등록</a></li>
                </ul>
            </div>
        </li>
    </ul>
</nav>
<!-- //nav -->