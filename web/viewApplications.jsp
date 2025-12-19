<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
    <title>My Applications</title>
    <link rel="icon" type="image/png" href="Images/tngovt_img.png">
    <style>
        body { font-family: Arial; padding: 20px; }
        table { border-collapse: collapse; width: 100%; margin-top: 20px; }
        th, td { border: 1px solid #ccc; padding: 10px; text-align: left; }
        th { background-color: #003366; color: white; }
        tr:nth-child(even) { background-color: #f2f2f2; }
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
<%
    String user = (String)session.getAttribute("username");
    if(user == null){
        response.sendRedirect("index.jsp");
    }
%>

<h2>My Applications:<span><%=user%></span></h2>

<table>
    <tr>
        <th>Scheme Name</th>
        <th>Status</th>
        <th>Aadhaar</th>
        <th>Phone</th>
        <th>Email</th>
        <th>Occupation</th>
        <th>Applied Date</th>
    </tr>
    <%
        try{
            Class.forName("com.mysql.cj.jdbc.Driver");
            Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/govtschemesdb","root","@Meera2206");

            PreparedStatement ps = con.prepareStatement(
                "SELECT s.scheme_name, a.status, a.aadhaar, a.phone, a.email, a.occupation, a.applied_date " +
                "FROM applications a " +
                "JOIN users u ON a.user_id = u.user_id " +
                "JOIN schemes s ON a.scheme_id = s.scheme_id " +
                "WHERE u.username = ?"
            );
            ps.setString(1, user);
            ResultSet rs = ps.executeQuery();

            while(rs.next()){
    %>
        <tr>
            <td><%=rs.getString("scheme_name")%></td>
            <td><%=rs.getString("status")%></td>
            <td><%=rs.getString("aadhaar")%></td>
            <td><%=rs.getString("phone")%></td>
            <td><%=rs.getString("email")%></td>
            <td><%=rs.getString("occupation")%></td>
            <td><%=rs.getTimestamp("applied_date")%></td>
        </tr>
    <%
            }
            con.close();
        }catch(Exception e){
            out.println("Error: "+e.getMessage());
        }
    %>
</table>
<br>
<br>
<a href="userHome.jsp" class="back-link">Back to User Dashboard</a>

</body>
</html>
