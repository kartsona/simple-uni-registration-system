<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Adding New Student...</title>
</head>
	<body>
		<%
			try {
		
				//Get the database connection
				ApplicationDB db = new ApplicationDB();	
				Connection con = db.getConnection();
		
				//Create a SQL statement
				Statement stmt = con.createStatement();
		
				//Get parameters from the HTML form at the index.jsp
				String newSName = request.getParameter("sname");
				int newSID = Integer.parseInt(request.getParameter("sid"));
				String newPhone_Num = request.getParameter("phone_num");
				String newBirth_Date = request.getParameter("birth_date");
				String newSPassword = request.getParameter("spassword");
		
				//Make an insert statement for the Sells table:
				String insert = "INSERT INTO Students(sid, sname, phone_num, birth_date, spassword)"
						+ "VALUES (?, ?, ?, ?, ?)";
				//Create a Prepared SQL statement allowing you to introduce the parameters of the query
				PreparedStatement ps = con.prepareStatement(insert);
		
				//Add parameters of the query. Start with 1, the 0-parameter is the INSERT statement itself
				ps.setInt(1, newSID);
				ps.setString(2, newSName);
				ps.setString(3, newPhone_Num);
				ps.setString(4, newBirth_Date);
				ps.setString(5, newSPassword);
				
				//Run the query against the DB
				ps.executeUpdate();
				//Run the query against the DB
				
				//Close the connection. Don't forget to do it, otherwise you're keeping the resources of the server allocated.
				con.close();
				//out.print("insert succeeded");
				
				response.sendRedirect("adminConsole.jsp");
				
			} catch (Exception e) {
				out.print("Student insert failed please return to previous page and try again");
				%>
					<form method="get" action="adminConsole.jsp">
						<input type="submit" value="Back">
					</form>
				<%
			}
		%>
		<form method="post" action="logout.jsp">
			<input type="submit" value="Logout">
		</form>
	</body>
</html>