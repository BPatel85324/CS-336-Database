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
<h2>Reports</h2>
<table>
<tr><form method="post" action="TotalEarn.jsp">
<td><b>Total Earnings to Date: </b></td><td> <input type="submit" value="run"> </td>
</tr>
</form>
<form method="post" action="EarningByItem.jsp">
<tr>
<td><u> Earnings by type:</u></td>
</tr>
<tr>
<td><b> Item Number: </b></td><td> <input type="text" name="ItemNumber"></td>
<td> <input type="submit" value="run"></td>
</tr>
</form>
<form method="post" action="CategoryEarning.jsp">
<tr>
<td><b> Item Category: </b></td><td> <input type="text" name="ItemCategory"></td>
<td> <input type="submit" value="run"></td>
</tr>
</form>
<form method="post" action="SellerEarning.jsp">
<tr>
<td><b> User: </b></td><td><input type="text" name="UserSeller"></td>
<td><input type="submit" value="run"></td>
</tr>
</form>
<form method="post" action="BestItem.jsp">
<tr>
<td><u> Best-Sellers by Type </u></td>
</tr>
<tr>
<td><b> Item Number: </b><td><input type="submit" value="run"></td>
</tr>
</form>
<form method="post" action="BestSellerUser.jsp">
<tr>
<td><b> Buyer: </b><td><input type="submit" value="run"></td>
</tr>

</form>
<br>
<br>
<tr><td>
Go back to <a href="adminDashboard.jsp">Dashboard</a>
</td></tr>
</table>
</body>
</html>
