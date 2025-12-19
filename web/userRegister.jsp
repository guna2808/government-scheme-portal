
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

            String sql = "INSERT INTO users(username,password,email,fullname) VALUES (?,?,?,?)";
            PreparedStatement ps = con.prepareStatement(sql);
            ps.setString(1, uname);
            ps.setString(2, pass);
            ps.setString(3, email);
            ps.setString(4, fullname);

            int i = ps.executeUpdate();
            if (i > 0) {
                message = "User Registered Successfully!";
            } else {
                message = "Registration Failed.";
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
    <title>User Registration</title>
    <link rel="icon" type="image/png" href="Images/tngovt_img.png">
    <style>
* {
    margin: 0;
    padding: 0;
    box-sizing: border-box;
    font-family: Arial, sans-serif;
}

/* Page background */
body {
    background: #f4f7fa;
    display: flex;
    flex-direction: column;
    align-items: center;
    justify-content: center;
    min-height: 100vh;
}

/* Heading */
h2 {
    margin-bottom: 20px;
    color: #004080;
    border-bottom: 2px solid #004080;
    padding-bottom: 8px;
    text-align: center;
}

/* Form container card */
form {
    background: #fff;
    padding: 25px 30px;
    border-radius: 10px;
    box-shadow: 0 4px 10px rgba(0,0,0,0.1);
    width: 350px;
}

/* Labels */
form label {
    display: block;
    font-weight: bold;
    margin-bottom: 6px;
    color: #333;
}

/* Inputs */
form input[type="text"],
form input[type="email"],
form input[type="password"] {
    width: 100%;
    padding: 10px;
    margin-bottom: 18px;
    border: 1px solid #ccc;
    border-radius: 6px;
    font-size: 14px;
    transition: border-color 0.2s;
}

form input:focus {
    border-color: #004080;
    outline: none;
}

/* Submit button */
form input[type="submit"] {
    width: 100%;
    padding: 12px;
    background: #004080;
    border: none;
    border-radius: 6px;
    color: #fff;
    font-size: 16px;
    font-weight: bold;
    cursor: pointer;
    transition: background 0.2s;
}

form input[type="submit"]:hover {
    background: #0066cc;
}

/* Success/Error message */
p {
    margin-top: 15px;
    text-align: center;
    font-size: 14px;
    font-weight: bold;
    color: green;
}

p:contains("Error"),
p:contains("Failed") {
    color: red;
}
/* Alert message box */
.alert {
    margin-top: 20px;
    padding: 12px 18px;
    border-radius: 6px;
    font-size: 14px;
    font-weight: bold;
    display: flex;
    align-items: center;
    gap: 10px;
    max-width: 350px;
    box-shadow: 0 2px 6px rgba(0,0,0,0.1);
}

/* Success */
.alert.success {
    background: #e6f9ec;
    border: 1px solid #3cc374;
    color: #2d8a57;
}

/* Error */
.alert.error {
    background: #fdeaea;
    border: 1px solid #e65a5a;
    color: #b32d2d;
}

/* Icon */
.alert span.icon {
    font-size: 18px;
}
/* Form group wrapper */
.form-group {
    position: relative;
    margin-bottom: 20px;
    width: 100%;
}

/* Inputs */
.form-group input {
    width: 100%;
    padding: 12px 10px;
    border: 1px solid #ccc;
    border-radius: 6px;
    font-size: 14px;
    outline: none;
    transition: border-color 0.2s;
}

/* Highlight on focus */
.form-group input:focus {
    border-color: #004080;
}

/* Labels (floating style) */
.form-group label {
    position: absolute;
    left: 12px;
    top: 12px;
    background: #fff;
    padding: 0 4px;
    color: #888;
    font-size: 14px;
    pointer-events: none;
    transition: 0.2s ease all;
}

/* Move label up when input is focused or filled */
.form-group input:focus + label,
.form-group input:not(:placeholder-shown) + label {
    top: -8px;
    left: 8px;
    font-size: 12px;
    color: #004080;
}

    </style>    
</head>
<body>
    <h2>User Registration</h2>
    <form method="post">
    <div class="form-group">
        <input type="text" name="fullname" required>
        <label>Full Name</label>
    </div>

    <div class="form-group">
        <input type="email" name="email" required>
        <label>Email</label>
    </div>

    <div class="form-group">
        <input type="text" name="uname" required>
        <label>Username</label>
    </div>

    <div class="form-group">
        <input type="password" name="pass" required>
        <label>Password</label>
    </div>

    <input type="submit" value="Register">
</form>
    
    <% if (message != null && !message.isEmpty()) { %>
    <div class="alert <%= message.contains("Successfully") ? "success" : "error" %>">
        <span class="icon"><%= message.contains("Successfully") ? "✅" : "❌" %></span>
        <%= message %>
    </div>

    <% if (message.contains("Successfully")) { %>
        <div style="margin-top:15px; text-align:center;">
            <a href="index.jsp" 
               style="display:inline-block; margin-top:10px; padding:10px 20px; 
                      background:#004080; color:#fff; border-radius:6px; 
                      text-decoration:none; font-weight:bold;">
               ⬅ Now You're Ready to Login
            </a>
        </div>
    <% } %>
<% } %>

    
</body>
</html>

