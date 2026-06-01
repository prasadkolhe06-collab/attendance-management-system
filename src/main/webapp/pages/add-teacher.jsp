<!DOCTYPE html>
<html>
<head>

<title>Add Teacher</title>
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

<h2>Add Teacher</h2>

<div class="form-box">

<form action="../AddTeacherServlet" method="post">

<input type="text" name="name" placeholder="Teacher Name" required>

<input type="email" name="email" placeholder="Email" required>

<input type="password" name="password" placeholder="Password" required>

<button type="submit">Add Teacher</button>

</form>

</div>

</div>

</body>
</html>