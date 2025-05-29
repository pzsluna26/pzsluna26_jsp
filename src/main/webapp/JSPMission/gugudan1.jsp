<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>구구단출력Type1 JSP 완성</title>
</head>
<body>
<%for(int i=2; i<=9; i++){%>
	<h2><%= i %>단</h2>
	<%for(int j=1; j<=9; j++){%>
		<%=i%>*<%=j%>=<%=i*j%><br>		 
	<% }%>
<% }%>

</body>
</html>

<%
// for(int i=2; i<=9; i++){
// 	out.println("<h2>"+i+"단"+"</h2>");
// 	for(int j=1; j<=9; j++){
// 	out.println(i+"*"+j+"="+(i*j)+("<br>")); 
// 	}
// }
%>