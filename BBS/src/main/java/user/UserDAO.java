package user;

import java.sql.*;

public class UserDAO {
	private Connection conn;
	private PreparedStatement pstmt;
	private ResultSet rs;
	User user = new User();
	
	public UserDAO() {
		try {
			String dbURL = "jdbc:mysql://localhost:3306/bbs";
			String dbID = "root";
			String dbPW = "domokun9803!";
			Class.forName("com.mysql.cj.jdbc.Driver");
			conn = DriverManager.getConnection(dbURL, dbID, dbPW);
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	
	public int login(String userId, String userPw) {
		String userSearchQuery = "select userPW from user where userID = ?;";
		try {
			pstmt = conn.prepareStatement(userSearchQuery);
			pstmt.setString(1,  userId);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				if(rs.getString(1).equals(userPw)) {
					return 1;
				}else {
					return 0;
				}
			}
			return -1;
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return -2;
	}
	
	public int join(User user) {
		String userJoinQuery = "insert into user values(?, ?, ?, ?, ?);";
		try {
			pstmt = conn.prepareStatement(userJoinQuery);
			pstmt.setString(1,  user.getUserID());
			pstmt.setString(2,  user.getUserPW());
			pstmt.setString(3,  user.getUserName());
			pstmt.setString(4,  user.getUserGender());
			pstmt.setString(5,  user.getUserEmail());
			return pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return -1;
	}
}
