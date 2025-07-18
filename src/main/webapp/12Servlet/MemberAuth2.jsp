<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<h2>MVC 패턴으로 회원인증하기</h2>
	<p>
		<a href="${pageContext.request.contextPath}/12Servlet/MemberAuth.mvc?id=nakja&pass=1234">회원인증(관리자)</a>
		<a href="${pageContext.request.contextPath}/12Servlet/MemberAuth.mvc?id=musthave&pass=1234">회원인증(회원)</a>
		<a href="${pageContext.request.contextPath}/12Servlet/MemberAuth.mvc?id=stranger&pass=1234">회원인증(비회원)</a>
	</p>
</body>
</html>
