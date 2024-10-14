package vistavogue.dao;
import vistavogue.beans.Location;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;
import vistavogue.DBConnection;
import vistavogue.beans.Package;

public class PackageDAO {

	public void addPackage(Package pkg) throws SQLException, ClassNotFoundException {
        Connection conn = DBConnection.getConnection();
        String sql = "INSERT INTO Packages (name, duration, route, cost) VALUES (?, ?, ?, ?)";
        PreparedStatement statement = conn.prepareStatement(sql);
        statement.setString(1, pkg.getName());
        statement.setInt(2, pkg.getDuration()); 
        statement.setString(3, pkg.getRoute());
        statement.setDouble(4, pkg.getCost());
        statement.executeUpdate();
        statement.close();
        conn.close();
    }

    public Package getPackage(int id) throws SQLException,ClassNotFoundException {
        Connection conn = DBConnection.getConnection();
        String sql = "SELECT * FROM Packages WHERE id=?";
        PreparedStatement statement = conn.prepareStatement(sql);
        statement.setInt(1, id);
        ResultSet rs = statement.executeQuery();
        Package pkg = null;
        if (rs.next()) {
            pkg = new Package();
            pkg.setId(rs.getInt("id"));
            pkg.setName(rs.getString("name"));
            pkg.setDuration(rs.getInt("duration"));
            pkg.setRoute(rs.getString("route"));
            pkg.setCost(rs.getDouble("cost"));
        }
        rs.close();
        statement.close();
        conn.close();
        return pkg;
    }

    public List<Package> getAllPackages() throws SQLException,ClassNotFoundException {
        Connection conn = DBConnection.getConnection();
        String sql = "SELECT * FROM Packages";
        Statement statement = conn.createStatement();
        ResultSet rs = statement.executeQuery(sql);
        List<Package> packageList = new ArrayList<>();
        while (rs.next()) {
            Package pkg = new Package();
            pkg.setId(rs.getInt("id"));
            pkg.setName(rs.getString("name"));
            pkg.setDuration(rs.getInt("duration"));
            pkg.setRoute(rs.getString("route"));
            pkg.setCost(rs.getDouble("cost"));
            packageList.add(pkg);
        }
        rs.close();
        statement.close();
        conn.close();
        return packageList;
    }
    public List<Location> getLocationsForPackage(int packageId) throws SQLException, ClassNotFoundException {
        Connection connection = DBConnection.getConnection();
        String query = "SELECT *  FROM Locations l JOIN Package_Locations pl ON l.id = pl.location_id WHERE pl.package_id = ?";
        List<Location> locations = new ArrayList<>();
        try (PreparedStatement pstmt = connection.prepareStatement(query)) {
            pstmt.setInt(1, packageId);
            try (ResultSet rs = pstmt.executeQuery()) {
                while (rs.next()) {
                    Location location = new Location();
                    location.setId(rs.getInt("id"));
                    location.setName(rs.getString("name"));
                    location.setDescription(rs.getString("description"));
                    location.setLatitude(rs.getDouble("latitude"));
                    location.setLongitude(rs.getDouble("longitude"));
                    locations.add(location);
                }
            }
        }
        return locations;
    }

    public void deletePackage(int packageId) throws SQLException,ClassNotFoundException{
        Connection conn = DBConnection.getConnection();
        String sql = "DELETE FROM Packages WHERE id=?";
        PreparedStatement statement = conn.prepareStatement(sql);
        statement.setInt(1, packageId);
        statement.executeUpdate();
        statement.close();
        conn.close();
    }
}
