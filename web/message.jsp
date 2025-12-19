<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <title>Message</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background: #f4f6f8;
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
        }
        .message-box {
            background: #fff;
            padding: 30px;
            border-radius: 10px;
            text-align: center;
            width: 400px;
            box-shadow: 0 4px 10px rgba(0,0,0,0.2);
        }
        .success { color: #27ae60; }
        .error { color: #e74c3c; }
        .btn {
            display: inline-block;
            margin-top: 15px;
            text-decoration: none;
            padding: 10px 20px;
            background: #3498db;
            color: white;
            border-radius: 5px;
            font-weight: bold;
        }
        .btn:hover { background: #2980b9; }
    </style>
</head>
<body>
    <div class="message-box">
        <%
            String type = request.getParameter("type");  // success / error
            String msg = request.getParameter("msg");

            if ("success".equals(type)) {
        %>
            <h2 class="success">✅ Success</h2>
            <p><%= msg %></p>
        <%
            } else {
        %>
            <h2 class="error">❌ Error</h2>
            <p><%= msg %></p>
        <%
            }
        %>
        <a href="adminApplicationsView.jsp" class="btn">Back to Applications</a>
    </div>
</body>
</html>
