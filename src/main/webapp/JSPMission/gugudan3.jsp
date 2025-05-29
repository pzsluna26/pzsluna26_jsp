<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
    String valParam = request.getParameter("val");
    int dan = 2; // 기본값 설정

%>
<html>
<head>
    <title>구구단출력Type3 JSP 완성</title>
</head>
<body>
    <h2><%= dan %>단 구구단</h2>
    <%
        for (int i = 1; i <= 9; i++) {
            out.println(dan + " x " + i + " = " + (dan * i) + "<br>");
        }
    %>
    <br>
    <a href="gugudanMain.jsp">다른 단 선택하기</a>
</body>
</html>