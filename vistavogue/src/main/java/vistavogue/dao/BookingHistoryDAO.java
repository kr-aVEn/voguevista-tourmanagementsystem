package vistavogue.dao;

import java.sql.*;
import vistavogue.DBConnection;
import vistavogue.beans.BookingHistory;

public class BookingHistoryDAO {
    

    private static final String INSERT_BOOKING_HISTORY_SQL = "INSERT INTO booking_history (username, packageId, bookingDate, travelDate, numTravelers, status) VALUES (?, ?, ?, ?, ?, ?);";
    private static final String SELECT_ALL_BOOKING_HISTORY = "SELECT * FROM booking_history WHERE username = ?;";
    private static final String SELECT_BOOKING_HISTORY_BY_ID = "SELECT * FROM booking_history WHERE id = ?;";
    private static final String UPDATE_BOOKING_HISTORY_SQL = "UPDATE booking_history SET status = ? WHERE id = ?;";

    public int insertBookingHistory(BookingHistory bookingHistory) throws SQLException, ClassNotFoundException {
        int generatedId = 0;
        try (Connection connection = DBConnection.getConnection();
             PreparedStatement preparedStatement = connection.prepareStatement(INSERT_BOOKING_HISTORY_SQL, Statement.RETURN_GENERATED_KEYS)) {
            preparedStatement.setString(1, bookingHistory.getUsername());
            preparedStatement.setInt(2, bookingHistory.getPackageId());
            preparedStatement.setDate(3, new java.sql.Date(bookingHistory.getBookingDate().getTime()));
            preparedStatement.setDate(4, new java.sql.Date(bookingHistory.getTravelDate().getTime()));
            preparedStatement.setInt(5, bookingHistory.getNumTravelers());
            preparedStatement.setString(6, bookingHistory.getStatus());
            preparedStatement.executeUpdate();

            ResultSet rs = preparedStatement.getGeneratedKeys();
            if (rs.next()) {
                generatedId = rs.getInt(1);
                bookingHistory.setId(generatedId);
            }
        } catch (SQLException e) {
            printSQLException(e);
        }
        return generatedId;
    }

    public BookingHistory getBookingHistoryById(int id) throws SQLException, ClassNotFoundException {
        BookingHistory bookingHistory = null;
        try (Connection connection = DBConnection.getConnection();
             PreparedStatement preparedStatement = connection.prepareStatement(SELECT_BOOKING_HISTORY_BY_ID)) {
            preparedStatement.setInt(1, id);
            ResultSet rs = preparedStatement.executeQuery();

            if (rs.next()) {
                String username = rs.getString("username");
                int packageId = rs.getInt("packageId");
                Date bookingDate = rs.getDate("bookingDate");
                Date travelDate = rs.getDate("travelDate");
                int numTravelers = rs.getInt("numTravelers");
                String status = rs.getString("status");
                bookingHistory = new BookingHistory(id, username, packageId, bookingDate, travelDate, numTravelers, status);
            }
        } catch (SQLException e) {
            printSQLException(e);
        }
        return bookingHistory;
    }
    public void updateBookingHistory(BookingHistory bookingHistory) throws SQLException, ClassNotFoundException {
        try (Connection connection = DBConnection.getConnection();
             PreparedStatement preparedStatement = connection.prepareStatement(UPDATE_BOOKING_HISTORY_SQL)) {
            preparedStatement.setString(1, bookingHistory.getStatus());
            preparedStatement.setInt(2, bookingHistory.getId());
            preparedStatement.executeUpdate();
        } catch (SQLException e) {
            printSQLException(e);
        }
    }

    private void printSQLException(SQLException ex) {
        for (Throwable e : ex) {
            if (e instanceof SQLException) {
                e.printStackTrace(System.err);
                System.err.println("SQLState: " + ((SQLException) e).getSQLState());
                System.err.println("Error Code: " + ((SQLException) e).getErrorCode());
                System.err.println("Message: " + e.getMessage());
                Throwable t = ex.getCause();
                while (t != null) {
                    System.out.println("Cause: " + t);
                    t = t.getCause();
                }
            }
        }
    }
}
