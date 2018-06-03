

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.Properties;

public class DBConnect {
	public static void main (String [] args)throws SQLException{
		
		String url = "jdbc:oracle:thin:@37.120.250.20:1521:oracle";
		String user = "ZAMFIR_ANDREEA";
		String pass = "stud";
				
		
		Properties props = new Properties();
		props.setProperty("user", "ZAMFIR_ANDREEA");
		props.setProperty("password", "stud");
		
		Connection conn = DriverManager.getConnection(url, user, pass);
		
		String sql = "select p.pretprodus, p.denumireprodus from produse p where p.pretprodus = ?";
		
		PreparedStatement preStatement = conn.prepareStatement(sql);
		ResultSet result = preStatement.executeQuery();
		
		while(result.next()){
			System.out.println(result.getString(result.toString()));
			
		}

		System.out.println("done");		
	}

}
