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
		document.form1.action = "${path}/board/insert.do";
		document.form1.submit();
	});
});
</script>
</head>
<body>
<%@ include file="../include/menu.jsp" %>
<script>
$(function(){
	$("#fileList").on("click", "a", function(){
		$(this).parent("div").remove();
	});
});
function addTag(){
	str = "<div><a href='javascript:;'>[delete]</a><input type='file' name='files' /></div>";
	$("#fileList").append(str);
}
</script>
<h1>Board Writing</h1>
<form name="form1" method="post" enctype="multipart/form-data">
	<table border="1" style="width: 700px;">
		<tr>
			<td>Writer</td>
			<td><input type="text" name="writer" value="${sessionScope.userid}" readonly/></td>
		</tr>
		<tr>
			<td>Subject</td>
			<td><input type="text" name="subject" size="80"/></td>
		</tr>
		<tr>
			<td>Content</td>
			<td><textarea name="content" id="" cols="80" rows="3"></textarea></td>
		</tr>
		<tr>
			<td>File Attach</td>
			<td>
				<span style="color: blue;" onclick="addTag()"><a href="javascript:;">[add]</a></span>
				<input type="file" name="files" /><div id="fileList"></div>
			</td>
		</tr>
		<tr align="center">
			<td colspan="2">
				<input type="button" id="btnSave" value="Save"/>
				<input type="button" value="List" onclick="location.href='${path}/board/list.do'" />
			</td>
		</tr>
	</table>
</form>
</body>
</html>