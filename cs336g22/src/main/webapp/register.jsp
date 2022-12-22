<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<!--Import some libraries that have classes that we need -->
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Registering...</title>
</head>
<body>
	<%
		try {
			//Get the database connection
			ApplicationDB db = new ApplicationDB();
			Connection con = db.getConnection();
			//Get parameters from the HTML form at the index.jsp
			String sid = session.getAttribute("username").toString();
/*  			String sid = request.getParameter("sid"); */
			String cid = request.getParameter("cid");
			String sectionNum = request.getParameter("section_num");
			
			// Query DB for course and section
			// Print message if something is wrong
			// Redirect to student console
 			ResultSet rs;
			PreparedStatement validateCourse = con.prepareStatement("select cid, section_num from Sections where cid=? and section_num=?");
  			validateCourse.setInt(1, Integer.parseInt(cid));
			validateCourse.setInt(2, Integer.parseInt(sectionNum));
			rs = validateCourse.executeQuery();
			if (!rs.next()) {
				//out.println("Invalid Course ID or Section Number");
				//out.println();
			}

			validateCourse = con.prepareStatement("select cid from Courses where cid=?");
			validateCourse.setInt(1, Integer.parseInt(cid));
			rs = validateCourse.executeQuery();
			if (!rs.next()) {
				out.println("Invalid Course ID");
				%><br><%
				//out.println();
			}
			
			validateCourse = con.prepareStatement("select section_num from Sections where section_num=?");
			validateCourse.setInt(1, Integer.parseInt(sectionNum));
			rs = validateCourse.executeQuery();
			if (!rs.next()) {
				out.println("Invalid Section Number");
				%><br><%
				//out.println();
			}
			
 			// Get a list of available course sections that the student can take
			// which includes course id, section number, the day/time
			String query = 
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
  			PreparedStatement mainQuery = con.prepareStatement(query);
			// Set the values for the four missing parameters
  			mainQuery.setInt(1, Integer.parseInt(sid));
			mainQuery.setInt(2, Integer.parseInt(sid));
			mainQuery.setInt(3, Integer.parseInt(sid));
			//Run the query against the database.
			ResultSet result = mainQuery.executeQuery(); // executeQuery never returns null
			
 			// Iterate through result tuples
			boolean canTake = false;
			while (result.next()) {
				// Check for a match to the student's requested course registration
				// If theres a match then set canTake to true and break out of the loop
				int rowCid = result.getInt("cid");
				if (rowCid == Integer.parseInt(cid)) {
					canTake = true;
					mainQuery.close();
					result.close();
					break;
				}
			} 
			
			if (canTake) {
				//out.println("Course Prereq Satisfied. No schedule conflict. Adding Course");
	 			//Make an insert statement for the Sells table:
				String insertCourse = "INSERT INTO Takes VALUES (?,?,?,?)";
				//Create a Prepared SQL statement allowing you to introduce the parameters of the query
				PreparedStatement ps = con.prepareStatement(insertCourse);
				
				//Add parameters of the query. Start with 1, the 0-parameter is the INSERT statement itself
				ps.setInt(1, Integer.parseInt(sid));
				ps.setInt(2, Integer.parseInt(cid));
				ps.setInt(3, Integer.parseInt(sectionNum));
				ps.setString(4, "-");
				// Check if insert was successful
				int returnValue = ps.executeUpdate();
				if (returnValue>0) {
					//out.print("Developer: Inserted into row " + returnValue + " of Taking");
					// Could do select count 
				} 
			} else {
				out.println("Cannot register for course because prereq not satisfied or schedule conflict");
			}
			//Close the connection. Don't forget to do it, otherwise you're keeping the resources of the server allocated.
			con.close();
			response.sendRedirect("studentConsole.jsp");
		} catch (Exception ex) {
			//out.print(ex);
 			out.println("Registration failed please return to previous page and try again");
 			%>
 		<form method="post" action="studentConsole.jsp">
			<input type="submit" value="Back">
		</form>
 			<%
 		}
	%>
</body>
</html>