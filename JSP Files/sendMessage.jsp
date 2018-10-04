<!--Bhavya Patel-->
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>
<h2>BuyMe Message Center</h2>

<form method="get" action="message.jsp" >
<table>
<tr>
<td> To user: </td><td><input type="text" name="username1"></td>
</tr>
<tr>
<td> From: </td><td><input type="text" name="username"></td>
</tr>
<tr>
<td> Message: </td><td><textarea name ="message-details" rows="4" cols="30"></textarea></td>
</tr>
<tr>
<td><input type="submit" value="Send">
</table>
</form>
<br>
<a href="viewMessage.jsp">View Messages</a> Click to view messages </p>
<a href="adminDashboard.jsp">Dashboard</a> Click to go to dashboard </p>

</body>
</html>
