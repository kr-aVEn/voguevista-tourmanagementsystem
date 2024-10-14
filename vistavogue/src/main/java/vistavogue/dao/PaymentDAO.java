package vistavogue.dao;

import java.sql.*;
import vistavogue.DBConnection;
import vistavogue.beans.Payment;

public class PaymentDAO {
    
    private static final String INSERT_PAYMENT_SQL = "INSERT INTO payments (bookingId, paymentDate, amount, status) VALUES (?, ?, ?, ?);";


    public void insertPayment(Payment payment) throws SQLException, ClassNotFoundException {
        try (Connection connection = DBConnection.getConnection();
             PreparedStatement preparedStatement = connection.prepareStatement(INSERT_PAYMENT_SQL)) {
            preparedStatement.setInt(1, payment.getBookingId());
            preparedStatement.setDate(2, payment.getPaymentDate());
            preparedStatement.setDouble(3, payment.getAmount());
            preparedStatement.setString(4, payment.getStatus());
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
