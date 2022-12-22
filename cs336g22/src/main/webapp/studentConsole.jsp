<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<!--Import some libraries that have classes that we need -->
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Student Console</title>
</head>
<body>

	<% String currSID = session.getAttribute("username").toString(); %>
	Taken Courses:
	
	<% try {
	
			//Get the database connection
			ApplicationDB db = new ApplicationDB();	
			Connection con = db.getConnection();		
			//Create a SQL statement
			Statement stmt = con.createStatement();
			
			//Make a SELECT query from the table specified by the 'command' parameter at the index.jsp
			String str = "SELECT cid, section_num, grade FROM Takes WHERE sid=\"" + currSID + "\"";
			//Run the query against the database.
			ResultSet result = stmt.executeQuery(str);
		%>
			
		<!--  Make an HTML table to show the results in: -->
	<table border=1>
		<tr>    
			<td><b>CID</b></td>
			<td><b>Section #</b></td>
			<td><b>Grade</b></td>
		</tr>
		<%
		//parse out the results
		while (result.next()) { %>
			<tr>    
				<td><%= result.getString("cid") %></td>
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
	Course Sections Able to Register For:
	<% try {
	
			//Get the database connection
			ApplicationDB db = new ApplicationDB();	
			Connection con = db.getConnection();		
			//Create a SQL statement
			Statement stmt = con.createStatement();
			
			//Make a SELECT query from the table specified by the 'command' parameter at the index.jsp
			String str =
					"select se.meet_time, se.cid, se.section_num " +
							"from sections se " +
							"where se.meet_time not in( " +
							"    select se1.meet_time " +
							"    from sections se1, takes t " +
							"    where se1.cid=t.cid AND se1.section_num=t.section_num AND (se1.cid, se1.section_num) in( " +
							"        select t0.cid, t0.section_num " +
							"        from takes t0 " +
							"        where t0.sid=?) " +
							") AND se.cid in( " +
							"    select c.cid " +
							"    from courses c " +
							"    where c.cid not in( " +
							"        select pr.curr_cid " +
							"        from prereqs pr " +
							"        where pr.prereq_cid not in( " +
							"            select t1.cid " +
							"            from takes t1 " +
							"            where t1.sid=?)) AND c.cid not in( " +
							"                select t2.cid " +
							"                from takes t2 " +
							"                where t2.sid=?)) ";
			PreparedStatement mainStmt = con.prepareStatement(str);
			
			mainStmt.setInt(1, Integer.parseInt(currSID));
			mainStmt.setInt(2, Integer.parseInt(currSID));
			mainStmt.setInt(3, Integer.parseInt(currSID));
			//Run the query against the database.
			ResultSet result = mainStmt.executeQuery();
		%>
			
		<!--  Make an HTML table to show the results in: -->
	<table border=1>
		<tr>    
			<td><b>CID</b></td>
			<td><b>Section #</b></td>
			<td><b>Meet Time</b></td>
		</tr>
		<%
		//parse out the results
		while (result.next()) { %>
			<tr>    
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
	Register for a course section:		
	<br>
		<form method="post" action="register.jsp">
			<input type="hidden" name="semester" value="<%=session.getAttribute("semester")%>">
			<table>
				<tr>    
					<td>Course ID</td><td>
						<select name="cid">
							<%
							ApplicationDB db = new ApplicationDB();	
							Connection con = db.getConnection();		
			
							//Create a SQL statement
							Statement stmt = con.createStatement();
							
							//Make a SELECT query from the table specified by the 'command' parameter at the index.jsp
							String str =
									"select distinct se.cid " +
											"from sections se " +
											"where se.meet_time not in( " +
											"    select se1.meet_time " +
											"    from sections se1, takes t " +
											"    where se1.cid=t.cid AND se1.section_num=t.section_num AND (se1.cid, se1.section_num) in( " +
											"        select t0.cid, t0.section_num " +
											"        from takes t0 " +
											"        where t0.sid=?) " +
											") AND se.cid in( " +
											"    select c.cid " +
											"    from courses c " +
											"    where c.cid not in( " +
											"        select pr.curr_cid " +
											"        from prereqs pr " +
											"        where pr.prereq_cid not in( " +
											"            select t1.cid " +
											"            from takes t1 " +
											"            where t1.sid=?)) AND c.cid not in( " +
											"                select t2.cid " +
											"                from takes t2 " +
											"                where t2.sid=?)) ";
							PreparedStatement mainStmt = con.prepareStatement(str);
							
							mainStmt.setInt(1, Integer.parseInt(currSID));
							mainStmt.setInt(2, Integer.parseInt(currSID));
							mainStmt.setInt(3, Integer.parseInt(currSID));
							//Run the query against the database.
							ResultSet result = mainStmt.executeQuery();
							
							while(result.next()){ %>
								<option value="<%= result.getString("cid") %>"><%= result.getString("cid") %></option>
								<%
							}
							db.closeConnection(con);
							%>
						</select>
					</td>
				</tr>
				<tr>    
					<td>Section #</td><td>
						<select name="section_num">
							<option value="1">1</option>
							<option value="2">2</option>
							<option value="3">3</option>
							<option value="4">4</option>
							<option value="5">5</option>
						</select>
					</td>
				</tr>
			</table>
			<input type="submit" value="Register">
		</form>
		<br><br>
		<form method="post" action="logout.jsp">
			<input type="submit" value="Logout">
		</form>
</body>
</html>
