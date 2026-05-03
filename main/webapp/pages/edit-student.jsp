<!DOCTYPE html>
<html>
<head>

<title>Edit Student</title>

<style>

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
}

</style>

</head>

<body>

<div class="main">

<h2>Edit Student</h2>

<form action="../UpdateStudentServlet" method="post">

<input type="hidden" name="id" value="<%=session.getAttribute("edit_id")%>">

Roll No

<input type="text" name="roll" value="<%=session.getAttribute("roll")%>">

Last Name

<input type="text" name="lname" value="<%=session.getAttribute("lname")%>">

First Name

<input type="text" name="fname" value="<%=session.getAttribute("fname")%>">

Middle Name

<input type="text" name="mname" value="<%=session.getAttribute("mname")%>">

Enrollment

<input type="text" name="enroll" value="<%=session.getAttribute("enroll")%>">

<button type="submit">Update</button>

</form>

</div>

</body>
</html>