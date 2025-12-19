<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
    <title>Apply for Scheme</title>
    <link rel="icon" type="image/png" href="Images/tngovt_img.png">
    <style>
        /* Same Design as before */
        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background: linear-gradient(135deg, #dceefb, #f0f4f9);
            margin: 0;
            padding: 0;
            display: flex;
            justify-content: center;
            align-items: center;
            min-height: 100vh;
        }
        .form-container {
            background: #fff;
            padding: 35px 40px;
            border-radius: 15px;
            box-shadow: 0 8px 24px rgba(0,0,0,0.1);
            width: 100%;
            max-width: 550px;
            animation: fadeIn 0.5s ease-in-out;
        }
        .form-container h2 {
            text-align: center;
            margin-bottom: 25px;
            color: #004080;
            font-size: 26px;
            border-bottom: 2px solid #004080;
            padding-bottom: 10px;
        }
        .welcome {
            text-align: center;
            font-size: 14px;
            margin-bottom: 20px;
            color: #333;
        }
        .form-group {
            position: relative;
            margin-bottom: 22px;
        }
        .form-group input,
        .form-group select {
            width: 100%;
            padding: 12px 10px;
            border: 1px solid #ccc;
            border-radius: 6px;
            font-size: 15px;
            background: transparent;
            transition: all 0.3s ease;
        }
        .form-group label {
            position: absolute;
            left: 12px;
            top: 12px;
            background: #fff;
            padding: 0 4px;
            color: #888;
            font-size: 14px;
            pointer-events: none;
            transition: 0.3s;
        }
        .form-group input:focus,
        .form-group select:focus {
            border-color: #004080;
            box-shadow: 0 0 6px rgba(0,64,128,0.2);
        }
        .form-group input:focus + label,
        .form-group input:not(:placeholder-shown) + label,
        .form-group select:focus + label,
        .form-group select:valid + label {
            top: -8px;
            left: 8px;
            font-size: 12px;
            color: #004080;
        }
        button {
            width: 100%;
            background: #004080;
            color: #fff;
            padding: 12px;
            border: none;
            border-radius: 6px;
            font-size: 17px;
            cursor: pointer;
            transition: background 0.3s ease;
        }
        button:hover {
            background: #0066cc;
        }
        @keyframes fadeIn {
            from { opacity: 0; transform: translateY(20px); }
            to { opacity: 1; transform: translateY(0); }
        }
        @media (max-width: 600px) {
            .form-container {
                padding: 25px;
            }
        }
    </style>
    <script>
        function validateForm() {
            let aadhaar = document.forms["applyForm"]["aadhaar"].value;
            let phone = document.forms["applyForm"]["phone"].value;
            let email = document.forms["applyForm"]["email"].value;

            // Aadhaar validation
            let aadhaarPattern = /^\d{12}$/;
            if (!aadhaarPattern.test(aadhaar)) {
                alert("Aadhaar must be exactly 12 digits.");
                return false;
            }

            // Phone validation
            let phonePattern = /^[0-9]{10}$/;
            if (!phonePattern.test(phone)) {
                alert("Phone number must be exactly 10 digits.");
                return false;
            }

            // Email validation
            let emailPattern = /^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$/;
            if (!emailPattern.test(email)) {
                alert("Please enter a valid email address.");
                return false;
            }
            return true;
        }
    </script>
