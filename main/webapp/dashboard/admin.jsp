<%@ page import="java.sql.*,com.attendance.db.DBConnection" %>

<%

int totalStudents=0;
int totalTeachers=0;
int totalClasses=1;
double attendance=0;

try{

Connection con=DBConnection.getConnection();

PreparedStatement ps1=con.prepareStatement("SELECT COUNT(*) FROM students");
ResultSet rs1=ps1.executeQuery();
if(rs1.next()) totalStudents=rs1.getInt(1);

PreparedStatement ps2=con.prepareStatement("SELECT COUNT(*) FROM teachers");
ResultSet rs2=ps2.executeQuery();
if(rs2.next()) totalTeachers=rs2.getInt(1);

PreparedStatement ps3=con.prepareStatement("SELECT status FROM attendance");
ResultSet rs3=ps3.executeQuery();

int total=0;
int present=0;

while(rs3.next()){
total++;
if(rs3.getString("status").equalsIgnoreCase("Present")){
present++;
}
}

if(total>0){
attendance=(present*100.0)/total;
}

}catch(Exception e){
e.printStackTrace();
}

%>

<!DOCTYPE html>

<html>

<head>

<title>Admin Dashboard</title>
<link rel="stylesheet" href="../css/dashboard.css">

<style>

.cards{
display:flex;
gap:20px;
margin-top:30px;
}

.card{
background:white;
padding:25px;
border-radius:10px;
width:220px;
box-shadow:0 2px 10px rgba(0,0,0,0.1);
text-align:center;
}

.card h3{
font-size:28px;
margin-top:10px;
}

</style>

</head>

<body>

<div class="sidebar">

<h2>Admin Panel</h2>

<ul>

<li><a href="admin.jsp">Dashboard</a></li>
<li><a href="../pages/students.jsp">Students</a></li>
<li><a href="../pages/teachers.jsp">Teachers</a></li>
<li><a href="../pages/class-attendance.jsp">Reports</a></li>
<li><a href="../LogoutServlet">Logout</a></li>

</ul>

</div>

<div class="main">

<h2>Welcome Admin</h2>

<div class="cards">

<div class="card">
<h4>Total Students</h4>
<h3><%=totalStudents%></h3>
</div>

<div class="card">
<h4>Total Teachers</h4>
<h3><%=totalTeachers%></h3>
</div>

<div class="card">
<h4>Classes</h4>
<h3><%=totalClasses%></h3>
</div>

<div class="card">
<h4>Attendance</h4>
<h3><%=String.format("%.0f",attendance)%>%</h3>
</div>

</div>

</div>

</body>
</html>
