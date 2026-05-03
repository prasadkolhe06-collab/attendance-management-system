<%@ page import="java.sql.*,com.attendance.db.DBConnection" %>

<!DOCTYPE html>
<html>
<head>

<title>Admin Reports</title>

<style>

body{margin:0;font-family:Arial;}

.sidebar{
width:240px;
background:#0f1b2d;
height:100vh;
position:fixed;
color:white;
padding:20px;
}

.sidebar a{
display:block;
color:white;
margin:15px 0;
text-decoration:none;
}

.main{
margin-left:260px;
padding:40px;
}

table{
width:100%;
border-collapse:collapse;
background:white;
}

th,td{
padding:10px;
border-bottom:1px solid #ddd;
}

th{
background:#243c8c;
color:white;
}

</style>

</head>

<body>

<div class="sidebar">

<h2>Admin Panel</h2>

<a href="../dashboard/admin.jsp">Dashboard</a>
<a href="students.jsp">Students</a>
<a href="teachers.jsp">Teachers</a>
<a href="admin-reports.jsp">Reports</a>
<a href="../LogoutServlet">Logout</a>

</div>

<div class="main">

<h2>System Report</h2>

<table>

<tr>
<th>Student</th>
<th>Total Classes</th>
<th>Present</th>
<th>Attendance %</th>
</tr>

<%

Connection con=DBConnection.getConnection();

String sql=
"SELECT s.firstname,s.last_name,COUNT(a.attendance_id) total,"+
"SUM(CASE WHEN a.status='Present' THEN 1 ELSE 0 END) present "+
"FROM students s LEFT JOIN attendance a "+
"ON s.student_id=a.student_id "+
"GROUP BY s.student_id";

PreparedStatement ps=con.prepareStatement(sql);

ResultSet rs=ps.executeQuery();

while(rs.next()){

int total=rs.getInt("total");

int present=rs.getInt("present");

double percent=(total>0)?(present*100.0)/total:0;

%>

<tr>

<td><%=rs.getString("firstname")%> <%=rs.getString("last_name")%></td>

<td><%=total%></td>

<td><%=present%></td>

<td><%=String.format("%.2f",percent)%>%</td>

</tr>

<%

}

%>

</table>

</div>

</body>
</html>