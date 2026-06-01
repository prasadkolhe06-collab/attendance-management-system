<%@ page import="java.sql.*,com.attendance.db.DBConnection" %>

<%

String teacherName = (String) session.getAttribute("name");
if(teacherName==null){
teacherName="Teacher";
}

int totalStudents=0;
int presentToday=0;
int absentToday=0;
int defaulters=0;

try{

Connection con = DBConnection.getConnection();

/* TOTAL STUDENTS */

PreparedStatement ps1 = con.prepareStatement(
"SELECT COUNT(*) FROM students");

ResultSet rs1 = ps1.executeQuery();

if(rs1.next()){
totalStudents = rs1.getInt(1);
}

/* TODAY ATTENDANCE */

PreparedStatement ps2 = con.prepareStatement(
"SELECT status FROM attendance WHERE date = CURDATE()");

ResultSet rs2 = ps2.executeQuery();

while(rs2.next()){

String status = rs2.getString("status");

if(status.equalsIgnoreCase("Present")){
presentToday++;
}else{
absentToday++;
}

}

/* FIND DEFAULTERS */

PreparedStatement ps3 = con.prepareStatement(
"SELECT student_id FROM students");

ResultSet rs3 = ps3.executeQuery();

while(rs3.next()){

int studentId = rs3.getInt("student_id");

PreparedStatement ps4 = con.prepareStatement(
"SELECT status FROM attendance WHERE student_id=?");

ps4.setInt(1,studentId);

ResultSet rs4 = ps4.executeQuery();

int total=0;
int present=0;

while(rs4.next()){

total++;

if(rs4.getString("status").equalsIgnoreCase("Present")){
present++;
}

}

if(total>0){

double percent = (present*100.0)/total;

if(percent<75){
defaulters++;
}

}

}

}catch(Exception e){
e.printStackTrace();
}

%>

<!DOCTYPE html>
<html>
<head>

<title>Teacher Dashboard</title>

<link rel="stylesheet" href="../css/dashboard.css">

<script src="https://cdn.jsdelivr.net/npm/chart.js"></script>

</head>

<body>

<div class="sidebar">

<h2>Teacher Panel</h2>

<ul>

<li><a href="teacher.jsp">Dashboard</a></li>

<li><a href="../pages/mark-attendance.jsp">Mark Attendance</a></li>

<li><a href="../pages/mark-attendance.jsp">Students</a></li>

<li><a href="../pages/class-attendance.jsp">Attendance Report</a></li>

<li><a href="../LogoutServlet">Logout</a></li>

</ul>

</div>
<div class="main">

<h2>Welcome <%=teacherName%></h2>

<div class="cards">

<div class="card">
<h4>Total Students</h4>
<h3><%=totalStudents%></h3>
</div>

<div class="card">
<h4>Present Today</h4>
<h3><%=presentToday%></h3>
</div>

<div class="card">
<h4>Absent Today</h4>
<h3><%=absentToday%></h3>
</div>

<div class="card">
<h4>Students Below 75%</h4>
<h3 style="color:red;"><%=defaulters%></h3>
</div>

</div>

<div class="chart-box">

<h3>Attendance Chart</h3>

<div style="width:350px;height:350px;margin:auto;">
<canvas id="attendanceChart"></canvas>
</div>

</div>

</div>

<script>

var ctx = document.getElementById('attendanceChart');

new Chart(ctx,{
type:'doughnut',
data:{
labels:['Present','Absent','Remaining'],
datasets:[{
data:[
<%=presentToday%>,
<%=absentToday%>,
<%=totalStudents - (presentToday + absentToday)%>
],
backgroundColor:['#22c55e','#ef4444','#64748b']
}]
},
options:{
responsive:true,
maintainAspectRatio:false
}
});

</script>
</body>
</html>