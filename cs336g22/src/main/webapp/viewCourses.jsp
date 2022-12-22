<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<!--Import some libraries that have classes that we need -->
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Completed Courses</title>
</head>
<body>
	<%
		try {
			//Get the database connection
			ApplicationDB db = new ApplicationDB();
			Connection con = db.getConnection();
			
			//Create a SQL statement
			Statement stmt = con.createStatement();
			
			String entity = (String)session.getAttribute("username");
			String takes = request.getParameter("command");
			
			//testing to see the client input
			   //out.println("username: " + entity);
			   //out.println("takes: " + takes);	      
			
			//Make a SELECT query from the table specified by the 'command' parameter at the index.jsp
			String query = "SELECT cid, section_num, grade FROM " + takes + " WHERE sid ='"+ entity + "'";
			
			//Checks if connection was sucessful
			   //out.println("Connection Made");
			
			//Run the query against the database.
			ResultSet result = stmt.executeQuery(query);
			
			
			
	%>
		<!--  Make an HTML table to show the results in: -->
	<table border=1>
		<tr>    
			<td>  
				<%if (takes.equals("takes")) 
					out.print("CID");
				else
					out.print("Error");
				%>
			</td>
			<td>
				<%if (takes.equals("takes")) 
					out.print("Section #");
				else
					out.print("Error");
				%>
			</td>
			
			<td>			
				<%if (takes.equals("takes"))
					out.print("Grade");
				else
					out.print("Error");
				%>
			</td>			
	   </tr>
		
			<%
			//parse out the results
			while (result.next()) { %>
				<tr>    	
					<td>
						<% if (takes.equals("takes")){ %>
							<%= result.getString("cid")%>
						<% } %>
					</td>		
					<td>
						<% if (takes.equals("takes")){ %>
							<%= result.getString("section_num")%>
						<% } %>
					
					</td>
					
					
					<td>	
						<% if (takes.equals("takes")){ %>
							<%= result.getString("grade")%>
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
		
	<form method="post" action="studentConsole.jsp">
		<input type="submit" value="Back">
	</form>
	<form method="post" action="logout.jsp">
		<input type="submit" value="Logout">
	</form>
</body>
</html>
