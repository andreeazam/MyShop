package com.myshop.jersey;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

public class DBConnection {
	static String URL = "jdbc:oracle:thin:@37.120.250.20:1521:oracle";
	static String USERNAME = "ZAMFIR_ANDREEA";
	static String PASSWORD = "stud";
	
	
	
	
	//connection = DriverManager.getConnection(URL,USERNAME,PASSWORD);
	
	@SuppressWarnings("finally")
	public static Connection createConnection() throws Exception {
		Connection conn = null;
		
		try {
			
			Class.forName("oracle.jdbc.driver.OracleDriver");
			conn = DriverManager.getConnection(URL, USERNAME, PASSWORD);
		} catch (Exception e){
			e.getMessage();
		}finally {
			return conn;
		}		
		
	}
	
	public static  boolean checkLoginAndroid(String uname, String pwd) throws Exception {
        boolean isClientDisponibil = false;
        Connection dbConn = null;
        try {
            try {
                dbConn = DBConnection.createConnection();
            } catch (Exception e) {             
                e.printStackTrace();
            }
            Statement stmt = dbConn.createStatement();
            String query = "SELECT * FROM clienti WHERE username = '" + uname
                    + "' AND parola =" + "'" + pwd + "'";
           
            ResultSet rs = stmt.executeQuery(query);
            while (rs.next()) {
               
                isClientDisponibil = true;
            }
        } catch (SQLException sqle) {
            throw sqle;
        } catch (Exception e) {
         
            if (dbConn != null) {
                dbConn.close();
            }
            throw e;
        } finally {
            if (dbConn != null) {
                dbConn.close();
            }
        }
        return isClientDisponibil;
    }

     
    public static boolean insertClient(String name, String uname, String pwd) throws SQLException, Exception {
        boolean insertStatus = false;
        Connection dbConn = null;
        try {
            try {
                dbConn = DBConnection.createConnection();
            } catch (Exception e) {
               
                e.printStackTrace();
            }
            Statement stmt = dbConn.createStatement();
            String query = "INSERT into user(name, username, password) values('"+name+ "',"+"'"
                    + uname + "','" + pwd + "')";
            
            int records = stmt.executeUpdate(query);
            //System.out.println(records);
            //When record is successfully inserted
            if (records > 0) {
                insertStatus = true;
            }
        } catch (SQLException e) {
            
            throw e;
        } catch (Exception e) {
            //e.printStackTrace();
            // TODO Auto-generated catch block
            if (dbConn != null) {
                dbConn.close();
            }
            throw e;
        } finally {
            if (dbConn != null) {
                dbConn.close();
            }
        }
        return insertStatus;
    }
}
