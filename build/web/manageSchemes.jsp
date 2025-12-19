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

    // Handle Add
    if ("POST".equalsIgnoreCase(request.getMethod()) && "add".equals(request.getParameter("action"))) {
        String schemeName = request.getParameter("scheme_name");
        String description = request.getParameter("description");
        String eligibility = request.getParameter("eligibility");

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/govtschemesdb", "root", "@Meera2206");
            PreparedStatement ps = con.prepareStatement("INSERT INTO schemes (scheme_name, description, eligibility, created_by) VALUES (?,?,?,?)");
            ps.setString(1, schemeName);
            ps.setString(2, description);
            ps.setString(3, eligibility);
            ps.setInt(4, adminId);
            ps.executeUpdate();
            con.close();
            out.println("<script>alert('Scheme added successfully!'); window.location='manageSchemes.jsp';</script>");
        } catch (Exception e) {
            out.println("Error: " + e.getMessage());
        }
    }

    // Handle Update
    if ("POST".equalsIgnoreCase(request.getMethod()) && "update".equals(request.getParameter("action"))) {
        String updateId = request.getParameter("update_id");
        String newName = request.getParameter("scheme_name");
        String newDesc = request.getParameter("description");
        String newEligibility = request.getParameter("eligibility");

        if (updateId != null) {
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
                    out.println("<script>alert('Scheme updated successfully!'); window.location='manageSchemes.jsp';</script>");
                } else {
                    out.println("<script>alert('You can only update your own schemes.'); window.location='manageSchemes.jsp';</script>");
                }
            } catch (Exception e) {
                out.println("Error: " + e.getMessage());
            }
        }
    }

    // Handle Delete
    if ("POST".equalsIgnoreCase(request.getMethod()) && "delete".equals(request.getParameter("action"))) {
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
                    out.println("<script>alert('Scheme deleted successfully!'); window.location='manageSchemes.jsp';</script>");
                } else {
                    out.println("<script>alert('You can only delete your own schemes.'); window.location='manageSchemes.jsp';</script>");
                }
            } catch (Exception e) {
                out.println("Error: " + e.getMessage());
            }
        }
    }
%>

