<%@ page import="java.sql.*,com.attendance.db.DBConnection" %>

<!DOCTYPE html>
<html>
<head>

<title>Teachers List</title>

<style>

body{
margin:0;
font-family:Arial;
background:#f4f6f9;
}

/* SIDEBAR */

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

.sidebar h2{
margin-bottom:30px;
}

.sidebar a{
display:block;
color:white;
text-decoration:none;
margin:15px 0;
font-size:16px;
}

/* MAIN CONTENT */

.main{
margin-left:260px;
padding:40px;
}

/* TABLE */

table{
width:100%;
border-collapse:collapse;
background:white;
margin-top:20px;
}

th,td{
padding:12px;
border-bottom:1px solid #ddd;
text-align:left;
}

th{
background:#243c8c;
color:white;
}

/* BUTTONS */

.add-btn{
background:#16a34a;
color:white;
padding:10px 15px;
border:none;
border-radius:5px;
cursor:pointer;
margin-bottom:15px;
}

.edit-btn{
background:#2563eb;
color:white;
border:none;
padding:6px 10px;
border-radius:5px;
cursor:pointer;
}

.delete-btn{
background:#dc2626;
color:white;
border:none;
padding:6px 10px;
border-radius:5px;
cursor:pointer;
}

</style>

</head>

<body>

<!-- ADMIN SIDEBAR -->

<div class="sidebar">

<h2>Admin Panel</h2>

<a href="../dashboard/admin.jsp">Dashboard</a>

<a href="students.jsp">Students</a>

<a href="teachers.jsp">Teachers</a>

<a href="admin-reports.jsp">Reports</a>

<a href="../LogoutServlet">Logout</a>

</div>

<!-- MAIN CONTENT -->

<div class="main">

<h2>Teachers List</h2>

<a href="add-teacher.jsp">
<button class="add-btn">+ Add Teacher</button>
</a>

<table>

<tr>
<th>Name</th>
<th>Email</th>
<th>Action</th>
</tr>

<%

try{

Connection con=DBConnection.getConnection();

PreparedStatement ps=
con.prepareStatement("SELECT teacher_id,name,email FROM teachers");

ResultSet rs=ps.executeQuery();

while(rs.next()){

int id=rs.getInt("teacher_id");

%>

<tr>

<td><%=rs.getString("name")%></td>

<td><%=rs.getString("email")%></td>

<td>

<a href="../EditTeacherServlet?id=<%=id%>">
<button class="edit-btn">Edit</button>
</a>

<a href="../DeleteTeacherServlet?id=<%=id%>" onclick="return confirm('Delete this teacher?')">
<button class="delete-btn">Delete</button>
</a>

</td>

</tr>

<%

}

con.close();

}catch(Exception e){

out.print("<tr><td colspan='3' style='color:red'>Database Error: "+e.getMessage()+"</td></tr>");

}

%>

</table>

</div>

</body>
</html>