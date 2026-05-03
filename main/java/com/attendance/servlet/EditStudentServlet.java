package com.attendance.servlet;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

import com.attendance.db.DBConnection;

@WebServlet("/EditStudentServlet")

public class EditStudentServlet extends HttpServlet{

protected void doGet(HttpServletRequest request,HttpServletResponse response)
throws IOException{

try{

int id=Integer.parseInt(request.getParameter("id"));

Connection con=DBConnection.getConnection();

PreparedStatement ps=
con.prepareStatement("SELECT * FROM students WHERE student_id=?");

ps.setInt(1,id);

ResultSet rs=ps.executeQuery();

if(rs.next()){

HttpSession session=request.getSession();

session.setAttribute("edit_id",id);
session.setAttribute("roll",rs.getString("roll_no"));
session.setAttribute("lname",rs.getString("last_name"));
session.setAttribute("fname",rs.getString("firstname"));
session.setAttribute("mname",rs.getString("middle_name"));
session.setAttribute("enroll",rs.getString("enrollment_no"));

}

response.sendRedirect("pages/edit-student.jsp");

}catch(Exception e){

e.printStackTrace();

}

}

}