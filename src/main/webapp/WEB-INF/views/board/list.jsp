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
	padding: 5px;
	width: 250px;
	height: auto;
	background-color: yellow;
	visibility: hidden;
}
</style>

</head>
<body>
<%@ include file="../include/menu.jsp" %>
<h1>Board List</h1>
<div id="previewTag">Content Preview</div>
<form name="form1">
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
<input type="text" name="keyword" value="${keyword}" id="keyword" />
<input type="button" value="Search" id="btnSearch"/>
</form>
<button id="btnWrite">Writing</button>
<table border="1" style="width: 700px;">
	<tr align="center">
		<td>Num</td>
		<td>Writer</td>
		<td>Subject</td>
		<td>ViewCount</td>
		<td>Date</td>
	</tr>
	<c:forEach var="row" items="${list}">
	<tr align="center">
		<td>${row.num}</td>
		<td>${row.name}</td>
		<td align="left">
			<c:if test="${row.substep > 0}">
				<c:forEach var="i" begin="1" end="${row.sublevel}">&nbsp;&nbsp;</c:forEach> 
			</c:if>
			<a href="${path}/board/detail.do/${row.num}" onmouseover="preview('${row.num}');show();" 
			onmouseout="hide();">${row.subject}
				<c:if test="${row.cnt > 0}"><span style="color: red;">[${row.cnt}]</span></c:if>
			</a></td>
		<td>${row.viewcount}</td>
		<td><fmt:formatDate value="${row.regdate}" pattern="yyyy-MM-dd HH:mm:ss" /> </td>
	</tr>
	</c:forEach>
</table>
<table width="700">
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
				<c:when test="${page.curPage == i}">
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
/* $(function(){
 	$("#btnWrite").click(function(){
		location.href = "${path}/board/write.do";
	});
	$("#btnSearch").click(function(){
		document.form1.action = "${path}/board/list.do?curPage=${page.curPage}";
		document.form1.submit();
	});
}); */
document.querySelector("#btnWrite")
	.addEventListener("click", () => location.href = "${path}/board/write.do");
document.querySelector("#btnSearch")
	.addEventListener("click", () => {
		document.form1.action = "${path}/board/list.do?curPage=${page.curPage}";
		document.form1.submit();
	});
function list(page){
	location.href = "${path}/board/list.do?curPage="+page
		/* +"&searchkey="+$("#searchkey").val()+"&keyword="+$("#keyword").val(); */
	+"&searchkey="+document.querySelector("#searchkey").value
	+"&keyword="+document.querySelector("#keyword").value;
}
function preview(num){
  	 $.ajax({
		url: "${path}/board/preview.do?num="+num,
		success: function(result){
			$("#previewTag").html(result);
		}
	});
}
function show(){
	/* $("#previewTag").css("visibility", "visible"); */
	document.querySelector("#previewTag").style.visibility="visible";
}
function hide(){
	/* $("#previewTag").css("visibility", "hidden"); */
	document.querySelector("#previewTag").style.visibility="hidden";
}
document.onmousemove = () => {
	/* $("#previewTag").css("marginTop", event.y+"px");
	$("#previewTag").css("marginLeft", event.x+"px"); */
	document.querySelector("#previewTag").style.marginTop=event.y+"px";
	document.querySelector("#previewTag").style.marginLeft=event.x+"px";
}
</script>
</body>
</html>