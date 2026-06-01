package com.attendance.servlet;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.time.LocalDate;

import com.attendance.db.DBConnection;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

@WebServlet("/MarkAttendanceServlet")

public class MarkAttendanceServlet extends HttpServlet {

protected void doPost(HttpServletRequest request, HttpServletResponse response)
throws ServletException, IOException {

try {

Connection con = DBConnection.getConnection();

PreparedStatement ps = con.prepareStatement("SELECT student_id FROM students");

ResultSet rs = ps.executeQuery();

while(rs.next()){

int studentId = rs.getInt("student_id");

String status = request.getParameter("status_" + studentId);

PreparedStatement insert = con.prepareStatement(
"INSERT INTO attendance(student_id,date,status) VALUES(?,?,?)");

insert.setInt(1, studentId);

insert.setDate(2, java.sql.Date.valueOf(LocalDate.now()));

insert.setString(3, status);

insert.executeUpdate();

}

response.sendRedirect("pages/mark-attendance.jsp");

}catch(Exception e){

e.printStackTrace();

}

}

}