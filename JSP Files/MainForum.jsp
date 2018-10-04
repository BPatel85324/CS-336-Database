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
<title>View Forum topic</title>
</head>
<body>
<form method="get" action="ForumFile1.jsp">
Topic:<input type="text" name="attention">
<br>
Question:<input type="text" name="notice">
<br>
<input type="submit" value="submit">
</form>
<h4><b>View Forum Message Here:</b></h4>
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
	//get attribute from session
	String current_user=(String)session.getAttribute("user");

	//SQL query
PreparedStatement result=con.prepareStatement("SELECT DISTINCT Forum.topic FROM Forum ");

	//Run the Query.
ResultSet rs=result.executeQuery();
int i=1;
while(rs.next())
{
	%>

	<a href="ViewFile1.jsp?value=<%String topic_name=rs.getString("topic"); out.println(topic_name); %>"><%String topic_name1=rs.getString("topic"); out.println(topic_name1); %></a>
	<br>
	<%
}

con.close();
}
catch (Exception e)
{
	out.println("Connection error!);
}
%>


</table>
</body>
</html>
