<%@page import="java.sql.PreparedStatement"%>
<%@ page import = "common.JDBConnect" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<h2>회원 추가</h2>
	<%
	JDBConnect jdbc = new JDBConnect();
	
	String id = request.getParameter("id");
	String pass = request.getParameter("pass");
	String name = request.getParameter("name");
	
	
	String sql = "INSERT INTO member(id,pass,name) VALUES (?,?,?)";
	PreparedStatement psmt = jdbc.getCon().prepareStatement(sql);
	psmt.setString(1, id);
	psmt.setString(2, pass);
	psmt.setString(3, name);
	
	int Result = psmt.executeUpdate();
	out.println(Result + "행이 입력되었습니다.");
	
	jdbc.close();
	psmt.close();
	
	//결과화면 출력
	response.sendRedirect("./ExeQuery.jsp");
	
	//홈화면 돌아가기
	//response.sendRedirect("./ExeUpdateFormMember.jsp");
	%>
</body>
</html>

