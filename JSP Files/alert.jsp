<!-- Stephanie Ng -->
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*" %>


<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">

<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>BuyMe Listings</title>
</head>

<body style=background-color:powderblue; >

<h1>Welcome <%out.print(session.getAttribute("user"));%>!</h1>
<br>
<p>Search BuyMe Listings</p>
<form id="search" method="get">
<table>

<td> Auction: </td><td>
	<select  required="required" name="expire" >
		<option value="1">Current Auctions</option>
		<option value="0">Past Auctions</option>
	</select></td>
</tr>

<tr>
<td> Item Category: </td><td><input type="text" name="itemCat"></td>
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
<td> Item #: </td><td><input type="text" name="itemNum"></td>
</tr>
<tr>
<td> Seller: </td><td><input type="text" name="sellerID"></td>
</tr>
<tr>
<td> Brand: </td><td><input type="text" name="brand"></td>
</tr>
<tr>
<td> Price range: </td><td><input type="text" name="price" placeholder="min - max"></td>
</tr>


</table>

<input type= "hidden" name="isSubmitted" value= "true">
<input type= "submit" value= "search" name ="dog">
<input type= "submit" value= "alert" name=alert >
</form>

<form method="post" action="alert.jsp">
<table>
<tr>
<td> Item Number: </td><td><input type="text" name="auction"></td>
</tr>
</table>


<table>
<tr>
<td> Bid: </td><td><input type="text" name="bid"></td>
<td>
<input type= "hidden" name="one" value="true">
<input type= "submit" value= "Place Bid"name=1>
</td>

</tr>
</table>


<table>
<tr>
<td> Maximum Bid: </td><td><input type="text" name="maxBid"></td>
<td>
<input type= "hidden" name="two" value="true">
<input type= "submit" value= "Place Reserve Bid" name=2 >
</td>
</tr>
</table>


