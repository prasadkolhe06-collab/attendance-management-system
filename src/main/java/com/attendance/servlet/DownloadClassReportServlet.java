package com.attendance.servlet;

import java.io.*;
import java.sql.*;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import com.attendance.db.DBConnection;

@WebServlet("/DownloadClassReportServlet")
public class DownloadClassReportServlet extends HttpServlet {

protected void doGet(HttpServletRequest request, HttpServletResponse response)
throws IOException {

try{

String type = request.getParameter("type");

Connection con = DBConnection.getConnection();

PreparedStatement ps = con.prepareStatement(
"SELECT roll_no,firstname,lastname,enrollment_no FROM students");

ResultSet rs = ps.executeQuery();

if("excel".equals(type)){

response.setContentType("application/vnd.ms-excel");
response.setHeader("Content-Disposition","attachment; filename=class_report.xls");

PrintWriter out = response.getWriter();

out.println("Roll No\tName\tEnrollment");

while(rs.next()){

String name = rs.getString("firstname")+" "+rs.getString("lastname");

out.println(
rs.getString("roll_no")+"\t"+
name+"\t"+
rs.getString("enrollment_no")
);

}

out.close();

}

}catch(Exception e){
e.printStackTrace();
}

}

}