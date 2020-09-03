<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Virtual Cards Wallet - Login</title>
</head>

<script type="text/javascript">
function validate(){
	document.getElementById("error-message").innerHTML= "";
	var userName = document.getElementById("username");
	var password = document.getElementById("password");
	if(userName.value.trim().length>30)
	{
		document.getElementById("error-message").style.display="block";
		document.getElementById("error-message").innerHTML="Username length should be less than of equals 30 characters";
		return false;
	}else if (password.value.trim().length>30) {
		document.getElementById("error-message").style.display="block";
		document.getElementById("error-message").innerHTML="Password length should be less than of equals 30 characters";
		return false;
	}else{
		return true;
		}
}	
</script>
<body>
<form action="login" method="POST" onsubmit="return validate()">
<div style="border: 2px solid black; margin-left: 25%; text-align: center; padding: 4px; width: 50%;">
		<br>
		<h1 style="text-align:center">VIRTUAL WALLET</h1>
		<div id="error-message" style="color: red; text-align: center">${error}</div>
		<label>User Name</label><br>
		<input type="text" name="username" id="username"/><br>
		<label>Password</label><br>
		<input type="password" name="password" id="password"/><br>
		<br>
		<input type="submit" id="login" name="login" value="Login" />
		<br>
		<br>
</div>
</form>
</body>
</html>