<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<%@ page import="java.lang.Class.*"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Register Account</title>
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


			//Get the values from create.jsp
			String entity = request.getParameter("username");
			String key= request.getParameter("password");
			String email= request.getParameter("email");


			//Create a SQL prepared statement to insert new user
			PreparedStatement register = con.prepareStatement("INSERT INTO User (username, email, password) VALUES (?, ?, ?)");
			register.setString(1, entity);
			register.setString(2, email);
			register.setString(3, key);

			//Run the update.
			register.executeUpdate();

			out.println("You are now registered as " + entity);
			session.setAttribute("user", entity);
			response.sendRedirect("userDashboard.jsp");

			//close the connection.
			con.close();

		} catch (Exception e) {
			out.println("Connection failed");
		}
	%>

</body>
</html>
