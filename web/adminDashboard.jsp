<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <title>Admin Dashboard</title>
    <link rel="icon" type="image/png" href="Images/tngovt_img.png">
    <!-- Font Awesome for Icons -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">

    <style>
        /* Reset */
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
        }

        body {
            background: #f4f8fc;
            min-height: 100vh;
            display: flex;
            flex-direction: column;
            align-items: center;
        }

        /* Header */
        .header {
            width: 100%;
            background: #004080;
            padding: 15px 30px;
            display: flex;
            justify-content: space-between;
            align-items: center;
            color: white;
        }
        .header .welcome {
            font-size: 18px;
            font-weight: bold;
        }
        .header .actions a {
            color: white;
            margin-left: 20px;
            text-decoration: none;
            font-weight: 500;
            transition: opacity 0.2s;
        }
        .header .actions a:hover {
            opacity: 0.8;
        }
        .header .actions i {
            margin-right: 6px;
        }

        /* Dashboard Grid */
        .dashboard {
            display: flex;
            justify-content: center;
            gap: 25px;
            margin-top: 40px;
            flex-wrap: wrap;
            padding: 40px;
        }

        /* Dashboard Cards */
        .card {
            background: #fff;
            padding: 40px 30px;
            border-radius: 12px;
            text-align: center;
            width: 250px;
            box-shadow: 0 6px 18px rgba(0,0,0,0.08);
            transition: transform 0.2s ease, box-shadow 0.2s ease;
        }
        .card:hover {
            transform: translateY(-6px);
            box-shadow: 0 12px 25px rgba(0,0,0,0.15);
        }
        .card i {
            font-size: 42px;
            color: #004080;
            margin-bottom: 15px;
        }
        .card h3 {
            font-size: 18px;
            margin-bottom: 10px;
            color: #004080;
        }
        .card p {
            font-size: 14px;
            margin-bottom: 15px;
            color: #333;
        }
        .card button {
            background: #004080;
            color: white;
            padding: 8px 16px;
            border: none;
            border-radius: 6px;
            cursor: pointer;
            font-size: 14px;
            font-weight: 500;
            transition: background 0.2s;
        }
        .card button:hover {
            background: #003366;
        }
    </style>
</head>
<body>
<%
    String admin = (String)session.getAttribute("username");
    if(admin == null){
        response.sendRedirect("index.jsp");
    }
%>

<!-- Header -->
<div class="header">
    <div class="welcome">Welcome, <%=admin%></div>
    <div class="actions">
        <a href="adminProfile.jsp"><i class="fas fa-user"></i> My Profile</a>
        <a href="logout.jsp"><i class="fas fa-sign-out-alt"></i> Logout</a>
    </div>
</div>

<!-- Dashboard Cards -->
<div class="dashboard">
    <div class="card">
        <i class="fas fa-file-alt"></i>
        <h3>Manage Applications</h3>
        <p>Submit and update applications for review.</p>
        <button onclick="location.href='adminApplicationsView.jsp'">Open</button>
    </div>

    <div class="card">
        <i class="fas fa-clipboard-check"></i>
        <h3>Track Status</h3>
        <p>Monitor status of submitted applications.</p>
        <button onclick="location.href='manageApplications.jsp'">Check</button>
    </div>

    <div class="card">
        <i class="fas fa-list"></i>
        <h3>View Schemes</h3>
        <p>Browse and manage all available schemes.</p>
        <button onclick="location.href='adminViewSchemes.jsp'">View</button>
    </div>

    <div class="card">
        <i class="fas fa-cogs"></i>
        <h3>Manage Schemes</h3>
        <p>Edit and maintain scheme details.</p>
        <button onclick="location.href='manageSchemes.jsp'">Manage</button>
    </div>
</div>

</body>
</html>
