<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../include/header.jsp"%>
<table width="700">
	<c:forEach var="dto" items="${list}">
	<tr>
		<td>${dto.name}
			(<fmt:formatDate value="${dto.regdate}" pattern="yyyy-MM-dd HH:mm:ss"/>)<br/>
			${dto.replytext}
		</td>
	</tr>
	</c:forEach>
</table>