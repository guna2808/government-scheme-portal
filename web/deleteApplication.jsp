<%@page import="java.sql.*"%>
<%
String appId = request.getParameter("id");

try{
    Class.forName("com.mysql.cj.jdbc.Driver");
    Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/govtschemesdb","root","@Meera2206");
    PreparedStatement ps = con.prepareStatement("DELETE FROM applications WHERE application_id=?");
    ps.setInt(1, Integer.parseInt(appId));
    int i = ps.executeUpdate();
    con.close();
   if(i>0){
    response.sendRedirect("message.jsp?type=success&msg=Application+deleted+successfully!");
} else {
    response.sendRedirect("message.jsp?type=error&msg=Failed+to+delete+application.");
}

}catch(Exception e){ out.println(e); }
%>
