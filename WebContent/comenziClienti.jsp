<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>

<%@page import="java.sql.*" %>
<%@page import="java.util.Date" %>
<%@page import="java.sql.Connection"%>
<%@page import="java.sql.Driver"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.PreparedStatement" %>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.SQLException"%>
<%@page import="java.util.Properties"%>



<!DOCTYPE html>
<html lang="en">
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
    <title>Comenzi clienti</title>
</head>
<body>
    <h1>Comenzi clienti</h1>
    <script type="text/javascript">
        function getTaskId ()
        {
            var id = document.getElementById('getTaskId').value;
            alert(id);
        }
    </script>
    
    <form name="newForm" action="comenziClienti.jsp" method="GET">
    
    
        <table class="table table-striped table-hover table table-sm table-success table-condensed" >
        	<thead class="">
            <tr>
                <th>Id comanda</th>
                <th>Numar comanda</th>
                <th>Valoare</th>
                <th>Status</th>
                <th>Nume</th>
                <th>Prenume</th>            
            </tr>
            </thead>
            <%
				String idcomandalinii = "";
                try {
                    Class.forName("oracle.jdbc.driver.OracleDriver");
                    /*
                    String URL = "jdbc:oracle:thin:@37.120.250.20:1521:oracle";
                    String USERNAME = "ZAMFIR_ANDREEA";
                    String PASSWORD = "stud";
                    */
                    String URL = "jdbc:oracle:thin:@localhost:1521:andreeaz";
                    String USERNAME = "SCOTT";
                    String PASSWORD = "stud";
                    
                    String query="select cc.id_comandaclient, cc.NUMARCOMANDA, cc.VALOARE, s.descrierestatus, c.nume, prenume from COMENZICLIENTI cc, clienti c, status s " +
                                 "where cc.id_client = c.id_client and s.id_status = cc.id_status and c.id_client = cc.id_client and cc.id_status > 1 order by cc.id_status" ;
          
                    Connection conn=DriverManager.getConnection(URL, USERNAME, PASSWORD);
                    
                    Statement stmt=conn.createStatement();
                    ResultSet rs=stmt.executeQuery(query);
                    
                    while(rs.next())
                    {
                        int idx = 1;
                        int taskId = rs.getInt(1);
            %> 
                       <tr>
                            <td><%=rs.getInt(idx++)%></td>
                            <td><%=rs.getInt(idx++)%></td>
                            <td><%=rs.getInt(idx++)%></td>
                            <td><%=rs.getString(idx++)%></td>
                            <td><%=rs.getString(idx++)%></td>
                            <td><%=rs.getString(idx++)%></td>                                                                    
                            <td><input type="submit" class = "btn btn-warning btn-sm" value="Status urmator" name="setnextstat" onclick="var f = document.forms ['newForm']; var elem = f.elements ['getTaskIdName']; elem.value = <%=taskId%>; return true;"/></td>
                            <td><input type="submit" class = "btn btn-warning btn-sm" value="Detalii comanda" name="detaliicomanda" onclick="var f = document.forms ['newForm']; var elem = f.elements ['getTaskIdName']; elem.value = <%=taskId%>; return true;"/></td>
                       </tr>
            <%
                    }
            %>
            <tr>
                 <td>
                    <input type="text" id="getTaskId" name="getTaskIdName" onclick="getTaskId();" value="" />
                </td>
            </tr>
        </table>
        <%			
        			
                    idcomandalinii = request.getParameter("getTaskIdName");
                    
                  //Incarcarea tabelului DetaliiComanda in functie de id-ul comenzii
                    if (request.getParameter("detaliicomanda")!= null) {
                        System.out.println(idcomandalinii);
                    }
                    
                    rs.close();
                    stmt.close();
                    conn.close();
                }
                catch(Exception e)
                {
                    e.printStackTrace();
                }
                // new table definition
                if(idcomandalinii != "" ){
            		%>
            		 <h1>Linii comanda</h1>
                    <table class="table table-striped table-hover table table-sm table-success table-condensed">
                    	<thead class="">
                		<tr>
					   		 <th>Produs</th>
					  		 <th>Cantitate</th>	
							 <th>Pret</th>
					  		 <th>Valoare totala</th>    
    					</tr>  
    					</thead>
            		<%
            		//Query pentru tabelul liniilor de comenzi
                	try{                		
                		 Class.forName("oracle.jdbc.driver.OracleDriver");
                         String URL = "jdbc:oracle:thin:@localhost:1521:andreeaz";
                         String USERNAME = "SCOTT";
                         String PASSWORD = "stud";
               
                         Connection conn=DriverManager.getConnection(URL, USERNAME, PASSWORD);
                         
                         Statement stmt=conn.createStatement();
                         PreparedStatement query = conn.prepareStatement("select p.denumireprodus, lcc.cantitate, lcc.pretprodus, lcc.lccvaloare "+
                        		 										"from COMENZICLIENTI cc, produse p, liniicomandaclienti lcc "+
                        												" where p.ID_PRODUS = lcc.ID_PRODUS " + 
                        		 										" and   cc.ID_COMANDACLIENT = lcc.ID_COMANDACLIENT "+
                        												" and cc.id_comandaclient = ?");
           		         
     				     query.setString(1, idcomandalinii);   
     				     System.out.println(idcomandalinii+" here here");
     			  				     
                         ResultSet rs = query.executeQuery();
                         
	                         while(rs.next())
	                         {
	                             int idn = 1;
	                		%>   				             
	                             <tr>
	                                 <td><%=rs.getString(idn++)%></td>
	                                 <td><%=rs.getInt(idn++)%></td>
	                                 <td><%=rs.getDouble(idn++)%></td>
	                                 <td><%=rs.getDouble(idn++) %></td>
	                            </tr>
	                 
	                      
	                		<%                        
		                        }
	                         %>
	                         </table>
	                         <%
		                        rs.close();
		                        stmt.close();
		                        conn.close();		                        
                         }catch(Exception e){
                        e.printStackTrace();
                	}
            		//---------------------------------------
            		//Schimbarea statusului 
            		if(request.getParameter("setnextstat")!= null){
	            		try{
	            			
	               		 Class.forName("oracle.jdbc.driver.OracleDriver");
	                     String URL = "jdbc:oracle:thin:@37.120.250.20:1521:oracle";
	                     String USERNAME = "ZAMFIR_ANDREEA";
	                     String PASSWORD = "stud";
	           
	                     Connection conn=DriverManager.getConnection(URL, USERNAME, PASSWORD);
	                     int idStatus = 0 ;
	                     ResultSet rs;
	                     
	                     PreparedStatement ps = conn.prepareStatement("select id_status from comenziclienti where id_comandaclient = ?");
	                     ps.setString(1, idcomandalinii);
	                     rs = ps.executeQuery();
	                     
	                     		while(rs.next()){                				 
	                     			idStatus = rs.getInt(1);
	                     			System.out.println("idStatus: "+idStatus);
	                     	    }
	                     		rs.close();
	                     		ps.close();
	                     		conn.close();
	                     		
	                     if(idStatus == 2){
	                    	 	
	                    	     conn=DriverManager.getConnection(URL, USERNAME, PASSWORD);
			                     ps = conn.prepareStatement("UPDATE comenziclienti c SET c.id_status = 3 WHERE c.ID_COMANDACLIENT = ?");
			                     ps.setString(1, idcomandalinii); 
			                     
			                     ps.executeUpdate();
			            			
			            			ps.close();
			            			conn.close();
	                     }
	                     
	                     if(idStatus ==3 ){
	                         conn=DriverManager.getConnection(URL, USERNAME, PASSWORD);
		                     ps = conn.prepareStatement("UPDATE comenziclienti c SET c.id_status = 4 WHERE c.ID_COMANDACLIENT = ?");
		                     ps.setString(1, idcomandalinii); 
		                     
		                     ps.executeUpdate();
		            			
		            			ps.close();
		            			conn.close();
	                     }else{
	                    	 System.out.println("Statusul nu mai poate fi schimbat");
	                     }
	            	
                	}catch(Exception e){
            			e.printStackTrace();
            		}   
                 }
            		
                }                
        %>
   
    </form>	

</body>
</html>
