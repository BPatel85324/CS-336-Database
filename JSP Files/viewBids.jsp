<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*" %>


<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">

<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Bid History</title>
</head>

<body style=background-color:powderblue; >

<h1>Bid History</h1>
<br>
<p> <%try {

	//Create a connection string
	String url = "jdbc:mysql://data2.c4x3kjvlkj6l.us-east-2.rds.amazonaws.com:3306/BuyMe";
	//Load JDBC driver - the interface standardizing the connection procedure. Look at WEB-INF\lib for a mysql connector jar file, otherwise it fails.
	Class.forName("com.mysql.jdbc.Driver");

	//Create a connection to your DB
	Connection con = DriverManager.getConnection(url, "kbonatakis", "cs336Proj");

	ResultSet bidList;

	//Create a SQL statement
	if(!request.getParameter("sellerID").equals("")){
		PreparedStatement stmt = con.prepareStatement("SELECT * FROM Bid WHERE Seller= ? LIMIT 100");
		String seller= request.getParameter("sellerID");
		stmt.setString(1, seller);
		//Run the query against the database.
		bidList = stmt.executeQuery();
	}
	else if(!request.getParameter("buyerID").equals("")){
		PreparedStatement stmt = con.prepareStatement("SELECT * FROM Bid WHERE Buyer= ? LIMIT 100");
		String buyer= request.getParameter("buyerID");
		stmt.setString(1, buyer);
		out.print(buyer);
		//Run the query against the database.
		bidList = stmt.executeQuery();
	}
	else{
		PreparedStatement stmt = con.prepareStatement("SELECT * FROM Bid WHERE Item_no= ? LIMIT 100");
		String item= request.getParameter("itemNum");
		stmt.setString(1, item);

		//Run the query against the database.
		bidList = stmt.executeQuery();
	}

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
		out.print("Seller");
		out.print("</td>");

		out.print("<td>");
		out.print("Buyer");
		out.print("</td>");

		out.print("<td>");
		out.print("Bid");
		out.print("</td>");

		out.print("<td>");
		out.print("Date & Time");
		out.print("</td>");

		out.print("</tr>");

		while(bidList.next()){
			out.print("<tr>");

			out.print("<td>");
			out.print(bidList.getString("Item_no"));
			out.print("</td>");

			out.print("<td>");
			out.print(bidList.getString("Seller"));
			out.print("</td>");

			out.print("<td>");
			out.print(bidList.getString("Buyer"));
			out.print("</td>");

			out.print("<td>");
			out.print(bidList.getString("BidAmt"));
			out.print("</td>");

			out.print("<td>");
			out.print(bidList.getString("Timestamp"));
			out.print("</td>");

			out.print("</tr>");
		}
		out.print("</table>");




	//close the connection.
	con.close();

} catch (Exception e) {
	out.print("Error");
} %></p>