</head>
<body>
<%
    String username = (String)session.getAttribute("username");
    if(username == null){
        response.sendRedirect("userLogin.jsp");
    }

    // ✅ Capture schemeId from URL (from viewSchemes.jsp)
    String selectedSchemeId = request.getParameter("schemeId");

    if("POST".equalsIgnoreCase(request.getMethod())){
        String aadhaar = request.getParameter("aadhaar");
        String phone = request.getParameter("phone");
        String email = request.getParameter("email");
        String occupation = request.getParameter("occupation");
        String schemeId = request.getParameter("scheme");

        try{
            Class.forName("com.mysql.cj.jdbc.Driver");
            Connection con = DriverManager.getConnection(
                "jdbc:mysql://localhost:3306/govtschemesdb","root","@Meera2206");

            PreparedStatement ps1 = con.prepareStatement(
                "SELECT user_id FROM users WHERE username=?");
            ps1.setString(1, username);
            ResultSet rs = ps1.executeQuery();

            if(rs.next()){
                int userId = rs.getInt("user_id");

                PreparedStatement ps2 = con.prepareStatement(
                    "INSERT INTO applications(user_id, scheme_id, aadhaar, phone, email, occupation, status) VALUES(?,?,?,?,?,?,?)"
                );
                ps2.setInt(1, userId);
                ps2.setInt(2, Integer.parseInt(schemeId));
                ps2.setString(3, aadhaar);
                ps2.setString(4, phone);
                ps2.setString(5, email);
                ps2.setString(6, occupation);
                ps2.setString(7, "Pending");
                ps2.executeUpdate();

                out.println("<script>alert('Application submitted successfully!'); window.location='viewApplications.jsp';</script>");
            } else {
                out.println("<script>alert('Session expired. Please login again.'); window.location='userLogin.jsp';</script>");
            }
            con.close();
        }catch(Exception e){
            out.println("Error: "+e.getMessage());
        }
    }
%>

<div class="form-container">
    <h2>Apply for Scheme</h2>
    <p class="welcome">Welcome, <b><%=username%></b></p>

    <form name="applyForm" method="post" onsubmit="return validateForm()">
        <div class="form-group">
            <input type="text" name="aadhaar" maxlength="12" required placeholder=" " pattern="\d{12}" title="Aadhaar must be 12 digits">
            <label>Aadhaar Number</label>
        </div>

        <div class="form-group">
            <input type="text" name="phone" maxlength="10" required placeholder=" " pattern="\d{10}" title="Phone must be 10 digits">
            <label>Phone Number</label>
        </div>

        <div class="form-group">
            <input type="email" name="email" required placeholder=" " title="Enter a valid email address">
            <label>Email</label>
        </div>

        <!-- ✅ Added Occupation Dropdown -->
        <div class="form-group">
            <select name="occupation" required>
                <option value="" disabled selected></option>
                <option value="Student">Student</option>
                <option value="Retired">Working Professional</option>
                <option value="Farmer">Farmer</option>
                <option value="Government Employee">Government Employee</option>
                <option value="Private Employee">Private Employee</option>
                <option value="Self-Employed">Self-Employed</option>
                <option value="Unemployed">Unemployed</option>
                <option value="Retired">Retired</option>
                <option value="Retired">Others</option>
            </select>
            <label>Select Occupation</label>
        </div>

        <!-- ✅ Scheme Dropdown with Auto-select -->
        <div class="form-group">
            <select name="scheme" required>
                <option value="" disabled>Select a Scheme</option>
                <%
                    try{
                        Class.forName("com.mysql.cj.jdbc.Driver");
                        Connection con = DriverManager.getConnection(
                            "jdbc:mysql://localhost:3306/govtschemesdb","root","@Meera2206");
                        Statement st = con.createStatement();
                        ResultSet rs = st.executeQuery("SELECT scheme_id, scheme_name FROM schemes");
                        while(rs.next()){
                            int id = rs.getInt("scheme_id");
                            String schemeName = rs.getString("scheme_name");
                            String selected = (selectedSchemeId != null && selectedSchemeId.equals(String.valueOf(id))) ? "selected" : "";
                %>
                    <option value="<%=id%>" <%=selected%>><%=schemeName%></option>
                <%
                        }
                        con.close();
                    }catch(Exception e){
                        out.println("Error: "+e.getMessage());
                    }
                %>
            </select>
            <label>Select Scheme</label>
        </div>

        <button type="submit">Submit Application</button>
    </form>
</div>
</body>
</html>
