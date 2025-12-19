<%@ page contentType="text/html" pageEncoding="UTF-8" import="java.sql.*" %>
<%
    String sessionAdmin = (String)session.getAttribute("username");
    if(sessionAdmin == null){
        response.sendRedirect("index.jsp");
    }

    String message = "";

    try {
        Class.forName("com.mysql.cj.jdbc.Driver");
        Connection con = DriverManager.getConnection(
            "jdbc:mysql://localhost:3306/govtschemesdb", "root", "@Meera2206");

        String sql = "DELETE FROM admins WHERE username=?";
        PreparedStatement ps = con.prepareStatement(sql);
        ps.setString(1, sessionAdmin);

        int i = ps.executeUpdate();
        if(i > 0){
            message = "✅ Admin Account Deleted Successfully!";
            session.invalidate(); // clear session
        } else {
            message = "❌ Failed to Delete Admin Account.";
        }
        con.close();
    } catch(Exception e){
        message = "Error: " + e.getMessage();
    }
%>
<!DOCTYPE html>
<html>
<head>
    <title>Delete Admin Account</title>
    <style>
        body { font-family: Arial, sans-serif; background:#f8d7da; display:flex; justify-content:center; align-items:center; height:100vh; }
        .box { background:#fff; padding:30px; border-radius:10px; box-shadow:0 6px 18px rgba(0,0,0,0.1); width:350px; text-align:center; }
        h2 { color:#721c24; margin-bottom:15px; }
        p { font-weight:bold; color:#721c24; }
        a { display:inline-block; margin-top:15px; padding:10px 18px; background:#004080; color:#fff; border-radius:6px; text-decoration:none; }
        a:hover { background:#0066cc; }
    </style>
</head>
<body>
    <div class="box">
        <h2>Delete Account</h2>
        <p><%= message %></p>
        <a href="index.jsp">⬅ Back to Home</a>
    </div>
</body>
</html>
