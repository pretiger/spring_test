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
<%@ include file= "../include/menu.jsp" %>
<h1>이메일 보내기</h1>
<form method="post" action="${path}/email/send.do">
발신자 이름 : <input name="senderName"><br>
발신자 이메일 주소: <input name="senderMail"><br> 
수신자 이메일 주소: <input name="receiveMail"><br>
제목: <input name="subject"><br>
내용: <textarea name="message" cols="80" rows="5"></textarea>
<input type="submit" value="전송">
</form>
<span style="color: red;">${message}</span>
</body>
</html>