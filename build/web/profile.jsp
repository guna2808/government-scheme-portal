<%@page import="java.sql.*"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    String username = (String) session.getAttribute("username");
    if(username == null){
        response.sendRedirect("index.jsp");
    }

    String fullName = "", email = "", role = "";
    try {
        Class.forName("com.mysql.cj.jdbc.Driver");
        Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/govtschemesdb", "root", "@Meera2206");
        PreparedStatement ps = con.prepareStatement("SELECT fullname, email, role FROM users WHERE username=?");
        ps.setString(1, username);
        ResultSet rs = ps.executeQuery();
        if(rs.next()){
            fullName = rs.getString("fullname");
            email = rs.getString("email");
            role = rs.getString("role");
        }
        con.close();
    } catch(Exception e){
        e.printStackTrace();
    }
%>
<!DOCTYPE html>
<html>
<head>
    <title>My Profile</title>
    <style>
        body { font-family: Arial, sans-serif; background: #f0f4f9; display: flex; justify-content: center; align-items: center; min-height: 100vh; margin: 0; }
        .profile-card { background: #fff; padding: 30px; border-radius: 12px; box-shadow: 0 6px 18px rgba(0,0,0,0.15); width: 400px; text-align: center; }
        .profile-card h2 { color: #004080; margin-bottom: 20px; }
        .profile-info { text-align: left; margin-bottom: 20px; }
        .profile-info p { margin: 10px 0; font-size: 15px; }
        .btn { display: inline-block; padding: 10px 18px; border-radius: 6px; text-decoration: none; font-weight: bold; margin: 5px; }
        .btn-edit { background: #28a745; color: #fff; }
        .btn-edit:hover { background: #218838; }
        .btn-back { background: #0066cc; color: #fff; }
        .btn-back:hover { background: #004999; }
    </style>
</head>
<body>
    <div class="profile-card">
        <h2>My Profile</h2>
        <div class="profile-info">
            <p><strong>Full Name:</strong> <%= fullName %></p>
            <p><strong>Email:</strong> <%= email %></p>
            <p><strong>Username:</strong> <%= username %></p>
            <p><strong>Role:</strong> <%= role %></p>
        </div>
        <a href="editProfile.jsp" class="btn btn-edit">Edit Profile</a>
        <a href="userHome.jsp" class="btn btn-back">Back to Home</a>
    </div>
</body>
</html>
