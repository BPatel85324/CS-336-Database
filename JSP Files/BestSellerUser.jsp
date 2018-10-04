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
<title>Best Seller Report</title>
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
		PreparedStatement prep=con.prepareStatement("SELECT Temp.Merchant FROM  (SELECT SUM(I.Curr_price) AS Income,B.Buyer AS Merchant FROM Bid B,Item I WHERE B.Item_no=I.Item_no AND B.IsWinner=1 GROUP BY B.Buyer) AS Temp WHERE Temp.Income >=  ALL (SELECT SUM(I.Curr_price) FROM Bid B,Item I WHERE B.Item_no=I.Item_no AND B.IsWinner=1 GROUP BY B.Buyer)");
		//Run the query against the database.
		ResultSet result=prep.executeQuery();
		if(result.next())
		{
			String name=result.getString(1);
			out.println("By Buyer "+ name);
			out.println("<br>");
			//Create a SQL statement
		PreparedStatement preparation=con.prepareStatement("SELECT Temp.Income FROM  (SELECT SUM(I.Curr_price) AS Income,B.Buyer AS Merchant FROM Bid B,Item I WHERE B.Item_no=I.Item_no AND B.IsWinner=1 GROUP BY B.Buyer) AS Temp WHERE Temp.Income >=  ALL (SELECT SUM(I.Curr_price) FROM Bid B,Item I WHERE B.Item_no=I.Item_no AND B.IsWinner=1 GROUP BY B.Buyer)");
		//Run the query against the database.
		ResultSet state=preparation.executeQuery();

		if(state.next())
		{

			String count=state.getString(1);

			out.println("Total earning to date is $"+count);


		}

		//Create a SQL statement
		PreparedStatement divide=con.prepareStatement("SELECT SUM(I.Curr_price) AS Price,I.End_time AS Time FROM Item I,Bid B WHERE  I.Item_no=B.Item_no AND B.isWinner=TRUE AND B.Buyer=? GROUP BY I.End_time WITH ROLLUP;");
			divide.setString(1,name);
			//Run the query against the database.
			ResultSet result3=divide.executeQuery();

			%>
			<br>
			<tr><td>Total(per day) $</td><td>Earning Day</td></tr>
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

		else
		{
			out.println("There is no best buyer yet");
		}
		//close connection
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
