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
<h1>Board Detail</h1>
<form name="form1" method="post" enctype="multipart/form-data">
<table border="1" style="width: 700px;">
	<tr align="center">
		<td width="20">Date</td>
		<td width="80"><fmt:formatDate value="${dto.regdate}" pattern="yyyy-MM-dd HH:mm:ss"/></td>
		<td width="20">ViewCount</td>
		<td width="80">${dto.viewcount}</td>
	</tr>
	<tr>
		<td>Subject</td>
		<td colspan="3"><input type="text" size="60" name="subject" id="subject" value="${dto.subject}"/></td>
	</tr>
	<tr>
		<td>Content</td>
		<td colspan="3"><textarea name="content" id="content" cols="80" rows="3">${dto.content}</textarea></td>
	</tr>
	<tr>
		<td>File Attach</td>
		<td colspan="3"><div id="listedFile" ></div><input type="file" name="files"/></td>
	</tr>
	<tr align="center">
		<td colspan="4">
			<input type="hidden" value="${dto.num}" name="num"/>
			<input type="button" id="btnUpdate" value="Update"/>
			<input type="button" id="btnDelete" value="Delete"/>
			<input type="button" id="btnAnswer" value="Answer"/>
			<input type="button" value="List" onclick="location.href='${path}/board/list.do' "/>
		</td>
	</tr>
</table>
</form>
<table style="width: 700px">
	<tr>
		<td>
			<textarea name="replytext" id="replytext" cols="80" rows="3" placeholder="Write down comment!"></textarea>
			<input type="button" value="Save" id="btnSave"/>
		</td>
	</tr>
</table>
<hr/>
<div id="listAttach"></div>
<script>
document.querySelector("#btnDelete").addEventListener("click", () => {
	if(confirm("would you delete?")) 
		location.href="${path}/board/delete.do?num=${dto.num}";
});

function listingAttach(){
	$.ajax({
		type: "post",
		url: "${path}/board/listingAttach.do/${dto.num}",
		success: function(result){
			$("#listAttach").html(result);
		}
	});
}
listingAttach();
document.querySelector("#btnSave").addEventListener("click", () => {
	const replytext = $("#replytext").val();
	const replyer = "${sessionScope.userid}";
	const bnum = "${dto.num}";
	const param = {"replytext": replytext, "replyer": replyer, "bnum": bnum};
	$.ajax({
		url: "${path}/board/insertAttach.do",
		data: param,
		success: function(result) {
			$("#listAttach").html(result);
			$("#replytext").val("");
		}
	});
});

document.querySelector("#btnAnswer")
	.addEventListener("click", () => location.href = "${path}/board/answer.do/${dto.num}");
	
function listAttach(){
	$.ajax({
		url: "${path}/board/listAttach.do/${dto.num}",
		success: function(files){
			files.forEach((file) => {
				const str = "<div><a href='${path}/board/downloadFile.do?fileName="
					+file+"'>"+originalName(file)+"</a><span class='dTag' data-src='"
					+file+"'> [Delete]</span></div>";
				document.getElementById("listedFile").innerHTML= str;
				/* $("#listedFile").append(str); */
				/* console.log(str); */
				/* const str2 = document.querySelector(".dTag");
				console.log(str2);
				document.querySelector(".dTag").addEventListener("click", (e) => {
					console.log($(e.target).attr("data-src"));
				}); */
				document.querySelector(".dTag").addEventListener("click", (e) => {
					const that = $(e.target);
					if(that.attr("class") === "dTag"){
						$.ajax({
							url: "${path}/board/deleteFile.do",
							data: {filename: that.attr("data-src")},
							success: function(result){
								if(result === "deleted"){
									that.parent("div").remove();
								}
							}
						});
					}
				});
			});
		}
	});
}
function originalName(file){
	return file.substr(file.lastIndexOf("_")+1);
}
listAttach();
document.querySelector("#btnUpdate").addEventListener("click", () => {
	document.form1.action = "${path}/board/update.do";
	document.form1.submit();
});
</script>
</body>
</html>