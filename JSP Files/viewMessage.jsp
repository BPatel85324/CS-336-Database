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
	Statement stmt = con.createStatement();
	//get attribute from session
	String current_user=(String)session.getAttribute("user");

	//SQL query
PreparedStatement result=con.prepareStatement("SELECT * FROM Message WHERE Message.to_user=?");

	result.setString(1,current_user);
	//Run the Query.
ResultSet rs=result.executeQuery();
int i=1;


%>
<h4><b>This is Inbox:</b></h4>

reply option:
<form method="post" action ="message.jsp">
	<tr><td></td><td>Reply TO(type the username):<input type="text"  name="username1"></td><td>Content:<input type="text"  name="message-details"></td></tr>
	<tr><td><input type="submit" value="Reply"></td></tr>
	</form>
<br>
<%
//print messages

	while(rs.next())
	{
		%>

		<tr><td><b><% out.println(i+".  "); %></b></td><td><b>FROM:</b> <%String from=rs.getString("from_user"); out.println(from);%></td></tr>
		<tr><td></td><td><b>TIME:</b> <%String dateTime=rs.getString("time"); out.println(dateTime);%></td></tr>
		<tr><td></td><td><b>CONTENT:</b> <%String cont=rs.getString("content"); out.println(cont);%></td></tr>

		<br>
		<%
		i=i+1;
	}

%>
</table>
<%
//close connection
con.close();

}
catch(Exception e)
{



}



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
	PreparedStatement result1=con.prepareStatement("SELECT * FROM Message WHERE Message.from_user=?");

	result1.setString(1,current_user);
	//Run the Query.
	ResultSet rslt=result1.executeQuery();
	int j=1;

	%>


<h3><b>This are sent messages</b></h3>
	<%
	//print messages
	while(rslt.next())
	{
	%>
<table>
	<tr><td><b><% out.println(j+".  "); %></b></td><td><b>To:</b> <%String from=rslt.getString("to_user"); out.println(from);%></td></tr>
	<tr><td></td><td><b>TIME:</b> <%String dateTime=rslt.getString("time"); out.println(dateTime);%></td></tr>
	<tr><td></td><td><b>CONTENT:</b> <%String cont=rslt.getString("content"); out.println(cont);%></td></tr>

	<br>
	<%
	j=j+1;
	}
	%>
	<br>
	<br>
	<tr><td>


</table>
<%
	con.close();
}
catch(Exception e)
{

}
%>
<a href="sendMessage.jsp">Send Messages</a> Click to create and send messages </p>
</body>
</html>
