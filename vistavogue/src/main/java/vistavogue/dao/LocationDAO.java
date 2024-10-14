package vistavogue.dao;


import java.sql.*;
import java.util.ArrayList;
import java.util.List;
import vistavogue.DBConnection;
import vistavogue.beans.Location;

public class LocationDAO {

    public void addLocation(Location location) throws SQLException,ClassNotFoundException {
        Connection conn = DBConnection.getConnection();
        String sql = "INSERT INTO Locations (name, description, latitude, longitude) VALUES (?, ?, ?, ?)";
        PreparedStatement statement = conn.prepareStatement(sql);
        statement.setString(1, location.getName());
        statement.setString(2, location.getDescription());
        statement.setDouble(3, location.getLatitude());
        statement.setDouble(4, location.getLongitude());
        statement.executeUpdate();
        statement.close();
        conn.close();
    }

    public Location getLocation(int id) throws SQLException,ClassNotFoundException {
        Connection conn = DBConnection.getConnection();
        String sql = "SELECT * FROM Locations WHERE id=?";
        PreparedStatement statement = conn.prepareStatement(sql);
        statement.setInt(1, id);
        ResultSet rs = statement.executeQuery();
        Location location = null;
        if (rs.next()) {
            location = new Location();
           
            location.setName(rs.getString("name"));
            location.setDescription(rs.getString("description"));
            location.setLatitude(rs.getDouble("latitude"));
            location.setLongitude(rs.getDouble("longitude"));
        }
        rs.close();
        statement.close();
        conn.close();
        return location;
    }

    public List<Location> getAllLocations() throws SQLException,ClassNotFoundException {
        Connection conn = DBConnection.getConnection();
        String sql = "SELECT * FROM locations";
        Statement statement = conn.createStatement();
        ResultSet rs = statement.executeQuery(sql);
        List<Location> locationList = new ArrayList<>();
        while (rs.next()) {
            Location location = new Location();
           location.setId(rs.getInt("id"));
            location.setName(rs.getString("name"));
            location.setDescription(rs.getString("description"));
            location.setLatitude(rs.getDouble("latitude"));
            location.setLongitude(rs.getDouble("longitude"));
            locationList.add(location);
        }
        rs.close();
        statement.close();
        
        return locationList;
    }

    public void deleteLocation(int locationId) throws SQLException,ClassNotFoundException{
        Connection conn = DBConnection.getConnection();
        String sql = "DELETE FROM Locations WHERE id=?";
        PreparedStatement statement = conn.prepareStatement(sql);
        statement.setInt(1, locationId);
        statement.executeUpdate();
        statement.close();
        conn.close();
    }
}

