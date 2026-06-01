package com.attendance.servlet;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;

import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

import com.attendance.db.DBConnection;

@WebServlet("/AddTeacherServlet")

public class AddTeacherServlet extends HttpServlet {

protected void doPost(HttpServletRequest request,HttpServletResponse response)
throws IOException {

try{

String name=request.getParameter("name");
String email=request.getParameter("email");
String password=request.getParameter("password");

Connection con=DBConnection.getConnection();

PreparedStatement ps=con.prepareStatement(

"INSERT INTO teachers(name,email,password) VALUES(?,?,?)"

);

ps.setString(1,name);
ps.setString(2,email);
ps.setString(3,password);

ps.executeUpdate();

response.sendRedirect("pages/teachers.jsp");

}catch(Exception e){

e.printStackTrace();

}

}

}