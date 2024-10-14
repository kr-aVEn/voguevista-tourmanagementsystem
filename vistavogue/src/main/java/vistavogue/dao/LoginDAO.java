package vistavogue.dao;



import java.sql.*;

import vistavogue.DBConnection;
import vistavogue.beans.User;
public class LoginDAO {
 public boolean Tstatus=false;
   

    public User login_check (String username, String password) throws SQLException,ClassNotFoundException {
    	  User user = null;
        Connection conn = DBConnection.getConnection();
        String sql = "SELECT * FROM Users WHERE username=? and password=?";
        PreparedStatement statement = conn.prepareStatement(sql);
        statement.setString(1, username);
        statement.setString(2, password);
        ResultSet rs = statement.executeQuery();
        if (rs.next()) {
        	user = new User();
            user.setUsername(rs.getString("username"));
            user.setPassword(rs.getString("password"));
            user.setEmail(rs.getString("email"));
            user.setPlace(rs.getString("place"));
            user.setRole(rs.getString("role"));
        }
        
          return user;
    }

    public String addUser(User user) throws SQLException,ClassNotFoundException {
    	String status=null;
        Connection conn = DBConnection.getConnection();
        String sql1 = "SELECT * FROM Users WHERE email=? ";
        PreparedStatement statement = conn.prepareStatement(sql1);
        statement.setString(1, user.getEmail());
        ResultSet rs = statement.executeQuery();
        if (rs.next()) {
        	status="email already ref=gistered on another user";
        	return status;
        }
        else {
        String sql = "INSERT INTO Users (username, password, email, place, role) VALUES (?, ?, ?, ?, ?)";
        PreparedStatement statement1 = conn.prepareStatement(sql);
        statement1.setString(1, user.getUsername());
        statement1.setString(2, user.getPassword());
        statement1.setString(3, user.getEmail());
        statement1.setString(4, user.getPlace());
        statement1.setString(5, user.getRole());
        int i=statement1.executeUpdate();
        statement1.close();
        conn.close();
        if(i>0) {
        	Tstatus=true;
        	status="User added successfully!!!";
        	
        return status;}
        else {
        	status="can't add the user";
            return status;}
    }}
}