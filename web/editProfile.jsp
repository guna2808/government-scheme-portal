<%@ page contentType="text/html" pageEncoding="UTF-8" import="java.sql.*" %>
<%
    String user = (String)session.getAttribute("username");
    if(user == null){
        response.sendRedirect("index.jsp");
    }

    String fullname = "", email = "", username = "", password = "";
    try {
        Class.forName("com.mysql.cj.jdbc.Driver");
        Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/govtschemesdb", "root", "@Meera2206");

        PreparedStatement ps = con.prepareStatement("SELECT * FROM users WHERE username=?");
        ps.setString(1, user);
        ResultSet rs = ps.executeQuery();

        if(rs.next()){
            fullname = rs.getString("fullname");
            email = rs.getString("email");
            username = rs.getString("username");
            password = rs.getString("password");
        }
        con.close();
    } catch(Exception e){
        out.println("Error: " + e.getMessage());
    }
%>
<!DOCTYPE html>
<html>
<head>
    <title>Edit Profile</title>
    <style>
        body { font-family: Arial, sans-serif; background: #f4f7fa; display:flex; justify-content:center; align-items:center; height:100vh; }
        .form-box { background:#fff; padding:30px; border-radius:10px; box-shadow:0 6px 18px rgba(0,0,0,0.1); width:350px; }
        h2 { text-align:center; margin-bottom:20px; color:#004080; }
        label { display:block; margin-top:12px; font-weight:bold; }
        input[type="text"], input[type="email"], input[type="password"] {
            width:100%; padding:10px; margin-top:6px; border:1px solid #ccc; border-radius:6px; 
        }
        input[type="submit"] {
            margin-top:20px; width:100%; padding:12px; background:#004080; color:#fff; border:none; border-radius:6px; cursor:pointer;
        }
        input[type="submit"]:hover { background:#0066cc; }
        a { display:block; text-align:center; margin-top:12px; color:#004080; text-decoration:none; }
    </style>
</head>
<body>
    <div class="form-box">
        <h2>Edit Profile</h2>
        <form action="updateProfile.jsp" method="post">
            <label>Full Name</label>
            <input type="text" name="fullname" value="<%= fullname %>" required>

            <label>Email</label>
            <input type="email" name="email" value="<%= email %>" required>

            <label>Username</label>
            <input type="text" name="uname" value="<%= username %>" required>

            <label>Password</label>
            <input type="password" name="pass" value="<%= password %>" required>

            <input type="submit" value="Update Profile">
        </form>
        <a href="userHome.jsp">⬅ Back to Home</a>
    </div>
</body>
</html>
