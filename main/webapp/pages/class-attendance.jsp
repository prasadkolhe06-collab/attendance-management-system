<%@ page import="java.sql.*,com.attendance.db.DBConnection" %>

<!DOCTYPE html>
<html>
<head>

<title>Class Attendance</title>

<link rel="stylesheet" href="../css/dashboard.css">

<style>

table{
border-collapse:collapse;
width:90%;
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

<div class="sidebar">

<h2>Teacher Panel</h2>

<ul>

<li><a href="../dashboard/teacher.jsp">Dashboard</a></li>

<li><a href="mark-attendance.jsp">Mark Attendance</a></li>

<li><a href="students.jsp">Students</a></li>

<li><a href="class-attendance.jsp">Attendance Report</a></li>

<li><a href="../LogoutServlet">Logout</a></li>

</ul>

</div>

<div class="main">

<h2>Class Attendance</h2>
<div style="margin-bottom:20px;">

<a href="../DownloadClassReportServlet?type=excel">

<button style="
padding:10px 20px;
background:#16a34a;
color:white;
border:none;
border-radius:6px;
cursor:pointer;
margin-right:10px;
">

Download Excel Report

</button>

</a>

<a href="../DownloadClassReportServlet?type=pdf">

<button style="
padding:10px 20px;
background:#dc2626;
color:white;
border:none;
border-radius:6px;
cursor:pointer;
">

Download PDF Report

</button>

</a>

</div>
<table>

<tr>

<th>Roll No</th>
<th>Name</th>
<th>Date</th>
<th>Status</th>

</tr>

<%

try{

Connection con = DBConnection.getConnection();

PreparedStatement ps = con.prepareStatement(

"SELECT s.roll_no,s.firstname,s.lastname,a.date,a.status " +
"FROM attendance a JOIN students s ON a.student_id=s.student_id " +
"ORDER BY a.date DESC"

);

ResultSet rs = ps.executeQuery();

while(rs.next()){

%>

<tr>

<td><%=rs.getString("roll_no")%></td>

<td>
<%=rs.getString("firstname")%> <%=rs.getString("lastname")%>
</td>

<td><%=rs.getDate("date")%></td>

<td><%=rs.getString("status")%></td>

</tr>

<%

}

}catch(Exception e){
e.printStackTrace();
}

%>

</table>

</div>

</body>
</html>