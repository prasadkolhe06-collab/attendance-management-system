<!DOCTYPE html>
<html>
<head>

<title>Add Student</title>
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
<li><a href="class-attendance.jsp">Reports</a></li>
<li><a href="../LogoutServlet">Logout</a></li>

</ul>

</div>

<div class="main-content">

<h2>Add Student</h2>

<div class="form-box">

<form action="../AddStudentServlet" method="post">

<input type="text" name="roll_no" placeholder="Roll Number (Example: D115)" required>

<input type="text" name="last_name" placeholder="Last Name" required>

<input type="text" name="firstname" placeholder="First Name" required>

<input type="text" name="middle_name" placeholder="Middle Name">

<input type="text" name="enrollment_no" placeholder="Enrollment Number" required>

<input type="text" name="password" placeholder="Password Example: Kolhe@6603" required>

<button type="submit">Add Student</button>

</form>

</div>

</div>

</body>
</html>