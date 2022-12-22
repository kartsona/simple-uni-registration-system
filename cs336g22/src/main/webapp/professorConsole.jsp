<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<!--Import some libraries that have classes that we need -->
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Professor Console</title>
</head>
<body>

	<b>Teaching Classes:</b>
	
	<% try {
	
			//Get the database connection
			ApplicationDB db = new ApplicationDB();	
			Connection con = db.getConnection();		

			//Create a SQL statement
			Statement stmt = con.createStatement();
			
			//Make a SELECT query from the table specified by the 'command' parameter at the index.jsp
			//String str = "SELECT cid FROM Teaches WHERE cid=" + session.getAttribute("username");
			String str =
					"SELECT c.cid, c.cname\n" +
					"FROM Courses c, Teaches t\n" +
					"WHERE t.cid=c.cid AND t.pid=" + session.getAttribute("username");;
			//Run the query against the database.
			ResultSet result = stmt.executeQuery(str);
		%>
			
		<!--  Make an HTML table to show the results in: -->
	<table border=1>
		<tr>    
			<td style="text-align:center"><b>CID</b></td>
			<td style="text-align:center"><b>Course Name</b></td>
		</tr>
		<%
		//parse out the results
		while (result.next()) { %>
			<tr>    
				<td><%= result.getString("cid") %></td>
				<td><%= result.getString("cname") %></td>
			</tr>
			

		<% }
		//close the connection.
		db.closeConnection(con);
		%>
	</table>

			
		<%} catch (Exception e) {
			out.print(e);
		}%>

	<br>


	<b>View Students & Assign Grades:</b>
	<br>
		<form method="post" action="showCourseStudents.jsp">
			<label for="class">Class:</label>
			<select name="cid">
				<%
				ApplicationDB db = new ApplicationDB();	
				Connection con = db.getConnection();		

				//Create a SQL statement
				Statement stmt = con.createStatement();
				
				//Make a SELECT query from the table specified by the 'command' parameter at the index.jsp
				String str =
					"SELECT c.cid, c.cname\n" +
					"FROM Courses c, Teaches t\n" +
					"WHERE t.cid=c.cid AND t.pid=" + session.getAttribute("username");;
				//Run the query against the database.
				ResultSet result = stmt.executeQuery(str);
				
				while(result.next()){ %>
					<option value="<%= result.getString("c.cid") %>"><%= result.getString("c.cid") %> <%= result.getString("c.cname")%></option>
					<%
				}
				db.closeConnection(con);
				%>
			</select>
			<br>
			<input type="submit" value="View Students">
		</form>
	<br>
	<form method="post" action="logout.jsp">
		<input type="submit" value="Logout">
	</form>
</body>
</html>