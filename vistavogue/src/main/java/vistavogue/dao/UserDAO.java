package vistavogue.dao;


import java.sql.*;
import java.util.ArrayList;
import java.util.List;
import vistavogue.DBConnection;
import vistavogue.beans.User;
public class UserDAO {

    public void addUser(User user) throws SQLException,ClassNotFoundException {
        Connection conn = DBConnection.getConnection();
        String sql = "INSERT INTO Users (username, password, email, place, role) VALUES (?, ?, ?, ?, ?)";
        PreparedStatement statement = conn.prepareStatement(sql);
        statement.setString(1, user.getUsername());
        statement.setString(2, user.getPassword());
        statement.setString(3, user.getEmail());
        statement.setString(4, user.getPlace());
        statement.setString(5, user.getRole());
        statement.executeUpdate();
        statement.close();
        conn.close();
    }

    public User getUser(String username) throws SQLException,ClassNotFoundException {
        Connection conn = DBConnection.getConnection();
        String sql = "SELECT * FROM Users WHERE username=?";
        PreparedStatement statement = conn.prepareStatement(sql);
        statement.setString(1, username);
        ResultSet rs = statement.executeQuery();
        User user = null;
        if (rs.next()) {
            user = new User();
            user.setUsername(rs.getString("username"));
            user.setPassword(rs.getString("password"));
            user.setEmail(rs.getString("email"));
            user.setPlace(rs.getString("place"));
            user.setRole(rs.getString("role"));
        }
        rs.close();
        statement.close();
        conn.close();
        return user;
    }
    public User getUserById(int id) throws SQLException, ClassNotFoundException {
    	Connection connection = DBConnection.getConnection();
        String query = "SELECT * FROM Users WHERE id = ?";
        PreparedStatement statement = connection.prepareStatement(query);
        statement.setInt(1, id);
        ResultSet resultSet = statement.executeQuery();

        if (resultSet.next()) {
            User user = new User();
            
            user.setUsername(resultSet.getString("username"));
            user.setEmail(resultSet.getString("email"));
            return user;
        }

        return null;
    }

    public List<User> getAllUsers() throws SQLException,ClassNotFoundException{
        Connection conn = DBConnection.getConnection();
        String sql = "SELECT * FROM Users";
        Statement statement = conn.createStatement();
        ResultSet rs = statement.executeQuery(sql);
        List<User> userList = new ArrayList<>();
        while (rs.next()) {
            User user = new User();
            user.setUsername(rs.getString("username"));
            user.setPassword(rs.getString("password"));
            user.setEmail(rs.getString("email"));
            user.setPlace(rs.getString("place"));
            user.setRole(rs.getString("role"));
            userList.add(user);
        }
        rs.close();
        statement.close();
        conn.close();
        return userList;
    }

    public void deleteUser(String username) throws SQLException,ClassNotFoundException {
        Connection conn = DBConnection.getConnection();
        String sql = "DELETE FROM Users WHERE username=?";
        PreparedStatement statement = conn.prepareStatement(sql);
        statement.setString(1, username);
        statement.executeUpdate();
        statement.close();
        
    }
    public boolean updateUser(User originalUser, User updatedUser) throws ClassNotFoundException,SQLException {
        String sql = "UPDATE users SET username = ?, email = ?, place = ?, password = ?, role = ? WHERE username = ?";
        Connection connection = DBConnection.getConnection();
        		PreparedStatement statement = connection.prepareStatement(sql);
            statement.setString(1, updatedUser.getUsername());
            statement.setString(2, updatedUser.getEmail());
            statement.setString(3, updatedUser.getPlace());
            statement.setString(4, updatedUser.getPassword());
            statement.setString(5, updatedUser.getRole());
            statement.setString(6, originalUser.getUsername());

            int rowsUpdated = statement.executeUpdate();
            return rowsUpdated > 0;
    
    }

}
