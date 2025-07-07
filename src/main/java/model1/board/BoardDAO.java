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

        String query = "SELECT * FROM board";

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
}
