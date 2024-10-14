package vistavogue.dao;


import vistavogue.beans.PackageRequest;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;

import vistavogue.DBConnection;

public class PackageRequestDao {
   

   

    public void createPackageRequest(PackageRequest packageRequest) throws SQLException, ClassNotFoundException {
    	Connection connection = DBConnection.getConnection();
        String query = "INSERT INTO PackageRequests (username, location_ids, status) VALUES (?, ?, ?)";
        PreparedStatement statement = connection.prepareStatement(query);
        statement.setString(1, packageRequest.getUsername());
        statement.setString(2, packageRequest.getLocationIds());
        statement.setString(3, packageRequest.getStatus());
        statement.executeUpdate();
    }
}
