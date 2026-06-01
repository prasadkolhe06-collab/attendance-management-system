<%@ page import="java.sql.*,com.attendance.db.DBConnection" %>

<!DOCTYPE html>
<html>
<head>

<title>Mark Attendance</title>

<link rel="stylesheet" href="../css/dashboard.css">

<style>

/* SEARCH BOX */

.search-box{
padding:10px;
width:300px;
margin-bottom:20px;
border:1px solid #ccc;
border-radius:5px;
}

/* TABLE */

table{
width:100%;
border-collapse:collapse;
background:white;
}

th{
background:#2c4a9a;
color:white;
padding:12px;
text-align:left;
}

td{
padding:10px;
border-bottom:1px solid #ddd;
}

button{
padding:10px 20px;
background:#16a34a;
color:white;
border:none;
border-radius:6px;
cursor:pointer;
}

</style>

</head>

<body>

<!-- SIDEBAR -->

<div class="sidebar">

<h2>Teacher Panel</h2>

<ul>

<li><a href="../dashboard/teacher.jsp">Dashboard</a></li>

<li><a href="mark-attendance.jsp">Mark Attendance</a></li>

<li><a href="mark-attendance.jsp">Students</a></li>

<li><a href="class-attendance.jsp">Attendance Report</a></li>

<li><a href="../LogoutServlet">Logout</a></li>

</ul>

</div>

<!-- MAIN -->

<div class="main">

<h2>Mark Attendance</h2>

<!-- SEARCH STUDENT -->

<input type="text"
id="searchStudent"
class="search-box"
placeholder="Search student by roll or name">

<form action="../MarkAttendanceServlet" method="post">

<table>

<thead>

<tr>

<th>Roll No</th>
<th>Name</th>
<th>Present</th>
<th>Absent</th>

</tr>

</thead>

<tbody id="studentTable">

<%

try{

Connection con = DBConnection.getConnection();

/* FIXED ROLL NUMBER SORTING */

PreparedStatement ps = con.prepareStatement(
"SELECT * FROM students ORDER BY CAST(SUBSTRING(roll_no,2) AS UNSIGNED)");

ResultSet rs = ps.executeQuery();

while(rs.next()){

%>

<tr>

<td><%=rs.getString("roll_no")%></td>

<td>

<b><%=rs.getString("last_name")%></b>
<%=rs.getString("firstname")%>
<%=rs.getString("middle_name")%>

</td>

<td>

<input type="radio"
name="status_<%=rs.getInt("student_id")%>"
value="Present" required>

</td>

<td>

<input type="radio"
name="status_<%=rs.getInt("student_id")%>"
value="Absent">

</td>

</tr>

<%

}

con.close();

}catch(Exception e){

out.print("<tr><td colspan='4' style='color:red'>Database Error</td></tr>");

}

%>

</tbody>

</table>

<br>

<button>

Submit Attendance

</button>

</form>

</div>

<!-- SEARCH SCRIPT -->

<script>

document.getElementById("searchStudent").addEventListener("keyup",function(){

let value=this.value.toLowerCase();

let rows=document.querySelectorAll("#studentTable tr");

rows.forEach(function(row){

row.style.display=row.innerText.toLowerCase().includes(value)?"":"none";

});

});

</script>

</body>
</html>