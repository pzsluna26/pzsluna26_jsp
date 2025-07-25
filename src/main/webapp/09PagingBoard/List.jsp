<%@page import="model1.board.BoardDTO"%>
<%@page import="java.util.List"%>
<%@page import="java.util.HashMap"%>
<%@page import="java.util.Map"%>
<%@page import="model1.board.BoardDAO"%>
<%@page import="utils.BoardPage" %>

<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
//DAO를 생성해 DB에 연결
BoardDAO dao = new BoardDAO(application);

//사용자가 입력한 검색 조건을 Map에 저장
Map<String, Object> param = new HashMap<String, Object>();
String searchField = request.getParameter("searchField");
String searchWord = request.getParameter("searchWord");
if (searchWord != null){
	param.put("searchField", searchField);
	param.put("searchWord", searchWord);
}


//게시물 수 확인
int totalCount = dao.selectCount(param); 


//페이지처리 start//
//전체페이지 수 계산

int pageSize= Integer.parseInt(application.getInitParameter("POSTS_PER_PAGE"));
 
/* int pageSize = 10;  */
int blockPage = Integer.parseInt(application.getInitParameter("PAGES_PER_BLOCK"));
int totalPage = (int)Math.ceil((double)totalCount / pageSize); //전체 페이지 수

//현재 페이지 확인
int pageNum = 1; //기본값
String pageTemp = request.getParameter("pageNum");
if (pageTemp != null && !pageTemp.equals("")) {
    pageNum = Integer.parseInt(pageTemp);
} //요청 받은 페이지로 수정

//목록에 출력할 게시물 범위 계산
int end = pageNum * pageSize;
int start = (pageNum -1) * pageSize; //첫 게시물 번호
System.out.print(start + ", " + end);


param.put("start", start);
param.put("end", end);
//페이지 처리 end//


//게시물 목록 받기
List<BoardDTO> boardLists = dao.selectListPage(param);

//DB연결 닫기
dao.close();
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원제 게시판</title>
</head>
<body>
	<jsp:include page="../Common/Link.jsp"/>
	<h2>목록 보기(List)-현재 페이지: <%=pageNum%>(전체: <%=totalPage %>)</h2>
	<form method="get">
	<table border="1" width="90%">
	<tr>
		<td align="center">
			<select name="searchField">
				<option value="title">제목</option>
				<option value="content">내용</option>
			</select>
			<input type="text" name="searchWord" >
			<input type="submit" value="검색하기" >
		</td>
	</tr>
	</table>
	</form>
	<table border="1" width="90%">
		<tr>
			<th width="10%">번호</th>
			<th width="50%">제목</th>
			<th width="15%">작성자</th>
			<th width="10%">조회수</th>
			<th width="15%">작성일</th>
		</tr>
<%
if(boardLists.isEmpty()){
	//게시물이 하나도 없을때

%>
		<tr>
			<td colspan="5" align="center">
				등록된 게시물이 없습니다 ^^*
			</td>
		</tr>	
<%
}
else {
	//게시물이 있을 때
	int virtualNum = 0; //화면상에서의 게시물 번호
	int countNum = 0;
	for (BoardDTO dto : boardLists)
	{
		virtualNum = totalCount - (((pageNum -1) * pageSize) + countNum++);

		%>
	<tr align="center">
		<td><%= virtualNum %></td>
		<td align="left">
			<a href="View.jsp?num=<%= dto.getNum() %>"><%= dto.getTitle() %></a>
		</td>
		<td align="center"><%= dto.getId() %></td>
		<td align="center"><%= dto.getVisitcount() %></td>
		<td align="center"><%= dto.getPostdate() %></td>
	</tr>
<% 
		}
}
%>
	</table>
	<table border="1" width="90%">
		<tr align="center">
			<td>
				<%= BoardPage.pagingStr(totalCount, pageSize, blockPage, pageNum, request.getRequestURI()) %>
			</td>
			<td>
				<button type="button" onclick="location.href='Write.jsp';">
					글쓰기
				</button>
			</td>
		</tr>
	</table>

</body>
</html>