<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Test update</title>
</head>

<body style=background-color:powderblue; >
<h1></h1>

<p> Reset Password </p>
<form method="post" action="custJava.jsp">

<table>

<tr>
<td> Username: </td><td><input type="text" name="username"></td>
</tr>

<tr>
<td> New Password: </td><td><input type="text" name="password"></td>
</tr>
</table>
<input type= "submit" value= "submit"name=0>

<p> Edit Bids </p>
<table>

<tr>
<td> Item Number: </td><td><input type="text" name="itemNum"></td>
</tr>

<tr>
<td> Bid Number: </td><td><input type="text" name="bidNum"></td>
</tr>

<tr>
<td> New Value: </td><td><input type="text" name="value"></td>
</tr>

</table>
<input type= "submit" value= "submit" name=1>

<p> Edit Listing </p>
<table>

<tr>
<td> Item Number: </td><td><input type="text" name="item"></td>
</tr>
<tr>
<td> Field </td><td><input type="text" name="field"></td>
</tr>
<tr>
<td> New Value: </td><td><input type="text" name="val"></td>
</tr>
</table>
<input type= "submit" value= "submit"name=2>


<p> Delete listing </p>
<table>
<tr>
<td> Item Number: </td><td><input type="text" name="delete"></td>
</tr>
</table>
<input type= "submit" value= "submit"name=3>


</form>
<br>
<a href="MainForum.jsp">Forum</a>
</body>




</html>
