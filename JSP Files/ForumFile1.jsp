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
<title>Supporting forum file</title>
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
		Statement stmt = con.createStatement();
		//Get the values from MainForum.jsp
		String othertopic1 = (String)request.getParameter("attention");
		String othertopic2 = (String)request.getParameter("notice");
		String accname = (String)session.getAttribute("user");
		DateFormat dateform = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
	   	Date dateobj = new Date();
	    String date = (String)dateform.format(dateobj);


	  //Create a SQL prepared statement
		PreparedStatement send_Forum = con.prepareStatement("INSERT INTO Forum (topic,from_user,time,content) VALUES (?,?,?,?);");
	    send_Forum.setString(1,othertopic1);
	    send_Forum.setString(2,accname);
	    send_Forum.setString(3,date);
	    send_Forum.setString(4,othertopic2);
	  //Run the update.
	    send_Forum.executeUpdate();
	    out.println("Message sent to Forum!");
	    //close connection
	    con.close();
}
catch(Exception e)
{
	out.println("Retry! Message could not be sent to forum");

}

%>
<a href="MainForum.jsp">create</a>
</body>
</html>
