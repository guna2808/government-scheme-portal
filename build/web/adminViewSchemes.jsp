<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import="java.sql.*" %>
<html>
<head>
    <title>Manage Government Schemes (Admin)</title>
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
        table {
            margin: 20px auto;
            width: 95%;
            border-collapse: collapse;
            background: #fff;
            box-shadow: 0px 4px 8px rgba(0,0,0,0.1);
            border-radius: 6px;
            overflow: hidden;
        }
        th, td {
            padding: 12px;
            border: 1px solid #ccc;
            text-align: center;
            font-size: 15px;
        }
        th {
            background: #003366;
            color: white;
        }
        tr:nth-child(even) {
            background: #f9f9f9;
        }
       .action-buttons {
    display: flex;
    justify-content: center;
    gap: 8px; /* space between buttons */
}

.btn-edit, .btn-delete {
    flex: 1; /* both take equal space */
    min-width: 70px; /* ensure a consistent button size */
    text-align: center;
    padding: 6px 0;
    text-decoration: none;
    border-radius: 5px;
    font-size: 13px;
    color: white;
    cursor: pointer;
    transition: background 0.2s ease;
}

/* Edit button */
.btn-edit {
    background: #4a90e2;  /* softer blue */
}
.btn-edit:hover {
    background: #357ab8;
}

/* Delete button */
.btn-delete {
    background: #e74c3c;  /* softer red */
}
.btn-delete:hover {
    background: #c0392b;
}

        .back {
            display: flex;
            justify-content: center;
            margin: 20px;
        }
        .back a {
            padding: 10px 15px;
            background: #003366;
            color: white;
            text-decoration: none;
            border-radius: 5px;
        }
        .back a:hover {
            background: #00509e;
        }
    </style>
</head>
<body>
    <%
    String username = (String) session.getAttribute("username");
    if (username == null) {
        response.sendRedirect("login.jsp"); // redirect if no session
    }
%>

    <h2>Government Schemes</h2>

    <table>
        <tr>
            <th>Scheme Name</th>
            <th>Description</th>
            <th>Eligibility</th>
            <th>Action</th>
        </tr>
        <%
            Connection con = null;
            Statement st = null;
            ResultSet rs = null;
            try {
                Class.forName("com.mysql.cj.jdbc.Driver");
                con = DriverManager.getConnection("jdbc:mysql://localhost:3306/govtschemesdb", "root", "@Meera2206");
                st = con.createStatement();
                rs = st.executeQuery("SELECT scheme_id, scheme_name, description, eligibility FROM schemes");

                while(rs.next()) {
        %>
        <tr>
            <td><%= rs.getString("scheme_name") %></td>
            <td><%= rs.getString("description") %></td>
            <td><%= rs.getString("eligibility") %></td>
            <td>
            <div class="action-buttons">
            <a href="editScheme.jsp?schemeId=<%= rs.getInt("scheme_id") %>" class="btn-edit">Update</a>
            <a href="deleteScheme.jsp?schemeId=<%= rs.getInt("scheme_id") %>" class="btn-delete" onclick="return confirm('Are you sure you want to delete this scheme?');">Delete</a>
    </div>
</td>

        </tr>
        <%
                }
            } catch(Exception e) {
                out.println("<tr><td colspan='4' style='color:red;'>Error: " + e.getMessage() + "</td></tr>");
            } finally {
                if(rs != null) rs.close();
                if(st != null) st.close();
                if(con != null) con.close();
            }
        %>
    </table>

    <div class="back">
        <a href="adminDashboard.jsp">⬅ Back to Admin Dashboard</a>
    </div>
</body>
</html>
