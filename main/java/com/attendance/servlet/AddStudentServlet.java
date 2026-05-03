package com.attendance.servlet;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;

import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

import com.attendance.db.DBConnection;

@WebServlet("/AddStudentServlet")

public class AddStudentServlet extends HttpServlet {

protected void doPost(HttpServletRequest request,HttpServletResponse response)
throws IOException{

try{

String roll=request.getParameter("roll_no");
String last=request.getParameter("last_name");
String first=request.getParameter("firstname");
String middle=request.getParameter("middle_name");
String enroll=request.getParameter("enrollment_no");

String password=last+"@"+enroll.substring(enroll.length()-4);

Connection con=DBConnection.getConnection();

PreparedStatement ps=con.prepareStatement(
"INSERT INTO students(roll_no,last_name,firstname,middle_name,enrollment_no,password) VALUES(?,?,?,?,?,?)");

ps.setString(1,roll);
ps.setString(2,last);
ps.setString(3,first);
ps.setString(4,middle);
ps.setString(5,enroll);
ps.setString(6,password);

ps.executeUpdate();

response.sendRedirect("pages/students.jsp");

}catch(Exception e){
e.printStackTrace();
}

}
}