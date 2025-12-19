<%@ page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <title>TamilNadu Government e-Scheme Portal</title>
    <link rel="icon" type="image/png" href="Images/tngovt_img.png">
    <link rel="stylesheet" href="indexstyle.css">
</head>
<body>
    <h2>TamilNadu Government e-Scheme Portal</h2>

    <div class="container">

        <!-- User Login -->
        <div class="login-box">
            <h3>User Login</h3>
            <form action="userLogin.jsp"    >
                <label>Username:</label>
                <input type="text" name="uname" required>
                
                <label>Password:</label>
                <div class="password-container">
                    <input type="password" id="userPassword" name="pass" required>
                    <span class="toggle-eye" onclick="togglePassword('userPassword', this)">⌣️</span>
                </div>
                
                <button type="submit">Login</button>
            </form>
            <p>New User? <a href="userRegister.jsp">Register Here</a></p>
        </div>

        <!-- Admin Login -->
        <div class="login-box">
            <h3>Admin Login</h3>
            <form action="adminLogin.jsp" method="post">
                <label>Username:</label>
                <input type="text" name="uname" required>
                
                <label>Password:</label>
                <div class="password-container">
                    <input type="password" id="adminPassword" name="pass" required>
                    <span class="toggle-eye" onclick="togglePassword('adminPassword', this)">⌣️</span>
                </div>
                
                <button type="submit">Login</button>
            </form>
            <p>New Admin? <a href="adminRegister.jsp">Register Here</a></p>
        </div>

    </div>

    <script>
    function togglePassword(id, eyeIcon) {
        var pwd = document.getElementById(id);
        if (pwd.type === "password") {
            pwd.type = "text";
            eyeIcon.textContent = "👁"; // change icon when showing
        } else {
            pwd.type = "password";
            eyeIcon.textContent = "️⌣"; // reset icon when hiding
        }
    }
    </script>

</body>
</html>
