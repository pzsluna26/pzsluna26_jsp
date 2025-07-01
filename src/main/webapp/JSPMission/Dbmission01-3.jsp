<%@page import="common.Mission1DTO"%>
<%@page import="java.util.List"%>
<%@page import="common.JDBConnect2"%>
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
	<form>
		<table>
			<tr>
				<th>인구수 입력</th>
					<td><input type ="text" name="num"></td>
			</tr>
		</table>
		<input type="submit" value="확인">
	</form>
<%
String numStr = request.getParameter("num");
int num = 0;
if (numStr != null) {
    num = Integer.parseInt(numStr);
}

//JDBConnect2.java 불러오고
JDBConnect2 jdbc = new JDBConnect2();

//JDBConnect2.java에 메서드 불러오기
List<Mission1DTO> list = jdbc.getCityByPopulation(num);

//for확장문으로 출력
for(Mission1DTO dto : list) {
	out.print(dto.countryCode + ", " + dto.population + "</br>");
}

%>
</body>
</html>
