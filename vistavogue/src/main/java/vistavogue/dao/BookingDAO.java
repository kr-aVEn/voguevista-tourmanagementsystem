package vistavogue.dao;


import java.sql.*;
import java.util.ArrayList;
import java.util.List;
import vistavogue.DBConnection;
import vistavogue.beans.Booking;

public class BookingDAO {

    public void addBooking(Booking booking) throws SQLException,ClassNotFoundException {
        Connection conn = DBConnection.getConnection();
        String sql = "INSERT INTO Bookings (username, package_id, booking_date, travel_date, num_travelers, status) VALUES (?, ?, ?, ?, ?, ?)";
        PreparedStatement statement = conn.prepareStatement(sql);
        statement.setString(1, booking.getUsername());
        statement.setInt(2, booking.getPackageId());
        statement.setDate(3, booking.getBookingDate());
        statement.setDate(4, booking.getTravelDate());
        statement.setInt(5, booking.getNumTravelers());
        statement.setString(6, booking.getStatus());
        statement.executeUpdate();
        statement.close();
        conn.close();
    }

    public Booking getBooking(int id) throws SQLException,ClassNotFoundException {
        Connection conn = DBConnection.getConnection();
        String sql = "SELECT * FROM Bookings WHERE id=?";
        PreparedStatement statement = conn.prepareStatement(sql);
        statement.setInt(1, id);
        ResultSet rs = statement.executeQuery();
        Booking booking = null;
        if (rs.next()) {
            booking = new Booking();
            booking.setId(rs.getInt("id"));
            booking.setUsername(rs.getString("username"));
            booking.setPackageId(rs.getInt("package_id"));
            booking.setBookingDate(rs.getDate("booking_date"));
            booking.setTravelDate(rs.getDate("travel_date"));
            booking.setNumTravelers(rs.getInt("num_travelers"));
            booking.setStatus(rs.getString("status"));
        }
        rs.close();
        statement.close();
        conn.close();
        return booking;
    }

    public List<Booking> getAllBookings() throws SQLException,ClassNotFoundException{
        Connection conn = DBConnection.getConnection();
        String sql = "SELECT * FROM Bookings";
        Statement statement = conn.createStatement();
        ResultSet rs = statement.executeQuery(sql);
        List<Booking> bookingList = new ArrayList<>();
        while (rs.next()) {
            Booking booking = new Booking();
            booking.setId(rs.getInt("id"));
            booking.setUsername(rs.getString("username"));
            booking.setPackageId(rs.getInt("package_id"));
            booking.setBookingDate(rs.getDate("booking_date"));
            booking.setTravelDate(rs.getDate("travel_date"));
            booking.setNumTravelers(rs.getInt("num_travelers"));
            booking.setStatus(rs.getString("status"));
            bookingList.add(booking);
        }
        rs.close();
        statement.close();
        conn.close();
        return bookingList;
    }

    public void updateBookingStatus(int bookingId, String status) throws SQLException,ClassNotFoundException {
        Connection conn = DBConnection.getConnection();
        String sql = "UPDATE Bookings SET status=? WHERE id=?";
        PreparedStatement statement = conn.prepareStatement(sql);
        statement.setString(1, status);
        statement.setInt(2, bookingId);
        statement.executeUpdate();
        statement.close();
        conn.close();
    }

    public void deleteBooking(int bookingId) throws SQLException,ClassNotFoundException {
        Connection conn = DBConnection.getConnection();
        String sql = "DELETE FROM Bookings WHERE id=?";
        PreparedStatement statement = conn.prepareStatement(sql);
        statement.setInt(1, bookingId);
        statement.executeUpdate();
        statement.close();
        conn.close();
    }
}
