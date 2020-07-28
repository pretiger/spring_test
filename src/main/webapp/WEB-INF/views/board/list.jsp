<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<%@ include file="../include/header.jsp" %>
<script>
$(function(){
	$("#btnSearch").click(function(){
		location.href="${path}/board/list.do?curPage="+${page.curPage}
			+"&searchkey="+$("#searchkey").val()+"&keyword="+$("#keyword").val();
	});
	$("#btnWrite").click(function(){
		location.href="${path}/board/write.do";
	});
});
function list(page){
	location.href="${path}/board/list.do?curPage="+page
		+"&searchkey="+$("#searchkey").val()+"&keyword="+$("#keyword").val();
}
</script>
</head>
<body>
<%@ include file="../include/menu.jsp" %>
<h1>Board List</h1>
<form>
<c:choose>
<c:when test="${searchkey == 'writer'}">
<select name="searchkey" id="searchkey">
	<option value="writer" selected>writer</option>
	<option value="subject">subject</option>
	<option value="content">content</option>
	<option value="all">All</option>
</select>
</c:when>
<c:when test="${searchkey == 'subject'}">
<select name="searchkey" id="searchkey">
	<option value="writer">writer</option>
	<option value="subject" selected>subject</option>
	<option value="content">content</option>
	<option value="all">All</option>
</select>
</c:when>
<c:when test="${searchkey == 'content'}">
<select name="searchkey" id="searchkey">
	<option value="writer">writer</option>
	<option value="subject">subject</option>
	<option value="content" selected>content</option>
	<option value="all">All</option>
</select>
</c:when>
<c:otherwise>
<select name="searchkey" id="searchkey">
	<option value="writer">writer</option>
	<option value="subject">subject</option>
	<option value="content">content</option>
	<option value="all" selected>All</option>
</select>
</c:otherwise>
</c:choose>
<input type="text" value="${keyword}" id="keyword">
<input type="button" value="Search" id="btnSearch">
</form>
<button id="btnWrite">Writing</button>
<table border="1" width="700">
	<tr>
		<td>Num</td>
		<td>Writer</td>
		<td>Subject</td>
		<td>ViewCount</td>
		<td>Date</td>
	</tr>
	<c:forEach var="row" items="${list}">
	<tr>
		<td>${row.num }</td>
		<td>${row.writer }</td>
		<td>${row.subject }</td>
		<td>${row.viewcount }</td>
		<td><fmt:formatDate value="${row.regdate}" pattern="yyyy-MM-dd HH:mm:ss"/> </td>
	</tr>
	</c:forEach>
</table>
<table style="width: 700px">
	<tr align="center">
		<td>
		<c:if test="${ 1 < page.curPage}">
			<a href="javascript:list(1)">[First]</a>
		</c:if>
		<c:if test="${ 1 < page.curBlock}">
			<a href="javascript:list('${page.prePage}')">[Previous]</a>
		</c:if>
		<c:forEach var="i" begin="${page.blockStart}" end="${page.blockEnd}">
		<c:choose>
		<c:when test="${i == page.curPage}">
			<span style="clolor: red;">${i}</span>
		</c:when>
		<c:otherwise>
			<a href="javascript:list('${i}')">${i}</a>
		</c:otherwise>
		</c:choose>
		</c:forEach>
		<c:if test="${ page.curBlock < page.totalBlock}">
			<a href="javascript:list('${page.nextPage}')">[Next]</a>
		</c:if>
		<c:if test="${ page.curPage < page.totalPage}">
			<a href="javascript:list('${page.totalPage}')">[Last]</a>
		</c:if>
		</td>
	</tr>
</table>
</body>
</html>