<!--Bhavya Patel-->

<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Admin Dashboard</title>
</head>
<body>
<h4>Create customer representative account</h4>
<form method="get" action="createCR.jsp">
<table>
<tr>
<td> Preferred Username: </td><td><input type="text" name="username"></td>
</tr>
<tr>
<td> Email: </td><td><input type="text" name="email"></td>
</tr>
<tr>
<td> Password: </td><td><input type="text" name="password"></td>
</tr>
</table>
<input type= "submit" value= "submit">
</form>
<br>
<br>

<form method="post" action="GenerateReport.jsp">
<input type="submit" value="Generate Reports">
</form>

<br>

<form method="post" action="sendMessage.jsp">
<input type="submit" value="Send Message">
</form>
<form method="post" action="logout.jsp">
<input type="submit" value="Logout">
</form>

</body>
</html>
