<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    String user = (String)session.getAttribute("username");
    if(user == null){
        response.sendRedirect("index.jsp");
    }
%>
<!DOCTYPE html>
<html>
<head>
    <title>User Home</title>
    <style>
        body {
            margin: 0;
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background: #f0f4f9;
        }

        /* Navbar */
        .navbar {
            display: flex;
            justify-content: space-between;
            align-items: center;
            background: #004080;
            padding: 12px 30px;
            color: #fff;
        }
        .navbar h2 {
            margin: 0;
            font-size: 20px;
        }
        .navbar a {
            color: #fff;
            margin-left: 20px;
            text-decoration: none;
            font-weight: bold;
            transition: 0.3s;
        }
        .navbar a:hover {
            color: #ffd700;
        }

        /* Container */
        .container {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(220px, 1fr));
            gap: 25px;
            padding: 50px;
            max-width: 1100px;
            margin: auto;
        }

        /* Card */
        .card {
            background: #fff;
            border-radius: 12px;
            box-shadow: 0 6px 18px rgba(0,0,0,0.1);
            padding: 30px 20px;
            text-align: center;
            transition: transform 0.2s, box-shadow 0.2s;
        }
        .card:hover {
            transform: translateY(-6px);
            box-shadow: 0 10px 22px rgba(0,0,0,0.2);
        }
        .card i {
            font-size: 40px;
            margin-bottom: 12px;
            color: #004080;
        }
        .card h3 {
            margin-bottom: 10px;
            color: #004080;
        }
        .card a {
            display: inline-block;
            margin-top: 10px;
            padding: 8px 14px;
            background: #004080;
            color: #fff;
            border-radius: 6px;
            font-size: 14px;
            text-decoration: none;
            transition: 0.3s;
        }
        .card a:hover {
            background: #0066cc;
        }
    </style>
    <!-- Font Awesome for icons -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css">
</head>
<body>
    <!-- Navbar -->
    <div class="navbar">
        <h2>Welcome, <%= user %></h2>
        <div>
            <a href="profile.jsp"><i class="fa-solid fa-user"></i> My Profile</a>
            <a href="logout.jsp"><i class="fa-solid fa-right-from-bracket"></i> Logout</a>
        </div>
    </div>

    <!-- Home Cards -->
    <div class="container">
        <div class="card">
            <i class="fa-solid fa-file-circle-plus"></i>
            <h3>Apply for Scheme</h3>
            <p>Submit your application for government schemes easily.</p>
            <a href="applyScheme.jsp">Apply Now</a>
        </div>

        <div class="card">
            <i class="fa-solid fa-clipboard-list"></i>
            <h3>View Status</h3>
            <p>Track the status of your submitted applications.</p>
            <a href="viewApplications.jsp">Check Status</a>
        </div>

        <div class="card">
            <i class="fa-solid fa-list-check"></i>
            <h3>View Schemes</h3>
            <p>Browse through all available government schemes.</p>
            <a href="viewSchemes.jsp">View Schemes</a>
        </div>

        <div class="card">
            <i class="fa-solid fa-id-card"></i>
            <h3>My Profile</h3>
            <p>View and update your personal details.</p>
            <a href="profile.jsp">View Profile</a>
        </div>
    </div>
</body>
</html>
