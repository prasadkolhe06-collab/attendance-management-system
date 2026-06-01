package com.attendance.servlet;

import java.io.IOException;
import java.io.OutputStream;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;

import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

import com.attendance.db.DBConnection;

import com.itextpdf.text.*;
import com.itextpdf.text.pdf.*;

@WebServlet("/DownloadReportServlet")

public class DownloadReportServlet extends HttpServlet {

protected void doGet(HttpServletRequest request, HttpServletResponse response)
throws IOException {

try {

HttpSession session = request.getSession();

Integer studentId = (Integer) session.getAttribute("student_id");

String type = request.getParameter("type");

Connection con = DBConnection.getConnection();



/* ========================= */
/* GET STUDENT DETAILS */
/* ========================= */

PreparedStatement studentPs = con.prepareStatement(
"SELECT firstname,lastname,enrollment_no,roll_no FROM students WHERE student_id=?");

studentPs.setInt(1, studentId);

ResultSet studentRs = studentPs.executeQuery();

String name="";
String enrollment="";
String roll="";

if(studentRs.next()){

name = studentRs.getString("firstname")+" "+studentRs.getString("lastname");
enrollment = studentRs.getString("enrollment_no");
roll = studentRs.getString("roll_no");

}



/* ========================= */
/* GET ATTENDANCE DATA */
/* ========================= */

PreparedStatement ps = con.prepareStatement(
"SELECT date,status FROM attendance WHERE student_id=?");

ps.setInt(1, studentId);

ResultSet rs = ps.executeQuery();



/* ========================= */
/* DATE FORMAT */
/* ========================= */

LocalDateTime now = LocalDateTime.now();

DateTimeFormatter formatter =
DateTimeFormatter.ofPattern("dd-MM-yyyy  HH:mm:ss");

String formattedDate = now.format(formatter);



/* ========================= */
/* EXCEL DOWNLOAD */
/* ========================= */

if("excel".equals(type)){

response.setContentType("application/vnd.ms-excel");

response.setHeader("Content-Disposition",
"attachment; filename=attendance_report.xls");

PrintWriter out = response.getWriter();

out.println("STUDENT ATTENDANCE REPORT");
out.println("");

out.println("Student Name:\t"+name);
out.println("Enrollment No:\t"+enrollment);
out.println("Roll No:\t"+roll);
out.println("Generated On:\t"+formattedDate);

out.println("");
out.println("Date\tStatus");

while(rs.next()){

out.println(rs.getDate("date") + "\t" + rs.getString("status"));

}

out.close();

}



/* ========================= */
/* PDF DOWNLOAD */
/* ========================= */

else if("pdf".equals(type)){

response.setContentType("application/pdf");

response.setHeader("Content-Disposition",
"attachment; filename=attendance_report.pdf");

OutputStream os = response.getOutputStream();

Document document = new Document();

PdfWriter.getInstance(document, os);

document.open();



/* ===== TITLE ===== */

Font titleFont =
new Font(Font.FontFamily.HELVETICA,20,Font.BOLD);

Paragraph title =
new Paragraph("STUDENT ATTENDANCE REPORT",titleFont);

title.setAlignment(Element.ALIGN_CENTER);

document.add(title);

document.add(new Paragraph(" "));



/* ===== STUDENT DETAILS ===== */

document.add(new Paragraph("Student Name : " + name));
document.add(new Paragraph("Enrollment No : " + enrollment));
document.add(new Paragraph("Roll No : " + roll));
document.add(new Paragraph("Generated On : " + formattedDate));

document.add(new Paragraph(" "));



/* ===== ATTENDANCE TABLE ===== */

PdfPTable table = new PdfPTable(2);

table.setWidthPercentage(100);

Font headerFont =
new Font(Font.FontFamily.HELVETICA,12,Font.BOLD);

PdfPCell c1 = new PdfPCell(new Phrase("Date",headerFont));
PdfPCell c2 = new PdfPCell(new Phrase("Status",headerFont));

c1.setHorizontalAlignment(Element.ALIGN_CENTER);
c2.setHorizontalAlignment(Element.ALIGN_CENTER);

table.addCell(c1);
table.addCell(c2);



while(rs.next()){

table.addCell(rs.getDate("date").toString());
table.addCell(rs.getString("status"));

}

document.add(table);

document.close();

os.close();

}

}catch(Exception e){

e.printStackTrace();

}

}

}