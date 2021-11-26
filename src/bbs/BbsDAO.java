package bbs;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

public class BbsDAO {

	// ���������� db���� ȸ������ �ҷ����ų� db�� ȸ������ ������
	private Connection conn;
	private ResultSet rs;
	// mysql�� ������ �ִ� �κ�
	public BbsDAO() { // ������ ����ɶ����� �ڵ����� db������ �̷�� �� �� �ֵ�����
		try {
			String dbURL = "jdbc:mysql://localhost:3306/BBS?useSSL=false&serverTimezone=Asia/Seoul"; // localhost:3306 ��Ʈ�� ��ǻ�ͼ�ġ�� mysql�ּ�
			String dbID = "root";
			String dbPassword = "1234";
			Class.forName("com.mysql.jdbc.Driver");
			conn = DriverManager.getConnection(dbURL, dbID, dbPassword);
		} catch (Exception e) {
			e.printStackTrace(); // ������ �������� ���
		}
	}
	public String getDate() {
		String SQL = "SELECT NOW()"; // ���� �ð� �������� ,�Խ��� �ۼ��� �� ���� �ð��� ������ �ð��� �־���
		try {						//���� ��¥ �״�� ��ȯ
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

	public int getNext() { // ���� �� ������ ����.
		String SQL = "SELECT bbsID FROM BBS ORDER BY bbsID DESC";//���������� Ȱ���Ͽ� ���� �������� ���� �� ��ȣ�� ���������� �ϴ� ��
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			rs = pstmt.executeQuery();
			if (rs.next()) {
				return rs.getInt(1) + 1; //�� ���� �Խñ� ��ȣ
			}
			return 1; // ù ��° �Խù��� ���
		} catch(Exception e) {
			e.printStackTrace();
		}
		return -1; // �����ͺ��̽� ����
	}

	public int write(String bbsTitle, String userID, String bbsContent) {
		String SQL = "INSERT INTO BBS VALUES (?, ?, ?, ?, ?, ?)"; //�ϳ��� �Խù��� �����ͺ��̽��� �����ϴ� write �Լ�
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setInt(1, getNext()); //�Խñ� ��ȣ
			pstmt.setString(2, bbsTitle); //�Խñ� ����
			pstmt.setString(3, userID);// 
			pstmt.setString(4, getDate());
			pstmt.setString(5, bbsContent);
			pstmt.setInt(6, 1);// Available�� ó�� ���ۼ����� ���� ���� �������� ���¿��� �ϹǷ� 1�� �־���.

			return pstmt.executeUpdate();
		} catch(Exception e) {
			e.printStackTrace();
		}
		return -1; // �����ͺ��̽� ����
	}
	public ArrayList<Bbs> getList(int pageNumber) {
		String SQL = "SELECT * FROM BBS WHERE bbsID < ? AND bbsAvailable = 1 ORDER BY bbsID DESC LIMIT 10";
													//������ ���� ���� Available�� 1�� �۵鸸 �������� bbsID�� ���������ϰ� ������ 10�������� ���������� ��
		ArrayList<Bbs> list = new ArrayList<Bbs>();
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setInt(1, getNext() - (pageNumber -1) * 10); //�������� �ۼ��� �� ��ȣ�� getNext(), ? �� �� ������ ���� �� ������ȣ���� ���� �۵鿡 ���ؼ� 10���� ����Ʈ�� �ɸ� �������� ��
			rs = pstmt.executeQuery();
			while (rs.next()) {
				Bbs bbs = new Bbs();
				bbs.setBbsID(rs.getInt(1));
				bbs.setBbsTitle(rs.getString(2));
				bbs.setUserID(rs.getString(3));
				bbs.setBbsDate(rs.getString(4));
				bbs.setBbsContent(rs.getString(5));
				bbs.setBbsAvailable(rs.getInt(1));
				list.add(bbs); //����Ʈ�� �ش� �ν��Ͻ��� ��Ƽ� ��ȯ
			}			
		} catch(Exception e) {
			e.printStackTrace();
		}
		return list; //10�� �̾ƿ� �������� ����Ʈ
	}

	public boolean nextPage(int pageNumber) { // �Խñ��� 10�� �̸��̸� 10�� �̻��϶� �Ѿ�� ���� �������� ������ �˷���,  boolean�� ����ؼ� ���� �������� �ִ��� �������� ����¡ ó�� �Լ�
		String SQL = "SELECT * FROM BBS WHERE bbsID < ? AND bbsAvailable = 1";  //�������� 1���� ũ��   
																				//ex) 1���� �� pageNumber=1
																				//ex) 11���� ��  pageNumber=2..

		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setInt(1, getNext() - (pageNumber -1) * 10);
			rs = pstmt.executeQuery();
			if (rs.next()) {
				return true; //���� �������� �Ѿ�� ����
			}			
		} catch(Exception e) {
			e.printStackTrace();
		}
		return false;  //���� �������� �Ѿ�� ����
	}
	 
	public Bbs getBbs(int bbsID) {  //ID�� �ش��ϴ� �Խñ��� �������� �Լ�
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
				return bbs; //������ ������ bbs�ν��Ͻ��� �޾Ƽ� return
			}			
		} catch(Exception e) {
			e.printStackTrace();
		}
		return null; //�ش� ���� �������� �ʴ´ٸ� null ��ȯ
	}
	
	public int update(int bbsID, String bbsTitle, String bbsContent) { //�Խñ� ���� �Լ� 
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
		return -1; // �����ͺ��̽� ����
	}

	public int delete(int bbsID) {
		String SQL = "UPDATE BBS SET bbsAvailable = 0 WHERE bbsID = ?";  //�Խñ� ���� �Լ�
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setInt(1, bbsID);

			return pstmt.executeUpdate();
		} catch(Exception e) {
			e.printStackTrace();
		}
		return -1; // �����ͺ��̽� ����
	}  
	
	
}