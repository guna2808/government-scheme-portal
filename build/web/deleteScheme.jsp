<%@page contentType="text/html" pageEncoding="UTF-8" import="java.sql.*"%>
<%@ page import="jakarta.servlet.http.*" %>

<%
    // Ensure admin session
    String admin = (String) session.getAttribute("username");
    if (admin == null) {
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
        if (rs.next()) {
            adminId = rs.getInt("admin_id");
        }
        con.close();
    } catch (Exception e) {
        out.println("Error: " + e.getMessage());
    }

    // Handle Delete Request
    String deleteId = request.getParameter("delete_id");
    if (deleteId != null) {
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/govtschemesdb", "root", "@Meera2206");
            PreparedStatement ps = con.prepareStatement("DELETE FROM schemes WHERE scheme_id=? AND created_by=?");
            ps.setInt(1, Integer.parseInt(deleteId));
            ps.setInt(2, adminId);
            int rows = ps.executeUpdate();
            con.close();
            if (rows > 0) {
                out.println("<script>alert('Scheme deleted successfully!'); window.location='deleteScheme.jsp';</script>");
            } else {
                out.println("<script>alert('You can only delete schemes created by you.'); window.location='deleteScheme.jsp';</script>");
            }
        } catch (Exception e) {
            out.println("Error: " + e.getMessage());
        }
    }
%>

<html>
<head>
    <title>Delete Scheme</title>
    <link rel="icon" type="image/png" href="Images/tngovt_img.png">
    <style>
        body {
            font-family: Arial, sans-serif;
            margin: 40px;
            background: #f9f9f9;
        }
        h2 {
            color: #003366;
        }
        table {
            width: 80%;
            border-collapse: collapse;
            margin-top: 20px;
            background: #fff;
            box-shadow: 0 2px 6px rgba(0,0,0,0.1);
        }
        th, td {
            border: 1px solid #ddd;
            padding: 12px;
            text-align: center;
        }
        th {
            background: #003366;
            color: white;
        }
        tr:nth-child(even) {
            background: #f2f2f2;
        }
        .delete-btn {
            background: #e60000;
            color: white;
            padding: 6px 12px;
            border: none;
            border-radius: 4px;
            cursor: pointer;
        }
        .delete-btn:hover {
            background: #cc0000;
        }
        .back {
            margin-top: 20px;
        }
        .back a {
            text-decoration: none;
            color: #003366;
            font-weight: bold;
        }
    </style>
</head>
<body>

    <h2>Delete Government Schemes</h2>

    <table>
        <tr>
            <th>Scheme ID</th>
            <th>Scheme Name</th>
            <th>Description</th>
            <th>Eligibility</th>
            <th>Action</th>
        </tr>
        <%
            try {
                Class.forName("com.mysql.cj.jdbc.Driver");
                Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/govtschemesdb", "root", "@Meera2206");
                PreparedStatement ps = con.prepareStatement("SELECT * FROM schemes WHERE created_by=?");
                ps.setInt(1, adminId);
                ResultSet rs = ps.executeQuery();
                while (rs.next()) {
        %>
        <tr>
            <td><%= rs.getInt("scheme_id") %></td>
            <td><%= rs.getString("scheme_name") %></td>
            <td><%= rs.getString("description") %></td>
            <td><%= rs.getString("eligibility") %></td>
            <td>
                <form method="post" action="deleteScheme.jsp" style="margin:0;">
                    <input type="hidden" name="delete_id" value="<%= rs.getInt("scheme_id") %>">
                    <button type="submit" class="delete-btn">Delete</button>
                </form>
            </td>
        </tr>
        <%
                }
                con.close();
            } catch (Exception e) {
                out.println("Error: " + e.getMessage());
            }
        %>
    </table>

    <div class="back">
        <a href="adminDashboard.jsp">⬅ Back to Admin Dashboard</a>
    </div>

</body>
</html>
