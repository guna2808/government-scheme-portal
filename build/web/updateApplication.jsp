<%@page contentType="text/html" pageEncoding="UTF-8" import="java.sql.*"%>
<!doctype html>
<html>
<head>
    <title>Update Application</title>
    <link rel="stylesheet" href="style.css">
    <style>
        body { font-family: Arial, sans-serif; background: #f9f9f9; }
        .form-container {
            width: 400px; margin: 50px auto;
            background: white; padding: 20px;
            border-radius: 8px; box-shadow: 0 2px 8px rgba(0,0,0,0.2);
        }
        h2 { color: #0a3d62; margin-bottom: 20px; text-align: center; }
        label { font-weight: bold; display: block; margin: 10px 0 5px; }
        select, input[type=submit] {
            width: 100%; padding: 10px; margin-bottom: 15px;
            border: 1px solid #ccc; border-radius: 5px;
        }
        input[type=submit] {
            background: #27ae60; color: white; cursor: pointer;
            font-weight: bold;
        }
        input[type=submit]:hover { background: #219150; }
        .back-link { text-decoration: none; color: #0a3d62; font-weight: bold; }
    </style>
</head>
<body>
<div class="form-container">
    <h2>Update Application Status</h2>
<%
    String appId = request.getParameter("id");
    String currentStatus = "";
    try {
        Class.forName("com.mysql.cj.jdbc.Driver");
        Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/govtschemesdb","root","@Meera2206");
        Statement st = con.createStatement();
        ResultSet rs = st.executeQuery("SELECT status FROM applications WHERE application_id=" + appId);
        if(rs.next()){
            currentStatus = rs.getString("status");
        }
        con.close();
    } catch(Exception e) { out.println("<p style='color:red;'>"+e+"</p>"); }
%>
    <form method="post" action="updateApplicationProcess.jsp">
        <input type="hidden" name="application_id" value="<%= appId %>">
        <label>Change Status:</label>
        <select name="status">
            <option value="Pending" <%= ("Pending".equals(currentStatus))?"selected":"" %>>Pending</option>
            <option value="Approved" <%= ("Approved".equals(currentStatus))?"selected":"" %>>Approved</option>
            <option value="Rejected" <%= ("Rejected".equals(currentStatus))?"selected":"" %>>Rejected</option>
        </select>
        <input type="submit" value="Update">
    </form>
    <a class="back-link" href="adminApplicationsView.jsp">← Back</a>
</div>
</body>
</html>
