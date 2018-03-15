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
<nav class="navbar" role="navigation" style="background-color:Black">

            <div class="container">
                <!-- Brand and toggle get grouped for better mobile display -->
                <div class="menu-container js_nav-item">
                    <button type="button" class="navbar-toggle" data-toggle="collapse" data-target=".nav-collapse">
                        <span class="sr-only">Toggle navigation</span>
                        <span class="toggle-icon"></span>
                    </button>

                    <!-- Logo -->
                    <!--div class="logo">
                        <a class="logo-wrap" href="#body">
                            <img class="logo-img logo-img-main" src="../img/logo.png" alt="Asentus Logo">
                            <img class="logo-img logo-img-active" src="../img/logo-dark.png" alt="Asentus Logo">
                        </a>
                    </div>
                    <!-- End Logo -->
                </div>

                <!-- Collect the nav links, forms, and other content for toggling -->
                <div class="collapse navbar-collapse nav-collapse">
                    <div class="menu-container">
                        <ul class="nav navbar-nav navbar-nav-right">
                            <li class="js_nav-item nav-item"><a class="nav-item-child nav-item-hover" href="adaugaProdusNou.jsp">
											<input type="submit" class = "btn btn-warning" value="Adauga Produs Nou" name="adProdus"/>
							</a></li>
                            <li class="js_nav-item nav-item"><a class="nav-item-child nav-item-hover" href="primireInStoc.jsp">
												<input type="submit" class = "btn btn-warning" value="Primeste Produse In Stoc" name="primProd"/>
		
							</a></li>
                            <li class="js_nav-item nav-item"><a class="nav-item-child nav-item-hover" href="stareStocuri.jsp">
												
												<input type="submit" class = "btn btn-warning" value="Verifica stocuri" name="verStoc"/>

		
							</a></li>
                            <li class="js_nav-item nav-item"><a class="nav-item-child nav-item-hover" href="comenziClienti.jsp">

											<input type="submit" value="Comenzi Clienti" name="comClien" class = "btn btn-warning" />
		
							</a></li>
                        </ul>
                    </div>
                </div>
                <!-- End Navbar Collapse -->
            </div>
        </nav>

<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Inserting data in database</title>
</head>
<body>
	<h1>Adaugare produs nou</h1>
	
	<%!
		public class Produs{
			/* String URL = "jdbc:oracle:thin:@37.120.250.20:1521:oracle";
			String USERNAME = "ZAMFIR_ANDREEA";
			String PASSWORD = "stud";
			*/
			
			String URL = "jdbc:oracle:thin:@localhost:1521:andreeaz";
			String USERNAME = "SCOTT";
			String PASSWORD = "stud";
			
			Connection connection = null;
			PreparedStatement insertProdus = null;
			ResultSet resultSet = null;
			
			
			
			public Produs(){
				try {
					connection = DriverManager.getConnection(URL,USERNAME,PASSWORD);
					
					insertProdus = connection.prepareStatement(
							"INSERT INTO produse(id_produs, denumireprodus, pretprodus, cantitateinstoc)"
							+" VALUES(?,?,?,?)"							
							);
				}catch(SQLException e){
					e.printStackTrace();					
				}
			}
		  
	      
		   public int setProdus (long idProdus, String denumireProdus, double pretProdus, int cantitateInStoc){
			   int result = 0;
			   
			   
			   try{
			   		insertProdus.setLong(1, idProdus);
			   		insertProdus.setString(2, denumireProdus);
			   		insertProdus.setDouble(3, pretProdus);
			   		insertProdus.setInt(4, cantitateInStoc);

					
			   		result = insertProdus.executeUpdate();
			   }catch(SQLException e){
				   e.printStackTrace();
			        }
			      return result;	       
		   	   }	   
		   }	   
	%>	
	<%

		int result = 0;
		
	 	long idProdus = 0;
	 	String denumireProdus = new String();
	 	double pretProdus = 0.00;
	 	int cantitateInStoc = 0;
	 	
		if (request.getParameter("submit")!= null){
	 	
		 	try{
				 	if (request.getParameter("idProdus") != null ){
				 		idProdus = Long.parseLong(request.getParameter("idProdus"));
				 	}
				 	
				 	if (request.getParameter("denumireProdus") != null){
				 		denumireProdus = request.getParameter("denumireProdus");
				 	}
				 	
				 	if (request.getParameter("pretProdus") != null){
				 		pretProdus = Double.parseDouble(request.getParameter("pretProdus"));
				 	}
				 	
				 	//Date date = new Date();
				 	//Timestamp timestamp = new Timestamp(date.getTime());
				    cantitateInStoc = 0;
				 	
				 	Produs produs = new Produs();
			
				    result = produs.setProdus(idProdus, denumireProdus, pretProdus, cantitateInStoc);
		 	}catch(NumberFormatException e){
		 		e.printStackTrace();
		 	}catch(NullPointerException e){
		 		System.out.println("Null pointer Exception");
		 		
		 	}
		}
	%>	
	
	<form name="myForm" action="adaugaProdusNou.jsp" method="POST">
		<table border="0">
			<tbody>
				<tr>
					<td>ID Produs</td>
					<td><input type="text" name="idProdus" value="" size="50"/></td>
				</tr>
				<tr>
					<td>Denumire Produs</td>
					<td><input type="text" name="denumireProdus" value="" size="50"/></td>
					
				</tr>
				<tr>				
					<td>Pret Produs</td>
					<td><input type="text" name="pretProdus" value="" size="50"/></td>
				</tr>
			</tbody>
		</table>
		<input type="reset" value="Anuleaza" name="clear" class="btn btn-warning"/>
		<input type="submit" value="Adauga" name="submit" class="btn btn-warning"/>
	</form>	
</body>
</html>