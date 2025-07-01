<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.Connection"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Dbmission01</title>
</head>
<body>
	<h2>인구 수가 많은 도시</h2>
		<table>
			<tr>
				<th>인구수 입력</th>
					<td><input type ="text" name="population"></td>
			</tr>
		</table>
		<input type="submit" value="확인">
<%
String numStr = request.getParameter("num");
int num = 0;
if (numStr != null) {
    num = Integer.parseInt(numStr);
}

// 1. JDBC 드라이버 로드
Class.forName("com.mysql.cj.jdbc.Driver");

// 2. DB 연결
Connection con = DriverManager.getConnection(
    "jdbc:mysql://localhost:3306/world", "musthave", "tiger");

// 3. SQL 쿼리 작성
String sql = "SELECT CountryCode, Population FROM City WHERE Population > ?";

// 4. PreparedStatement 생성 및 값 설정
PreparedStatement psmt = con.prepareStatement(sql);

// 5. 쿼리에 파라미터 값 세팅 (예: 인구수 입력값 설정)
psmt.setInt(1, num);


// 6. 쿼리 실행 및 결과(ResultSet) 받기
ResultSet rs = psmt.executeQuery();

//7. ResultSet에서 결과 데이터 읽기 (while문 등으로 반복해서 읽기)
while (rs.next()){
	String CountryCode = rs.getString("CountryCode");
	int Population = rs.getInt("Population");
}

//8. 읽은 데이터를 원하는 형태로 출력 또는 저장
response.sendRedirect("");

//9. 사용한 자원 (ResultSet, PreparedStatement, Connection) 닫기 (자원 반납)
rs.close();
psmt.close();

%>
</body>
</html>
