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
		$("#btnUpdate").click(function(){
			document.form1.action="${path}/member/update.do";
			document.form1.submit();
		});
		$("#btnDelete").click(function(){
			if(confirm("Would you delete?")){
				location.href="${path}/member/delete.do/${dto.userid}";
			}
		});
	});
</script>
</head>
<body>
<%@ include file="../include/menu.jsp" %>
<h1>Member Detail</h1>
<form name="form1">
<table border="1" style="width: 500px">
	<tr>
		<td>UserID</td>
		<td>${dto.userid}</td>
	</tr>
	<tr>
		<td>Password</td>
		<td><input type="password" name="passwd" value="${dto.passwd}"/> </td>
	</tr>
	<tr>
		<td>Name</td>
		<td><input type="text" name="name" value="${dto.name}"/></td>
	</tr>
	<tr>
		<td>E-mail</td>
		<td><input type="text" name="email" value="${dto.email}"/></td>
	</tr>
	<tr align="center">
		<td colspan="2">
			<input type="hidden" name="userid" value="${dto.userid}"/>
			<input type="button" id="btnUpdate" value="Update" />
			<input type="button" id="btnDelete" value="Delete" />
			<input type="button" value="List" onclick="location.href='${path}/member/list.do'"></td>
	</tr>
</table>
</form>
</body>
</html>