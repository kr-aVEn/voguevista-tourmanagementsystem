package vistavogue.dao;


import java.sql.*;
import java.util.ArrayList;
import java.util.List;
import vistavogue.DBConnection;
import vistavogue.beans.CustomizationRequest;

public class CustomizationRequestDAO {

	public void saveRequest(CustomizationRequest request) throws ClassNotFoundException, SQLException {
		String sql = "INSERT INTO CustomizationRequests (user_id, package_id, request_details, status) " +
                "SELECT u.id AS user_id, p.id AS package_id, ?, 'pending' AS status " +
                "FROM Users u " +
                "JOIN Packages p ON p.id = ? " +
                "WHERE u.username = ?"; 
        try (Connection conn = DBConnection.getConnection(); 
 PreparedStatement pstmt = conn.prepareStatement(sql)) {
            
         
            pstmt.setString(1, request.getRequestDetails()); 
            pstmt.setInt(2,request.getPackageId()); 
            pstmt.setString(3, request.getUserId());
            
           
            int rowsInserted = pstmt.executeUpdate();
            System.out.println(rowsInserted + " row(s) inserted.");
            
        }
           
	}

    public CustomizationRequest getCustomizationRequest(int id) throws SQLException,ClassNotFoundException {
        Connection conn = DBConnection.getConnection();
        String sql = "SELECT * FROM CustomizationRequests WHERE id=?";
        PreparedStatement statement = conn.prepareStatement(sql);
        statement.setInt(1, id);
        ResultSet rs = statement.executeQuery();
        CustomizationRequest request = null;
        if (rs.next()) {
            request = new CustomizationRequest();
            request.setId(rs.getInt("id"));
            request.setUserId(rs.getString("user_id"));
            request.setPackageId(rs.getInt("package_id"));
            request.setRequestDetails(rs.getString("request_details"));
            request.setStatus(rs.getString("status"));
        }
        rs.close();
        statement.close();
        conn.close();
        return request;
    }

    public List<CustomizationRequest> getAllCustomizationRequests() throws SQLException,ClassNotFoundException {
        Connection conn = DBConnection.getConnection();
        String sql = "SELECT * FROM CustomizationRequests";
        Statement statement = conn.createStatement();
        ResultSet rs = statement.executeQuery(sql);
        List<CustomizationRequest> requestList = new ArrayList<>();
        while (rs.next()) {
            CustomizationRequest request = new CustomizationRequest();
            request.setId(rs.getInt("id"));
            request.setUserId(rs.getString("user_id"));
            request.setPackageId(rs.getInt("package_id"));
            request.setRequestDetails(rs.getString("request_details"));
            request.setStatus(rs.getString("status"));
            requestList.add(request);
        }
        rs.close();
        statement.close();
        conn.close();
        return requestList;
    }

    public void updateRequestStatus(int requestId, String status) throws SQLException,ClassNotFoundException {
        Connection conn = DBConnection.getConnection();
        String sql = "UPDATE CustomizationRequests SET status=? WHERE id=?";
        PreparedStatement statement = conn.prepareStatement(sql);
        statement.setString(1, status);
        statement.setInt(2, requestId);
        statement.executeUpdate();
        statement.close();
        conn.close();
    }

    public void deleteCustomizationRequest(int requestId) throws SQLException,ClassNotFoundException {
        Connection conn = DBConnection.getConnection();
        String sql = "DELETE FROM CustomizationRequests WHERE id=?";
        PreparedStatement statement = conn.prepareStatement(sql);
        statement.setInt(1, requestId);
        statement.executeUpdate();
        statement.close();
        conn.close();
    }
}
