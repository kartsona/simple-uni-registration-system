<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Checking Credentials...</title>
</head>
	<body>
		<%
			try{
				
				ApplicationDB db = new ApplicationDB();	
				Connection con = db.getConnection();
				
				Statement stmt = con.createStatement();
				
				ResultSet rs;
				
				String login_usertype = request.getParameter("usertype");
				String login_username = request.getParameter("username");
				String login_password = request.getParameter("password");
				
				if(login_usertype.equals("admin")){
					session.setAttribute("usertype", login_usertype);
					session.setAttribute("username", login_username);
					response.sendRedirect("adminConsole.jsp");
				}
				
				else if(login_usertype.equals("professor")){
					rs = stmt.executeQuery("select * from Professors where pid=" + login_username + " AND ppassword=\"" + login_password + "\"");
				    if (rs.next()) {
				    	session.setAttribute("usertype", login_usertype);
						session.setAttribute("username", login_username);
				        response.sendRedirect("professorConsole.jsp");
				    }
				}
				else if(login_usertype.equals("student")){
					rs = stmt.executeQuery("select * from Students where sid=" + login_username + " AND spassword=\"" + login_password + "\"");
				    if (rs.next()) {
				    	session.setAttribute("usertype", login_usertype);
						session.setAttribute("username", login_username);
				        response.sendRedirect("studentConsole.jsp");
				    }
				}
				
				con.close();
				
				
			} catch (Exception e){
				//session.removeAttribute("usertype");
				//session.removeAttribute("username");
				session.invalidate();
				out.print("Login failed please return to previous page and try again");
				%>
					<form method="get" action="main.jsp">
						<input type="submit" value="Logout">
					</form>
				<%
			}
		%>
	</body>
</html>
