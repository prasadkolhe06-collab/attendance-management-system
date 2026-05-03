package com.attendance.servlet;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;

import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

import com.attendance.db.DBConnection;

@WebServlet("/DeleteStudentServlet")

public class DeleteStudentServlet extends HttpServlet{

protected void doGet(HttpServletRequest request,HttpServletResponse response)
throws IOException{

try{

int id=Integer.parseInt(request.getParameter("id"));

Connection con=DBConnection.getConnection();

PreparedStatement ps=
con.prepareStatement("DELETE FROM students WHERE student_id=?");

ps.setInt(1,id);

ps.executeUpdate();

response.sendRedirect("pages/students.jsp");

}catch(Exception e){

e.printStackTrace();

}

}

}