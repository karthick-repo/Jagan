<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Virtual Cards Wallet - Create card</title>
<%@include file="style.css" %>

</head>
<body>
<%if(session.getAttribute("userid")==null || session.getAttribute("userid").equals("")){
	response.sendRedirect("login");
	}%>
<%@include file="navbar.jsp" %>
<br><br>
<form action="create_card/error" method="POST" onsubmit="return validate()">
<div style="border: 2px solid black; margin-left: 25%; text-align: center; padding: 4px; width: 50%;">
<br>
<h1>Create New VirtualCard</h1>
<hr>
<div id="error-message" style="color: red; text-align: center"><h3>${error}</h3></div>

<label>Card Name</label><br>
<input type="text" name="input-cardname" placeholder="eg.,Online Payments"/><br><br>
<label>Select Account</label><br>
<select name="from-account" id="from-account">
  <option value="MyWallet">MyWallet</option>  			  							  							  
</select><br><br>
<% int balance=(Integer)session.getAttribute("balance");%>
<label>Balance:</label>Rs.<label id="lbl-acc-balance"><%=balance %></label><br><br>
<label>Amount</label><br>
<input type="number" name="input-amount"/><br><br>	

<input type="submit" id="btn-createcard" name="btn-createcard" value="Create Card"/>
<br><br>
</div>
</form>
</body>
</html>