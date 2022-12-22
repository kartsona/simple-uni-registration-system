<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*" %>
    

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
		<title>Main Page</title>
	</head>
	
	<body>
	Welcome to the Group 22 University Registration System Project!
	<br><br>
	<b>Login Below:</b>
	<br>
		<form method="post" action="credentialCheck.jsp">
			<input type="radio" name="usertype" value="admin"/>Admin
			<input type="radio" name="usertype" value="professor"/>Professor
			<input type="radio" name="usertype" value="student"/>Student
			<table>
				<tr>    
					<td>ID/Username:</td><td><input type="text" name="username"></td>
				</tr>
				<tr>
					<td>Password:</td><td><input type="text" name="password"></td>
				</tr>
			</table>
			<input type="submit" value="Submit">
		</form>
	<br>
	</body>
</html>