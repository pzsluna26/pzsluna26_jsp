<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix ="c" uri="jakarta.tags.core"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<h4>향상된 for문 형태의 forEach 태그</h4>
	<%
	String[] rgba = {"Red","Green","Blue","Black"};
	%>
	<c:forEach items="<%= rgba %>" var="c">
		<span sytle = "color:${c};">${c}</span>
	</c:forEach>
	
	<h4>varState 속성 살펴보기</h4>
	<table border = "1">
	
	<c:forEach items="<%= rgba %>" var="c" varStatus="loop">
		<tr>
			<td>count : ${loop.count}</td>
			<td>index : ${loop.index}</td>
			<td>current : ${loop.current}</td>
			<td>first : ${loop.first}</td>
			<td>last: ${loop.last}</td>
		</tr>
	</c:forEach>
	</table>
</body>
</html>