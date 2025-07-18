<%@page import="model1.board.BoardDTO"%>
<%@page import="model1.board.BoardDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
//일련번호 받기
String num = request.getParameter("num"); 

// DAO생성
BoardDAO dao = new BoardDAO(application);

// 조회수 증가
dao.updateVisitCount(num);

// 게시물 가져오기
BoardDTO dto = dao.selectView(num);

// DB 연결 해제
dao.close();
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원제 게시판</title>
	<script>
		function deletePost(){
			var confirmed = confirm("정말로 삭제하겠습니까?");
			if (confirmed){
				//이름이 "writeFrm"인 폼 선텍
				var form = document.writeFrm;
				//전송방식
				form.method = "post";
				//전송경로
				form.action = "DeleteProcess.jsp";
				//폼값전송
				form.submit();
			}
		}
	</script>
</head>
<body>
	<jsp:include page="../Common/Link.jsp"/>	
	<h2>회원제 게시판-상세보기</h2>
	<form name = "writeFrm">
		<input type="hidden" name="num" value="<%=num %>"/>
		<table border="1" width="90%">
			<tr>
				<td>번호</td>
				<td><%=dto.getNum() %></td>
				<td>작성자</td>
				<td><%=dto.getId() %></td>
			</tr>
			<tr>
				<td>작성일</td>
				<td><%=dto.getPostdate() %></td>
				<td>조회수</td>
				<td><%=dto.getVisitcount() %></td>		
			</tr>
			<tr>
				<td>제목</td>
				<td colspan="3"><%= dto.getTitle() %></td>
			</tr>
			<tr>
				<td>내용</td>
				<td colspan="3" height="100">
					<%=dto.getContent().replace("\r\n", "<br/>") %>
				</td>
			</tr>
			<tr>
				<td colspan="4" align="center">
					<%
					if (session.getAttribute("UserId") != null && session.getAttribute("UserId").toString().equals(dto.getId())) {
					%>
					<button type="button"
						onclick="location.href='Edit.jsp?num=<%=dto.getNum()%>';">수정하기</button>
					<button type="button" onclick="deletePost();">삭제하기</button> <%
					 }
					 %>
					<button type="button" onclick="location.href='List.jsp';">목록보기</button>

				</td>
			</tr>		
		</table>
	</form>	
</body>
</html>