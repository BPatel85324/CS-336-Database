<!--Bhavya Patel-->
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
<%
List<String> list = new ArrayList<String>();

try {

	//Create a connection string
	String url = "jdbc:mysql://data2.c4x3kjvlkj6l.us-east-2.rds.amazonaws.com:3306/BuyMe";
	//Load JDBC driver - the interface standardizing the connection procedure. Look at WEB-INF\lib for a mysql connector jar file, otherwise it fails.
	Class.forName("com.mysql.jdbc.Driver");

	//Create a connection to your DB
	Connection con = DriverManager.getConnection(url, "kbonatakis", "cs336Proj");
	Statement stmt = con.createStatement();

	//Get the values from sendMessage.jsp
	String otherAccount = (String)request.getParameter("username1");
	String accname = (String)session.getAttribute("user");
	String message = (String)request.getParameter("message-details");

	DateFormat dateform = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
   	Date dateobj = new Date();
    String date = (String)dateform.format(dateobj);

  //Create a SQL prepared statement
    PreparedStatement send_Message = con.prepareStatement("INSERT INTO Message (to_user,from_user,time,content) VALUES (?,?,?,?);");
    send_Message.setString(1,otherAccount);
    send_Message.setString(2,accname);
    send_Message.setString(3,date);
    send_Message.setString(4,message);
  //Run the update.
    send_Message.executeUpdate();

    out.println("Message sent!");
    //close connection
    con.close();

} catch (Exception e)
{
	out.println(e);
	out.println("Retry!");
	%>
	<a href="sendMessage.jsp">Send Messages</a> Click to create and send messages </p>
	<%
}


%>

</body>
</html>
