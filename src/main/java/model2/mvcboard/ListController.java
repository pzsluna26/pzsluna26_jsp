package model2.mvcboard;

import java.io.IOException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import jakarta.servlet.ServletContext;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import utils.BoardPage;

// 게시물 목록을 '출력하기 위한' 서블릿 (모델1과 차이점: 모델1=jsp / 모델2=서블릿)
public class ListController extends HttpServlet {
	
	private static final long serialVersionUID = 1L;
	
	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		//DAO생성
		MVCBoardDAO dao = new MVCBoardDAO();
		
		//뷰에 전달할 매개변수 저장용 맵 생성
		Map<String, Object>map = new HashMap<String, Object>();
		String searchField = req.getParameter("searchField");
		String searchWord = req.getParameter("searchWord");
		if(searchWord != null) {
			//쿼리스트링으로 전달받은 매개변수 중 검색어가 있다면 map에 저장
			map.put("searchField", searchField);
			map.put("searchWord", searchWord);
		}
		//게시물 개수
		int totalCount = dao.selectCount(map);
		
//페이지처리 시작
		ServletContext application = getServletContext();
		int pageSize = Integer.parseInt(application.getInitParameter("POSTS_PER_PAGE"));
		int blockPage = Integer.parseInt(application.getInitParameter("PAGES_PER_BLOCK"));
		
		//현재 페이지 확인
		int pageNum = 1; //기본값
		String pageTemp = req.getParameter("pageNum");
		if(pageTemp != null && !pageTemp.equals(""))
			//요청받은 페이지로 수정
			pageNum = Integer.parseInt(pageTemp);
		
		//목록에 출력할 게시물 범위 계산
		//첫 게시물 번호(MySQL은 0부터 시작)
		int start = (pageNum -1) * pageSize;
		map.put("start",start);
		map.put("pageSize",pageSize);
		
//페이지처리 끝
		
		List<MVCBoardDTO>boardLists = dao.selectListPage(map);
		//게시물 목록 받기
		dao.close(); //db연결 닫기
		
		//뷰에 전달할 매개변수 추가
		String pagingImg = BoardPage.pagingStr(totalCount, pageSize, blockPage, pageNum, "../mvboard/list.do");
		//바로가기 영역 html 문자열
		map.put("pagingImg", pagingImg);
		map.put("totalCount", totalCount);
		map.put("pageSize", pageSize);
		map.put("pageNum", pageNum);
		
		//전달할 데이터를 request 영역에 저장 후  list.jsp로 포워드
		req.setAttribute("boardLists", boardLists);
		req.setAttribute("map", map);
		req.getRequestDispatcher("/14MVCBoard/List.jsp").forward(req,resp);
	}
}
