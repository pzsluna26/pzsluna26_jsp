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
	<h2>회원 추가</h2>
	 <form action="ExeUpdateMember.jsp" method="post">
	 <table>
		 <tr>
		 	<th>아이디:</th>
		 		<td><input type="text" name="id"></td>
		 </tr>
		 <tr>
		 	<th>비밀번호:</th>
		 		<td><input type="text" name="pass"></td>
		 </tr>
		 <tr>
		 	<th>이름: </th>
		 	 	<td><input type="text" name="name"></td>
		 </tr>
		 </table>
		 <input type = "submit" value = "등록">
	 </form>

</body>
</html>