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
<title>Earning by Seller</title>
</head>
<body>
<table>
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
		String SellerUser=request.getParameter("UserSeller");
		String BuyerUser=request.getParameter("UserSeller");

		double Total;
		double Btotal;
		double Stotal;


		//Create a SQL statement
				PreparedStatement state0=con.prepareStatement("SELECT * FROM User WHERE User.username=?");
				state0.setString(1,SellerUser);
				//Run the query against the database.
				ResultSet auth0=state0.executeQuery();
				if(!auth0.next())
				{
					out.println("Invalid Username");
				}
				else
				{
					//Create a SQL statement
					PreparedStatement stmt=con.prepareStatement("SELECT * FROM Item WHERE Item.Seller=?");
					stmt.setString(1,SellerUser);
					//Run the query against the database.
					ResultSet auth=stmt.executeQuery();
					String count="";
					String count2="";
					if(!auth.next())
					{
						out.println("Invalid Seller <br>");
						Stotal=0.0;
					}
					else
					{
						//Create a SQL statement
						PreparedStatement state=con.prepareStatement("SELECT SUM(Item.Curr_price) FROM Bid,Item WHERE Bid.Seller=Item.Seller AND Bid.Item_no=Item.Item_no AND Bid.IsWinner=1 AND Bid.Seller=?");
						state.setString(1,SellerUser);
						//Run the query against the database.
						ResultSet res=state.executeQuery();

						while(res.next())
						{
							count=res.getString(1);
							if(count==null)
							{
								out.println("There is no winning bid as Seller <br>");
								out.println("<b>Total earning to date as Seller is $ 0 </b>");
							count="0";
							Stotal=0.0;
							}
							else
							{
								out.println("<b>Total earning to date as Seller is $ "+count+"</b>");
							}
						}
						Stotal=Double.parseDouble(count);
						//Create a SQL statement
						PreparedStatement divide=con.prepareStatement("SELECT SUM(I.Curr_price) AS Price,I.End_time AS Time FROM Item I,Bid B WHERE  I.Item_no=B.Item_no AND B.isWinner=TRUE AND B.Seller=? GROUP BY I.End_time WITH ROLLUP;");
						divide.setString(1,SellerUser);
						//Run the query against the database.
						ResultSet result3=divide.executeQuery();

						%>
						<br>
						<tr><td>Total(per day) $</td><td>Earning Day</td></tr>
						<br>
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

						<br>
						<br>
						</table>
						<%
					}

					PreparedStatement stmt2=con.prepareStatement("SELECT * FROM Item,Bid WHERE Item.Item_no=Bid.Item_no AND Bid.Buyer=?");
					stmt2.setString(1,BuyerUser);
					//Run the query against the database.
					ResultSet auth2=stmt2.executeQuery();
					if(!auth2.next())
					{
						out.println("Invalid Buyer <br>");
						Btotal=0.0;
					}
					else
					{
						//Create a SQL statement
						PreparedStatement state2=con.prepareStatement("SELECT SUM(Item.Curr_price) FROM Bid,Item WHERE Bid.Seller=Item.Seller AND Bid.Item_no=Item.Item_no AND Bid.Buyer!=Bid.seller AND Bid.IsWinner=1 AND Bid.Buyer=?");
						state2.setString(1,BuyerUser);
						//Run the query against the database.
						ResultSet res1=state2.executeQuery();

						while(res1.next())
						{
							count2=res1.getString(1);
							if(count2==null)
							{
								out.println("There is no winning bid as Buyer <br>");
								out.println("<b>Total earning to date as Buyer is $ 0 </b>");
							count2="0";
							Btotal=0.0;
							}
							else
							{
								out.println("<b>Total earning to date as Buyer is $ "+count2+"</b>");
							}
						}
						Btotal=Double.parseDouble(count2);
						//Create a SQL statement
						PreparedStatement divide1=con.prepareStatement("SELECT SUM(I.Curr_price) AS Price,I.End_time AS Time FROM Item I,Bid B WHERE  I.Item_no=B.Item_no AND B.isWinner=TRUE AND B.Buyer!=B.Seller AND B.Buyer=? GROUP BY I.End_time WITH ROLLUP;");
						divide1.setString(1,BuyerUser);
						//Run the query against the database.
						ResultSet result4=divide1.executeQuery();

						%>
						<table>
						<br>
						<tr><td>Total(per day) $</td><td>Earning Day</td></tr>
						<%
						while(result4.next())
						{
			               %>

							<br>
							<tr><td><%String Num=result4.getString("Price"); out.println(Num); %></td><td><%String day=result4.getString("Time");if(day==null){ out.println("Total earning");} else {out.println(day);} %></td></tr>
							<br>

							<%
						}

						%>
						</table>
						<br>
						<br>

						<%
					}



					 Total=Stotal+Btotal;
					out.println("The total contibution of the user "+SellerUser+" as Seller and Buyer is $ "+Total);


				}

				%>


		<br>
		Go back to <a href="adminDashboard.jsp">Dashboard</a>
		<%

		//close the connection.
		con.close();

}
catch (Exception e)
{
	out.println(e);
	out.println("Retry!");
	%>
	Go back to <a href="adminDashboard.jsp">Dashboard</a>
			<%
}
%>
</body>
</html>
