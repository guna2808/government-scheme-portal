<%@page contentType="text/html" pageEncoding="UTF-8" import="java.sql.*"%>
<%@ page import="jakarta.servlet.http.*" %>

<%
    String admin = (String) session.getAttribute("username");
    if(admin == null){
        response.sendRedirect("index.jsp");
        return;
    }

    // Fetch admin_id
    int adminId = -1;
    try {
        Class.forName("com.mysql.cj.jdbc.Driver");
        Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/govtschemesdb", "root", "@Meera2206");
        PreparedStatement ps = con.prepareStatement("SELECT admin_id FROM admins WHERE username=?");
        ps.setString(1, admin);
        ResultSet rs = ps.executeQuery();
        if(rs.next()){
            adminId = rs.getInt("admin_id");
        }
        con.close();
    } catch(Exception e){
        out.println("Error: " + e.getMessage());
    }

    // Handle Form Submission
    String schemeName = request.getParameter("scheme_name");
    String desc = request.getParameter("description");
    String eligibility = request.getParameter("eligibility");

    String message = "";
    boolean success = false;

    if(schemeName != null && desc != null && eligibility != null){
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/govtschemesdb", "root", "@Meera2206");
            PreparedStatement ps = con.prepareStatement(
                "INSERT INTO schemes (scheme_name, description, eligibility, created_by) VALUES (?, ?, ?, ?)"
            );
            ps.setString(1, schemeName);
            ps.setString(2, desc);
            ps.setString(3, eligibility);
            ps.setInt(4, adminId);
            ps.executeUpdate();
            con.close();

            message = "✅ Scheme added successfully!";
            success = true;

        } catch(Exception e){
            message = "❌ Error: " + e.getMessage();
        }
    }

    // Fetch all schemes for display
    java.util.List<String[]> schemeList = new java.util.ArrayList<>();
    try {
        Class.forName("com.mysql.cj.jdbc.Driver");
        Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/govtschemesdb", "root", "@Meera2206");
        Statement st = con.createStatement();
        ResultSet rs = st.executeQuery(
            "SELECT s.scheme_name, s.description, s.eligibility, a.username " +
            "FROM schemes s JOIN admins a ON s.created_by = a.admin_id ORDER BY s.scheme_id DESC"
        );
        while(rs.next()){
            schemeList.add(new String[]{
                rs.getString("scheme_name"),
                rs.getString("description"),
                rs.getString("eligibility"),
                rs.getString("username")
            });
        }
        con.close();
    } catch(Exception e){
        out.println("Error fetching schemes: " + e.getMessage());
    }
%>

<!DOCTYPE html>
<html>
<head>
    <title>Add Scheme</title>
    <link rel="icon" type="image/png" href="Images/tngovt_img.png">
    <style>
        body {
            font-family: Arial, sans-serif;
            background: #f5f6fa;
            margin: 0;
            padding: 0;
        }
        h2 {
            text-align: center;
            padding: 15px;
            background: #003366;
            color: white;
            margin: 0;
        }
        .container {
            width: 70%;
            margin: 30px auto;
            background: white;
            padding: 25px;
            border-radius: 8px;
            box-shadow: 0px 4px 8px rgba(0,0,0,0.1);
        }
        label {
            font-weight: bold;
            display: block;
            margin: 10px 0 5px;
        }
        input[type="text"], textarea {
            width: 100%;
            padding: 10px;
            border: 1px solid #ccc;
            border-radius: 5px;
            font-size: 14px;
        }
        textarea {
            resize: vertical;
            min-height: 70px;
        }
        .btn {
            margin-top: 15px;
            padding: 10px 15px;
            border: none;
            border-radius: 5px;
            font-size: 14px;
            cursor: pointer;
            color: white;
        }
        .btn-submit {
            background: #007bff;
        }
        .btn-submit:hover {
            background: #0056b3;
        }
        .btn-back {
            background: #6c757d;
            margin-left: 10px;
            text-decoration: none;
            display: inline-block;
        }
        .btn-back:hover {
            background: #555;
        }
        .message {
            margin-top: 15px;
            padding: 10px;
            font-weight: bold;
            border-radius: 5px;
            text-align: center;
        }
        .success { background: #d4edda; color: #155724; }
        .error { background: #f8d7da; color: #721c24; }

        /* Table Styling */
        table {
            width: 100%;
            border-collapse: collapse;
            margin-top: 25px;
        }
        table, th, td {
            border: 1px solid #ddd;
        }
        th {
            background: #003366;
            color: white;
            padding: 10px;
            text-align: left;
        }
        td {
            padding: 10px;
            vertical-align: top;
        }
        tr:nth-child(even) {
            background: #f9f9f9;
        }
    </style>
    <% if(success) { %>
        <!-- Refresh to clear form after 2 seconds -->
        <meta http-equiv="refresh" content="2;URL=addScheme.jsp">
    <% } %>
</head>
<body>
    <h2>Add New Government Scheme</h2>
    <div class="container">
        <form method="post" action="addScheme.jsp">
            <label>Scheme Name:</label>
            <input type="text" name="scheme_name" required>

            <label>Description:</label>
            <textarea name="description" rows="4" required></textarea>

            <label>Eligibility:</label>
            <textarea name="eligibility" rows="4" required></textarea>

            <div>
                <button type="submit" class="btn btn-submit">➕ Add Scheme</button>
                <a href="adminDashboard.jsp" class="btn btn-back">⬅ Back</a>
            </div>
        </form>

        <% if(!message.equals("")) { %>
            <div class="message <%= success ? "success" : "error" %>">
                <%= message %>
            </div>
        <% } %>
        <br>
        <hr>
        <h3>Existing Schemes List 🠗</h3>
        <table>
            <tr>
                <th>Scheme Name</th>
                <th>Description</th>
                <th>Eligibility</th>
                <th>Created By</th>
            </tr>
            <% for(String[] scheme : schemeList) { %>
                <tr>
                    <td><%= scheme[0] %></td>
                    <td><%= scheme[1] %></td>
                    <td><%= scheme[2] %></td>
                    <td><%= scheme[3] %></td>
                </tr>
            <% } %>
        </table>
    </div>
</body>
</html>
