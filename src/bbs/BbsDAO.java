package bbs;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

public class BbsDAO {
	private Connection conn;
	private ResultSet rs;
	
	// 기본 생성자
	public BbsDAO() {
		try {
			String dbURL = "jdbc:mysql://localhost:3306/jspdb?useUnicode=true&characterEncoding=utf-8&serverTimezone=UTC";
			String dbID = "root";
			String dbPassword = "park3587rs";
			Class.forName("com.mysql.cj.jdbc.Driver");
			conn = DriverManager.getConnection(dbURL, dbID, dbPassword);
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	
	// 작성일자 메소드
	public String getDate() {
		String sql = "select now()";
		try {
			PreparedStatement pstmt = conn.prepareStatement(sql);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				return rs.getString(1);
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return ""; // 데이터베이스 오류
	}
	// 게시글 번호 부여 메소드
	public int getNext() {
		// 현재 게시글을 내림차순으로 조회하여 가장 마지막 글의 번호를 구한다
		String sql = "select bbsID from bbs order by bbsID desc";
		try {
			PreparedStatement pstmt = conn.prepareStatement(sql);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				return rs.getInt(1) + 1;
			}
			return 1; // 첫 번째 게시물인 경우
		} catch (Exception e) {
			e.printStackTrace();
		}
		return -1; // 데이터베이스 오류
	}
	// 글쓰기 메소드
	public int write(String bbsTitle, String id, String bbsContent) {
	      String sql = "insert into bbs(bbsId, bbsTitle, userID, bbsDate, bbsContent) values(?, ?, ?, ?, ?)";
	      try {
	         PreparedStatement pstmt = conn.prepareStatement(sql);
	         pstmt.setInt(1, getNext());
	         pstmt.setString(2, bbsTitle);
	         pstmt.setString(3, id);
	         pstmt.setString(4, getDate());
	         pstmt.setString(5, bbsContent);
	         return pstmt.executeUpdate();
	      }catch (Exception e) {
	         e.printStackTrace();
	      }
	      return -1; //데이터베이스 오류
	   }
	// 게시글 리스트 메소드
	public ArrayList<Bbs> getList(int pageNumber) {
		String sql = "select * from bbs where bbsID < ? order by bbsID desc limit 10";
		ArrayList<Bbs> list = new ArrayList<Bbs>();
		try {
			PreparedStatement pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, getNext() - (pageNumber - 1) * 10);
			rs = pstmt.executeQuery();
			while(rs.next()) {
				Bbs bbs = new Bbs();
				bbs.setBbsID(rs.getInt(1));
				bbs.setBbsTitle(rs.getString(2));
				bbs.setId(rs.getString(3));
				bbs.setBbsDate(rs.getString(4));
				bbs.setBbsContent(rs.getString(5));
				bbs.setBbsView(rs.getInt(6));
				list.add(bbs);
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return list;
	}
	
	// 페이징 처리 메소드
	public boolean nextPage(int pageNumber) {
		String sql = "select * from bbs where bbsID < ?";
		try {
			PreparedStatement pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, getNext() - (pageNumber - 1) * 10);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				return true;
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return false;
	}
	
	// 하나의 게시글을 보는 메소드
	public Bbs getBbs(int bbsID) {
		String sql = "select * from bbs where bbsID = ?";
		try {
			PreparedStatement pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, bbsID);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				Bbs bbs = new Bbs();
				bbs.setBbsID(rs.getInt(1));
				bbs.setBbsTitle(rs.getString(2));
				bbs.setId(rs.getString(3));
				bbs.setBbsDate(rs.getString(4));
				bbs.setBbsContent(rs.getString(5));
				int bbsView=rs.getInt(6);
				bbs.setBbsView(bbsView);
				bbsView++;
				view(bbsView, bbsID);
				return bbs;
			}
		} catch (Exception e) {
				e.printStackTrace();
		}
			return null;
	}
	
	
	// 게시글 수정 메소드
	public int update(int bbsID, String bbsTitle, String bbsContent) {
		String sql = "update bbs set bbsTitle = ?, bbsContent = ? where bbsID = ?";
		try {
			PreparedStatement pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, bbsTitle);
			pstmt.setString(2, bbsContent);
			pstmt.setInt(3, bbsID);
			return pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return -1; // 데이터베이스 오류
	}
	
	// 게시글 삭제 메소드
	public int delete(int bbsID) {
		// 실제 데이터를 삭제하는 것이 아니라 게시글 유효숫자를 '0'으르 수정한다
		String sql = "delete from bbs where bbsID = ?";
		try {
			PreparedStatement pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, bbsID);
			return pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return -1; // 데이터베이스 오류
	}
	public int view(int bbsView, int bbsID) {
	      String SQL = "update bbs set bbsView = ? where bbsID = ?";
	      try {
	         PreparedStatement pstmt=conn.prepareStatement(SQL);
	         pstmt.setInt(1, bbsView);//물음표의 순서
	         pstmt.setInt(2, bbsID);
	         return pstmt.executeUpdate();//insert,delete,update         
	      } catch(Exception e) {
	         e.printStackTrace();
	      }
	      return -1;//데이터베이스 오류
	}
	public ArrayList<Bbs> allList(){
		String SQL = "select * from bbs order by bbsView desc limit 5";
		ArrayList<Bbs> bbsList = new ArrayList<Bbs>();
		try {
	        PreparedStatement pstmt=conn.prepareStatement(SQL);
	        rs=pstmt.executeQuery();
	        while(rs.next()) {
				Bbs bbs = new Bbs();
				bbs.setBbsID(rs.getInt(1));
				bbs.setBbsTitle(rs.getString(2));
				bbs.setId(rs.getString(3));
				bbs.setBbsDate(rs.getString(4));
				bbs.setBbsContent(rs.getString(5));
				bbs.setBbsView(rs.getInt(6));
				bbsList.add(bbs);
	        }
		} catch(Exception e) {
			e.printStackTrace();
		}
		return bbsList;
	}
}
