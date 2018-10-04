<!-- Kristina Bonatakis, edits S Ng -->
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">

<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>BuyMe New Listing</title>
</head>

<body style=background-color:powderblue; >

<h1>Welcome <%out.print(session.getAttribute("user"));%>!</h1>
<br>
<p>List your item on BuyMe</p>

<form id="listing" method="post">
<table>
<tr>
<td> Item Category*: </td>
<td>
	<select required="required" name="itemCat" >
		<option value="handbag">Handbag</option>
		<option value="shoes">Shoes</option>
		<option value="apparel">Apparel</option>
		<option value="jewelry">Jewelry</option>
	</select>
</td>
</tr>
<tr>
<td> Brand: </td><td><input type="text" name="brand"></td>
</tr>
<tr>
<td> Style: </td><td><input type="text" name="style"></td>
</tr>
<tr>
<td> Color: </td><td><input type="text" name="color"></td>
</tr>
<tr>
<td> Size: </td><td><input type="text" name="size"></td>
</tr>
<tr>
<td> Starting Price: </td><td><input type="text" name="start_price"></td>
</tr>
<tr>
<td> Bid Increment: </td><td><input type="text" name="bid_inc"></td>
</tr>
<tr>
<td> Min. Sale Price: </td><td><input type="text" name="min_price"></td>
</tr>
<tr>
<td> Auction Length: </td>
<td><select required="required" name="length">
	<option value="1">1 day</option>
	<option value="7">7 days</option>
	<option value="10">10 days</option>
	</select>
</td>
</tr>
</table>
<input type= "hidden" name="isSubmitted" value= "true">
<input type= "submit" value= "submit">
</form>
<br>
<% String category= request.getParameter("itemCat");%>
<% try {

	PreparedStatement stmt= null;

	if(request.getParameter("isSubmitted").equals("true")){



		//Create a connection string
		String url = "jdbc:mysql://data2.c4x3kjvlkj6l.us-east-2.rds.amazonaws.com:3306/BuyMe";
		//Load JDBC driver - the interface standardizing the connection procedure. Look at WEB-INF\lib for a mysql connector jar file, otherwise it fails.
		Class.forName("com.mysql.jdbc.Driver");

		//Create a connection to your DB
		Connection con = DriverManager.getConnection(url, "kbonatakis", "cs336Proj");

		//ensure handbag category has a color
		if(category.equals("handbag") && request.getParameter("color").equals("")){
			out.print("ERROR Required Field: Please enter a color");
		}
		//ensure shoe category has a size
		else if(category.equals("shoes") && request.getParameter("size").equals("")){
			out.print("ERROR Required Field: Please enter a size");
		}
		//ensure apparel category has a style
		else if(category.equals("apparel") && request.getParameter("style").equals("")){
			out.print("ERROR Required Field: Please enter a style");
		}
		else{
			String brand=request.getParameter("brand");
			String style=request.getParameter("style");
			String color=request.getParameter("color");
			String size=request.getParameter("size");
			String start= request.getParameter("start_price");
			String bid=request.getParameter("bid_inc");
			String min= request.getParameter("min_price");
			String seller= (String)session.getAttribute("user");
			int length= Integer.parseInt(request.getParameter("length"));
			String days= request.getParameter("length");

			java.util.Date now= new java.util.Date();
			java.util.Date next= new java.util.Date(now.getTime() + (1000*60*60*24* length));
			Object date = new java.sql.Timestamp(next.getTime());

			// add item to item table
			if(Integer.parseInt(min) >= Integer.parseInt(start)  && Integer.parseInt(min)>0 && Integer.parseInt(start)>0 && Integer.parseInt(bid)>0 ){
				stmt = con.prepareStatement("INSERT INTO Item(Item_category, Brand, Style, Color, Size, Start_price, Curr_price, Bid_inc, Min_win, Seller, End_time) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)");
				stmt.setString(1, category);
				stmt.setString(2, brand);
				stmt.setString(3, style);
				stmt.setString(4, color);
				stmt.setString(5, size );
				stmt.setString(6, start);
				stmt.setString(7, start);
				stmt.setString(8, bid);
				stmt.setString(9, min);
				stmt.setString(10, seller);
				stmt.setObject(11, date);
				stmt.executeUpdate();

				// get new item auto-incremented item #
				stmt = con.prepareStatement("SELECT MAX(I.Item_no) AS maxnum FROM Item I;");
				ResultSet max= stmt.executeQuery();


				int max_no=0;
				String num= null;
				if(max.next()){
					max_no= max.getInt("maxnum");
					num= seller + Integer.toString(max_no);
				}


				//create event at listing end to check for max bid and updates as isWinner
				stmt = con.prepareStatement(" CREATE EVENT "+num+ " ON SCHEDULE AT current_timestamp + INTERVAL ? DAY DO CALL find_win(?, ?);");
				stmt.setString(1, days);
				stmt.setObject(2, max_no);
				String itemno= Integer.toString(max_no);
				String message= "Congratulations! You are the winning bidder for item "+ itemno + ". Proceed to the BuyMe payment center to complete your transaction.";
				stmt.setObject(3, message);
				stmt.execute();
				//System.out.println("ok");
			}else{
				response.sendRedirect("createListing.jsp");
			}

		}

		if(stmt!=null){
			response.sendRedirect("userDashboard.jsp");
		}

		//close the connection.
		con.close();



	}

}catch (Exception e) {

}
%>
