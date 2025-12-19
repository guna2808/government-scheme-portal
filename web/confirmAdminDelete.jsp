<%@ page contentType="text/html" pageEncoding="UTF-8" %>
<%
    String sessionAdmin = (String)session.getAttribute("username");
    if(sessionAdmin == null){
        response.sendRedirect("index.jsp");
    }
%>
<!DOCTYPE html>
<html>
<head>
    <title>Confirm Delete</title>
    <style>
        body { font-family: Arial, sans-serif; background:#fff3cd; display:flex; justify-content:center; align-items:center; height:100vh; }
        .box { background:#fff; padding:30px; border-radius:10px; box-shadow:0 6px 18px rgba(0,0,0,0.1); width:350px; text-align:center; }
        h2 { color:#856404; margin-bottom:15px; }
        p { font-weight:bold; }
        a { display:inline-block; margin:10px; padding:10px 18px; border-radius:6px; text-decoration:none; font-weight:bold; }
        .yes { background:#dc3545; color:#fff; }
        .yes:hover { background:#c82333; }
        .no { background:#28a745; color:#fff; }
        .no:hover { background:#218838; }
    </style>
</head>
<body>
    <div class="box">
        <h2>⚠ Confirm Delete</h2>
        <p>Are you sure you want to delete your admin account <b><%= sessionAdmin %></b>?</p>
        <a href="adminDeleteProfile.jsp" class="yes">✅ Yes, Delete</a>
        <a href="adminDashboard.jsp" class="no">❌ No, Go Back</a>
    </div>
</body>
</html>
