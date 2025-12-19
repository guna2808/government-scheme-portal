
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ page import="jakarta.servlet.http.*" %>
<%@ page import="jakarta.servlet.*" %>

<%
    String uname = request.getParameter("uname");
    String pass = request.getParameter("pass");

    if(uname != null && pass != null) {
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            
            Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/govtschemesdb", "root", "@Meera2206");

            PreparedStatement ps = con.prepareStatement("SELECT * FROM admins WHERE username=? AND password=?");
            
            ps.setString(1, uname);
            ps.setString(2, pass);
            
            ResultSet rs = ps.executeQuery();

            if(rs.next()) {
                // Store admin ID in session
                HttpSession session1 = request.getSession();
                session1.setAttribute("username", uname);
                response.sendRedirect("adminDashboard.jsp");
            } else {
                out.println("<script>alert('Invalid Admin Credentials'); window.location='adminLogin.jsp';</script>");
            }

            con.close();
        } catch(Exception e) {
            out.println("Error: " + e.getMessage());
        }
    }
%>




