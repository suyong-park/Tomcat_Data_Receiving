<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import = "java.sql.*" %>

<html>
<head>
    <!-- Compiled and minified CSS -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/materialize/1.0.0/css/materialize.min.css">
    <!-- Compiled and minified JavaScript -->
    <script src="https://cdnjs.cloudflare.com/ajax/libs/materialize/1.0.0/js/materialize.min.js"></script>
    <title>DATABASE CHECK</title>

    <!--Import Google Icon Font-->
    <link href="https://fonts.googleapis.com/icon?family=Material+Icons" rel="stylesheet">

    <!--Let browser know website is optimized for mobile-->
    <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
    <style>
        * {margin-left: 20px;}
        .bold {font-weight: 700}
        .highlight {border: 3px solid}
        .align {text-align: center}
        .row {display: inline-block}
        .rows_horizontal {display: inline-block}
        #btn_device {
            background: white;
            color: mediumblue;
        }
        #btn_refri {
            background: white;
            color: mediumblue;
        }
        #btn_checkin {
            background: white;
            color: mediumblue;
            alignment: center;
        }
        #btn_datain {
            background: white;
            color: mediumblue;
            alignment: center;
        }
        #btn_go_post {
            background: white;
            color: mediumblue;
        }
        #btn_go_top {
            background: white;
            color: mediumblue;
        }
        #check-in-div {
            border: 1px solid;
            border-radius: 2em;
            color: black;
        }
        #data-in-div {
            border: 1px solid;
            border-radius: 2em;
            color: black;
        }
        #main_title {
            color: black;
        }
        #datetime {padding: 20px}
        td {padding: 15px}
        .horizontal, a {display: inline-block}
    </style>
</head>
<body>
    <a name="top">
        <h3 class="horizontal" id="main_title">DATABASE CHECK RN400 with DEKIST</h3>
    </a>
    <a class="waves-effect waves-light btn-large" href="#target" id="btn_go_post">BOTTOM</a>
    <br>
