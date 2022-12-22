<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<!--Import some libraries that have classes that we need -->
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Course Schedule</title>
</head>
	<body>
		<%
		if(request.getParameter("semester") != null){
			session.setAttribute("semester", request.getParameter("semester"));
		}
		String tempSemester = (String)session.getAttribute("semester");
		%>
		<b>Course Schedule for <%= tempSemester%>:</b>
	
		<%
		try {
		
				//Get the database connection
				ApplicationDB db = new ApplicationDB();	
				Connection con = db.getConnection();		
	
				//Create a SQL statement
				Statement stmt = con.createStatement();
			
				String str =
						"SELECT c.cname, se.cid, se.section_num, se.meet_time, se.semester\n" +
						"FROM Sections se, Courses c\n" +
						"WHERE c.cid=se.cid AND se.semester=\"" + tempSemester + "\"";
				
				PreparedStatement mainQuery = con.prepareStatement(str);
				//Run the query against the database.
				ResultSet result = mainQuery.executeQuery(str);
			%>
				
			<!--  Make an HTML table to show the results in: -->
		<table border=1>
			<tr>    
				<td style="text-align:center"><b>Course Name</b></td>
				<td style="text-align:center"><b>CID</b></td>
				<td style="text-align:center"><b>Section #</b></td>
				<td style="text-align:center"><b>Meeting Time</b></td>
			</tr>
			<%
			//parse out the results
			while (result.next()) { %>
				<tr>    
					<td><%= result.getString("cname") %></td>
					<td><%= result.getString("cid") %></td>
					<td><%= result.getString("section_num") %></td>
					<td>
						<% if ((result.getString("meet_time")).charAt(9) == '1'){ %>
							Monday @ <%= (result.getString("meet_time")).substring(10, 16)%>
						<% }else if((result.getString("meet_time")).charAt(9) == '2'){ %>
							Tuesday @ <%= (result.getString("meet_time")).substring(10, 16)%>
						<% }else if((result.getString("meet_time")).charAt(9) == '3'){ %>
							Wednesday @ <%= (result.getString("meet_time")).substring(10, 16)%>
						<% }else if((result.getString("meet_time")).charAt(9) == '4'){ %>
							Thursday @ <%= (result.getString("meet_time")).substring(10, 16)%>
						<% }else if((result.getString("meet_time")).charAt(9) == '5'){ %>
							Friday @ <%= (result.getString("meet_time")).substring(10, 16)%>
						<% } %>
					</td>
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
		<b>Create New Section:</b>
		<form method="post" action="addNewSection.jsp">
			<input type="hidden" name="semester" value="<%=session.getAttribute("semester")%>">
			<table>
				<tr>    
					<td>Course ID</td><td>
						<select name="newCID">
							<%
							ApplicationDB db = new ApplicationDB();	
							Connection con = db.getConnection();		
			
							//Create a SQL statement
							Statement stmt = con.createStatement();
							
							//Make a SELECT query from the table specified by the 'command' parameter at the index.jsp
							String str = "SELECT * FROM Courses";
							//Run the query against the database.
							ResultSet result = stmt.executeQuery(str);
							
							while(result.next()){ %>
								<option value="<%= result.getString("cid") %>"><%= result.getString("cid") %> <%= result.getString("cname") %></option>
								<%
							}
							db.closeConnection(con);
							%>
						</select>
					</td>
				</tr>
				<tr>    
					<td>Section #</td><td>
						<select name="newSection_Num">
							<option value="1">1</option>
							<option value="2">2</option>
							<option value="3">3</option>
							<option value="4">4</option>
							<option value="5">5</option>
						</select>
					</td>
				</tr>
				<tr>
					<td>Meet Time</td><td>
						<select name="newMeet_Day">
							<option value="2022-08-01">Monday</option>
							<option value="2022-08-02">Tuesday</option>
							<option value="2022-08-03">Wednesday</option>
							<option value="2022-08-04">Thursday</option>
							<option value="2022-08-05">Friday</option>
						</select>
					</td>
				</tr>
				<tr>
					<td></td><td>
						<select name="newMeet_Hour">
							<option value="09:00:00">9:00am</option>
							<option value="12:00:00">12:00pm</option>
							<option value="15:00:00">3:00pm</option>
							<option value="18:00:00">6:00pm</option>
						</select>
					</td>
				</tr>
			</table>
			<input type="submit" value="Create">
		</form>
		<br><br>
		<form method="post" action="adminConsole.jsp">
			<input type="submit" value="Back">
		</form>
		<form method="post" action="logout.jsp">
			<input type="submit" value="Logout">
		</form>
	</body>
</html>