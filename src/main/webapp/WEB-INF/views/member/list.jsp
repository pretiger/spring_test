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
		$("#btnJoin").click(function(){
			location.href="${path}/member/join.do";
		});
	});
</script>
</head>
<body>
<%@ include file="../include/menu.jsp" %>
<h1>Member List</h1>
<input type="button" id="btnJoin" value="Join" />
<form>
	<table border="1" style="width: 700px">
		<tr>
			<td>UserID</td>
			<td>Name</td>
			<td>E-mail</td>
			<td>JoinDate</td>
		</tr>
		<c:forEach var="row" items="${list}">
		<tr>
			<td>${row.userid}</td>
			<td>${row.name}</td>
			<td><a href="${path}/member/detail.do/${row.userid}">${row.email}</a></td>
			<td><fmt:formatDate value="${row.join_date}" pattern="yyyy-MM-dd HH:mm:dd"/> </td>
		</tr>
		</c:forEach>
	</table>
</form>
</body>
</html>