<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ page import="java.net.URLEncoder" %> <!-- URLEncoder 사용 시 필요 -->

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>FileUpload</title>
</head>
<body>
	<h2>DB에 등록된 파일 목록 보기</h2>
	<a href="FileUploadMain.jsp">파일등록1</a>
	<a href="MultiUploadMain.jsp">파일등록2</a>

	<table border="1">
		<tr>
			<th>No</th><th>작성자</th><th>제목</th><th>카테고리</th>
			<th>원본 파일명</th><th>저장된 파일명</th><th>작성일</th><th></th>
		</tr>
		
		<c:forEach var="f" items="${fileLists}">
			<tr>
				<td>${f.idx}</td>
				<td>${f.title}</td>
				<td>${f.cate}</td>
				<td>${f.ofile}</td>
				<td>${f.sfile}</td>
				<td>${f.postdate}</td>
				<td>
					<c:url var="downloadUrl" value="DownLoad.jsp">
						<c:param name="oName" value="${fn:escapeXml(f.ofile)}"/>
						<c:param name="sName" value="${fn:escapeXml(f.sfile)}"/>
					</c:url>
					<a href="${downloadUrl}">[다운로드]</a>
				</td>
			</tr>
		</c:forEach>
	</table>
</body>
</html>
