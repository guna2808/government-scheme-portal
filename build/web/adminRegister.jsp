
<%@page contentType="text/html" pageEncoding="UTF-8" import="java.sql.*"%>
<%
    String message = "";
    if ("POST".equalsIgnoreCase(request.getMethod())) {
        String uname = request.getParameter("uname");
        String pass = request.getParameter("pass");
        String email = request.getParameter("email");
        String fullname = request.getParameter("fullname");

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/govtschemesdb", "root", "@Meera2206");

            String sql = "INSERT INTO admins(username,password,email,fullname) VALUES (?,?,?,?)";
            PreparedStatement ps = con.prepareStatement(sql);
            ps.setString(1, uname);
            ps.setString(2, pass);
            ps.setString(3, email);
            ps.setString(4, fullname);

            int i = ps.executeUpdate();
            if (i > 0) {
                message = "✅ Admin Registered Successfully!";
            } else {
                message = "❌ Registration Failed.";
            }

            con.close();
        } catch (Exception e) {
            message = "Error: " + e.getMessage();
        }
    }
%>
<!DOCTYPE html>
<html>
<head>
    <title>Admin Registration</title>
    <link rel="icon" type="image/png" href="Images/tngovt_img.png">
    <link rel="stylesheet" href="style.css">
</head>
<body>
    <h2>Admin Registration</h2>
    <form method="post">
        <label>Full Name:</label><input type="text" name="fullname" required><br><br>
        <label>Email:</label><input type="email" name="email" required><br><br>
        <label>Username:</label><input type="text" name="uname" required><br><br>
        <label>Password:</label><input type="password" name="pass" required><br><br>
        <input type="submit" value="Register">
    </form>
    <p><%= message %></p>
</body>
</html>

