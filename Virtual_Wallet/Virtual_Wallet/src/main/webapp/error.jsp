<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title><%=session.getAttribute("title") %></title>
<%@include file="style.css" %>
</head>
<body>
<%if(session.getAttribute("userid")==null || session.getAttribute("userid").equals("")){
	response.sendRedirect("login");
	}%>
<%@include file="navbar.jsp" %>
<br><br>
<form action="../view_cards" method="POST">
<div style="border: 2px solid black; margin-left: 25%; text-align: center; padding: 4px; width: 50%;">
<br>
<div id="error-message" style="color: red; text-align: center"><h3><span style="font-size:25px"><b>X</b>&nbsp;&nbsp;</span>${error}</h3></div>
<hr>
<br>
<input type="submit" name="btn-viewcard" value="View Cards"/><br><br>
</div>
</form>
</body>
</html>