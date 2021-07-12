<%--
  Created by IntelliJ IDEA.
  User: suyong
  Date: 2021/07/12
  Time: 4:40 오후
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
</head>
<body>
<%
    String insert_time = application.getAttribute("timestamp").toString();
    String Ok = application.getAttribute("is_ok").toString();
%>
<script>
    let is_ok = '<%=Ok%>';
    let timestamp = '<%=insert_time%>';

    if(is_ok == 'ok')
        alert("SUCCESS !\n" + "timestamp : " + timestamp);
    else
        alert("Fail !\n" + "Caused by : " + is_ok + "\n" + "timestamp : " + timestamp);
    location.href="showDatabase.jsp";
</script>
</body>
</html>
