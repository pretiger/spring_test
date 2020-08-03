<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<%@ include file="../include/header.jsp" %>
<style>
#previewTag{
	position: absolute;
	opacity: 0.8;
	width: 250px;
	height: auto;
	padding: 3px;
	border: dotted;
	background-color: yellow;
	visibility: hidden;
}
</style>
<script>
function preview(num){
	$.ajax({
		url: "${path}/board/preview.do/"+num,
		success: function(str){
			$("#previewTag").html(str);
		}
	});
}
function show(){
	/* $("#previewTag").css("visibility", "visible"); */
	document.getElementById("previewTag").style.visibility = "visible";
}
function hide(){
	/* $("#previewTag").css("visibility", "hidden"); */
	document.getElementById("previewTag").style.visibility = "hidden";
}
document.onmousemove = () => {
	/* $("#previewTag").css("marginTop", event.y+"px");
	$("#previewTag").css("marginLeft", event.x+"px"); */
	document.getElementById("previewTag").style.marginTop = event.y + "px";
	document.getElementById("previewTag").style.marginLeft = event.x + "px";
}
</script>
</head>
<body>
<%@ include file="../include/menu.jsp" %>
<h1>Board List</h1>
<div id="previewTag">This is content</div>
<form name="form1">
<c:choose>
<c:when test="${searchkey == 'writer'}">
<select name="searchkey" id="searchkey">
	<option value="writer" selected>Writer</option>
	<option value="subject">Subject</option>
	<option value="content">Content</option>
	<option value="all">All</option>
</select>
</c:when>
<c:when test="${searchkey == 'subject'}">
<select name="searchkey" id="searchkey">
	<option value="writer">Writer</option>
	<option value="subject" selected>Subject</option>
	<option value="content">Content</option>
	<option value="all">All</option>
</select>
</c:when>
<c:when test="${searchkey == 'content'}">
<select name="searchkey" id="searchkey">
	<option value="writer">Writer</option>
	<option value="subject">Subject</option>
	<option value="content" selected>Content</option>
	<option value="all">All</option>
</select>
</c:when>
<c:otherwise>
<select name="searchkey" id="searchkey">
	<option value="writer">Writer</option>
	<option value="subject">Subject</option>
	<option value="content">Content</option>
	<option value="all" selected>All</option>
</select>
</c:otherwise>
</c:choose>
<input type="text" name="keyword" value="${keyword}"/>
<input type="button" value="Search" id="btnSearch"/>
</form>
<button id="btnWrite">Writing</button>
<table border="1" style="width: 700px;">
	<tr align="center">
		<td>Num</td>
		<td>Writer</td>
		<td>Subject</td>
		<td>Viewcount</td>
		<td>Date</td>
	</tr>
	<c:forEach var="dto" items="${list}">
	<tr align="center">
		<td>${dto.num}</td>
		<td>${dto.name}</td>
		<td align="left">
			<c:if test="${dto.sublevel > 0}">
				<c:forEach begin="1" end="${dto.sublevel}">&nbsp;&nbsp;</c:forEach>
			</c:if>
			<a href="${path}/board/detail.do/${dto.num}" onmouseover="preview('${dto.num}');show();"
				 onmouseout="hide();">${dto.subject}</a>
			<c:if test="${dto.cnt > 0}"><span style="color: red;">[${dto.cnt}]</span></c:if>
		</td>
		<td>${dto.viewcount}</td>
		<td><fmt:formatDate value="${dto.regdate}" pattern="yyyy-MM-dd HH:mm:ss"/></td>
	</tr>
	</c:forEach>
</table>
<table style="width: 700px;">
	<tr align="center">
		<td>
		<c:if test="${1 < page.curPage}">
			<a href="javascript:list(1)">[First]</a>
		</c:if>
		<c:if test="${1 < page.curBlock}">
			<a href="javascript:list('${page.prePage}')">[Previous]</a>
		</c:if>
			<c:forEach var="i" begin="${page.blockStart}" end="${page.blockEnd}">
			<c:choose>
			<c:when test="${i == page.curPage}">
				<span style="color: red;">${i}</span>
			</c:when>
			<c:otherwise>
				<a href="javascript:list('${i}')">${i}</a>
			</c:otherwise>
			</c:choose>
			</c:forEach>
		<c:if test="${page.curBlock < page.totalBlock}">
			<a href="javascript:list('${page.nextPage}')">[Next]</a>
		</c:if>
		<c:if test="${page.curPage < page.totalPage}">
			<a href="javascript:list('${page.totalPage}')">[Last]</a>
		</c:if>
		</td>
	</tr>
</table>
<script>
document.querySelector("#btnWrite")
	.addEventListener("click", () => location.href = "${path}/board/write.do");
document.querySelector("#btnSearch").addEventListener("click", () => {
	document.form1.action = "${path}/board/list.do";
	document.form1.submit();
});
function list(page){
	location.href = "${path}/board/list.do?curPage="+page;
}
</script>
</body>
</html>