</form>
<%
try {

	String url = "jdbc:mysql://data2.c4x3kjvlkj6l.us-east-2.rds.amazonaws.com:3306/BuyMe";

	//Load JDBC driver - the interface standardizing the connection procedure. Look at WEB-INF\lib for a mysql connector jar file, otherwise it fails.
	Class.forName("com.mysql.jdbc.Driver");
	//Create a connection to your DB
	Connection con = DriverManager.getConnection(url, "kbonatakis", "cs336Proj");
	String itemCat = request.getParameter("itemCat");		//0
	String style= request.getParameter("style");			//1
	String color=request.getParameter("color");				//2
	String size=request.getParameter("size");				//3
	String itemNum=request.getParameter("itemNum");			//4
	String seller=request.getParameter("sellerID");			//5
	String brand=request.getParameter("brand");			//6
	String one=request.getParameter("1");
	String two=request.getParameter("2");
	String alertBtn= request.getParameter("alert");
	String dog=request.getParameter("dog");
	String price=request.getParameter("price");
	String q;
	String query;
	PreparedStatement id;
	ResultSet currBid;
	String user= (String)session.getAttribute("user");
	String expire= request.getParameter("expire");
	java.util.Date h= new java.util.Date();
	java.util.Date now=new java.sql.Timestamp(h.getTime());
	System.out.println("This is the current time "+ now);
	boolean all=true;
	double secondBid , current, highestbid;
	String c="SELECT * FROM Item WHERE";

	System.out.println("expire " + expire );

	//bid buttons, this is the bid mech, does not check for empty text box




		if(two!=null||one!=null){
			//getting increments, Item does exist
			String u="SELECT * FROM Item WHERE Item_no=?";
			String auction = request.getParameter("auction");	//5
			PreparedStatement register = con.prepareStatement(u);
			register.setString(1, auction);
			ResultSet listing= register.executeQuery();
			if(listing.isBeforeFirst()){
				listing.next();
				java.util.Date thisDate = listing.getDate("End_time");
					if(now.before(thisDate)){
						int increments = Integer.parseInt(listing.getString("Bid_inc"));
						String soldBy= listing.getString("Seller");
						int startingPrice=listing.getInt("Start_price");
						q= "Select * from Bid where Item_no=? order by BidAmt desc";
						register = con.prepareStatement(q);
						register.setString(1, auction);
						System.out.println("current Bid query "+ register.toString());
						listing= register.executeQuery();
						boolean anotherBidder=false;
						double maxMax=0;
						int ISMAX=0;
							String currentHighest=user;
									if(listing.isBeforeFirst()){
											listing.next();
											maxMax=listing.getDouble("BidAmt");
											current= maxMax;
											ISMAX=listing.getInt("isMax");
											currentHighest= listing.getString("Buyer");
											anotherBidder=true;
											if(listing.next()){
												//anotherBidder=true;
												if(ISMAX==1){
													System.out.println("IsMax and there is  a second");
													secondBid=listing.getDouble("BidAmt");
													current=secondBid+increments;
												}
											}else if(ISMAX==1){	//only one bid and it is max, starting price
												current=startingPrice;
											}
									}else{	//no bid at all `
										current=startingPrice;
									}
									String change="INSERT INTO Bid (BidAmt,Timestamp,IsWinner,isMax,Item_no,Buyer,Seller) VALUES (?,current_timestamp(),0,?,?,?,?)";
									register = con.prepareStatement(change);
									String bidValue= request.getParameter("bid");	//2
									String isMax="0";	//4
									//its not bid it's max bid
									if(two!=null){
										bidValue= request.getParameter("maxBid");
										isMax="1";
									}
										double enterPrice = Double.parseDouble(bidValue);
										register.setString(1, bidValue);
										register.setString(2, isMax);
										register.setString(3, auction);
										register.setString(4, user);					//THIS IS WHERE YOU PUT THE USER IN HERE
										register.setString(5, soldBy);
									if(current==startingPrice && current<=enterPrice && !anotherBidder){				//starting price, must check if its bidless for this to work
										System.out.println("Starting price");
										System.out.println(register.toString());
										register.executeUpdate();

									}else if((current<=enterPrice &&ISMAX==1) || (current<enterPrice && ISMAX==0 )){				//there was a bid on it and enterPrice must be greater than the current+incremented price
										System.out.println("Bid success");
										System.out.println("final" + register.toString());
										register.executeUpdate();


									}else{
										System.out.println("Error: bid must be higher than "+ (current)+".");
									}
					}else{
						System.out.println("Error: this auction is over this ended "+ thisDate);
					}
			}
	}







	/*if(two!=null||one!=null){
			//getting increments, Item does exist
			String u="SELECT * FROM Item WHERE Item_no=?";
			String auction = request.getParameter("auction");	//5
			PreparedStatement register = con.prepareStatement(u);
			register.setString(1, auction);
			ResultSet listing= register.executeQuery();
			if(listing.isBeforeFirst()){
				listing.next();
				java.util.Date thisDate = listing.getDate("End_time");
				System.out.println("CRASHING?      "+thisDate);
					if(now.before(thisDate)){
						int increments = Integer.parseInt(listing.getString("Bid_inc"));
						String soldBy= listing.getString("Seller");
						int startingPrice=listing.getInt("Start_price");
						q= "Select * from Bid where Item_no=? order by BidAmt desc";
						register = con.prepareStatement(q);
						register.setString(1, auction);
						System.out.println("current Bid query "+ register.toString());
						listing= register.executeQuery();
						boolean anotherBidder=false;
						double maxMax=0;
						int ISMAX=0;
							//are there bids
							String currentHighest=user;
									if(listing.isBeforeFirst()){
											listing.next();
											maxMax=listing.getDouble("BidAmt");
											current= maxMax;
											ISMAX=listing.getInt("isMax");
											currentHighest= listing.getString("Buyer");
											if(listing.next()){
												anotherBidder=true;
												if(ISMAX==1){
													System.out.println("IsMax and there is  a second");
													secondBid=listing.getDouble("BidAmt");
													current=secondBid+increments;
												}
											}else if(ISMAX==1){	//only one bid and it is max, starting price
												current=startingPrice;
											}
									}else{	//no bid at all
										System.out.println("starting price!");
										current=startingPrice;
									}
									String change="INSERT INTO Bid (BidAmt,Timestamp,IsWinner,isMax,Item_no,Buyer,Seller) VALUES (?,current_timestamp(),0,?,?,?,?)";
									register = con.prepareStatement(change);
									String bidValue= request.getParameter("bid");	//2
									String isMax="0";	//4
									//its not bid it's max bid
									if(two!=null){
										bidValue= request.getParameter("maxBid");
										isMax="1";
									}
										double enterPrice = Double.parseDouble(bidValue);
										register.setString(1, bidValue);
										register.setString(2, isMax);
										register.setString(3, auction);
										register.setString(4, user);					//THIS IS WHERE YOU PUT THE USER IN HERE
										register.setString(5, soldBy);

										System.out.println(current  + "enterPrice "+ enterPrice  +" ISMAX:" +ISMAX +"!");
									if(current==startingPrice && current<=enterPrice && !anotherBidder){				//starting price, must check if its bidless for this to work
										register.executeUpdate();

									}else if((current<=enterPrice &&ISMAX==1) || (current<enterPrice && ISMAX==0 )){				//there was a bid on it and enterPrice must be greater than the current+incremented price
										System.out.println("final" + register.toString());
										register.executeUpdate();
										System.out.println(maxMax +" ~ "  + enterPrice);
										register = con.prepareStatement("INSERT INTO Message (time, content , to_user , from_user) VALUES (current_timestamp(),'alert: You have been outbitted in auction: " + auction + "', ? ,'auto')"   );
										if(enterPrice>maxMax){	//there is another bidder and the enteredPrice is greater
											register.setString(1, currentHighest);
											//System.out.println("1Alert this "+register.toString());
										}else if(enterPrice<maxMax){
											register.setString(1,user);
											//System.out.println("2Alert this "+register.toString());
										}
										register.executeUpdate();

									}else{
										System.out.println("Error: bid must be higher than "+ (current+increments)+".");
									}
					}else{
						System.out.println("Error: this auction is over this ended "+ thisDate);
						out.print("Error: this auction is over.");
					}
			}
	}*/

	int[] number = new int[7];
	String[] ans = {" Item_category = ? AND"," Style = ? AND"," Color = ? AND", " Size = ? AND", " Item_no = ? AND", " Seller = ? AND"," Brand = ? AND"};
	String[] alert= new String[6];

	int index=0; int val=1;
	if(itemCat.length()!=0){	//0
		number[index]=val; val++;
		c=c+ans[index];
	}index++;
	if(style.length()!=0){		//1
		number[index]=val; val++;
		c=c+ans[index];
	}index++;
	if(color.length()!=0){		//2
		number[index]=val; val++;
		c=c+ans[index];
	}index++;
	if(size.length()!=0){		//3
		number[index]=val; val++;
		c=c+ans[index];
	}index++;
	if(itemNum.length()!=0){		//4
		number[index]=val; val++;
		c=c+ans[index];
	}index++;
	if(seller.length()!=0){		//5
		number[index]=val; val++;
		c=c+ans[index];
	}index++;
	if(brand.length()!=0){		//6
		number[index]=val; val++;
		c=c+ans[index];
	}
	if(alertBtn!=null){
		System.out.println("AlertBtn! was hit what about all: " +  all);
		PreparedStatement register;
					String a="Insert into Alert (user,brand,color,size,style,itemcat,item_no)VALUES(?,?,?,?,?,?,?)";
					number[5]=1;
					register = con.prepareStatement(a);
					for(int i=0;i<7;i++){
						System.out.println(register.toString());
								switch(i){
									case 0:
										if(itemCat.length()==0){
											register.setString(6,null);
										}else{
											register.setString(6,itemCat);
										}
										break;
									case 1:
										if(style.length()==0){
											register.setString(5,null);
										}else{
											register.setString(5,style);
										}
										 break;
									case 2:
										if(color.length()==0){
											register.setString(3,null);
										}else{
											register.setString(3,color);
										}
										break;
									case 3:
										if(size.length()==0){
											register.setString(4,null);
										}else{
											register.setString(4,size);
										}
										break;

									case 4:
										if(itemNum.length()==0){
											register.setString(7,null);
										}else{
											register.setString(7,itemNum);
										}
										break;
									case 5:
										register.setString(1,user);				//THIS IS WHERE YOU PUT THE USER IN HERE
										break;

									default:
										if(brand.length()==0){
											register.setString(2,null);
										}else{
											register.setString(2,brand);
										}
										break;
								}
					}
					System.out.println(register.toString());
					register.executeUpdate();
	}



	if(dog!=null){
		query=c.substring(0,c.length()-4);
		PreparedStatement register = con.prepareStatement(query);
		for(int i=0;i<7;i++){
			if(number[i]!=0){
					switch(i){
						case 0:
							register.setString(number[i],itemCat); break;
						case 1:
							register.setString(number[i],style); break;
						case 2:
							register.setString(number[i],color); break;
						case 3:
							register.setString(number[i],size); break;
						case 4:
							register.setString(number[i],itemNum); break;
						case 5:
							register.setString(number[i],seller); break;
						default:
							register.setString(number[i],brand); break;
					}
			}
		}
		System.out.println("register query "+register.toString());
		ResultSet listing = register.executeQuery();


	int isMax;
	out.print("<table>");
	//make a row
	out.print("<tr>");
	//make a column
	out.print("<td>");
	//print out column header
	out.print("Item #");
	out.print("</td>");

	out.print("<td>");
	out.print("Brand");
	out.print("</td>");

	out.print("<td>");
	out.print("Style");
	out.print("</td>");

	out.print("<td>");
	out.print("Color");
	out.print("</td>");

	out.print("<td>");
	out.print("Size");
	out.print("</td>");

	out.print("<td>");
	out.print("Seller");
	out.print("</td>");

	out.print("<td>");
	out.print("Starting Bid");
	out.print("</td>");

	out.print("<td>");
	out.print("Bid Inc.");
	out.print("</td>");

	out.print("<td>");
	out.print("Time   ");
	out.print("</td>");

	out.print("<td>");
	out.print("Current Bid");
	out.print("</td>");

	out.print("</tr>");

	ResultSet cross;
	double min=Double.MIN_VALUE;
	double max=Double.MAX_VALUE;
	boolean aids;
	System.out.println("e:" + min + "-" + max);
	if(price.length()!=0){
		StringTokenizer st = new StringTokenizer(price,"-");
		String e =st.nextToken();
		String w= st.nextToken();
		min= Double.parseDouble(e);
		max = Double.parseDouble(w);
		System.out.println("e:" + e + "-" + w);
	}


	while(listing.next() ){

		aids=false;
		//System.out.println("end date " + listing.getDate("End_time") + ""+ now +now.after(listing.getDate("End_time")) );
		register = con.prepareStatement("Select isWinner from Bid Where isWinner= 1 and Item_no= ?" );
		register.setString(1,listing.getString("Item_no"));
		cross = register.executeQuery();
		//first returns true if there is a row

		//Depends what you want to search for if you want just winning auctions or if you want all past auctions
		//this is looking for the past auctions
		if((cross.first()&&expire.compareTo("0")==0 )||(now.after(listing.getDate("End_time")) && expire.compareTo("0")==0 )   ){
			aids=true;
		}else if(!cross.first()&&expire.compareTo("1")==0&&now.before(listing.getDate("End_time")) ){		//we want current
			aids=true;
		}
		if(aids){

				q= "Select * from Bid where Item_no=? order by BidAmt desc";
				id = con.prepareStatement(q);
				id.setString(1,listing.getString("Item_no"));
				currBid=id.executeQuery();
				if(!currBid.isBeforeFirst()){
					current=listing.getInt("Start_price");
				}else{
					currBid.next();
					int ISMAX=currBid.getInt("isMax");
					current=currBid.getDouble("BidAmt");
					listing.getInt("Start_price");
					if(ISMAX ==1 && currBid.next()){		//its a maxBid, there is a second bid
						secondBid=currBid.getDouble("BidAmt");
						if(secondBid!=current){
							current=secondBid+listing.getInt("Bid_inc");
						}
					}else if(ISMAX==1){		//its a naxBid, there is no second bid so its the starting price
						System.out.println("testing");
						current=listing.getInt("Start_price");
					}
				}
				System.out.println( min + "<= " +current+ "<= " +max );
				if(min<=current && current<=max){

					out.print("<tr>");

					out.print("<td>");
					out.print(listing.getString("Item_no"));
					out.print("</td>");

					out.print("<td>");
					out.print(listing.getString("Brand"));
					out.print("</td>");

					out.print("<td>");
					out.print(listing.getString("Style"));
					out.print("</td>");

					out.print("<td>");
					out.print(listing.getString("Color"));
					out.print("</td>");

					out.print("<td>");
					out.print(listing.getString("Size"));
					out.print("</td>");

					out.print("<td>");
					out.print(listing.getString("Seller"));
					out.print("</td>");

					out.print("<td>");
					out.print(listing.getString("Start_price"));
					out.print("</td>");

					out.print("<td>");
					out.print(listing.getString("Bid_inc"));
					out.print("</td>");

					out.print("<td>");
					out.print(listing.getDate("End_time"));
					out.print("</td>");

					out.print("<td>");
					out.print(current);
					out.print("</td>");
				}

			}
		}
	out.print("</table>");

		}
	con.close();
} catch (Exception e) {
	//out.print("<br>");
	//out.print("No items found");
} %>

</html>
