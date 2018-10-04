<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<%@ page import="java.lang.Class.*"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Login</title>
</head>
<body>
	<%

		try {

			//Create a connection string
			String url = "jdbc:mysql://data2.c4x3kjvlkj6l.us-east-2.rds.amazonaws.com:3306/BuyMe";
			//Load JDBC driver - the interface standardizing the connection procedure. Look at WEB-INF\lib for a mysql connector jar file, otherwise it fails.
			Class.forName("com.mysql.jdbc.Driver");

			//Create a connection to your DB
			Connection con = DriverManager.getConnection(url, "kbonatakis", "cs336Proj");


			//Create a SQL statement
			PreparedStatement stmt = con.prepareStatement("SELECT * FROM User WHERE username= ?");

			//Get the username and password from the index.jsp
			String entity = request.getParameter("username");
			String key = request.getParameter("password");

			stmt.setString(1, entity);
			//Run the query against the database.
				System.out.println(stmt.toString());
			ResultSet auth = stmt.executeQuery();

			if(!auth.next()){
				out.print("Invalid username");
			}
			else{
				if(auth.getString("username").compareTo(entity)==0 ){
					String cPass = auth.getString("password");

					if(cPass.equals(key)){
						session.setAttribute("user", entity);
						out.print("You are now logged in as " + entity);
						//direct to appropriate dashboar for user/rep/admin
						if(auth.getBoolean("isRep")){
							response.sendRedirect("custRepDash.jsp");
						}
						else if(auth.getBoolean("isAdmin")){
							out.print(" ADMIN ");
							response.sendRedirect("adminDashboard.jsp");
						}
						else{
							response.sendRedirect("userDashboard.jsp");
						}
					}
				}
			}

			String loggedIn= (String)session.getAttribute("user");
			if(!loggedIn.equals(entity)){
				out.print("Invalid password");
			}


			//close the connection.
			con.close();

		} catch (Exception e) {
			out.print("Login failed");
		}
	%>

</body>
</html>
