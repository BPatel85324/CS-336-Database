<!--Bhavya Patel-->
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<%@ page import="java.lang.Class.*"%>

<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Earning by Category</title>
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
	//Get the values from GenerateReport.jsp
	String ICategory=request.getParameter("ItemCategory");
	//Create a SQL statement
	PreparedStatement stmt = con.prepareStatement("SELECT * FROM Item WHERE Item_category= ?");

	stmt.setString(1,ICategory);
	ResultSet auth = stmt.executeQuery();

	if(!auth.next()){
		out.print("Invalid Item Category");
	}
	else
	{
		out.println("Category name: "+ICategory);
		out.println("<br>");
		//Create a SQL statement
		PreparedStatement state = con.prepareStatement("SELECT SUM(Item.Curr_price) FROM Item,Bid WHERE Item.Item_no=Bid.Item_no AND Bid.IsWinner =1 AND Item.Item_category= ?");
		state.setString(1,ICategory);
		//Run the query against the database.
		ResultSet result=state.executeQuery();
		String count="";
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
		}
		//Create a SQL statement
		PreparedStatement divide=con.prepareStatement("SELECT SUM(I.Curr_price) AS Price,I.End_time AS Time FROM Item I,Bid B WHERE  I.Item_no=B.Item_no AND B.isWinner=TRUE AND I.Item_category=? GROUP BY I.End_time WITH ROLLUP;");
		divide.setString(1,ICategory);
		//Run the query against the database.
			ResultSet result3=divide.executeQuery();

			%>
			<br>
			<tr><td> Total(per day) $</td><td> Earning Day</td></tr>
			<%
			while(result3.next())
			{
               %>

				<br>
				<tr><td><%String Num=result3.getString("Price"); out.println(Num); %></td><td><%String day=result3.getString("Time");if(day==null){ out.println("Total earning");} else {out.println(day);} %></td></tr>
				<br>

				<%
			}
		%>
		</table>
		<br>
		<br>
		Go back to <a href="adminDashboard.jsp">Dashboard</a>
		<%
	}

	//close the connection.
	con.close();
}
catch (Exception e)
{
	out.println(e);
	out.print("Retry!");
	%>
	Go back to <a href="adminDashboard.jsp">Dashboard</a>
	<%
}
%>
</body>
</html>
