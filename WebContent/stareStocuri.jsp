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
<title>Stare stocuri</title>
</head>
<body>
	<%!

	{
	  String URL = "jdbc:oracle:thin:@localhost:1521:andreeaz";
	  String USERNAME = "SCOTT";
	  String PASSWORD = "stud";
	 
	 Connection connection = null;	    
	 PreparedStatement stm = null;
     ResultSet rs=null;

	}
	
  
	%>	

	<form name="newForm" action="stareStocuri.jsp" method="POST">
	
		<table class="table table-striped table-hover table table-sm table-success table-condensed">
			<thead class="">
			   <tr>
				   <th>ID Produs</th>		      
				   <th>Denumire</th>
				   <th>Pret</th>
				   <th>Cantitate in stoc</th>
			   </tr>
		  </thead>
   <%
		   try{
		   
		      Class.forName("oracle.jdbc.driver.OracleDriver");
		 	  String URL = "jdbc:oracle:thin:@localhost:1521:andreeaz";
		   	  String USERNAME = "SCOTT";
		 	  String PASSWORD = "stud";
		 	  
		      String query="select * from produse p order by p.denumireprodus";
		      Connection conn=DriverManager.getConnection(URL, USERNAME, PASSWORD);

		       Statement stmt=conn.createStatement();
		       ResultSet rs=stmt.executeQuery(query);
		       
		       while(rs.next())
		       {
		   %>
		           <tr>
			           <td><%=rs.getLong("id_produs") %></td>
			           <td><%=rs.getString("denumireprodus") %></td>
			           <td><%=rs.getDouble("pretprodus") %></td>
			           <td><%=rs.getInt("cantitateinstoc") %></td>
			       </tr>		
		
		   <%
		       }
		   %>
		   </table>
		   <%
		        rs.close();
		        stmt.close();
		        conn.close();
		   }
		   catch(Exception e)
		   {
		        e.printStackTrace();
		   }
   %>
	</form>	

</body>
</html>