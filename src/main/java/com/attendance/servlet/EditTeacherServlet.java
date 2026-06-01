package com.attendance.servlet;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

import com.attendance.db.DBConnection;

@WebServlet("/EditTeacherServlet")

public class EditTeacherServlet extends HttpServlet {

protected void doGet(HttpServletRequest request, HttpServletResponse response)
throws ServletException, IOException {

try {

int id = Integer.parseInt(request.getParameter("id"));

Connection con = DBConnection.getConnection();

PreparedStatement ps =
con.prepareStatement("SELECT * FROM teachers WHERE teacher_id=?");

ps.setInt(1, id);

ResultSet rs = ps.executeQuery();

if (rs.next()) {

HttpSession session = request.getSession();

session.setAttribute("teacher_id", rs.getInt("teacher_id"));
session.setAttribute("name", rs.getString("name"));
session.setAttribute("email", rs.getString("email"));
session.setAttribute("password", rs.getString("password"));

}

response.sendRedirect("pages/edit-teacher.jsp");

} catch (Exception e) {

e.printStackTrace();

}

}

}