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
	$("#btnLogin").click(function(){
		document.form1.submit();
	});
});
</script>
</head>
<body>
<%@ include file="../include/menu.jsp" %>
<h1>User Login</h1>
<form name="form1" action="${path}/member/passChk.do">
<table border="1" style="width: 500px">
	<tr>
		<td>Userid</td>
		<td><input type="text" name="userid" /></td>
	</tr>
	<tr>
		<td>Password</td>
		<td><input type="password" name="passwd"/></td>
	</tr>
	<tr>
		<td colspan="2" align="center">
			<input type="button" id="btnLogin" value="Login" />
			<div style="color: red;">${message}</div>
		</td>
	</tr>
</table>
</form>
</body>
</html>