<%@ page language="java" contentType="text/html; charset=UTF-8" %>

<!DOCTYPE html>
<html>
<head>

<title>Edit Teacher</title>

<style>

body{
font-family:Arial;
margin:0;
background:#f4f6f9;
}

.sidebar{
width:240px;
background:#0f1b2d;
height:100vh;
position:fixed;
padding:20px;
color:white;
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

input{
width:300px;
padding:10px;
margin:10px 0;
}

button{
padding:10px 20px;
background:#16a34a;
color:white;
border:none;
border-radius:5px;
cursor:pointer;
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

<h2>Edit Teacher</h2>

<form action="../UpdateTeacherServlet" method="post">

<input type="hidden" name="id"
value="<%=session.getAttribute("teacher_id")%>">

Name

<br>

<input type="text" name="name"
value="<%=session.getAttribute("name")%>">

<br>

Email

<br>

<input type="text" name="email"
value="<%=session.getAttribute("email")%>">

<br>

Password

<br>

<input type="text" name="password"
value="<%=session.getAttribute("password")%>">

<br><br>

<button type="submit">Update Teacher</button>

</form>

</div>

</body>
</html>