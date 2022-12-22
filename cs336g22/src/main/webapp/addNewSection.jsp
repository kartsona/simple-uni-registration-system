<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Adding New Section...</title>
</head>
	<body>
		<%
			String newSemester = request.getParameter("semester");
			//String newSemesterTest = (String)request.getAttribute("semester");
			try {
		
				//Get the database connection
				ApplicationDB db = new ApplicationDB();	
				Connection con = db.getConnection();
		
				//Create a SQL statement
				Statement stmt = con.createStatement();
		
				//Get parameters from the HTML form at the index.jsp
				int newCID = Integer.parseInt(request.getParameter("newCID"));
				int newSection_Num = Integer.parseInt(request.getParameter("newSection_Num"));
				String newMeet_Time = request.getParameter("newMeet_Day") + " " + request.getParameter("newMeet_Hour");
				//newSemester = request.getParameter("semester");
		
				//Make an insert statement for the Sells table:
				String insert = "INSERT INTO Sections(cid, section_num, meet_time, semester)"
						+ "VALUES (?, ?, ?, ?)";
				//Create a Prepared SQL statement allowing you to introduce the parameters of the query
				PreparedStatement ps = con.prepareStatement(insert);
		
				//Add parameters of the query. Start with 1, the 0-parameter is the INSERT statement itself
				ps.setInt(1, newCID);
				ps.setInt(2, newSection_Num);
				ps.setString(3, newMeet_Time);
				ps.setString(4, newSemester);
				
				//Run the query against the DB
				ps.executeUpdate();
				//Run the query against the DB
				
				//Close the connection. Don't forget to do it, otherwise you're keeping the resources of the server allocated.
				con.close();
				//out.print("insert succeeded");
				
				session.setAttribute("semester", newSemester);
				response.sendRedirect("showCourseSchedule.jsp");
				
			} catch (Exception e) {
				//out.println(e);
				request.setAttribute("semester", newSemester);
				out.print("Section insert failed. Section already exists or meet time is already taken. please return to previous page and try again");
				%>
					<form method="post" action="showCourseSchedule.jsp">
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