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
	attachList();
	listComment();
	$("#btnSave").click(function(){
		const replytext = $("#comment").val();
		const replyer = "${sessionScope.userid}";
		const bnum = "${dto.num}";
		const param = {"bnum": bnum, "replyer": replyer, "replytext": replytext};
		$.ajax({
			type: "post",
			url: "${path}/board/insertComment.do",
			data: param,
			success: function(){
				listComment();
				$("#comment").val("");
			}
		});
	});
	$("#btnAnswer").click(function(){
		location.href = "${path}/board/answer.do/${dto.num}";
	})
	$("#uploadedFile").on("click", "span", function(){
		const that = $(this);
		console.log(that);
		$.ajax({
			url: "${path}/board/deleteFile",
			data: {filename: that.attr("data-src")},
			success: function(result){
				console.log(result);
				if(result === "deleted"){
					that.parent("div").remove();
				}
			}
		});
	});
	$("#btnUpdate").click(function(){
		document.form1.action = "${path}/board/update.do";
		document.form1.submit();
	});
});
function listComment(){
	$.ajax({
		url: "${path}/board/listComment.do/${dto.num}",
		success: function(result){
			$("#commentList").html(result);
		}
	});
}
function attachList(){
	$.ajax({
		url: "${path}/board/attachList.do/${dto.num}",
		success: function(files){
			files.forEach(file => {
				const str = "<div><a href='${path}/board/downloadFile?filename="
					+file+"'>"+originalName(file)+"</a><span data-src='"
					+file+"'><a href='#'> [delete]</a></span></div>";
				$("#uploadedFile").append(str);
			});
		}
	});
}
function originalName(filename){
	return filename.substr(filename.lastIndexOf("_")+1);	
}
</script>
</head>
<%@ include file="../include/menu.jsp" %>
<h1>Board Detail</h1>
<form name="form1" method="post" enctype="multipart/form-data">
	<table border="1" width="700">
		<tr align="center">
			<td width="20%">Date</td>
			<td width="80%"><fmt:formatDate value="${dto.regdate}" pattern="yyyy-MM-dd HH:mm:ss"/></td>
			<td width="20%">ViewCount</td>
			<td width="80%">${dto.viewcount}</td>
		</tr>
		<tr>
			<td>Subject</td>
			<td colspan="3"><input type="text" name="subject" id="subject" size="50" value="${dto.subject}"/></td>
		</tr>
		<tr>
			<td>Content</td>
			<td colspan="3"><textarea name="content" id="content" cols="80" rows="3">${dto.content}</textarea></td>
		</tr>
		<tr>
			<td>File</td>
			<td colspan="3"><input type="file" name="files" />
				<div id="uploadedFile"></div>	
			</td>
		</tr>
		<tr align="center">
			<td colspan="4">
				<input type="hidden" value="${dto.num}" name="num"/>
				<input type="button" value="Update" id="btnUpdate"/>
				<input type="button" value="Delete" id="btnDelete"/>
				<input type="button" value="Answer" id="btnAnswer"/>
				<input type="button" value="List" onclick="location.href='${path}/board/list.do'"/>
			</td>
		</tr>
	</table>
</form>
<table width="700">
	<tr>
		<td>
			<textarea name="comment" id="comment" cols="80" rows="3" placeholder="Write down comment!"></textarea>
			<input type="button" value="Save" id="btnSave"/>
		</td>
	</tr>
</table>
<hr/>
<div id="commentList"></div>
</body>
</html>