<html>
<head>
    <title>Manage Schemes</title>
    <link rel="icon" type="image/png" href="Images/tngovt_img.png">
    <style>
        body { font-family: Arial, sans-serif; margin: 40px; background: #f9f9f9; }
        h2 { color: #003366; }
        .tabs { display: flex; gap: 20px; margin-bottom: 20px; }
        .tab-btn { padding: 10px 20px; background: #003366; color: white; border: none; border-radius: 5px; cursor: pointer; }
        .tab-btn:hover { background: #0055aa; }
        .tab-content { display: none; }
        .active { display: block; }
        form { margin-top: 15px; background: #fff; padding: 20px; border-radius: 6px; box-shadow: 0px 2px 6px rgba(0,0,0,0.1); }
        input, textarea { width: 100%; padding: 10px; margin: 8px 0; }
        table { width: 100%; border-collapse: collapse; margin-top: 20px; background: #fff; }
        th, td { border: 1px solid #ddd; padding: 10px; text-align: center; }
        th { background: #003366; color: white; }
        tr:nth-child(even) { background: #f2f2f2; }
        .action-btn { padding: 5px 10px; border: none; border-radius: 4px; cursor: pointer; }
        .update { background: #0066cc; color: white; }
        .delete { background: #e60000; color: white; }
        .delete:hover { background: #cc0000; }

        /* Fix delete white patch */
        td form {
            margin: 0;
            background: transparent;
            display: inline;
        }

        /* Modal Styling */
        .modal { display: none; position: fixed; z-index: 1; left: 0; top: 0; width: 100%; height: 100%; overflow: auto; background-color: rgba(0,0,0,0.4); }
        .modal-content { background-color: #fff; margin: 10% auto; padding: 20px; border-radius: 8px; width: 40%; box-shadow: 0px 4px 8px rgba(0,0,0,0.2); }
        .close { float: right; font-size: 22px; cursor: pointer; }
        .close:hover { color: red; }
        .back-link { text-decoration: none; color: #0a3d62; font-weight: bold; }
        .back-link {
            margin-top: 15px;
            display: inline-block;
            text-decoration: none;
            color: #0a3d62;
            font-weight: bold;
            
        }
        .back-link {
            display: inline-block;
            padding: 10px 20px;
            background-color: #003366;   /* Same as table header */
            color: #ffffff;              /* White text */
            font-weight: bold;
            text-decoration: none;
            border-radius: 6px;
            transition: background 0.3s, transform 0.2s;
            margin-top: 15px;            /* Small gap above */
        }

        .back-link:hover {
            background-color: #0055a5;   /* Lighter blue on hover */ 
            transform: translateY(-2px); /* Hover lift */
        }

        .back-link:active {
            background-color: #002244;   /* Darker blue on click */
            transform: translateY(0);    /* Reset */
        }
    </style>
    <script>
        function showTab(tabId) {
            document.querySelectorAll(".tab-content").forEach(c => c.style.display = "none");
            document.getElementById(tabId).style.display = "block";
        }

        function openModal(id, name, desc, elig) {
            document.getElementById("editModal").style.display = "block";
            document.getElementById("update_id").value = id;
            document.getElementById("edit_name").value = name;
            document.getElementById("edit_desc").value = desc;
            document.getElementById("edit_elig").value = elig;
        }

        function closeModal() {
            document.getElementById("editModal").style.display = "none";
        }
    </script>
</head>
<body>

    <h2>Manage Government Schemes</h2>

    <div class="tabs">
        <button class="tab-btn" onclick="showTab('add')">➕ Add Scheme</button>
        <button class="tab-btn" onclick="showTab('update')">✏️ Update Scheme</button>
        <button class="tab-btn" onclick="showTab('delete')">🗑 Delete Scheme</button>
    </div>

    <!-- Add Scheme -->
    <div id="add" class="tab-content active">
        <form method="post">
            <input type="hidden" name="action" value="add">
            <label>Scheme Name:</label>
            <input type="text" name="scheme_name" required>
            <label>Description:</label>
            <textarea name="description" required></textarea>
            <label>Eligibility:</label>
            <textarea name="eligibility" required></textarea>
            <button type="submit" class="tab-btn">Add Scheme</button>
        </form>
    </div>

    <!-- Update Scheme -->
    <div id="update" class="tab-content">
        <table>
            <tr>
                <th>ID</th><th>Name</th><th>Description</th><th>Eligibility</th><th>Action</th>
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
                    <button type="button" class="action-btn update"
                        onclick="openModal('<%= rs.getInt("scheme_id") %>',
                                          '<%= rs.getString("scheme_name").replace("'", "\\'") %>',
                                          '<%= rs.getString("description").replace("'", "\\'") %>',
                                          '<%= rs.getString("eligibility").replace("'", "\\'") %>')">
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
    </div>

    <!-- Delete Scheme -->
    <div id="delete" class="tab-content">
        <table>
            <tr>
                <th>ID</th><th>Name</th><th>Description</th><th>Eligibility</th><th>Action</th>
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
                    <form method="post">
                        <input type="hidden" name="delete_id" value="<%= rs.getInt("scheme_id") %>">
                        <input type="hidden" name="action" value="delete">
                        <button type="submit" class="action-btn delete" onclick="return confirm('Delete this scheme?');">Delete</button>
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
    </div>

    <!-- Edit Modal -->
    <div id="editModal" class="modal">
        <div class="modal-content">
            <span class="close" onclick="closeModal()">&times;</span>
            <h3>Edit Scheme</h3>
            <form method="post">
                <input type="hidden" name="action" value="update">
                <input type="hidden" id="update_id" name="update_id">
                <label>Scheme Name:</label>
                <input type="text" id="edit_name" name="scheme_name" required>
                <label>Description:</label>
                <textarea id="edit_desc" name="description" required></textarea>
                <label>Eligibility:</label>
                <textarea id="edit_elig" name="eligibility" required></textarea>
                <button type="submit" class="tab-btn">Update</button>
            </form>
        </div>
    </div>

    <div>
        <a href="adminDashboard.jsp" class="back-link">⬅ Back to Admin Dashboard</a>
    </div>

</body>
</html>
