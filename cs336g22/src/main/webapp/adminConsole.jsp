<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<!--Import some libraries that have classes that we need -->
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Admin Console</title>
</head>
<body>
	Logged In: <%= session.getAttribute("username") %>
	<br>
	<b>Students:</b>
	
	<% try {
	
			//Get the database connection
			ApplicationDB db = new ApplicationDB();	
			Connection con = db.getConnection();		
			//Create a SQL statement
			Statement stmt = con.createStatement();
			
			//Make a SELECT query from the table specified by the 'command' parameter at the index.jsp
			String str = "SELECT * FROM Students";
			//Run the query against the database.
			ResultSet result = stmt.executeQuery(str);
		%>
			
		<!--  Make an HTML table to show the results in: -->
	<table border=1>
		<tr>    
			<td style="text-align:center"><b>Name</b></td>
			<td style="text-align:center"><b>SID</b></td>
			<td style="text-align:center"><b>Password</b></td>
		</tr>
		<%
		//parse out the results
		while (result.next()) { %>
			<tr>    
				<td><%= result.getString("sname") %></td>
				<td><%= result.getString("sid") %></td>
				<td><%= result.getString("spassword") %></td>
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

	<b>Professors:</b>
	
	<% try {
	
			//Get the database connection
			ApplicationDB db = new ApplicationDB();	
			Connection con = db.getConnection();		
			//Create a SQL statement
			Statement stmt = con.createStatement();
			
			//Make a SELECT query from the table specified by the 'command' parameter at the index.jsp
			String str = "SELECT * FROM Professors";
			//Run the query against the database.
			ResultSet result = stmt.executeQuery(str);
		%>
			
		<!--  Make an HTML table to show the results in: -->
	<table border=1>
		<tr>    
			<td style="text-align:center"><b>Name</b></td>
			<td style="text-align:center"><b>PID</b></td>
			<td style="text-align:center"><b>Password</b></td>
		</tr>
		<%
		//parse out the results
		while (result.next()) { %>
			<tr>    
				<td><%= result.getString("pname") %></td>
				<td><%= result.getString("pid") %></td>
				<td><%= result.getString("ppassword") %></td>
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
	
	<b>Courses:</b>
	
	<% try {
	
			//Get the database connection
			ApplicationDB db = new ApplicationDB();	
			Connection con = db.getConnection();		
			//Create a SQL statement
			Statement stmt = con.createStatement();
			
			//Make a SELECT query from the table specified by the 'command' parameter at the index.jsp
			String str = "SELECT * FROM Courses";
			//Run the query against the database.
			ResultSet result = stmt.executeQuery(str);
		%>
			
		<!--  Make an HTML table to show the results in: -->
	<table border=1>
		<tr>    
			<td style="text-align:center"><b>Name</b></td>
			<td style="text-align:center"><b>CID</b></td>
			<td style="text-align:center"><b>Credits</b></td>
		</tr>
		<%
		//parse out the results
		while (result.next()) { %>
			<tr>    
				<td><%= result.getString("cname") %></td>
				<td><%= result.getString("cid") %></td>
				<td><%= result.getString("credit_num") %></td>
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

	<b>Add New Student:</b>
	<br>
		<form method="post" action="addNewStudent.jsp">
			<table>
				<tr>    
					<td>Student Name</td><td><input type="text" name="sname"></td>
				</tr>
				<tr>    
					<td>Student ID</td><td><input type="text" name="sid"></td>
				</tr>
				<tr>    
					<td>Password</td><td><input type="text" name="spassword"></td>
				</tr>
				<tr>
					<td>Phone Number</td><td><input type="text" name="phone_num"></td>
				</tr>
				<tr>
					<td>Birthdate</td><td><input type="date" name="birth_date"></td>
				</tr>
			</table>
			<input type="submit" value="Create">
		</form>
	<br>
	
	<b>Add New Professor:</b>
	<br>
		<form method="post" action="addNewProfessor.jsp">
			<table>
				<tr>    
					<td>Professor Name</td><td><input type="text" name="pname"></td>
				</tr>
				<tr>    
					<td>Professor ID</td><td><input type="text" name="pid"></td>
				</tr>
				<tr>    
					<td>Password</td><td><input type="text" name="ppassword"></td>
				</tr>
				<tr>
					<td>Phone Number</td><td><input type="text" name="phone_num"></td>
				</tr>
				<tr>
					<td>Office Number</td><td><input type="text" name="office_num"></td>
				</tr>
			</table>
			<input type="submit" value="Create">
		</form>
	<br>
	<b>Add New Course:</b>
	<br>
		<form method="post" action="addNewCourse.jsp">
			<table>
				<tr>    
					<td>Course Name</td><td><input type="text" name="cname"></td>
				</tr>
				<tr>    
					<td>Course ID</td><td><input type="text" name="cid"></td>
				</tr>
				<tr>
					<td>Credit Amount</td><td><input type="text" name="credit_num"></td>
				</tr>
				<tr>
					<td>Department</td><td><input type="text" name="department"></td>
				</tr>
			</table>
			<input type="submit" value="Create">
		</form>
	<br>
	<b>Show All Sections & Add New Section:</b>
	<br>
		<form method="post" action="showCourseSchedule.jsp">
			<label for="semester">Choose a semester:</label>
			<select name="semester">
				<%
				ApplicationDB db = new ApplicationDB();	
				Connection con = db.getConnection();		
				//Create a SQL statement
				Statement stmt = con.createStatement();
				
				//Make a SELECT query from the table specified by the 'command' parameter at the index.jsp
				String str = "SELECT DISTINCT semester FROM Sections";
				//Run the query against the database.
				ResultSet result = stmt.executeQuery(str);
				
				while(result.next()){ %>
					<option value="<%= result.getString("semester") %>"><%= result.getString("semester") %></option>
					<%
				}
				db.closeConnection(con);
				%>
			</select>
			<br>
			<input type="submit" value="Show & Edit Course Schedule">
		</form>
	<br><br>
		<form method="post" action="logout.jsp">
			<input type="submit" value="Logout">
		</form>
</body>
</html>