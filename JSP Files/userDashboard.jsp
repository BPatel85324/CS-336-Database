<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*" %>


<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">

<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>User Dashboard</title>
</head>

<body style=background-color:powderblue; >

<h1>Welcome <%out.print(session.getAttribute("user"));%>!</h1>
<p> Your Alerts: <%try {

	//Create a connection string
	String url = "jdbc:mysql://data2.c4x3kjvlkj6l.us-east-2.rds.amazonaws.com:3306/BuyMe";
	//Load JDBC driver - the interface standardizing the connection procedure. Look at WEB-INF\lib for a mysql connector jar file, otherwise it fails.
	Class.forName("com.mysql.jdbc.Driver");

	//Create a connection to your DB
	Connection con = DriverManager.getConnection(url, "kbonatakis", "cs336Proj");


	//Create a SQL statement
	PreparedStatement stmt = con.prepareStatement("SELECT * FROM Alert WHERE user= ?");
	stmt.setString(1, (String)session.getAttribute("user"));

	//Run the query against the database.
	ResultSet alertList = stmt.executeQuery();

	//Make an HTML table to show the results in:
			out.print("<table>");

			//make a row
			out.print("<tr>");
			//make a column
			out.print("<td>");
			//print out column header
			out.print("Item #");
			out.print("</td>");

			out.print("<td>");
			out.print("Category");
			out.print("</td>");

			out.print("<td>");
			out.print("Color");
			out.print("</td>");

			out.print("<td>");
			out.print("Size");
			out.print("</td>");

			out.print("</tr>");

			while(alertList.next()){
				out.print("<tr>");

				out.print("<td>");
				out.print(alertList.getString("item_no"));
				out.print("</td>");

				out.print("<td>");
				out.print(alertList.getString("itemcat"));
				out.print("</td>");

				out.print("<td>");
				out.print(alertList.getString("color"));
				out.print("</td>");

				out.print("<td>");
				out.print(alertList.getString("size"));
				out.print("</td>");

				out.print("</tr>");
			}
			out.print("</table>");


	//close the connection.
	con.close();

} catch (Exception e) {
	out.print("Error");
} %></p>
<br>
<p><a href="viewListings.jsp">Search Listings</a></p>
<p><a href="createListing.jsp">Create a Listing</a></p>
<p><a href="sendMessage.jsp">Send a Message</a></p>
<br>
<p>View Bid History</p>
<form method="get" action="viewBids.jsp">
<table>
<tr>
<td> By Seller ID: </td><td><input type="text" name="sellerID"></td>
<td><input type= "submit" value= "submit"></td>
</tr>
<tr>
<td> By Buyer ID: </td><td><input type="text" name="buyerID"></td>
<td><input type= "submit" value= "submit"></td>
</tr>
<tr>
<td> By Item Number: </td><td><input type="text" name="itemNum"></td>
<td><input type= "submit" value= "submit"></td>
</tr>
</table>
</form>
</html>
