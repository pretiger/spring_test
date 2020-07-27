<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<a href="${path}">홈</a> |
<a href="${path}/board/list.do">게시판</a> |
<a href="${path}/shop/list.do">상품목록</a> |
<a href="${path}/shop/listCart.do">장바구니</a> |
<a href="${path}/member/list.do">회원관리</a> |
<div align="right">
<c:choose>
<c:when test="${sessionScope.userid != null}">
	<span style="color: blue;">${sessionScope.name}님이 로그인 상태입니다.</span> |
	<a href="${path}/member/logout.do">로그아웃</a>
</c:when>
<c:otherwise>
	<a href="${path}/member/login.do">사용자 로그인</a> |
	<a href="${path}/member/adminLogin.do">관리자 로그인</a>
</c:otherwise>
</c:choose>
</div>
<hr>