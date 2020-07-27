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
		document.form1.submit();
	});
});
</script>
</head>
<body>
<%@ include file="../include/menu.jsp" %>
<h1>Board Writing</h1>
<form name="form1"  method="post" enctype="multipart/form-data" action="${path}/board/insert.do">
<table border="1" style="width: 700px">
	<tr>
		<td width="20%">writer</td>
		<td width="80%"><input type="text" size="10" name="writer" value="${sessionScope.userid}"/></td>
	</tr>
	<tr>
		<td width="20%">subject</td>
		<td width="80%"><input type="text" size="50" name="subject"/></td>
	</tr>
	<tr>
		<td width="20%">content</td>
		<td width="80%"><textarea name="content" cols="80" rows="3"></textarea></td>
	</tr>
	<tr>
		<td width="20%">attach file</td>
		<td width="80%"><input type="file" name="files"/></td>
	</tr>
	<tr>
		<td colspan="2" align="center">
			<input type="button" value="Save" id="btnSave"/>
			<input type="button" value="List" onclick="location.href='${path}/board/list.do'"/>
		</td>
	</tr>
</table>
</form>
</body>
</html>