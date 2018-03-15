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
	<h1>Primire Comanda in Stoc</h1>
	
	<%!
		public class ComandaPrimire{

		    /* String URL = "jdbc:oracle:thin:@37.120.250.20:1521:oracle";
			String USERNAME = "ZAMFIR_ANDREEA";
			String PASSWORD = "stud";
			*/
			
			String URL = "jdbc:oracle:thin:@localhost:1521:andreeaz";
			String USERNAME = "SCOTT";
			String PASSWORD = "stud";
						
			Connection connection = null;
			ResultSet resultSet = null;
			ResultSet resultSet2 = null;
			ResultSet resultSet3 = null;
			
			//PreparedStatements:		    
			PreparedStatement insertComandaPrimire = null;
			PreparedStatement cantitateExistentaDupaId = null;
			PreparedStatement updateCantitateProdus = null;	
			
			public int cantitateVecheInStoc = 0;
			
			//Constructor
			public ComandaPrimire(){
				try {
					//Conexiunea la baza:
					connection = DriverManager.getConnection(URL,USERNAME,PASSWORD);
										
				 	long idProdusPrimit = 0;
				 	int numarComandaPrimire=0;
				 	int cantitatePrimitaProdus=0;
				 	
				 	int cantitateNouaInStoc=0;
				 	
				 //Prepared Statements:						
				 insertComandaPrimire= connection.prepareStatement("INSERT INTO comenziprimireinstoc(numarcomanda, id_produs, cantitate, timestamp) "
					                                                  +"VALUES(?,?,?,?)");				
			 	 cantitateExistentaDupaId = connection.prepareStatement("SELECT p.cantitateinstoc from produse p where p.id_produs = ?");
			 	 updateCantitateProdus = connection.prepareStatement("UPDATE produse p SET p.cantitateinstoc  = ? where p.ID_PRODUS = ?");

				}catch(SQLException e){
					e.printStackTrace();
					
				}
			}
		  
	      //Metoda1 : adaugarea Comenzii in tabela ComenziPrimireInStoc:
		   public int setComandaPrimire (int numarComandaPrimire,long idProdusPrimit,int cantitatePrimitaProdus, Timestamp timestamp){
			   int result = 0;
			   
			   try{
				    insertComandaPrimire.setInt(1, numarComandaPrimire);
			   		insertComandaPrimire.setLong(2, idProdusPrimit);
			   		insertComandaPrimire.setInt(3, cantitatePrimitaProdus);
			   		insertComandaPrimire.setTimestamp(4, timestamp);
			
				    result = insertComandaPrimire.executeUpdate();
			   }catch(SQLException e){
				   e.printStackTrace();
			        }
			      return result;	       
		   	   }

		   
		   //Metoda 2: Update cantitate in tabela PRODUSE dupa primirea comenzii:
		   public int updateCantitateInStoc(int cantitateVecheInStoc, int cantitatePrimitaProdus, long idProdusPrimit, int cantitateNouaInStoc){
			  try{
			  
			//Primul query pentru obtinerea cantitatii vechi:
		 	   cantitateExistentaDupaId.setLong(1, idProdusPrimit);									
			   resultSet2 = cantitateExistentaDupaId.executeQuery();
			   				   
			   if (!resultSet2.next()){
				   System.out.println("Nu exista produse pentru query");
			   }			
			   //Incarcarea valorii in variabila cantitateVecheInStoc:
			   cantitateVecheInStoc = resultSet2.getInt("cantitateinstoc");
		       System.out.println("Return cantitatea veche in stoc: " +cantitateVecheInStoc);
			   				        
		       //Incarcarea in variabila cantitateNouaInStoc:
		       cantitateNouaInStoc = cantitateVecheInStoc+cantitatePrimitaProdus;
			  
		       //Al doilea query:
			   updateCantitateProdus.setInt(1, cantitateNouaInStoc);
		       updateCantitateProdus.setLong(2, idProdusPrimit);
				        
			        //Execute Update pentru al doilea query:
		            cantitateNouaInStoc = updateCantitateProdus.executeUpdate();
				        
				        System.out.println("Noua cantitate este: "+cantitateNouaInStoc+" CantitateVecheInStoc: "+cantitateVecheInStoc+" Cantitatea primita: "+cantitatePrimitaProdus+"Noua cantitate: "+cantitateNouaInStoc);
			   }catch(SQLException e){
				   e.printStackTrace();
			   }
			   
			   return cantitateNouaInStoc;
		   }
		   
		   }   
	%>	
	<%

		int result = 0;
		int resultCantitateVeche=0;
		int resultCantitateNoua=0;
		Class.forName("oracle.jdbc.driver.OracleDriver");
		
		//Daca butonul "submit" a fost apasat:
		if (request.getParameter("submit")!= null){
					
			 	long idProdusPrimit = 0;
			 	int numarComandaPrimire=0;
			 	int cantitatePrimitaProdus=0;
			 	
			 	int cantitateVecheInStoc=0;
			 	int cantitateNouaInStoc=0;
			 	
			 	try{
					 	if (request.getParameter("numarComandaPrimire") != null){
					 		numarComandaPrimire = Integer.parseInt(request.getParameter("numarComandaPrimire"));
					 	}
					 	
					 	if (request.getParameter("idProdusPrimit") != null){
					 		idProdusPrimit = Long.parseLong(request.getParameter("idProdusPrimit"));
					 	}
					 	
					 	if (request.getParameter("cantitatePrimitaProdus") != null){
					 		cantitatePrimitaProdus = Integer.parseInt(request.getParameter("cantitatePrimitaProdus"));
					 	}
					 	
					 	
					 	Date date = new Date();
					 	Timestamp timestamp = new Timestamp(date.getTime());
					
	    			 	ComandaPrimire comandaPrimire = new ComandaPrimire();
				
					   result = comandaPrimire.setComandaPrimire(numarComandaPrimire, idProdusPrimit, cantitatePrimitaProdus, timestamp);
					   resultCantitateNoua = comandaPrimire.updateCantitateInStoc(cantitateVecheInStoc, cantitatePrimitaProdus, 
							                                                       idProdusPrimit, cantitateNouaInStoc);
					   
			 	}catch(NumberFormatException e){
			 		e.printStackTrace();
			 	}
		    	
		}
	%>	
	
	<form name="myForm" action="primireInStoc.jsp" method="POST">
		<table border="0">
			<tbody>
				<tr>
					<td>Numar Comanda</td>
					<td><input type="text" name="numarComandaPrimire" value="" size="50"/></td>
				</tr>
				<tr>
					<td>Cod Produs</td>
					<td><input type="text" name="idProdusPrimit" value="" size="50"/></td>
				</tr>
				<tr>				
					<td>Cantitate</td>
					<td><input type="text" name="cantitatePrimitaProdus" value="" size="50"/></td>
				</tr>
			</tbody>
		</table>
		<input type="reset" value="Anuleaza" name="clear" class = "btn btn-warning"/>
		<input type="submit" value="Primeste in stoc" name="submit" class = "btn btn-warning"/>
	</form>	
</body>
</html>