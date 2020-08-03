<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<%@ include file="../include/header.jsp" %>
</head>
<body>
<%@ include file="../include/menu.jsp" %>
<h1>Board Writing</h1>
<form name="form1" method="post" enctype="multipart/form-data">
	<table border="1" style="width: 700px;">
		<tr>
			<td align="center">Subject</td>
			<td><input type="text" size="60" name="subject" id="subject"/></td>
		</tr>
		<tr>
			<td align="center">Content</td>
			<td><textarea name="content" id="content" cols="80" rows="3"></textarea></td>
		</tr>
		<tr>
			<td align="center">File Attach</td>
			<td><input type="file" name="files" /></td>
		</tr>
		<tr align="center">
			<td colspan="2">
				<input type="hidden" value="${sessionScope.userid}" name="writer">
				<input type="button" value="Save" id="btnSave" />
				<input type="button" value="List" onclick="location.href='${path}/board/list.do'" />
			</td>
		</tr>
	</table>
</form>
<script>
document.querySelector("#btnSave").addEventListener("click", () => {
	document.form1.action = "${path}/board/insert.do";
	document.form1.submit();
});
</script>
</body>
</html>