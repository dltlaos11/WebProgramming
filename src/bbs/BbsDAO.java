package bbs;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

public class BbsDAO {

	// 실질적으로 db에서 회원정보 불러오거나 db에 회원정보 넣을때
	private Connection conn;
	private ResultSet rs;
	// mysql에 접속해 주는 부분
	public BbsDAO() { // 생성자 실행될때마다 자동으로 db연결이 이루어 질 수 있도록함
		try {
			String dbURL = "jdbc:mysql://localhost:3306/BBS?useSSL=false&serverTimezone=Asia/Seoul"; // localhost:3306 포트는 컴퓨터설치된 mysql주소
			String dbID = "root";
			String dbPassword = "1234";
			Class.forName("com.mysql.jdbc.Driver");
			conn = DriverManager.getConnection(dbURL, dbID, dbPassword);
		} catch (Exception e) {
			e.printStackTrace(); // 오류가 무엇인지 출력
		}
	}
	public String getDate() {
		String SQL = "SELECT NOW()"; // 현재 시간 가져오기 ,게시판 작성할 떄 현재 시간을 서버에 시간을 넣어줌
		try {						//현재 날짜 그대로 반환
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			rs = pstmt.executeQuery();
			if (rs.next()) {
				return rs.getString(1);
			}
		} catch(Exception e) {
			e.printStackTrace();
		}
		return "";
	}

	public int getNext() { // 다음 글 가지고 오기.
		String SQL = "SELECT bbsID FROM BBS ORDER BY bbsID DESC";//내림차순을 활용하여 가장 마지막에 쓰인 글 번호를 가져오도록 하는 것
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			rs = pstmt.executeQuery();
			if (rs.next()) {
				return rs.getInt(1) + 1; //그 다음 게시글 번호
			}
			return 1; // 첫 번째 게시물인 경우
		} catch(Exception e) {
			e.printStackTrace();
		}
		return -1; // 데이터베이스 오류
	}

	public int write(String bbsTitle, String userID, String bbsContent) {
		String SQL = "INSERT INTO BBS VALUES (?, ?, ?, ?, ?, ?)"; //하나의 게시물을 데이터베이스에 삽입하는 write 함수
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setInt(1, getNext()); //게시글 번호
			pstmt.setString(2, bbsTitle); //게시글 제목
			pstmt.setString(3, userID);// 
			pstmt.setString(4, getDate());
			pstmt.setString(5, bbsContent);
			pstmt.setInt(6, 1);// Available로 처음 글작성했을 떄는 글이 보여지는 형태여야 하므로 1을 넣어줌.

			return pstmt.executeUpdate();
		} catch(Exception e) {
			e.printStackTrace();
		}
		return -1; // 데이터베이스 오류
	}
	public ArrayList<Bbs> getList(int pageNumber) {
		String SQL = "SELECT * FROM BBS WHERE bbsID < ? AND bbsAvailable = 1 ORDER BY bbsID DESC LIMIT 10";
													//삭제가 되지 않은 Available이 1인 글들만 가져오고 bbsID로 내림차순하고 위에서 10개까지만 가져오도록 함
		ArrayList<Bbs> list = new ArrayList<Bbs>();
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setInt(1, getNext() - (pageNumber -1) * 10); //다음으로 작성될 글 번호는 getNext(), ? 에 들어갈 내용은 현재 글 다음번호보다 작은 글들에 대해서 10개씩 리미트를 걸며 가져오는 것
			rs = pstmt.executeQuery();
			while (rs.next()) {
				Bbs bbs = new Bbs();
				bbs.setBbsID(rs.getInt(1));
				bbs.setBbsTitle(rs.getString(2));
				bbs.setUserID(rs.getString(3));
				bbs.setBbsDate(rs.getString(4));
				bbs.setBbsContent(rs.getString(5));
				bbs.setBbsAvailable(rs.getInt(1));
				list.add(bbs); //리스트에 해당 인스턴스를 담아서 반환
			}			
		} catch(Exception e) {
			e.printStackTrace();
		}
		return list; //10개 뽑아온 데이터의 리스트
	}

	public boolean nextPage(int pageNumber) { // 게시글이 10개 미만이면 10개 이상일때 넘어가는 다음 페이지가 없음을 알려줌,  boolean을 사용해서 다음 페이지가 있는지 없는지의 페이징 처리 함수
		String SQL = "SELECT * FROM BBS WHERE bbsID < ? AND bbsAvailable = 1";  //페이지가 1보다 크면   
																				//ex) 1개의 글 pageNumber=1
																				//ex) 11개의 글  pageNumber=2..

		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setInt(1, getNext() - (pageNumber -1) * 10);
			rs = pstmt.executeQuery();
			if (rs.next()) {
				return true; //다음 페이지로 넘어갈수 있음
			}			
		} catch(Exception e) {
			e.printStackTrace();
		}
		return false;  //다음 페이지로 넘어가지 않음
	}
	 
	public Bbs getBbs(int bbsID) {  //ID에 해당하는 게시글을 가져오는 함수
		String SQL = "SELECT * FROM BBS WHERE bbsID = ?";

		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setInt(1, bbsID);
			rs = pstmt.executeQuery();
			if (rs.next()) {
				Bbs bbs = new Bbs();
				bbs.setBbsID(rs.getInt(1));
				bbs.setBbsTitle(rs.getString(2));
				bbs.setUserID(rs.getString(3));
				bbs.setBbsDate(rs.getString(4));
				bbs.setBbsContent(rs.getString(5));
				bbs.setBbsAvailable(rs.getInt(1));
				return bbs; //각각의 변수를 bbs인스턴스에 받아서 return
			}			
		} catch(Exception e) {
			e.printStackTrace();
		}
		return null; //해당 글이 존재하지 않는다면 null 반환
	}
	
	public int update(int bbsID, String bbsTitle, String bbsContent) { //게시글 수정 함수 
		String SQL = "UPDATE BBS SET bbsTitle = ?, bbsContent = ? WHERE bbsID =?";
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setString(1, bbsTitle);
			pstmt.setString(2, bbsContent);
			pstmt.setInt(3, bbsID);

			return pstmt.executeUpdate();
		} catch(Exception e) {
			e.printStackTrace();
		}
		return -1; // 데이터베이스 오류
	}

	public int delete(int bbsID) {
		String SQL = "UPDATE BBS SET bbsAvailable = 0 WHERE bbsID = ?";  //게시글 삭제 함수
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setInt(1, bbsID);

			return pstmt.executeUpdate();
		} catch(Exception e) {
			e.printStackTrace();
		}
		return -1; // 데이터베이스 오류
	}  
	
	
}