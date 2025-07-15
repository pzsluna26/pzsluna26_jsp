package model1.board;

import java.sql.*;
import java.util.*;
import java.util.List;
import java.util.Vector;

import common.JDBConnect;
import jakarta.servlet.ServletContext;

public class BoardDAO extends JDBConnect {
    
    public BoardDAO(ServletContext application) {
        super(application);
    }

    // 게시물 개수 세기
    public int selectCount(Map<String, Object> map) {
        int totalCount = 0;
        Statement stmt = null;
        ResultSet rs = null;

        String query = "SELECT COUNT(*) FROM board";

        // SQL Injection 방지를 위한 searchField 유효성 검사
        if (map.get("searchWord") != null) {
            String field = String.valueOf(map.get("searchField"));
            if (List.of("title", "content", "id").contains(field)) {
                query += " WHERE " + field + " LIKE '%" + map.get("searchWord") + "%'";
            }
        }

        try {
            stmt = getCon().createStatement();
            rs = stmt.executeQuery(query);
            if (rs.next()) {
                totalCount = rs.getInt(1);
            }
        } catch (Exception e) {
            System.out.println("게시물 수를 구하는 중 예외 발생");
            e.printStackTrace();
        } finally {
            try {
                if (rs != null) rs.close();
                if (stmt != null) stmt.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }

        return totalCount;
    }

    // 게시물 목록 조회
    public List<BoardDTO> selectList(Map<String, Object> map) {
        List<BoardDTO> bbs = new Vector<>();
        Statement stmt = null;
        ResultSet rs = null;

        String query = "SELECT * FROM board ";

        // SQL Injection 방지를 위한 searchField 유효성 검사
        if (map.get("searchWord") != null) {
            String field = String.valueOf(map.get("searchField"));
            if (List.of("title", "content", "id").contains(field)) {
                query += " WHERE " + field + " LIKE '%" + map.get("searchWord") + "%'";
            }
        }

        query += " ORDER BY num DESC";  // 공백 주의

        try {
            stmt = getCon().createStatement();
            rs = stmt.executeQuery(query);
            
            while (rs.next()) {
                BoardDTO dto = new BoardDTO();
                
                dto.setNum(rs.getString("num"));
                dto.setTitle(rs.getString("title"));
                dto.setContent(rs.getString("content"));
                dto.setPostdate(rs.getDate("postDate"));
                dto.setId(rs.getString("id"));
                dto.setVisitcount(rs.getString("visitcount"));
                
                bbs.add(dto);
            }
        } catch (Exception e) {
            System.out.println("게시물 조회 중 예외 발생");
            e.printStackTrace();
        } finally {
            try {
                if (rs != null) rs.close();
                if (stmt != null) stmt.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }

        return bbs;
    }
    
    //검색 조건에 맞는 게시물 목록을 반환합니다(페이징 기능 지원)
    public List<BoardDTO> selectListPage(Map<String, Object> map){
    	// 결과(게시물 목록)를 담을 변수
    	List<BoardDTO> bbs = new Vector<BoardDTO>();
    	
    	//쿼리문 템플릿
    	String query = "select * from board ";
    	
    	if (map.get("searchWord") != null){
    		query += " WHERE " + map.get("searchField")
    			  + " LIKE '%" + map.get("searchWord") + "%' ";
    	}
    	query += " ORDER BY num DESC limit ? ,? ";
    	try {
    	
    	psmt = getCon().prepareStatement(query);
    	psmt.setInt(1, (int)map.get("start"));
    	psmt.setInt(2, (int)map.get("pageSize"));
    		
		//쿼리문 실행
		rs = psmt.executeQuery();
		
		while(rs.next()) {
			//한행 (게시물 하나)의 데이터를 DTO에 저장
			BoardDTO dto = new BoardDTO();
			dto.setNum(rs.getString("num"));
			dto.setTitle(rs.getString("title"));
			dto.setContent(rs.getString("content"));
			dto.setPostdate(rs.getDate("postdate"));
			dto.setId(rs.getString("id"));
			dto.setVisitcount(rs.getString("visitcount"));
			
			//반환할 결과 목록에 게시물 추가
			bbs.add(dto);
    		}
    	}
    	catch(Exception e) {
    		System.out.println("게시물 조회 중 예외 발생");
    		e.printStackTrace();
    	}
    	
    	//목록반환
    	return bbs;
    }
    
    // 게시글 데이터를 받아 DB에 추가합니다.
    public int insertWrite(BoardDTO dto) {
		int result =0;
	
		try {
			String query = "INSERT INTO board ( "
						 + "title,content,id,visitcount) "
						 + "VALUES ( "
						 + " ?, ?, ?, 0)";
			
			psmt = getCon().prepareStatement(query);
			psmt.setString(1, dto.getTitle());
			psmt.setString(2, dto.getContent());
			psmt.setString(3, dto.getId());
			
			result = psmt.executeUpdate();
			
		} catch (Exception e) {
			System.out.println("게시물 입력 중 예외 발생");
			e.printStackTrace();
		}
		
		return result;
	}
    
    // 지정한 게시물을 찾아 내용을 반환합니다.
    public BoardDTO selectView(String num) {
    	BoardDTO dto = new BoardDTO();
    	 
    	// 쿼리문 준비
    	String query = "SELECT B.*, M.name "
                + "FROM member M INNER JOIN board B "
                + "ON M.id = B.id "
                + "WHERE num = ?";
    	try {
    		psmt = getCon().prepareStatement(query);
    		psmt.setString(1,num); // 인파라미터를 일렬변호로 설정
    		rs=psmt.executeQuery(); // 쿼리실행
    		
    		// 결과 처리
    		if(rs.next()) {
    			dto.setNum(rs.getString(1));
    			dto.setTitle(rs.getString(2));
    			dto.setContent(rs.getString("content"));
    			dto.setPostdate(rs.getDate("postdate"));
    			dto.setId(rs.getString("id"));
    			dto.setVisitcount(rs.getString(6));
    			dto.setName(rs.getString("name"));
    		}
    	}
    	catch(Exception e) {
    		System.out.println("게시물 상세보기 중 예외 발생");
    		e.printStackTrace();
    	}
    	return dto;
    	
    }
    
    // 지정한 게시물의 조회수를 1 증가 시킵니다.
    public void updateVisitCount(String num) {
    	// 쿼리문 준비
    	String query ="UPDATE board SET visitcount = visitcount +1 " + 
    				"WHERE num =?";
    	try {
    		psmt = getCon().prepareStatement(query);
    		psmt.setString(1,num);
    		psmt.executeUpdate();
    	}
    	catch(Exception e) {
    		System.out.println("게시물 조회수 증가 중 예외 발생");
    		e.printStackTrace();
    	}
    }
    
    // 지정한 게시물을 수정합니다.
    public int updateEdit(BoardDTO dto) {
    	int result = 0;
    	try {
    		// 쿼리문 템플릿
    		String query = "UPDATE board SET "
    					 + "title = ? , content = ? " 
    					 + "WHERE num = ?";
    		
    		// 쿼리문 완성
    		psmt = getCon().prepareStatement(query);
    		psmt.setString(1, dto.getTitle());
    		psmt.setString(2, dto.getContent());
    		psmt.setString(3, dto.getNum());
    		
    		//쿼리문 실행
    		result = psmt.executeUpdate();
    	}
    	catch(Exception e) {
    		System.out.println("게시물 수정 중 예외 발생");
    		e.printStackTrace();
    	}
    	return result;
    }
    
    // 지정한 게시물을 삭제합니다.
    public int deletePost(BoardDTO dto) {
    	int result = 0;
    	try {
    		// 쿼리 문 템플릿
    		String query = "DELETE FROM board WHERE num=?";
    		
    		// 쿼리문 완성
    		psmt = getCon().prepareStatement(query);
    		psmt.setString(1,  dto.getNum());
    		
    		// 쿼리문 실행
    		result = psmt.executeUpdate();
    	}
    	catch(Exception e) {
    		System.out.println("게시물 삭제 중 예외 발생");
    		e.printStackTrace();
    	}
    	// 결과 반환
    	return result;
    }
    
    public static void main(String[] args) {
        // 테스트용 DTO 객체 생성
        BoardDTO dto = new BoardDTO();
        dto.setNum("3"); // 삭제할 게시물 번호 입력 (기존 DB에 존재하는 num)

        // BoardDAO 객체 생성 (ServletContext 없이 JDBConnect에 기본 생성자가 있어야 함)
        BoardDAO dao = new BoardDAO(null); // getCon()이 기본 연결 사용하도록 구현돼야 함

        int result = dao.deletePost(dto);

        if (result > 0) {
            System.out.println("삭제 성공!");
        } else {
            System.out.println("삭제 실패. 해당 번호의 게시물이 없거나 DB 오류.");
        }

        dao.close(); // 연결 닫기
    }
}
