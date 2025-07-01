package common;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Statement;

import jakarta.servlet.ServletContext;

public class JDBConnect {
    public Connection con;
   
    public ResultSet rs;
    public Connection getCon() {
		return con;
	}
	public PreparedStatement psmt;
    
    // 기본 생성자
    public JDBConnect() {
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            con = DriverManager.getConnection(
                "jdbc:mysql://localhost:3306/musthave", "musthave", "tiger");
            System.out.println("DB 연결 성공(기본 생성자)");
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    // 매개변수 4개 생성자
    public JDBConnect(String driver, String url, String id, String pwd) {
        try {
            Class.forName(driver);
            con = DriverManager.getConnection(url, id, pwd);
            System.out.println("DB 연결 성공(인수 생성자 1)");
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    // ServletContext를 이용한 생성자
    public JDBConnect(ServletContext application) {
        try {
            String driver = application.getInitParameter("MySQLDriver");
            String url = application.getInitParameter("MySQLURL");
            String id = application.getInitParameter("MySQLId");
            String pwd = application.getInitParameter("MySQLPwd");

            Class.forName(driver); // 드라이버도 반드시 로딩해줘야 함
            con = DriverManager.getConnection(url, id, pwd);
            System.out.println("DB 연결 성공(인수 생성자 2)");
        } catch (Exception e) {
            System.out.println("DB 연결 실패: " + e.getMessage());
        }
    }

    // 자원 해제 메서드
    public void close() {
        try {
            if (con != null) con.close();
            System.out.println("JDBC 자원 해제");
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}
