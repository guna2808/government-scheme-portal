<%@page import="java.sql.*"%>
<%
String appId = request.getParameter("application_id");
String status = request.getParameter("status");

try{
    Class.forName("com.mysql.cj.jdbc.Driver");
    Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/govtschemesdb","root","@Meera2206");
    PreparedStatement ps = con.prepareStatement("UPDATE applications SET status=? WHERE application_id=?");
    ps.setString(1, status);
    ps.setInt(2, Integer.parseInt(appId));
    int i = ps.executeUpdate();
    con.close();
    if(i>0){
    response.sendRedirect("message.jsp?type=success&msg=Application+status+updated+successfully!");
} else {
    response.sendRedirect("message.jsp?type=error&msg=Failed+to+update+application.");
}

}catch(Exception e){ out.println(e); }

%>
