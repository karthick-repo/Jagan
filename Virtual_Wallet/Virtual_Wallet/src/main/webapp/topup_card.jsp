<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
     <%@ page import="com.wipro.model.CardEntity"%>
    <%@ page import="java.util.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Virtual Cards Wallet - Topup</title>
<%@include file="style.css" %>
<script src="https://code.jquery.com/jquery-1.10.2.js"></script>
<script type="text/javascript" src="topup.js"></script>
<%-- <script type="text/javascript">
<%@include file="jquery.js" %>
</script> --%>
</head>
<body>
<%if(session.getAttribute("userid")==null || session.getAttribute("userid").equals("")){
	response.sendRedirect("login");
	}%>
<%@include file="navbar.jsp" %>
<br><br>
<form action="topup_card/error" method="POST" onsubmit="return validate()">
<div style="border: 2px solid black; margin-left: 25%; text-align: center; padding: 4px; width: 50%;">
<br>
<h1>TopUp Virtual Card</h1>
<hr>
<div id="error" style="color: red; text-align: center">${error}</div>
<label>Select Card</label><br>
<select name="select-card" id="select-card">
<% Iterator<CardEntity> cards=(Iterator<CardEntity>)session.getAttribute("CardEntity"); 
String userid=(String)session.getAttribute("userid");
Map<String, Integer> map = new HashMap<String, Integer>();
while(cards.hasNext()){
	CardEntity card=new CardEntity();
	card=cards.next();	
	if((card.getUsername()).equals(userid)){
		String opvalue=card.getCardName();		
		map.put(opvalue, card.getCardBalance());		
		%>
  <option value="<%=opvalue%>" selected><%=opvalue%></option>  	
  <%}
	}  
int balance=(Integer)session.getAttribute("balance");%>		  							  							  
</select><br><br>

<label>Balance:</label><label id="lbl-card-balance"><span id="bal"></span></label><br><br> 

<label>Select Account</label><br>
<select name="select-account" id="select-account">
  <option value="MyWallet" selected>MyWallet</option>  			  							  							  
</select><br><br>
<label>Balance:</label><label id="lbl-wallet-balance"><%=balance%></label><br><br>
<label>Amount</label><br>
<input type="number" name="topup-val" id="topup-val" /><br><br>
<input type="submit" value="TopUp Card" name="btn-topup"/>
<br><br>
</div>
</form>
</body>
</html>