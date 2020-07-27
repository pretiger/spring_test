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
	$("#btnUpdate").click(function(){
		document.form1.action='${path}/board/update.do';
		document.form1.submit();
	});
});
</script>
</head>
<body>
<%@ include file="../include/menu.jsp" %>
<h1>Board Detail</h1>
<form name="form1">
<table border="1" style="width: 700px">
	<tr>
		<td width="10%">RegDate</td>
		<td width="40%"><fmt:formatDate value="${dto.regdate}" pattern="yyyy-MM-dd HH:mm:ss"/> </td>
		<td width="10%">Viewcount</td>
		<td width="40%">${dto.viewcount}</td>
	</tr>
	<tr>
		<td>subject</td>
		<td colspan="3"><input type="text" value="${dto.subject}" size="60" name="subject"/></td>
	</tr>
	<tr>
		<td>content</td>
		<td colspan="3"><textarea id="" cols="80" rows="5" name="content">${dto.content}</textarea>
	</tr>
	<tr>
		<td>AttachFile</td>
		<td colspan="3"></td>
	</tr>
	<tr align="center">
		<td colspan="4">
			<input type="hidden" value="${dto.num}" name="num"/>
			<input type="button" value="Update" id="btnUpdate"/>
			<input type="button" value="Reply"/>
			<input type="button" value="List"/>
		</td>
	</tr>
</table>
</form>
</body>
</html>