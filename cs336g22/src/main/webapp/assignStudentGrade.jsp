<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Assigning Student Grade...</title>
</head>
	<body>
		<%
			int newCID = Integer.parseInt(request.getParameter("newCID"));
			//String newSemesterTest = (String)request.getAttribute("semester");
			try {
		
				//Get the database connection
				ApplicationDB db = new ApplicationDB();	
				Connection con = db.getConnection();
		
				//Create a SQL statement
				Statement stmt = con.createStatement();
		
				//Get parameters from the HTML form at the index.jsp
				int newSID = Integer.parseInt(request.getParameter("newSID"));
				//int newSection_Num = Integer.parseInt(request.getParameter("newSection_Num"));
				String newGrade = request.getParameter("newGrade");
				//newSemester = request.getParameter("semester");
		
				//Make an insert statement for the Sells table:
				String insert = "UPDATE Takes SET grade=\"" + newGrade + "\" WHERE sid=" + newSID + " AND cid=" + newCID;
				//Create a Prepared SQL statement allowing you to introduce the parameters of the query
				PreparedStatement ps = con.prepareStatement(insert);
		
				//Add parameters of the query. Start with 1, the 0-parameter is the INSERT statement itself
				//ps.setString(1, newGrade);
				//ps.setInt(2, newSID);
				//ps.setInt(3, newCID);
				//ps.setInt(4, newSection_Num);
				
				//Run the query against the DB
				ps.executeUpdate();
				//Run the query against the DB
				
				//Close the connection. Don't forget to do it, otherwise you're keeping the resources of the server allocated.
				con.close();
				//out.print("insert succeeded");
				
				session.setAttribute("cid", newCID);
				response.sendRedirect("showCourseStudents.jsp");
				
			} catch (Exception e) {
				out.println(e);
				request.setAttribute("cid", newCID);
				out.println("Grade update failed. please return to previous page and try again");
				%>
					<form method="post" action="showCourseStudents.jsp">
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