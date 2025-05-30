<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<style>
 table {
 border:1px solid;
 border-collapse: collapse;
 }
 td, tr {
 border:1px solid;
 padding: 4px 10px;
 }
 .title {
 text-align: center;
 background-color: lightgray;
 }
 </style>
<meta charset="UTF-8">
<title>구구단출력Type2 JSP 완성</title>
</head>
<body>
	
	

	<tr>
	<%//단 (2~9)
 		for (int dan = 2; dan <= 9; dan++) {%>
			<th><%= dan %>단</th>                
		<%} %>
	</tr>   
	
 	<%//곱하는 수 (1~9)
		for (int i = 1; i <= 9; i++){%> 
	
	<tr>
	<% for (int dan=2; dan <=9; dan++){%>
			<%=result = i * n;%>
			<%}%>		
	<th><%=dan%>*<%=i%>=<%=dan*i%></th>
			
	</tr>
	
        
</body>
</html>




















<%-- </tr>
        <%
            // 곱하는 수 (1 ~ 9)
            for (int i = 1; i <= 9; i++) {
        %>
            <tr>
                <%
                    for (int dan = 2; dan <= 9; dan++) {
                        int result = dan * i;
                %>
                        <td><%= dan %> x <%= i %> = <%= result %></td>
                <%
                    }
                %>
            </tr>
        <%
            }
        %> --%>