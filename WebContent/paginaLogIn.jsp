<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>

<%@page import="java.sql.*" %>
<%@page import="java.util.Date" %>
<%@page import="java.sql.Connection"%>
<%@page import="java.sql.Driver"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.PreparedStatement" %>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.SQLException"%>
<%@page import="java.util.Properties"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<link href="/MyShop1/bootstrap-3.3.7-dist/bootstrap-3.3.7-dist/css/bootstrap.css" rel="stylesheet" type="text/css" />

<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Logare</title>
</head>
<body>
	<%!

	public class Login{
	 /* 
	 String URL = "jdbc:oracle:thin:@37.120.250.20:1521:oracle";
	  String USERNAME = "ZAMFIR_ANDREEA";
	  String PASSWORD = "stud";
	  */
		String URL = "jdbc:oracle:thin:@localhost:1521:andreeaz";
		String USERNAME = "SCOTT";
		String PASSWORD = "stud";
	  
      String parolaDB="";
      
	Connection connection = null;
	
	//PreparedStatements:		    
	PreparedStatement returnParolaAngajat = null;
	
	//Variabile globale:
 	long idAngajat = 0;
 	String numeAngajat="";
 	String prenumeAngajat="";
 	String usernameAngajat ="";
 	String parolaAngajat="";
 	String parolaData="";
 	
 	//Result sets:
    ResultSet resultSetParolaDB=null;
	
	//Constructor
	public Login(){
		try {
			//Conexiunea la baza:
			connection = DriverManager.getConnection(URL,USERNAME,PASSWORD);
									 	
		 //Prepared Statements:		
	      returnParolaAngajat = connection.prepareStatement("SELECT a.parola from angajati a where a.username like ?");
          
		}catch(SQLException e){
			e.printStackTrace();
		}
	}
		
	
    //get parola userului dupa username:
	public String parolaDB (String usernameAngajat, String parolaData){
			  
			   if (usernameAngajat !=null && parolaData != null){
			   try{

				   returnParolaAngajat.setString(1, usernameAngajat);
				   resultSetParolaDB = returnParolaAngajat.executeQuery();
				   
				   if (!resultSetParolaDB.next()){
					   System.out.println("Parola gresita");
				   }
				   
				 
				   //Incarcarea valorii parolaDB cu parola din baza gasita e query
				   parolaDB = resultSetParolaDB.getString("parola");
			      

				    System.out.println(parolaDB);
			   }catch(SQLException e){
				   e.printStackTrace();
			        }
			      return parolaDB;	
		   	   }else{
		   		   return "nope";
		   		   }		
		   	   }
	}
	
  
	%>	
	<%
		Class.forName("oracle.jdbc.driver.OracleDriver");
		
		//Daca butonul "login" a fost apasat:
		if (request.getParameter("login")!= null){
					
			 	String usernameAngajat="";
			 	String result = "";
			 	String parolaData="";
			 	
			 	try{
			 		
					 	if (request.getParameter("usernameAngajat") != null){
					 		
					 		usernameAngajat = request.getParameter("usernameAngajat");
					 	}					 	
					 	if (request.getParameter("parola") != null){
					 		parolaData = request.getParameter("parola");
					 	}else{
					 		System.out.println("Introduceti parola");
					 	}
									
						if((request.getParameter("usernameAngajat")!=null)&&(request.getParameter("parola") != null)){
							usernameAngajat = request.getParameter("usernameAngajat");
							parolaData = request.getParameter("parola");
						}else{
							System.out.println("Introduceti corect datele");
						}
										    
	    			  Login login = new Login();

					  result = login.parolaDB(usernameAngajat, parolaData);
					  System.out.println(result);
					  
				      if((result.toString()).equals(parolaData)){
						   System.out.println("Bine ai venit "+usernameAngajat);
						%>
						
					       <jsp:forward page="comenziClienti.jsp"></jsp:forward>
					       
	 					<%   
	 
					   }else{
						   System.out.println("Introduceti parola corecta!");
					   }
					 					  
			 	}catch(NumberFormatException e){
			 		e.printStackTrace();
			 	}finally{
			 		System.out.println("done");
			 		}
		}	
	%>	
	<form name="myForm" action="paginaLogIn.jsp" method="POST">
		<table border="0">
			<tbody>
				<tr>
					<td>Utilizator</td>
					<td><input type="text" name="usernameAngajat" value="" size="50"/></td>
				</tr>
				<tr>
					<td>Parola</td>
					<td><input type="password" name="parola" value="" size="50"/></td>
				</tr>
			</tbody>
		</table>
		<input type="reset" value="Anulare" name="clear"/>
		<input type="submit" value="Log In" name="login"/>
	</form>	
</body>
</html>