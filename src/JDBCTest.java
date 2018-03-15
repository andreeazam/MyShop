

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.Properties;

public class JDBCTest{
	public static void main (String [] args){
	

		try{
		//Class.forName("com.mysql.jdbc.Driver").newInstance();
		String url = "jdbc:oracle:thin:@37.120.250.20:1521:oracle";
		
		Properties props = new Properties();
		props.setProperty("user", "ZAMFIR_ANDREEA");
		props.setProperty("password", "stud");
		
		Connection conn = DriverManager.getConnection(url, props);
		
		//String sql = "select sysdate as current_day from dual";
		String sql = "select p.pretprodus, p.denumireprodus as pretulprodusului, denumireprodus from produse p where p.denumireprodus != null ";
		
		PreparedStatement preStatement = conn.prepareStatement(sql);
		ResultSet result = preStatement.executeQuery();
		
		while(result.next()){
			System.out.println(result.getString("pretulprodusului"));
		}

		System.out.println("done");
		}catch(SQLException e){
			e.printStackTrace();
		}
		
	}

}
