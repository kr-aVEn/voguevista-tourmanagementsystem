package vistavogue.dao;



import java.sql.*;
import java.util.ArrayList;
import java.util.List;
import vistavogue.DBConnection;
import vistavogue.beans.Review;

public class ReviewDAO {

    public void addReview(Review review) throws SQLException,ClassNotFoundException {
        Connection conn = DBConnection.getConnection();
        String sql = "INSERT INTO Reviews (user_id, package_id, review, rating) VALUES (?, ?, ?, ?)";
        PreparedStatement statement = conn.prepareStatement(sql);
        statement.setInt(1, review.getUserId());
        statement.setInt(2, review.getPackageId());
        statement.setString(3, review.getReview());
        statement.setInt(4, review.getRating());
        statement.executeUpdate();
        statement.close();
        conn.close();
    }

    public Review getReview(int id) throws SQLException,ClassNotFoundException {
        Connection conn = DBConnection.getConnection();
        String sql = "SELECT * FROM Reviews WHERE id=?";
        PreparedStatement statement = conn.prepareStatement(sql);
        statement.setInt(1, id);
        ResultSet rs = statement.executeQuery();
        Review review = null;
        if (rs.next()) {
            review = new Review();
            review.setId(rs.getInt("id"));
            review.setUserId(rs.getInt("user_id"));
            review.setPackageId(rs.getInt("package_id"));
            review.setReview(rs.getString("review"));
            review.setRating(rs.getInt("rating"));
        }
        rs.close();
        statement.close();
        conn.close();
        return review;
    }

    public List<Review> getAllReviews() throws SQLException,ClassNotFoundException {
        Connection conn = DBConnection.getConnection();
        String sql = "SELECT * FROM Reviews";
        Statement statement = conn.createStatement();
        ResultSet rs = statement.executeQuery(sql);
        List<Review> reviewList = new ArrayList<>();
        while (rs.next()) {
            Review review = new Review();
            review.setId(rs.getInt("id"));
            review.setUserId(rs.getInt("user_id"));
            review.setPackageId(rs.getInt("package_id"));
            review.setReview(rs.getString("review"));
            review.setRating(rs.getInt("rating"));
            reviewList.add(review);
        }
        rs.close();
        statement.close();
        conn.close();
        return reviewList;
    }

    public void deleteReview(int reviewId) throws SQLException,ClassNotFoundException {
        Connection conn = DBConnection.getConnection();
        String sql = "DELETE FROM Reviews WHERE id=?";
        PreparedStatement statement = conn.prepareStatement(sql);
        statement.setInt(1, reviewId);
        statement.executeUpdate();
        statement.close();
        conn.close();
    }
}
