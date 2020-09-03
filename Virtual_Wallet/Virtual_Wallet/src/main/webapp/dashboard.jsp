<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
    
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Virtual Cards Wallet - Home</title>
<%@include file="style.css" %>
<style>

/* Float four columns side by side */
.column {
  float: left;
  width: 25%;
  padding: 0 10px;
}

/* Remove extra left and right margins, due to padding */
.row {margin: 0 -5px;}

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
  text-align: center;
  background-color: #DBDADA;
}
</style>
</head>
<body>
<%if(session.getAttribute("userid")==null || session.getAttribute("userid").equals("")){
	response.sendRedirect("login");
	}%>

<%@include file="navbar.jsp" %>

<br>
<div class="row">
  <div class="column">
    <div class="card">
      <h3><b>My wallet</b></h3> 
    <hr>
    <label>Available Balance</label> 
    <h3><label id="wallet-balance"><%=session.getAttribute("balance")%></label></h3>
    </div>
  </div>

  <div class="column">
    <div class="card">
      <h3><b>Cards</b></h3> 
    <hr>
    <label>No. of Cards remaining</label> 
    <h3><label id="cards-remaining"><%=session.getAttribute("noOfCards")%></label></h3>
    </div>
  </div>
  </div>
</body>
</html>