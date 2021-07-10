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
    try {
        DriverManager.registerDriver(new com.mysql.cj.jdbc.Driver());
        String url = "jdbc:mysql://localhost:3306/tomcat?serverTimezone=UTC";
        String userName = "root";
        String password = "";

        Connection con = DriverManager.getConnection(url, userName, password);

        Statement st = con.createStatement();

        String sql = "TRUNCATE TABLE RN400_REFRIGERRATOR;";

        st.executeUpdate(sql);

    } catch (SQLException e) {
        e.printStackTrace();
    }
%>
<html>
<head>
    <title>Truncate</title>
</head>
<body>
<jsp:forward page="Show_Database.jsp" />
</body>
</html>
