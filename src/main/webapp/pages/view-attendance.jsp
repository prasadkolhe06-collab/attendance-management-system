<%@ page import="java.sql.*,com.attendance.db.DBConnection" %>

<!DOCTYPE html>
<html>
<head>

<title>View Attendance</title>

<link rel="stylesheet" href="../css/dashboard.css">

<style>

table{
border-collapse: collapse;
width:70%;
background:white;
margin-top:20px;
}

th,td{
padding:10px;
border:1px solid #ccc;
text-align:center;
}

th{
background:#1e3a8a;
color:white;
}

</style>

</head>

<body>

<!-- Sidebar -->

<div class="sidebar">

<h2>Student Panel</h2>

<ul>

<li>
<a href="../dashboard/student.jsp">Dashboard</a>
</li>

<li>
<a href="../pages/view-attendance.jsp">View Attendance</a>
</li>

<li>
<a href="../LogoutServlet">Logout</a>
</li>

</ul>

</div>


<!-- Main Content -->

<div class="main">

<h2>My Attendance</h2>

<table>

<tr>
<th>Date</th>
<th>Status</th>
</tr>

<%

Integer studentId = (Integer) session.getAttribute("student_id");

if(studentId != null){

Connection con = null;
PreparedStatement ps = null;
ResultSet rs = null;

try{

con = DBConnection.getConnection();

ps = con.prepareStatement(
"SELECT date,status FROM attendance WHERE student_id=? ORDER BY date DESC");

ps.setInt(1, studentId);

rs = ps.executeQuery();

while(rs.next()){

%>

<tr>

<td><%= rs.getDate("date") %></td>

<td><%= rs.getString("status") %></td>

</tr>

<%

}

}catch(Exception e){

out.println("<tr><td colspan='2'>Error loading attendance</td></tr>");

}

}else{

%>

<tr>
<td colspan="2">Session expired. Please login again.</td>
</tr>

<%

}

%>

</table>

</div>

</body>
</html>