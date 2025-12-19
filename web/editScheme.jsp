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

    // Handle Update Form Submission
    String updateId = request.getParameter("update_id");
    String newName = request.getParameter("scheme_name");
    String newDesc = request.getParameter("description");
    String newEligibility = request.getParameter("eligibility");

    if (updateId != null && newName != null && newDesc != null && newEligibility != null) {
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/govtschemesdb", "root", "@Meera2206");
            PreparedStatement ps = con.prepareStatement(
                "UPDATE schemes SET scheme_name=?, description=?, eligibility=? WHERE scheme_id=? AND created_by=?"
            );
            ps.setString(1, newName);
            ps.setString(2, newDesc);
            ps.setString(3, newEligibility);
            ps.setInt(4, Integer.parseInt(updateId));
            ps.setInt(5, adminId);

            int rows = ps.executeUpdate();
            con.close();
            if (rows > 0) {
                out.println("<script>alert('Scheme updated successfully!'); window.location='updateScheme.jsp';</script>");
            } else {
                out.println("<script>alert('You can only update schemes created by you.'); window.location='updateScheme.jsp';</script>");
            }
        } catch (Exception e) {
            out.println("Error: " + e.getMessage());
        }
    }
%>

<html>
<head>
    <title>Update Scheme</title>
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
            width: 90%;
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
        .update-btn {
            background: #0066cc;
            color: white;
            padding: 6px 12px;
            border: none;
            border-radius: 4px;
            cursor: pointer;
        }
        .update-btn:hover {
            background: #004d99;
        }
        .form-popup {
            display: none;
            position: fixed;
            top: 20%;
            left: 30%;
            background: #fff;
            padding: 20px;
            border: 2px solid #003366;
            border-radius: 6px;
            box-shadow: 0px 4px 10px rgba(0,0,0,0.2);
        }
        .form-popup input, .form-popup textarea {
            width: 100%;
            padding: 8px;
            margin: 8px 0;
        }
        .close-btn {
            background: #e60000;
            color: #fff;
            padding: 6px 12px;
            border: none;
            border-radius: 4px;
            cursor: pointer;
        }
    </style>
    <script>
        function openForm(id, name, desc, eligibility) {
            document.getElementById("updateForm").style.display = "block";
            document.getElementById("update_id").value = id;
            document.getElementById("scheme_name").value = name;
            document.getElementById("description").value = desc;
            document.getElementById("eligibility").value = eligibility;
        }
        function closeForm() {
            document.getElementById("updateForm").style.display = "none";
        }
    </script>
</head>
<body>

    <h2>Update Government Schemes</h2>

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
                <button class="update-btn"
                        onclick="openForm('<%= rs.getInt("scheme_id") %>',
                                          '<%= rs.getString("scheme_name") %>',
                                          '<%= rs.getString("description") %>',
                                          '<%= rs.getString("eligibility") %>')">
                    Update
                </button>
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

    <!-- Popup Form -->
    <div class="form-popup" id="updateForm">
        <form method="post" action="updateScheme.jsp">
            <input type="hidden" name="update_id" id="update_id">

            <label>Scheme Name:</label>
            <input type="text" name="scheme_name" id="scheme_name" required>

            <label>Description:</label>
            <textarea name="description" id="description" rows="3" required></textarea>

            <label>Eligibility:</label>
            <textarea name="eligibility" id="eligibility" rows="3" required></textarea>

            <button type="submit" class="update-btn">Save Changes</button>
            <button type="button" class="close-btn" onclick="closeForm()">Cancel</button>
        </form>
    </div>

    <div class="back" style="margin-top:20px;">
        <a href="adminDashboard.jsp">⬅ Back to Admin Dashboard</a>
    </div>

</body>
</html>
