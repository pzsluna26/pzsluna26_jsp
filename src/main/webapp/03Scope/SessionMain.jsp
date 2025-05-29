<%@ page import="java.util.ArrayList" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
ArrayList<String> list = new ArrayList<String>();
list.add("리스트");
list.add("컬렉션");
session.setAttribute("lists", list);


//펄슨 객체 만들어서 어레이리스트 저장해서 세션 로케이션에서 출력해라
//ArrayList<Person> persons = new ArrayList<>();
//Person p = new Person("홍",10);
//persons.add(p);
//persons.add(new Person("Lee", 10));
//persons.add(new Person("Lee", 10));
//session.setAttribute("persons", persons);

%>



<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>session 영역</title>
</head>
<body>
	<h2>페이지 이동 후 session 영역의 속성 읽기</h2>
	<a href="SessionLocation.jsp">SessionLocation.jsp 바로가기</a>
</body>
</html>