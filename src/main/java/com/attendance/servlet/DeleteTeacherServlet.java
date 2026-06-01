package com.attendance.servlet;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;

import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

import com.attendance.db.DBConnection;

@WebServlet("/DeleteTeacherServlet")

public class DeleteTeacherServlet extends HttpServlet{

protected void doGet(HttpServletRequest request,HttpServletResponse response)
throws IOException{

try{

int id=Integer.parseInt(request.getParameter("id"));

Connection con=DBConnection.getConnection();

PreparedStatement ps=
con.prepareStatement("DELETE FROM teachers WHERE teacher_id=?");

ps.setInt(1,id);

ps.executeUpdate();

response.sendRedirect("pages/teachers.jsp");

}catch(Exception e){

e.printStackTrace();

}

}

}