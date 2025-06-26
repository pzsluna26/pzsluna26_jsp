<%@page import="java.sql.PreparedStatement"%>
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
	<h2>board</h2>
	<%
	JDBConnect jdbc = new JDBConnect();
	
	String title = request.getParameter("title");
	String content = request.getParameter("content");
	String id = request.getParameter("id");
	
	
	String sql = "INSERT INTO board(title,content,id) VALUES (?,?,?)";
	PreparedStatement psmt = jdbc.getCon().prepareStatement(sql);
	psmt.setString(1, title);
	psmt.setString(2, content);
	psmt.setString(3, id);
	
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