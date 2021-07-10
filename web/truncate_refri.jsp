<%--
  Created by IntelliJ IDEA.
  User: suyong
  Date: 2021/07/09
  Time: 5:21 오후
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import = "java.sql.*" %>

<%
    boolean is_success;
    try {
        DriverManager.registerDriver(new com.mysql.cj.jdbc.Driver());
        String url = "jdbc:mysql://localhost:3306/tomcat?serverTimezone=UTC";
        String userName = "root";
        String password = "";

        Connection con = DriverManager.getConnection(url, userName, password);

        Statement st = con.createStatement();

        String sql = "TRUNCATE TABLE RN400_REFRIGERRATOR;";

        st.executeUpdate(sql);

        is_success = true;
    } catch (SQLException e) {
        e.printStackTrace();
        is_success = false;
    }
%>
<script>
    let is_success = <%=is_success%>;
    if(is_success)
        alert("SUCCESS !");
    else
        alert("Truncate Fail !");
    location.href="Show_Database.jsp";
</script>
