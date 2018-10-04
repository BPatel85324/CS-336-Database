<!--Bhavya Patel-->
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<%@ page import="java.lang.Class.*"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Total Earning to date</title>
</head>
<body>
<%
try
{

	//Create a connection string
	String url = "jdbc:mysql://data2.c4x3kjvlkj6l.us-east-2.rds.amazonaws.com:3306/BuyMe";
	//Load JDBC driver - the interface standardizing the connection procedure. Look at WEB-INF\lib for a mysql connector jar file, otherwise it fails.
	Class.forName("com.mysql.jdbc.Driver");
	//Create a connection to your DB
	Connection con = DriverManager.getConnection(url, "kbonatakis", "cs336Proj");
	//Create a SQL statement
    PreparedStatement state = con.prepareStatement("SELECT SUM(I.Curr_price) FROM Bid B, Item I WHERE B.Item_no=I.Item_no AND B.isWinner=TRUE");
  //Run the query against the database.
	ResultSet result=state.executeQuery();
	String count="";
	//Create a SQL statement
	PreparedStatement show=con.prepareStatement("SELECT SUM(I.Curr_price) AS Price,I.End_time AS Time FROM Item I,Bid B WHERE  I.Item_no=B.Item_no AND B.isWinner=TRUE GROUP BY I.End_time WITH ROLLUP");
	//Run the query against the database.
	ResultSet result2=show.executeQuery();


	while(result.next())
	{

		count=result.getString(1);

		if(count==null)
		{
			out.println("There is no winning bid <br>");
			out.println("<b>Total earning to date is $ 0 </b>");
		}
		else
		{
			out.println("<b>Total earning to date is $ "+count+"</b>");
		}

		out.println("<br>");

	}
	%>

	<table>
	<tr><td>Total per day $</td><td> Time</td></tr>

	<% while(result2.next())
	{
		//shows all items who are bided and are won.
		%>

		<br>
		<tr><td><%String Num=result2.getString("Price"); out.println(Num); %></td><td><%String day=result2.getString("Time");if(day==null){ out.println("Total earning");} else {out.println(day);} %></td></tr>
		<br>

		<%
	}
	%>
	</table>
	<br>
	<br>
	Go back to <a href="adminDashboard.jsp">Dashboard</a>
	<%
	//close the connection.
	con.close();
}
catch (Exception e)
{
	out.println("Connection failed! Retry.");
	%>
	Go back to <a href="adminDashboard.jsp">Dashboard</a>
	<%
}
%>
</body>
</html>
