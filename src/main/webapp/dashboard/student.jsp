<%@ page import="java.sql.*,com.attendance.db.DBConnection" %>

<%

Integer studentId = (Integer) session.getAttribute("student_id");
String studentName = (String) session.getAttribute("studentName");

int totalClasses = 0;
int present = 0;
int absent = 0;
double percentage = 0;

try{

if(studentId != null){

Connection con = DBConnection.getConnection();

PreparedStatement ps = con.prepareStatement(
"SELECT status FROM attendance WHERE student_id=?");

ps.setInt(1, studentId);

ResultSet rs = ps.executeQuery();

while(rs.next()){

String status = rs.getString("status");

totalClasses++;

if(status.equalsIgnoreCase("Present")){
present++;
}else{
absent++;
}

}

if(totalClasses > 0){
percentage = (present * 100.0) / totalClasses;
}

}

}catch(Exception e){
e.printStackTrace();
}

%>

<!DOCTYPE html>
<html>

<head>

<title>Student Dashboard</title>

<link rel="stylesheet" href="../css/dashboard.css">

<script src="https://cdn.jsdelivr.net/npm/chart.js"></script>

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

.chart-box{
width:420px;
margin-top:40px;
background:white;
padding:25px;
border-radius:10px;
box-shadow:0 2px 10px rgba(0,0,0,0.1);
}

.chart-buttons{
margin-bottom:20px;
}

</style>

</head>


<body>


<!-- Sidebar -->

<div class="sidebar">

<h2>Student Panel</h2>

<ul>

<li>
<a href="student.jsp">Dashboard</a>
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

<h2>Welcome <%=studentName%></h2>

<p>This is your attendance dashboard.</p>



<!-- Dashboard Cards -->

<div class="cards">

<div class="card">
<h4>Total Classes</h4>
<h3><%=totalClasses%></h3>
</div>

<div class="card">
<h4>Present</h4>
<h3><%=present%></h3>
</div>

<div class="card">
<h4>Absent</h4>
<h3><%=absent%></h3>
</div>

<div class="card">
<h4>Attendance %</h4>
<h3><%=String.format("%.2f",percentage)%>%</h3>
</div>

</div>



<!-- Chart Section -->

<div class="chart-box">

<h3>Attendance Chart</h3>

<br>

<div class="chart-buttons">

<a href="../DownloadReportServlet?type=excel">

<button style="
padding:10px 18px;
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


<a href="../DownloadReportServlet?type=pdf">

<button style="
padding:10px 18px;
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


<!-- Chart Canvas -->

<canvas id="attendanceChart" width="300" height="300"></canvas>

</div>

</div>



<!-- Chart Script -->

<script>

var ctx = document.getElementById('attendanceChart').getContext('2d');

new Chart(ctx,{

type:'pie',

data:{

labels:['Present','Absent'],

datasets:[{

data:[<%=present%>,<%=absent%>],

backgroundColor:['#22c55e','#ef4444']

}]

}

});

</script>


</body>
</html>