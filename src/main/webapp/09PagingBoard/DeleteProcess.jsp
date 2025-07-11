<%@page import="utils.JSFunction"%>
<%@page import="model1.board.BoardDAO"%>
<%@page import="model1.board.BoardDTO"%>
<%@ include file="./IsLoggedIn.jsp"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
// 일련번호 얻기
String num = request.getParameter("num");

// DTO 객체 생성
BoardDTO dto = new BoardDTO();
// DAO 객체 생성
BoardDAO dao = new BoardDAO(application); 
// 주어진 일련번호에 해당하는 기존 게시물 얻기
dto = dao.selectView(num);

//로그인된 사용자 ID 얻기
String sessionId = session.getAttribute("UserId").toString();

int delResult = 0;

//작성자가 본인이면...
if(sessionId.equals(dto.getId())){
	dto.setNum(num);
	//삭제
	delResult = dao.deletePost(dto);
	dao.close();
	
	//성공/실패처리
	if(delResult == 1){
		//성공 시 목록 페이지로 이동
		JSFunction.alertLocation("삭제되었습니다.", "List.jsp", out);
	} else {
		//실패 시 이전 페이지로 이동
		JSFunction.alertBack("삭제에 실패했습니다.", out);
	}
}
else {
	//작성자 본인이 아니라면 이전 페이지로 이동
	JSFunction.alertBack("본인만 삭제할 수 있습니다.", out);
	return;
}
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>

</body>
</html>
