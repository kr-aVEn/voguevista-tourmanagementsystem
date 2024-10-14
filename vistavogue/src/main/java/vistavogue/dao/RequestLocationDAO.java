package vistavogue.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;

import vistavogue.DBConnection;

public class RequestLocationDAO {
    public void addRequestLocation(String name, String latitude, String longitude) throws SQLException, ClassNotFoundException {
        String query = "INSERT INTO request_location (name, latitude, longitude) VALUES (?, ?, ?)";
        try (Connection connection = DBConnection.getConnection();
             PreparedStatement preparedStatement = connection.prepareStatement(query)) {
            preparedStatement.setString(1, name);
            preparedStatement.setString(2, latitude);
            preparedStatement.setString(3, longitude);
            int rowsInserted = preparedStatement.executeUpdate();
            System.out.println("Rows inserted: " + rowsInserted); 
        } catch (SQLException e) {
            e.printStackTrace(); 
            throw e;
        }
    }
}
