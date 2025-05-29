<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<html>
<head>
    <title>구구단 선택</title>
</head>
<body>
    <h2>단을 선택하세요</h2>
    <form action="gugudan3.jsp" method="get">
        <label for="val">단 선택:</label>
        <select name="val">
            <% for (int i = 2; i <= 9; i++) { %>
                <option value="<%= i %>"><%= i %>단</option>
            <% } %>
        </select>
        <input type="submit" value="출력">
    </form>
</body>
</html>