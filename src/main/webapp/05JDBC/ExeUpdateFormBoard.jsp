<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Statement"%>
<%@page import="common.JDBConnect"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<h2>Board</h2>
	<form action="ExeUpdateBoard.jsp" method="post">
		<table>
			<tr>
				<th>title</th>
					<td><input type ="text" name="title"></td>
			</tr>
			<tr>
				<th>content</th>
					<td><input type ="text" name="content"></td>
			</tr>
			<tr>
				<th>id</th>
					<td>
						<select name ="id" >
						<% 
							JDBConnect jdbc = new JDBConnect();
							String sql = "SELECT id from member";
							Statement stmt = jdbc.getCon().createStatement();
							ResultSet rs = stmt.executeQuery(sql);
							
							while (rs.next()) {
						        String id = rs.getString("id");
							}
							rs.close();
							stmt.close();
						    jdbc.close();
						%>
						</select>
					</td>
			</tr>
		</table>
		<input type="submit" value="등록">
		
</body>
</html>