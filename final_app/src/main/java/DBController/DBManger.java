package DBController;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class DBManger {
	public static Connection getConnection(){
		Connection con=null;
		try {
			Class.forName("com.mysql.jdbc.Driver");
		} catch (ClassNotFoundException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		String url="jdbc:mysql://localhost:3306/final_app?user=root&password=";
		try {
			con =DriverManager.getConnection(url);
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return con;
	}
	
	public static void main(String[] args){
	}
	
	
	
	
}
