package com.attendance.servlet;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import com.attendance.db.DBConnection;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

@WebServlet("/LoginServlet")
public class LoginServlet extends HttpServlet {

protected void doPost(HttpServletRequest request, HttpServletResponse response)
throws ServletException, IOException {

String role = request.getParameter("role");
String username = request.getParameter("username");
String password = request.getParameter("password");

try {

Connection con = DBConnection.getConnection();

/* STUDENT LOGIN */

if(role.equals("student")){

PreparedStatement ps = con.prepareStatement(
"SELECT * FROM students WHERE enrollment_no=? AND password=?");

ps.setString(1, username);
ps.setString(2, password);

ResultSet rs = ps.executeQuery();

if(rs.next()){

HttpSession session = request.getSession();

session.setAttribute("student_id", rs.getInt("student_id"));
session.setAttribute("studentName", rs.getString("firstname"));
session.setAttribute("role","student");

response.sendRedirect("dashboard/student.jsp");

}else{

response.getWriter().println("Invalid Student Login");

}

}
/* TEACHER LOGIN */

else if(role.equals("teacher")){

PreparedStatement ps = con.prepareStatement(
"SELECT * FROM teachers WHERE username=? AND password=?");

ps.setString(1, username);
ps.setString(2, password);

ResultSet rs = ps.executeQuery();

if(rs.next()){

HttpSession session = request.getSession();

session.setAttribute("name", rs.getString("name"));
session.setAttribute("role","teacher");

response.sendRedirect("dashboard/teacher.jsp");

}else{

response.getWriter().println("Invalid Teacher Login");

}

}

/* ADMIN LOGIN */

else if(role.equals("admin")){

PreparedStatement ps = con.prepareStatement(
"SELECT * FROM admin WHERE username=? AND password=?");

ps.setString(1, username);
ps.setString(2, password);

ResultSet rs = ps.executeQuery();

if(rs.next()){

HttpSession session = request.getSession();

session.setAttribute("name", username);
session.setAttribute("role","admin");

response.sendRedirect("dashboard/admin.jsp");

}else{

response.getWriter().println("Invalid Admin Login");

}

}

} catch(Exception e){
e.printStackTrace();
}

}
}