<%
    try {
        DriverManager.registerDriver(new com.mysql.cj.jdbc.Driver());
        String url = "jdbc:mysql://localhost:3306/tomcat?serverTimezone=UTC";
        String userName = "root";
        String password = "";

        Connection con = DriverManager.getConnection(url, userName, password);

        Statement st_device = con.createStatement();
        Statement st_refrigerator = con.createStatement();
        Statement st_cnt_refrigerator = con.createStatement();
        Statement st_cnt_device = con.createStatement();

        String sql_device_info = "SELECT * FROM RN400_DEVICEINFO";
        String sql_refrigerator = "SELECT * FROM RN400_REFRIGERRATOR";
        String sql_cnt_device = "SELECT COUNT(*) FROM RN400_DEVICEINFO";
        String sql_cnt_refrigerator = "SELECT COUNT(*) FROM RN400_REFRIGERRATOR";

        ResultSet rs_device = st_device.executeQuery(sql_device_info);
        ResultSet rs_refrigerator = st_refrigerator.executeQuery(sql_refrigerator);
        ResultSet rs_cnt_device = st_cnt_device.executeQuery(sql_cnt_device);
        ResultSet rs_cnt_refrigerator = st_cnt_refrigerator.executeQuery(sql_cnt_refrigerator);

        if(rs_cnt_device.next()) {}
%>
    <h5 class="rows_horizontal">RN400_DEVICEINFO</h5>
    Rows : <%= rs_cnt_device.getInt(1) %>
    <table class="highlight">
        <thead class="bold">
            <tr>
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
        </thead>
<%
        while(rs_device.next()) {
%>
        <tbody>
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
        </tbody>
    </table>
    <br>
    <a class="waves-effect waves-light btn-small" onclick="check_del_device()" id="btn_device">truncate</a>

    <br>
    <br>
<%
        if(rs_cnt_refrigerator.next()) {}
%>
    <h5 class="rows_horizontal">RN400_REFRIGERRATOR</h5>
    Rows : <%= rs_cnt_refrigerator.getInt(1) %>
    <table class="highlight">
        <thead class="bold">
            <tr>
                <td>TIMESTAMP_VALUE</td>
                <td>MAC</td>
                <td>MODEL</td>
                <td>IP</td>
                <td>SAMPLE_RATE</td>
                <td>INTERVAL_VALUE</td>
                <td>WIRELESS_SIGNAL</td>
                <td>CH1_TAG_NAME</td>
                <td>CH1_DATA_VALUE</td>
                <td>CH2_TAG_NAME</td>
                <td>CH2_DATA_VALUE</td>
                <td>CH3_TAG_NAME</td>
                <td>CH3_DATA_VALUE</td>
                <td>CH4_TAG_NAME</td>
                <td>CH4_DATA_VALUE</td>
                <td>CH5_TAG_NAME</td>
                <td>CH5_DATA_VALUE</td>
                <td>CH6_TAG_NAME</td>
                <td>CH6_DATA_VALUE</td>
                <td id="datetime">DATETIME</td>
            </tr>
        </thead>
<%
        while(rs_refrigerator.next()) {
%>
        <tbody>
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
        </tbody>
<%
        }
%>
    </table>
    <br>

    <a class="waves-effect waves-light btn-small" onclick="check_del_refri()" id="btn_refri">truncate</a>

    <br>
    <br>

    <a name="target"/>
    <div>
        <div id="check-in-div">
            <h6 class="align">Check-in POST</h6>
            <form method="post" action="checkin.jsp" id="CHECK-IN">

                <div class="row">
                    <div class="input-field col s10">
                        <input id="textarea1_check" type="text" name="mac">
                        <label for="textarea1_check">MAC</label>
                    </div>
                </div>

                <div class="row">
                    <div class="input-field col s10">
                        <input id="textarea2_check" type="text" name="ver">
                        <label for="textarea2_check">VER</label>
                    </div>
                </div>

                <div class="row">
                    <div class="input-field col s10">
                        <input id="textarea3_check" type="text" name="model">
                        <label for="textarea3_check">MODEL</label>
                    </div>
                </div>

                <div class="row">
                    <div class="input-field col s10">
                        <input id="textarea4_check" type="text" name="ip">
                        <label for="textarea4_check">IP</label>
                    </div>
                </div>

                <div class="row">
                    <div class="input-field col s10">
                        <input id="textarea5_check" type="text" name="splrate">
                        <label for="textarea5_check">SPLRATE</label>
                    </div>
                </div>

                <div class="row">
                    <div class="input-field col s10">
                        <input id="textarea6_check" type="text" name="interval">
                        <label for="textarea6_check">INTERVAL</label>
                    </div>
                </div>

                <div class="row">
                    <div class="input-field col s10">
                        <input id="textarea7_check" type="text" name="tags">
                        <label for="textarea7_check">TAGS</label>
                    </div>
                </div>

                <div class="input-field col s10">
                    <button class="btn waves-effect waves-light" type="submit" form="CHECK-IN" id="btn_checkin">CHECK-IN
                        <i class="material-icons right">send</i>
                    </button>
                </div>
            </form>
        </div>

        <br>

        <div id="data-in-div">
            <h6 class="align">Data-in POST</h6>
            <form method="post" action="datain.jsp" id="DATA-IN">

                <div class="row">
                    <div class="input-field col s10">
                        <textarea id="textarea1" class="materialize-textarea" name="mac"></textarea>
                        <label for="textarea1">MAC</label>
                    </div>
                </div>

                <div class="row">
                    <div class="input-field col s10">
                        <textarea id="textarea2" class="materialize-textarea" name="sig"></textarea>
                        <label for="textarea2">SIG</label>
                    </div>
                </div>

                <div class="row">
                    <div class="input-field col s10">
                        <textarea id="textarea3" class="materialize-textarea" name="bat"></textarea>
                        <label for="textarea3">BAT</label>
                    </div>
                </div>

                <div class="row">
                    <div class="input-field col s10">
                        <textarea id="textarea4" class="materialize-textarea" name="volt"></textarea>
                        <label for="textarea4">VOLT</label>
                    </div>
                </div>

                <div class="row">
                    <div class="input-field col s10">
                        <textarea id="textarea5" class="materialize-textarea" name="smodel"></textarea>
                        <label for="textarea5">MODEL</label>
                    </div>
                </div>

                <div class="row">
                    <div class="input-field col s10">
                        <textarea id="textarea6" class="materialize-textarea" name="C000"></textarea>
                        <label for="textarea6">C000</label>
                    </div>
                </div>

                <div class="row">
                    <div class="input-field col s10">
                        <textarea id="textarea7" class="materialize-textarea" name="P000"></textarea>
                        <label for="textarea7">P000</label>
                    </div>
                </div>

                <div class="row">
                    <div class="input-field col s10">
                        <textarea id="textarea8" class="materialize-textarea" name="P001"></textarea>
                        <label for="textarea8">P001</label>
                    </div>
                </div>

                <div class="input-field col s10">
                    <button class="btn waves-effect waves-light" type="submit" name="button" form="DATA-IN" id="btn_datain">DATA-IN
                        <i class="material-icons right">send</i>
                    </button>
                </div>
            </form>
        </div>
    </div>
  <br>
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
  <br>
  <script>
      setTimeout('location.reload()', 600000); // 60 minute reload
      function check_del_device() {
          if(confirm("Really Delete ?") == true)
              location='truncate_device.jsp'
          else
              return;
      }

      function check_del_refri() {
          if(confirm("Really Delete ?") == true)
              location='truncate_refri.jsp'
          else
              return;
      }
  </script>

  <div style="position: fixed; bottom: 10px; right: 10px;">
      <a class="btn-floating btn-large waves-effect waves-light" href="#top" id="btn_go_top">TOP</a>
  </div>
  </body>
</html>