<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
    <title>Manage Applications</title>
    <link rel="icon" type="image/png" href="Images/tngovt_img.png">
    <style>
        body { font-family: Arial; padding: 20px; }
        h2 { color: #003366; }
        table { border-collapse: collapse; width: 100%; margin-top: 20px; }
        th, td { border: 1px solid #ccc; padding: 10px; text-align: left; }
        th { background-color: #003366; color: white; }
        tr:nth-child(even) { background-color: #f9f9f9; }
        button { padding: 5px 10px; margin: 2px; border: none; border-radius: 4px; cursor: pointer; }
        .approve { background: #28a745; color: white; }
        .reject { background: #dc3545; color: white; }
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
</head>
<body>

<h2>Manage Applications</h2>

<table>
    <tr>
        <th>Application ID</th>
        <th>User</th>
        <th>Scheme</th>
        <th>Aadhaar</th>
        <th>Phone</th>
        <th>Email</th>
        <th>Occupation</th>
        <th>Status</th>
        <th>Applied Date</th>
        <th>Action</th>
    </tr>
    <%
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/govtschemesdb","root","@Meera2206");

            Statement st = con.createStatement();
            ResultSet rs = st.executeQuery(
                "SELECT a.application_id, u.username, s.scheme_name, a.aadhaar, a.phone, a.email, a.occupation, a.status, a.applied_date " +
                "FROM applications a " +
                "JOIN users u ON a.user_id = u.user_id " +
                "JOIN schemes s ON a.scheme_id = s.scheme_id"
            );

            while(rs.next()) {
    %>
        <tr>
            <td><%= rs.getInt("application_id") %></td>
            <td><%= rs.getString("username") %></td>
            <td><%= rs.getString("scheme_name") %></td>
            <td><%= rs.getString("aadhaar") %></td>
            <td><%= rs.getString("phone") %></td>
            <td><%= rs.getString("email") %></td>
            <td><%= rs.getString("occupation") %></td>
            <td><%= rs.getString("status") %></td>
            <td><%= rs.getTimestamp("applied_date") %></td>
            <td>
                <form action="update.jsp" method="post" style="display:inline;">
                    <input type="hidden" name="appId" value="<%= rs.getInt("application_id") %>">
                    <input type="hidden" name="status" value="Approved">
                    <button type="submit" class="approve">Approve</button>
                </form>
                <form action="update.jsp" method="post" style="display:inline;">
                    <input type="hidden" name="appId" value="<%= rs.getInt("application_id") %>">
                    <input type="hidden" name="status" value="Rejected">
                    <button type="submit" class="reject">Reject</button>
                </form>
            </td>
        </tr>
    <%
            }
            con.close();
        } catch(Exception e) {
            out.println("Error: " + e.getMessage());
        }
    %>
</table>
<br>
<br>
<a href="adminDashboard.jsp" class="back-link">Back to Admin Dashboard</a>
</body>
</html>
