package membership;
import java.sql.*;
import common.JDBConnect;

public class MemberDAO extends JDBConnect {

    public MemberDAO(String driver, String url, String id, String pw) {
        super(driver, url, id, pw);
    }

    public MemberDTO getMemberDTO(String uid, String upass) {
        MemberDTO dto = new MemberDTO();
        String query = "SELECT * FROM member WHERE id=? AND pass=?";

        try {
            psmt = getCon().prepareStatement(query);
            psmt.setString(1, uid);
            psmt.setString(2, upass); // 오타 수정

            rs = psmt.executeQuery();

            if (rs.next()) {
                // 조건에 맞을 때만 객체 생성
                dto.setId(rs.getString("id"));
                dto.setPass(rs.getString("pass"));
                dto.setName(rs.getString("name"));        // 컬럼명 명시 권장
                dto.setRegidate(rs.getString("regidate")); // 컬럼명 명시 권장
            }
        } catch (Exception e) {
            e.printStackTrace();
        }

        return dto; // 반환 누락 수정
    }

    public static void main(String[] args) {
        MemberDAO dao = new MemberDAO(
            "com.mysql.cj.jdbc.Driver", 
            "jdbc:mysql://localhost:3306/musthave", 
            "musthave", 
            "tiger"
        );

        MemberDTO dto = dao.getMemberDTO("musthave", "1234");
        System.out.println(dto);
        System.out.println("id: " + dto.getId());
        System.out.println("pwd: " + dto.getPass());

    }
}
