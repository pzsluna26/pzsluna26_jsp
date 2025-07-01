package common;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class JDBConnect2 {
    private Connection con;
   
    public Connection getCon() {
		return con;
	}
	public PreparedStatement psmt;
    
    public JDBConnect2() {
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            con = DriverManager.getConnection(
            		
            	//world 로 변경
                "jdbc:mysql://localhost:3306/world", "musthave", "tiger");
            System.out.println("DB 연결 성공(기본 생성자)");
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    public void close() {
        try {
            if (con != null) con.close();
            System.out.println("JDBC 자원 해제");
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
    
    
    //메서드 만들어서 dbmission01번의 3,4,5,6,7 다 가져오기
    public List<Mission1DTO> getCityByPopulation(int num) throws Exception {
    	// 3. SQL 쿼리 작성
    	String sql = "SELECT CountryCode, Population FROM City WHERE Population > ?";

    	// 4. PreparedStatement 생성 및 값 설정
    	PreparedStatement psmt = con.prepareStatement(sql);

    	// 5. 쿼리에 파라미터 값 세팅 (예: 인구수 입력값 설정)
    	psmt.setInt(1, num);

    	// 6. 쿼리 실행 및 결과(ResultSet) 받기
    	ResultSet rs = psmt.executeQuery();

    	List<Mission1DTO> list = new ArrayList<>();
    	
    	//7. ResultSet에서 결과 데이터 읽어서 출력하기 (while문 등으로 반복해서 읽기)
    	while (rs.next()){

    		Mission1DTO dto = new Mission1DTO();
    		dto.countryCode = rs.getString("CountryCode");
    		dto.population = rs.getInt("Population");
    		
    		list.add(dto);
    	}

    	//9. 사용한 자원 (ResultSet, PreparedStatement, Connection) 닫기 (자원 반납)
    	rs.close();
    	psmt.close();
    	
    	
    	//리턴 list하기
    	return list;
    }
    
}
