<%@ page contentType="text/html" pageEncoding="UTF-8" import="java.sql.*" %>
<%
    String sessionAdmin = (String)session.getAttribute("username");
    if(sessionAdmin == null){
        response.sendRedirect("index.jsp");
    }

    String fullname = request.getParameter("fullname");
    String email = request.getParameter("email");
    String uname = request.getParameter("uname");
    String pass = request.getParameter("pass");
    String message = "";

    try {
        Class.forName("com.mysql.cj.jdbc.Driver");
        Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/govtschemesdb", "root", "@Meera2206");

        String sql = "UPDATE admins SET fullname=?, email=?, username=?, password=? WHERE username=?";
        PreparedStatement ps = con.prepareStatement(sql);
        ps.setString(1, fullname);
        ps.setString(2, email);
        ps.setString(3, uname);
        ps.setString(4, pass);
        ps.setString(5, sessionAdmin);

        int i = ps.executeUpdate();
        if(i > 0){
            message = "✅ Admin Profile Updated Successfully!";
            // Update session username if changed
            session.setAttribute("username", uname);
        } else {
            message = "❌ Failed to Update Admin Profile.";
        }

        con.close();
    } catch(Exception e){
        message = "Error: " + e.getMessage();
    }
%>
<!DOCTYPE html>
<html>
<head>
    <title>Update Admin Profile</title>
    <style>
        body { font-family: Arial, sans-serif; background:#f0f4f9; display:flex; justify-content:center; align-items:center; height:100vh; }
        .box { background:#fff; padding:30px; border-radius:10px; box-shadow:0 6px 18px rgba(0,0,0,0.1); width:350px; text-align:center; }
        h2 { color:#004080; margin-bottom:15px; }
        p { font-weight:bold; }
        a { display:inline-block; margin-top:15px; padding:10px 18px; background:#004080; color:#fff; border-radius:6px; text-decoration:none; }
        a:hover { background:#0066cc; }
    </style>
</head>
<body>
    <div class="box">
        <h2>Update Admin Profile</h2>
        <p><%= message %></p>
        <a href="adminDashboard.jsp">⬅ Back to Dashboard</a>
    </div>
</body>
</html>
