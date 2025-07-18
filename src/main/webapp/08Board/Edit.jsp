<%@page import="model1.board.BoardDTO"%>
<%@page import="model1.board.BoardDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="./IsLoggedIn.jsp"%>
<%
//일련번호받기
String num = request.getParameter("num");
//DAO생성
BoardDAO dao = new BoardDAO(application);
//게시물 가져오기
BoardDTO dto = dao.selectView(num);
//로그인 id얻기
String sessionId = session.getAttribute("UserId").toString();
//본인인지 확인
if(!sessionId.equals(dto.getId())){
	JSFunction.alertBack("작성자 본인만 수정할 수 있습니다.", out);
	return;
}
dao.close();
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원제 게시판</title>
	<script>
		//폼내용 검증
		function validateForm(form){
			if(form.title.value ==""){
				alert("제목을 입력하세요.");
				form.title.focus();
				return false;
			}
			if(form.content.value==""){
				alert("내용을 입력하세요.");
				form.content.focus();
				return false;
			}
		}
	</script>
</head>
<body>
	<jsp:include page="../Common/Link.jsp"/>
	<h2>회원제 게시판-수정하기(Edit)</h2>
	<form name="writeFrm" method="post" action="EditProcess.jsp"
	onsubmit="return validateForm(this);">
 		<input type="hidden" name="num" value="<%=dto.getNum() %>"/>
 		<table border="1" width="90%">
 			<tr>
 				<td>제목</td>
 				<td>
 					<input type="text" name="title" style="width:90%" value="<%=dto.getTitle() %>"/>
 				</td>
 			</tr>
 			<tr>
 				<td>내용</td>
 				<td>
 					<textarea name="content" style="width: 90%; height:100px;"><%= dto.getContent() %></textarea>
 				</td>
 			</tr>
 			<tr>
 				<td colspan="2" align="center">
 					<button type="submit">작성 완료</button>
 					<button type="reset">다시 입력</button>
 					<button type="button" onclick="location.href='List.jsp';">목록 보기</button>
 				</td>
 			</tr>
 		</table>	
	</form>
</body>
</html>