<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<!--Import some libraries that have classes that we need -->
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Students List</title>
</head>
	<body>
		<%
		if(request.getParameter("cid") != null){
			session.setAttribute("cid", Integer.parseInt(request.getParameter("cid")));
		}
		int tempCID = (int)session.getAttribute("cid");
		%>
		<b>Students in <%= tempCID%>:</b>
	
		<%
		try {
		
				//Get the database connection
				ApplicationDB db = new ApplicationDB();	
				Connection con = db.getConnection();		
	
				//Create a SQL statement
				Statement stmt = con.createStatement();
			
				String str =
						"SELECT s.sname, t.sid, t.section_num, t.grade\n" +
						"FROM Students s, Takes t\n" +
						"WHERE s.sid=t.sid AND t.cid=" + tempCID;
				
				PreparedStatement mainQuery = con.prepareStatement(str);
				//Run the query against the database.
				ResultSet result = mainQuery.executeQuery(str);
			%>
				
			<!--  Make an HTML table to show the results in: -->
		<table border=1>
			<tr>
				<td style="text-align:center"><b>Name</b></td>
				<td style="text-align:center"><b>SID</b></td>
				<td style="text-align:center"><b>Section #</b></td>
				<td style="text-align:center"><b>Grade</b></td>
			</tr>
			<%
			//parse out the results
			while (result.next()) { %>
				<tr>    
					<td><%= result.getString("sname") %></td>
					<td><%= result.getString("sid") %></td>
					<td><%= result.getString("section_num") %></td>
					<td><%= result.getString("grade") %></td>
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
		<b>Assign New Grade:</b>
		<form method="post" action="assignStudentGrade.jsp">
			<input type="hidden" name="newCID" value="<%=session.getAttribute("cid")%>">
			<table>
				<tr>    
					<td>Student:</td><td>
						<select name="newSID">
							<%
							ApplicationDB db = new ApplicationDB();	
							Connection con = db.getConnection();		
				
							//Create a SQL statement
							Statement stmt = con.createStatement();
						
							String str =
									"SELECT s.sname, t.sid, t.section_num, t.grade\n" +
									"FROM Students s, Takes t\n" +
									"WHERE s.sid=t.sid AND t.cid=" + tempCID;
							
							PreparedStatement mainQuery = con.prepareStatement(str);
							//Run the query against the database.
							ResultSet result = mainQuery.executeQuery(str);
							
							while(result.next()){ %>
								<option value="<%= result.getString("sid") %>"><%= result.getString("sname") %></option>
								<%
							}
							db.closeConnection(con);
							%>
						</select>
					</td>
				</tr>
				<tr>
					<td>Grade:</td><td>
						<select name="newGrade">
							<option value="A">A</option>
							<option value="B">B</option>
							<option value="C">C</option>
							<option value="D">D</option>
							<option value="F">F</option>
							<option value="-">No Grade</option>
						</select>
					</td>
				</tr>
			</table>
			<input type="submit" value="Assign">
		</form>
		<br><br>
		<form method="post" action="professorConsole.jsp">
			<input type="submit" value="Back">
		</form>
		<form method="post" action="logout.jsp">
			<input type="submit" value="Logout">
		</form>
	</body>
</html>