<%@ page import="java.sql.*,com.attendance.db.DBConnection" %>

<!DOCTYPE html>
<html>
<head>

<title>Students</title>
<link rel="stylesheet" href="../css/dashboard.css">

<style>

body{
margin:0;
font-family:Arial;
background:#f4f6f9;
}

.sidebar{
width:240px;
background:#0f1b2d;
height:100vh;
position:fixed;
left:0;
top:0;
padding:20px;
color:white;
}

.sidebar a{
display:block;
color:white;
text-decoration:none;
margin:15px 0;
}

.main{
margin-left:260px;
padding:40px;
}
</style>

</head>

<body>

<div class="sidebar">

<h2>Admin Panel</h2>

<ul>

<li><a href="../dashboard/admin.jsp">Dashboard</a></li>

<li><a href="students.jsp">Students</a></li>

<li><a href="teachers.jsp">Teachers</a></li>

<li><a href="admin-reports.jsp">Reports</a></li>

<li><a href="../LogoutServlet">Logout</a></li>

</ul>

</div>

<div class="main">

<h2>Students List</h2>

<input type="text" id="searchStudent" class="search-box"
placeholder="Search student by name, roll or enrollment">

<a href="add-student.jsp">
<button class="add-btn">+ Add Student</button>
</a>

<table>

<tr>
<th>Roll No</th>
<th>Name</th>
<th>Enrollment</th>
<th>Attendance</th>
<th>Action</th>
</tr>

<%

try{

Connection con=DBConnection.getConnection();

String sql=
"SELECT s.student_id,s.roll_no,s.last_name,s.firstname,s.middle_name,s.enrollment_no,"+
"COUNT(a.attendance_id) total,"+
"SUM(CASE WHEN a.status='Present' THEN 1 ELSE 0 END) present "+
"FROM students s "+
"LEFT JOIN attendance a ON s.student_id=a.student_id "+
"GROUP BY s.student_id "+
"ORDER BY CAST(SUBSTRING(s.roll_no,2) AS UNSIGNED)";

PreparedStatement ps=con.prepareStatement(sql);

ResultSet rs=ps.executeQuery();

while(rs.next()){

int id=rs.getInt("student_id");

int total=rs.getInt("total");

int present=rs.getInt("present");

double percent=(total>0)?(present*100.0)/total:0;

%>

<tr>

<td><%=rs.getString("roll_no")%></td>

<td>
<b><%=rs.getString("last_name")%></b>
<%=rs.getString("firstname")%>
<%=rs.getString("middle_name")%>
</td>

<td><%=rs.getString("enrollment_no")%></td>

<td>
<%=String.format("%.2f",percent)%> %
(<%=present%>/<%=total%>)
</td>

<td>

<a href="../EditStudentServlet?id=<%=id%>">
<button class="edit-btn">Edit</button>
</a>

<a href="../DeleteStudentServlet?id=<%=id%>" onclick="return confirm('Delete student?')">
<button class="delete-btn">Delete</button>
</a>

</td>

</tr>

<%

}

con.close();

}catch(Exception e){

out.print("<tr><td colspan='5'>Database Error</td></tr>");

}

%>

</table>

</div>
<script>

document.getElementById("searchStudent").addEventListener("keyup",function(){

let value=this.value.toLowerCase();

let rows=document.querySelectorAll("tbody tr");

rows.forEach(function(row){

row.style.display=row.innerText.toLowerCase().includes(value)?"":"none";

});

});

</script>
</body>
</html>