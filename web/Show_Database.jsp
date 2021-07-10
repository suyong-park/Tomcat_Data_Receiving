<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import = "java.sql.*" %>

<html>
  <head>
    <title>DATABASE CHECK</title>
  </head>
  <body>
  <h1>DATABASE CHECK</h1>
  <h3>RN400_DEVICEINFO</h3>
  <table border = "1">
    <tr align="center">
      <td>MAC</td>
      <td>MODEL</td>
      <td>IP</td>
      <td>VER</td>
      <td>SAMPLE_RATE</td>
      <td>INTERVAL_VALUE</td>
      <td>CH1_TAG_NAME</td>
      <td>CH2_TAG_NAME</td>
      <td>CH3_TAG_NAME</td>
      <td>CH4_TAG_NAME</td>
      <td>CH5_TAG_NAME</td>
      <td>CH6_TAG_NAME</td>
    </tr>
<%
    try {
      DriverManager.registerDriver(new com.mysql.cj.jdbc.Driver());
      String url = "jdbc:mysql://localhost:3306/tomcat?serverTimezone=UTC";
      String userName = "root";
      String password = "";

      Connection con = DriverManager.getConnection(url, userName, password);

      Statement st_device = con.createStatement();
      Statement st_refrigerator = con.createStatement();

      String sql_device_info = "SELECT * FROM RN400_DEVICEINFO";
      String sql_refrigerator = "SELECT * FROM RN400_REFRIGERRATOR";

      ResultSet rs_device = st_device.executeQuery(sql_device_info);
      ResultSet rs_refrigerator = st_refrigerator.executeQuery(sql_refrigerator);

      while(rs_device.next()) {
%>
    <tr>
      <td><%= rs_device.getString("MAC") %></td>
      <td><%= rs_device.getString("MODEL") %></td>
      <td><%= rs_device.getString("IP") %></td>
      <td><%= rs_device.getString("VER") %></td>
      <td><%= rs_device.getString("SAMPLE_RATE") %></td>
      <td><%= rs_device.getString("INTERVAL_VALUE") %></td>
      <td><%= rs_device.getString("CH1_TAG_NAME") %></td>
      <td><%= rs_device.getString("CH2_TAG_NAME") %></td>
      <td><%= rs_device.getString("CH3_TAG_NAME") %></td>
      <td><%= rs_device.getString("CH4_TAG_NAME") %></td>
      <td><%= rs_device.getString("CH5_TAG_NAME") %></td>
      <td><%= rs_device.getString("CH6_TAG_NAME") %></td>
<%
      }
%>
    </tr>
  </table>
  <br>
  <input type="button" name="truncate" value="truncate" onclick="location='truncate_device.jsp'">
  <br>

  <h3>RN400_REFRIGERRATOR</h3>
  <table border = "1">
    <tr align="center">
      <td>TIMESTAMP_VALUE</td>
      <td>MAC</td>
      <td>MODEL</td>
      <td>IP</td>
      <td>SAMPLE_RATE</td>
      <td>INTERVAL_VALUE</td>
      <td>WIRELESS_SIGNAL</td>
      <td>CH1_TAG_NAME</td>
      <td>CH1_DATE_VALUE</td>
      <td>CH2_TAG_NAME</td>
      <td>CH2_DATE_VALUE</td>
      <td>CH3_TAG_NAME</td>
      <td>CH3_DATE_VALUE</td>
      <td>CH4_TAG_NAME</td>
      <td>CH4_DATE_VALUE</td>
      <td>CH5_TAG_NAME</td>
      <td>CH5_DATE_VALUE</td>
      <td>CH6_TAG_NAME</td>
      <td>CH6_DATE_VALUE</td>
      <td>DATETIME</td>
    </tr>
<%
    while(rs_refrigerator.next()) {
%>
    <tr>
      <td><%= rs_refrigerator.getString("TIMESTAMP_VALUE") %></td>
      <td><%= rs_refrigerator.getString("MAC") %></td>
      <td><%= rs_refrigerator.getString("MODEL") %></td>
      <td><%= rs_refrigerator.getString("IP") %></td>
      <td><%= rs_refrigerator.getString("SAMPLE_RATE") %></td>
      <td><%= rs_refrigerator.getString("INTERVAL_VALUE") %></td>
      <td><%= rs_refrigerator.getString("WIRELESS_SIGNAL") %></td>
      <td><%= rs_refrigerator.getString("CH1_TAG_NAME") %></td>
      <td><%= rs_refrigerator.getString("CH1_DATE_VALUE") %></td>
      <td><%= rs_refrigerator.getString("CH2_TAG_NAME") %></td>
      <td><%= rs_refrigerator.getString("CH2_DATE_VALUE") %></td>
      <td><%= rs_refrigerator.getString("CH3_TAG_NAME") %></td>
      <td><%= rs_refrigerator.getString("CH3_DATE_VALUE") %></td>
      <td><%= rs_refrigerator.getString("CH4_TAG_NAME") %></td>
      <td><%= rs_refrigerator.getString("CH4_DATE_VALUE") %></td>
      <td><%= rs_refrigerator.getString("CH5_TAG_NAME") %></td>
      <td><%= rs_refrigerator.getString("CH5_DATE_VALUE") %></td>
      <td><%= rs_refrigerator.getString("CH6_TAG_NAME") %></td>
      <td><%= rs_refrigerator.getString("CH6_DATE_VALUE") %></td>
      <td><%= rs_refrigerator.getString("DATETIME") %></td>
    </tr>
<%
    }
%>
  </table>
  <br>
  <input type="button" name="truncate" value="truncate" onclick="location='truncate_refri.jsp'">

  <br>
  <br>

  <h4>Check-in POST</h4>
  <form name="checkin" method="post" action="checkin.jsp">
    <div>
      <table>
        <tr align="center">
          <td>mac</td>
          <td>ver</td>
          <td>model</td>
          <td>ip</td>
          <td>splrate</td>
          <td>interval</td>
          <td>tags</td>
        </tr>
        <tr>
          <td><input type="text" name="mac"></td>
          <td><input type="text" name="ver"></td>
          <td><input type="text" name="model"></td>
          <td><input type="text" name="ip"></td>
          <td><input type="text" name="splrate"></td>
          <td><input type="text" name="interval"></td>
          <td><input type="text" name="tags"></td>
        </tr>
      </table>
    </div>
    <br>
    <div>
      <input type="submit" name="button" value="CHECK-IN">
    </div>
  </form>

  <br>

  <h4>Data-in POST</h4>
  <form name="datain" method="post" action="datain.jsp">
    <div>
      <table>
        <tr align="center">
          <td>mac</td>
          <td>sig</td>
          <td>bat</td>
          <td>volt</td>
          <td>model</td>
          <td>C000</td>
          <td>P000</td>
          <td>P001</td>
        </tr>
        <tr>
          <td><input type="text" name="mac"></td>
          <td><input type="text" name="sig"></td>
          <td><input type="text" name="bat"></td>
          <td><input type="text" name="volt"></td>
          <td><input type="text" name="smodel"></td>
          <td><input type="text" name="C000"></td>
          <td><input type="text" name="P000"></td>
          <td><input type="text" name="P001"></td>
        </tr>
      </table>
    </div>
    <br>
    <div>
      <input type="submit" name="button" value="DATA-IN">
    </div>
  </form>
<%
    rs_device.close();
    st_device.close();
    rs_refrigerator.close();
    st_refrigerator.close();

    con.close();

  } catch (SQLException e) {
    System.out.println("SQL EXCEPTION");
    e.printStackTrace();
  } catch (Exception e) {
    System.out.println("EXCEPTION");
    e.printStackTrace();
  }
%>
  </body>
</html>