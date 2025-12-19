<%@page contentType="text/html" pageEncoding="UTF-8" import="java.sql.*"%>
<!doctype html>
<html>
<head>
    <title>Admin Applications View</title>
    <link rel="icon" type="image/png" href="Images/tngovt_img.png">
    <link rel="stylesheet" href="style.css">
    <style>
        body {
            font-family: Arial, sans-serif;
            background: #f9f9f9;
            margin: 20px;
        }
        h2 {
            color: #0a3d62;
            border-bottom: 2px solid #0a3d62;
            padding-bottom: 8px;
        }
        .table-container {
            margin-top: 20px;
        }
        table {
            width: 100%;
            border-collapse: collapse;
            background: white;
            box-shadow: 0 2px 6px rgba(0,0,0,0.1);
        }
        th, td {
            border: 1px solid #ddd;
            padding: 10px;
            text-align: center;
        }
        th {
            background: #0a3d62;
            color: white;
        }
        tr:nth-child(even) {
            background: #f2f2f2;
        }
        .action-btn {
            padding: 6px 12px;
            text-decoration: none;
            color: white;
            border-radius: 4px;
            font-size: 14px;
        }
        .edit-btn {
            background: #27ae60;
        }
        .delete-btn {
            background: #c0392b;
        }
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
</head>

<body>
<h2>Applications List</h2>
<div class="table-container">
<table>
<tr>
    <th>Scheme-ID</th>
    <th>Application-ID</th>
    <th>Name</th>
    <th>Email</th>
    <th>Scheme</th>
    <th>Status</th>
    <th>Action</th>
</tr>
<%
try{
    Class.forName("com.mysql.cj.jdbc.Driver");
    Connection con = DriverManager.getConnection(
        "jdbc:mysql://localhost:3306/govtschemesdb","root","@Meera2206");
    Statement st = con.createStatement();

    String sql = "SELECT a.application_id, a.status, " +
                 "s.scheme_id, s.scheme_name, " +
                 "u.fullname, u.email " +
                 "FROM applications a " +
                 "INNER JOIN schemes s ON a.scheme_id = s.scheme_id " +
                 "INNER JOIN users u ON a.user_id = u.user_id";

    ResultSet rs = st.executeQuery(sql);

    while(rs.next()){
%>
<tr>
    <td><%= rs.getInt("scheme_id") %></td>
    <td><%= rs.getInt("application_id") %></td>
    <td><%= rs.getString("fullname") %></td>
    <td><%= rs.getString("email") %></td>
    <td><%= rs.getString("scheme_name") %></td>
    <td><%= rs.getString("status") %></td>
    <td>
        <a class="action-btn edit-btn" href="updateApplication.jsp?id=<%= rs.getInt("application_id") %>">Update</a>
        <a class="action-btn delete-btn" href="deleteApplication.jsp?id=<%= rs.getInt("application_id") %>"
           onclick="return confirm('Are you sure you want to delete this application?');">Delete</a>
    </td>
</tr>
<%
    }
    con.close();
}catch(Exception e){ out.println("<tr><td colspan='7'>" + e + "</td></tr>"); }
%>
</table>
</div>
<a class="back-link" href="adminDashboard.jsp">← Back to Admin Dashboard</a>
</body>
</html>
