<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
 <%@ page import="com.wipro.model.CardEntity"%>
    <%@ page import="java.util.Iterator" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Virtual Cards Wallet - Topup Success</title>
<%@include file="style.css" %>
</head>
<body>
<%if(session.getAttribute("userid")==null || session.getAttribute("userid").equals("")){
	response.sendRedirect("login");
	}%>
<%@include file="navbar.jsp" %>
<br><br>
<form action="../view_cards" method="POST" onsubmit="return validate()">
<div style="border: 2px solid black; margin-left: 25%; text-align: center; padding: 4px; width: 50%;">
<br>
<div id="success-message"><h1 style="color:green">&#x2611;	TopUp Successful</h1></div>
<hr>
<div id="error" style="color: red; text-align: center">${error}</div>
<%CardEntity card=(CardEntity)session.getAttribute("CardEntity");%>
<label style="font-size:12px;color:gray">Card Name</label><br>
<label id="lbl-cardname"><%=card.getCardName() %></label><br>
<label style="font-size:12px;color:gray">Card Number</label><br>
<label id="lbl-cardnumber"><%=card.getCardNumber() %></label><br>
<label style="font-size:12px;color:gray">Card Balance</label><br>
<label id="lbl-cardbalance"><%=card.getCardBalance() %></label><br><br>
<input type="submit" name="btn-viewcard" value="View Cards"/><br><br>
</div>
</form>
</body>
</html>