<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ page import="com.wipro.model.CardEntity"%>
<%@ page import="java.util.Iterator"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Virtual Cards Wallet - View Cards</title>
<link rel="stylesheet" href="https://www.w3schools.com/w3css/4/w3.css">
<%@include file="style.css"%>
<style>
/* Float four columns side by side */
.column {
	float: left;
	width: 25%;
	padding: 0 10px;
}

/* Remove extra left and right margins, due to padding */
.row {
	margin: 0 -5px;
}

/* Clear floats after the columns */
.row:after {
	content: "";
	display: table;
	clear: both;
}

/* Responsive columns */
@media screen and (max-width: 600px) {
	.column {
		width: 100%;
		display: block;
		margin-bottom: 20px;
	}
}

/* Style the counter cards */
.card {
	box-shadow: 0 4px 8px 0 rgba(0, 0, 0, 0.2);
	padding: 16px;
	text-align: left;
	background-color: #DBDADA;
}

.card1 {
	border: 2px dotted gray;
	margin-bottom: 20px;
	text-align: center;
	padding: 40px;
	width: 90%;
	overflow: auto;
}
</style>
</head>
<body>
	<%
		if (session.getAttribute("userid") == null || session.getAttribute("userid").equals("")) {
			response.sendRedirect("login");
		}
	%>
	<%@include file="navbar.jsp"%>
	<br>
	<div class="row">
		<%
			Iterator<CardEntity> cards = (Iterator<CardEntity>) session.getAttribute("CardEntity");
			String userId = (String) session.getAttribute("userid");
			int count = 0;
			while (cards.hasNext()) {
				CardEntity card = new CardEntity();
				card = cards.next();
				if (card.getUsername().equals(userId)) {
					count++;
		%>

		<div class="column">
			<div class="card">
				<h3>
					<label id="lbl-cardname"><%=card.getCardName()%></label>
				</h3>
				<label id="lbl-cardnumber"><%=card.getCardNumber()%></label><br>
				<label id="lbl-expiry"><%=card.getExpiryDate()%></label><br>
				<h3>
					<label id="lbl-cardbalance" style="padding: 50%">&#8377;<%=card.getCardBalance()%></label>
				</h3>
			</div>
		</div>
		<%
			}
			}
		%>

		<%
			if (count < 3) {
		%>
		<div class="column">
			<div class="card1">
				<a href="create_card"><button id="btn-createcard"
						class="w3-button w3-xlarge w3-circle w3-black">+</button></a>
				<h4 style="text-align: center; color: gray">Create a Virtual
					Card</h4>
			</div>
		</div>
		<%
			} else {
		%>
		<div class="column">
			<div class="card1">
				<a href="create_card"><button id="btn-createcard"
						class="w3-button w3-xlarge w3-circle w3-black" disabled>+</button></a>
				<div id="information" style="color:red">You have reached the limit to create card</div>			
			</div>
		</div>
		<%} %>
	</div>
</body>
</html>