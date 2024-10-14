	package vistavogue.dao;


import java.sql.*;
import java.util.ArrayList;
import java.util.List;
import vistavogue.DBConnection;
import vistavogue.beans.Activity;
public class ActivityDAO {

    public void addActivity(Activity activity) throws SQLException,ClassNotFoundException{
        Connection conn = DBConnection.getConnection();
        String sql = "INSERT INTO Activities (location_id, activity_name, description) VALUES (?, ?, ?)";
        PreparedStatement statement = conn.prepareStatement(sql);
        statement.setInt(1, activity.getLocationid());
        statement.setString(2, activity.getActivityname());
        statement.setString(3, activity.getDescription());
        statement.executeUpdate();
        statement.close();
        conn.close();
    }

    public Activity getActivity(int id) throws SQLException,ClassNotFoundException {
        Connection conn = DBConnection.getConnection();
        String sql = "SELECT * FROM Activities WHERE id=?";
        PreparedStatement statement = conn.prepareStatement(sql);
        statement.setInt(1, id);
        ResultSet rs = statement.executeQuery();
        Activity activity = null;
        if (rs.next()) {
            activity = new Activity();
            activity.setId(rs.getInt("id"));
            activity.setLocationid(rs.getInt("location_id"));
            activity.setActivityname(rs.getString("activity_name"));
            activity.setDescription(rs.getString("description"));
        }
        rs.close();
        statement.close();
        conn.close();
        return activity;
    }

    
    public List<Activity> getAllActivities(int id) throws SQLException,ClassNotFoundException {
        Connection conn = DBConnection.getConnection();
        String sql = "SELECT * FROM Activities where location_id=? ";
        PreparedStatement statement = conn.prepareStatement(sql);
        statement.setInt(1, id);
        ResultSet rs = statement.executeQuery();
        List<Activity> activityList = new ArrayList<>();
        while (rs.next()) {
            Activity activity = new Activity();
            activity.setId(rs.getInt("id"));
            activity.setLocationid(rs.getInt("location_id"));
            activity.setActivityname(rs.getString("activity_name"));
            activity.setDescription(rs.getString("description"));
            activityList.add(activity);
        }
        rs.close();
        statement.close();
        conn.close();
        return activityList;
    }

    public void deleteActivity(int activityId) throws SQLException,ClassNotFoundException {
        Connection conn = DBConnection.getConnection();
        String sql = "DELETE FROM Activities WHERE id=?";
        PreparedStatement statement = conn.prepareStatement(sql);
        statement.setInt(1, activityId);
        statement.executeUpdate();
        statement.close();
        conn.close();
    }
}
