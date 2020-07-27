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
	$("#btnSave").click(function(){
		const userid=$("#userid"),
			passwd=$("#passwd"),
			email=$("#email"),
			name=$("#name");
		if(userid.val() === ""){
			alert("Write down userid!");
			userid.focus();
			return;
		}
		if(passwd.val() === ""){
			alert("Write down password!");
			passwd.focus();
			return;
		}
		if(name.val() === ""){
			alert("Write down name!");
			name.focus();
			return;
		}
		if(email.val() === ""){
			alert("Write down email");
			email.focus();
			return;
		}
		document.form1.action="${path}/member/insert.do";
		document.form1.submit();
	});
});
</script>
</head>
<body>
<%@ include file="../include/menu.jsp" %>
<h1>Member Join</h1>
<form name="form1">
	<table border="1" style="width: 500px;">
		<tr>
			<td>UserID</td>
			<td><input type="text" id="userid" name="userid"/></td>
		</tr>
		<tr>
			<td>Password</td>
			<td><input type="password" id="passwd" name="passwd"/></td>
		</tr>
		<tr>
			<td>Name</td>
			<td><input type="text" id="name" name="name" /></td>
		</tr>
		<tr>
			<td>E-Mail</td>
			<td><input type="text" id="email" name="email"/></td>
		</tr>
		<tr align="center">
			<td colspan="2"><input type="button" id="btnSave" value="Save"/>
				<input type="button" value="List" onclick="location.href='${path}/member/list.do'" />
			</td>
		</tr>
	</table>
</form>
</body>
</html>