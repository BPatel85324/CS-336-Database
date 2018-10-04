<!--BHAVYA PATEL-->
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<%@ page import="java.util.Date, java.text.DateFormat, java.text.SimpleDateFormat" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>
<a href="MainForum.jsp">Reply here!</a>
<%
try
{
	//Create a connection string
			String url = "jdbc:mysql://data2.c4x3kjvlkj6l.us-east-2.rds.amazonaws.com:3306/BuyMe";
			//Load JDBC driver - the interface standardizing the connection procedure. Look at WEB-INF\lib for a mysql connector jar file, otherwise it fails.
			Class.forName("com.mysql.jdbc.Driver");

			//Create a connection to your DB
			Connection con = DriverManager.getConnection(url, "kbonatakis", "cs336Proj");
			Statement stmt = con.createStatement();
			String hold=(String)request.getParameter("value");
			out.println("Topic is: "+hold);

			PreparedStatement result=con.prepareStatement("SELECT * FROM Forum  WHERE Forum.topic=?");
			result.setString(1,hold);

			//Run the Query.
		ResultSet rs=result.executeQuery();
		int i=1;

		while(rs.next())
		{
			%>
			<table>
			<br>
			<tr><td><b><% out.println(i+".  "); %></b></td><td><b>FROM:</b> <%String from=rs.getString("from_user"); out.println(from);%></td></tr>
			<tr><td></td><td><b>Topic:</b><%String topic_name=rs.getString("topic"); out.println(topic_name); %>
			<tr><td></td><td><b>TIME:</b> <%String dateTime=rs.getString("time"); out.println(dateTime);%></td></tr>
			<tr><td></td><td><b>CONTENT:</b> <%String cont=rs.getString("content"); out.println(cont);%></td></tr>
			<br>
			<%
			i=i+1;
			}


			//close connection
			con.close();
}
catch(Exception e)
{
	out.println(e);
}


%>

</body>
</html>
