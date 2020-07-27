<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<%@ include file="../include/header.jsp" %>
<script>
'use strict';
$(function(){
	$("#btnSearch").click(function(){
		location.href = "${path}/board/list.do?curPage=${page.curPage}&searchkey="
			+$("#searchkey").val()+"&keyword="+$("#keyword").val();
	})
	$("#btnWrite").click(function(){
		location.href = "${path}/board/write.do";
	});
});
function list(page) {
	location.href = "${path}/board/list.do?curPage="+page+"&searchkey="
		+$("#searchkey").val()+"&keyword="+$("#keyword").val();
}
</script>
</head>
<body>
<%@ include file="../include/menu.jsp" %>
<h1>Board</h1>
<form>
	<select id="searchkey">
	<c:choose>
	<c:when test="${searchkey == 'writer'}">
		<option value="all">All</option>
		<option value="writer" selected>Writer</option>
		<option value="subject">Subject</option>
		<option value="content">Content</option>
	</c:when>
	<c:when test="${searchkey == 'subject'}">
		<option value="all">All</option>
		<option value="writer">Writer</option>
		<option value="subject" selected>Subject</option>
		<option value="content">Content</option>
	</c:when>
	<c:when test="${searchkey == 'content'}">
		<option value="all">All</option>
		<option value="writer">Writer</option>
		<option value="subject">Subject</option>
		<option value="content" selected>Content</option>
	</c:when>
	<c:otherwise>
		<option value="all" selected>All</option>
		<option value="writer">Writer</option>
		<option value="subject">Subject</option>
		<option value="content">Content</option>
	</c:otherwise>
	</c:choose>
	</select>
	<input type="text" id="keyword" value="${keyword}"/>
	<input type="button" id="btnSearch" value="Search" />
</form>
<button id="btnWrite">Writing</button>
<table border="1" style="width: 700px">
	<tr>
		<td>Number</td>
		<td>Writer</td>
		<td>Subject</td>
		<td>Viewcnt</td>
		<td>Date</td>
	</tr>
<c:forEach var="row" items="${list}">
	<tr>
		<td>${row.num }</td>
		<td>${row.writer }</td>
		<td><a href="${path}/board/detail.do/${row.num}">${row.subject}</a></td>
		<td>${row.viewcount }</td>
		<td><fmt:formatDate value="${row.regdate}" pattern="yyyy-MM-dd HH:mm:ss"/></td>
	</tr>
</c:forEach>
</table>
<table style="width: 700px">
	<tr align="center">
		<td>
		<c:if test="${1 < page.curPage }">
			<a href="javascript:list('1')">[First]</a>
		</c:if>
		<c:if test="${1 < page.curBlock }">
			<a href="javascript:list('${page.prePage}')">[Previous]</a>
		</c:if>
		<c:forEach var="i" begin="${page.blockStart}" end="${page.blockEnd}">
			<c:choose>
			<c:when test="${page.curPage == i}">
				<span style="color: red">${i}</span>
			</c:when>
			<c:otherwise>
				<a href="javascript:list('${i}')">${i}</a>
			</c:otherwise>
			</c:choose>
		</c:forEach>
			<c:if test="${page.curBlock < page.totalBlock}">
			<a href="javascript:list('${page.nextPage}')">[next]</a>
		</c:if>
		<c:if test="${page.curPage < page.totalPage}">
			<a href="javascript:list('${page.totalPage}')">[Last]</a>
		</c:if>
		</td>
	</tr>
</table>
</body>
</html>