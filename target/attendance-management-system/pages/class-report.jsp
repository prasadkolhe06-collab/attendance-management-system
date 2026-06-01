<%@ page import="java.sql.*,com.attendance.db.DBConnection" %>

<!DOCTYPE html>
<html>

<head>

<title>Class Attendance Report</title>

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

.download-btn{
padding:10px 20px;
border:none;
border-radius:5px;
color:white;
cursor:pointer;
margin-right:10px;
}

.excel{
background:#16a34a;
}

.pdf{
background:#dc2626;
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

<li><a href="class-report.jsp">Attendance Report</a></li>

<li><a href="../LogoutServlet">Logout</a></li>

</ul>

</div>


<div class="main">

<h2>Class Attendance Report</h2>

<br>

<a href="../DownloadClassReportServlet?type=excel">
<button class="download-btn excel">Download Excel</button>
</a>

<a href="../DownloadClassReportServlet?type=pdf">
<button class="download-btn pdf">Download PDF</button>
</a>

<table>

<tr>

<th>Roll No</th>
<th>Name</th>
<th>Enrollment</th>
<th>Total Classes</th>
<th>Present</th>
<th>Absent</th>
<th>Attendance %</th>

</tr>

<%

try{

Connection con = DBConnection.getConnection();

PreparedStatement ps = con.prepareStatement(
"SELECT * FROM students ORDER BY roll_no");

ResultSet rs = ps.executeQuery();

while(rs.next()){

int studentId = rs.getInt("student_id");

PreparedStatement ps2 = con.prepareStatement(
"SELECT status FROM attendance WHERE student_id=?");

ps2.setInt(1, studentId);

ResultSet rs2 = ps2.executeQuery();

int total=0;
int present=0;

while(rs2.next()){

total++;

if(rs2.getString("status").equalsIgnoreCase("Present")){
present++;
}

}

int absent = total - present;

double percent = 0;

if(total>0){
percent = (present*100.0)/total;
}

%>

<tr>

<td><%=rs.getString("roll_no")%></td>

<td>
<%=rs.getString("firstname")%> <%=rs.getString("lastname")%>
</td>

<td><%=rs.getString("enrollment_no")%></td>

<td><%=total%></td>

<td><%=present%></td>

<td><%=absent%></td>

<td><%=String.format("%.2f",percent)%>%</td>

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