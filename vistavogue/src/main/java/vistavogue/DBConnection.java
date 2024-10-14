package vistavogue;
import java.sql.Connection;
import java.sql.SQLException;
import java.sql.DriverManager;
public class DBConnection {
	
	    private static final String URL = "jdbc:postgresql://localhost:5432/voyagevista";
	    private static final String USER = "postgres";
	    private static final String PASSWORD = "root";

	    public static Connection getConnection() throws SQLException,ClassNotFoundException {
	    	 Class.forName("org.postgresql.Driver");
	        return DriverManager.getConnection(URL, USER, PASSWORD);
	    }
	}


