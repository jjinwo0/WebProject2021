package member;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import org.apache.catalina.User;

public class MemberDAO {
	Connection conn = null;
	PreparedStatement pstmt = null;
	
	String DRIVER = "com.mysql.cj.jdbc.Driver";
	String DB = "jdbc:mysql://localhost:3306/jspdb?useUnicode=true&characterEncoding=utf-8";
	String USER = "root";
	String PW = "park3587rs";
	
	void connect() {
		try {
			Class.forName(DRIVER);
			conn = DriverManager.getConnection(DB, USER, PW);
		} catch(Exception e) {
			e.printStackTrace();
		}
	}
	void disconnect() {
		if(pstmt != null) {
			try {
				pstmt.close();
			} catch(SQLException e) {
				e.printStackTrace();
			}
		}
		if(conn != null) {
			try {
				conn.close();
			} catch(SQLException e) {
				e.printStackTrace();
			}
		}
	}
	
	public boolean insertDB(MemberVO memberVO) {
		connect();
		
		String sql="insert into userdata(id, pwd, username, age, place, email, nickname) values(?,?,?,?,?,?,?)";
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1,memberVO.getId());
			pstmt.setString(2,memberVO.getPwd());
			pstmt.setString(3,memberVO.getUsername());
			pstmt.setString(4,memberVO.getAge());
			pstmt.setString(5,memberVO.getPlace());
			pstmt.setString(6,memberVO.getEmail());
			pstmt.setString(7,memberVO.getNickname());
			pstmt.executeUpdate();
		} catch(SQLException e) {
			e.printStackTrace();
			return false;
		} finally {
			disconnect();
		}
		return true;
	}

	public ArrayList<MemberVO>selectUserDB(){
		connect();
		String SQL = "select * from userdata";
		ArrayList<MemberVO> list=new ArrayList<MemberVO>();
		try {
			PreparedStatement pstmt=conn.prepareStatement(SQL);
			ResultSet rs=pstmt.executeQuery();
			while(rs.next()) {
				MemberVO member=new MemberVO();
				member.setId(rs.getString("id"));
				member.setPwd(rs.getString("pwd"));
				member.setUsername(rs.getString("username"));
				member.setAge(rs.getString("age"));
				member.setPlace(rs.getString("place"));
				member.setEmail(rs.getString("email"));
				member.setNickname(rs.getString("nickname"));
				member.setManager(rs.getInt("manager"));
				list.add(member);
			}
		}catch(Exception e) {
			e.printStackTrace();
		}finally {
			disconnect();
		}
		return list;
	}
	public ArrayList<TodoVO>selectTodoDB(String id){
		connect();
		String SQL = "select * from todolist where id=? order by date";
		ArrayList<TodoVO> list=new ArrayList<TodoVO>();
		try {
			PreparedStatement pstmt=conn.prepareStatement(SQL);
			pstmt.setString(1,  id);
			ResultSet rs=pstmt.executeQuery();
			while(rs.next()) {
				TodoVO member=new TodoVO();
				member.setId(rs.getString("id"));
				member.setContent(rs.getString("content"));
				member.setDate(rs.getString("date"));
				list.add(member);
			}
		}catch(Exception e) {
			e.printStackTrace();
		}finally {
			disconnect();
		}
		return list;
	}
	public MemberVO checkDB(String id, String pwd) {
		connect();
		String SQL = "select * from userdata where id=? and pwd=?";
		MemberVO usr = new MemberVO();
		try {
			PreparedStatement pstmt=conn.prepareStatement(SQL);
			pstmt.setString(1, id);
			pstmt.setString(2, pwd);
			ResultSet rs=pstmt.executeQuery();
			while(rs.next()) {
				if(rs != null) {
					usr.setId(rs.getString("id"));
					usr.setPwd(rs.getString("pwd"));
					usr.setUsername(rs.getString("username"));
					usr.setAge(rs.getString("age"));
					usr.setPlace(rs.getString("place"));
					usr.setEmail(rs.getString("email"));
					usr.setNickname(rs.getString("nickname"));
					usr.setIntroduce(rs.getString("introduce"));
					usr.setDogname(rs.getString("dogname"));
					usr.setDogdate(rs.getString("dogdate"));
					usr.setDogbreed(rs.getString("dogbreed"));
					usr.setTel(rs.getString("tel"));
					usr.setInstagram(rs.getString("instagram"));
					usr.setManager(rs.getInt("manager"));
				}
			}
		}catch(Exception e){
			e.printStackTrace();
		}finally {
			disconnect();
		}
		return usr;
	}
	public boolean deleteDB(String id) {
		connect();
		String SQL="delete from userdata where id=?";
		try {
			PreparedStatement pstmt=conn.prepareStatement(SQL);
			pstmt.setString(1, id);
			pstmt.executeUpdate();
		}catch(Exception e) {
			e.printStackTrace();
			return false;
		}finally {
			disconnect();
		}
		return true;
	}
	public boolean modifyDB(MemberVO member, String id) {
		connect();
		String SQL="update userdata set pwd=?, username=?, age=?, place=?, email=?, nickname=? where id=?";
		try {
			PreparedStatement pstmt=conn.prepareStatement(SQL);
			pstmt.setString(1,  member.getPwd());
			pstmt.setString(2,  member.getUsername());
			pstmt.setString(3,  member.getAge());
			pstmt.setString(4,  member.getPlace());
			pstmt.setString(5,  member.getEmail());
			pstmt.setString(6,  member.getNickname());
			pstmt.setString(7,  id);
			pstmt.executeUpdate();
		}catch(Exception e) {
			e.printStackTrace();
			return false;
		}finally {
			disconnect();
		}
		return true;
	}
	public boolean myModify(MemberVO member, String id) {
		connect();
		String SQL="update userdata set introduce=?, dogname=?, dogdate=?, dogbreed=?, tel=?, instagram=? where id=?";
		try {
			PreparedStatement pstmt=conn.prepareStatement(SQL);
			pstmt.setString(1,  member.getIntroduce());
			pstmt.setString(2,  member.getDogname());
			pstmt.setString(3,  member.getDogdate());
			pstmt.setString(4,  member.getDogbreed());
			pstmt.setString(5,  member.getTel());
			pstmt.setString(6,  member.getInstagram());
			pstmt.setString(7,  id);
			pstmt.executeUpdate();
		}catch(Exception e) {
			e.printStackTrace();
			return false;
		}finally {
			disconnect();
		}
		return true;
	}
	public boolean setTodoList(String id, String date, String content) {
		connect();
		String SQL="insert into todolist(id, date, content) values(?,?,?)";
		try {
			PreparedStatement pstmt=conn.prepareStatement(SQL);
			pstmt.setString(1,  id);
			pstmt.setString(2,  date);
			pstmt.setString(3,  content);
			pstmt.executeUpdate();
		}catch(Exception e) {
			e.printStackTrace();
			return false;
		}finally {
			disconnect();
		}
		return true;
	}
	public boolean deleteTodoList(String id, String date, String cont) {
		connect();
		String SQL="delete from todolist where id=? and date=? and content=?";
		try {
			PreparedStatement pstmt=conn.prepareStatement(SQL);
			pstmt.setString(1,  id);
			pstmt.setString(2,  date);
			pstmt.setString(3,  cont);
			pstmt.executeUpdate();
		}catch(Exception e) {
			e.printStackTrace();
			return false;
		}finally {
			disconnect();
		}
		return true;
	}
	   public MemberVO findID(String username, String email) {
		      connect();
		      String SQL = "select id from userdata where username=? and email=?";
		      MemberVO usr = new MemberVO();
		      try {
		         PreparedStatement pstmt=conn.prepareStatement(SQL);
		         pstmt.setString(1, username);
		         pstmt.setString(2, email);
		         ResultSet rs=pstmt.executeQuery();
		         while(rs.next()) {
		            if(rs != null) {
		               usr.setId(rs.getString("id"));
		            }
		         }
		      }catch(Exception e){
		         e.printStackTrace();
		         return null;
		      }finally {
		         disconnect();
		      }
		      return usr;
		   }
		   
		   public MemberVO findPW(String username, String id, String email) {
		      connect();
		      String SQL = "select pwd from userdata where username=? and id=? and email=?";
		      MemberVO usr = new MemberVO();
		      try {
		         PreparedStatement pstmt=conn.prepareStatement(SQL);
		         pstmt.setString(1, username);
		         pstmt.setString(2, id);
		         pstmt.setString(3, email);
		         ResultSet rs=pstmt.executeQuery();
		         while(rs.next()) {
		            if(rs != null) {
		               usr.setPwd(rs.getString("pwd"));
		            }
		         }
		      }catch(Exception e){
		         e.printStackTrace();
		         return null;
		      }finally {
		         disconnect();
		      }
		      return usr;
		   }
	public int managerApp(String id) {
	      connect();
	      String SQL="update userdata set manager = 1 where id = ?";
	      try {
	         PreparedStatement pstmt=conn.prepareStatement(SQL);
	         pstmt.setString(1,  id);
	         return pstmt.executeUpdate();
	      } catch(Exception e) {
	         e.printStackTrace();
	      } return -1;
	   }
	   
	   public int managerDis(String id) {
	      connect();
	      String SQL="update userdata set manager = 0 where id = ?";
	      try {
	         PreparedStatement pstmt=conn.prepareStatement(SQL);
	         pstmt.setString(1,  id);
	         return pstmt.executeUpdate();
	      } catch(Exception e) {
	         e.printStackTrace();
	      } return -1;
	   }
}