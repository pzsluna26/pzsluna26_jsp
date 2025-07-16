package fileupload;


import java.sql.PreparedStatement;
import java.sql.Statement;
import java.util.List;
import java.util.Vector;

import common.JDBConnect;

public class MyFileDAO extends JDBConnect {
	public int insertFile(MyFileDTO dto) {
		
		PreparedStatement psmt = null;
		int applyResult =0;
		try {
			String query = "INSERT INTO myfile(title, cate, ofile, sfile) "
					+ " VALUES (?,?,?,?)";
			psmt = getCon().prepareStatement(query);
			psmt.setString(1, dto.getTitle());
			psmt.setString(2, dto.getCate());
			psmt.setString(3, dto.getOfile());
			psmt.setString(4, dto.getSfile());
			applyResult = psmt.executeUpdate();
		}
		catch(Exception e){
			System.out.println("INSERT 중 예외 발생");
			e.printStackTrace();
		}
		return applyResult;
	}
	
	// 파일 목록을 반환합니다.
	public List<MyFileDTO> myFileList(){
		List<MyFileDTO> fileList = new Vector<MyFileDTO>();
		Statement stmt = null;
		//쿼리문 작성
		String query = "SELECT * FROM myfile ORDER BY idx DESC";
		try {
			// statement 객체 생성
			stmt = getCon().createStatement();
			// 쿼리 실행
			rs = stmt.executeQuery(query);
			
			//목록 안의 파일 수만큼 반복
			while(rs.next()) {
				//DTO에 저장
				MyFileDTO dto = new MyFileDTO();
				dto.setIdx(rs.getString(1));
				dto.setTitle(rs.getString(2));
				dto.setCate(rs.getString(3));
				dto.setOfile(rs.getString(4));
				dto.setSfile(rs.getString(5));
				dto.setPostdate(rs.getString(6));
				
				// 목록에 추가
				fileList.add(dto);
			}
		}
		catch(Exception e) {
			System.out.println("SELECT 시 예외 발생");
			e.printStackTrace();
		}
		// 목록 반환
		return fileList;
		
	}
}
