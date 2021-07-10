<%--
  Created by IntelliJ IDEA.
  User: suyong
  Date: 2021/07/07
  Time: 9:41 오전
  To change this template use File | Settings | File Templates.
--%>

<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import = "java.util.*" %>
<%@ page import = "java.util.regex.*" %>
<%@ page import = "java.sql.*" %>
<%@ page import = "javax.sql.*" %>
<%@ page import = "org.apache.commons.lang.StringEscapeUtils" %>
<%!
    public String replaceValidParam(String str) {
        String retVal = str;
        retVal = retVal.replaceAll("%", "");
        retVal = retVal.replaceAll("'", "");
        retVal = retVal.replaceAll("`", "");
        retVal = retVal.replaceAll("\n", "");
        retVal = retVal.replaceAll("\r", "");
        retVal = retVal.replaceAll("\t", "");
        retVal = retVal.replaceAll("\\\\", "");
        retVal = retVal.replaceAll("[?]", "");
        retVal = retVal.replaceAll("\\(", "");
        retVal = retVal.replaceAll("\\)", "");
        retVal = retVal.replaceAll(";", "");
        retVal = retVal.replaceAll("@", "");
        retVal = retVal.replaceAll("[$]", "");
        retVal = retVal.replaceAll("[*]", "");
        retVal = retVal.replaceAll("\\^", "");
        return retVal;
    }
%>
<%
    String mac = "";
    String sig = "";
    String bat = "";
    String smodel = "";
    String Ok = "ok";
    Map<String, String[]> sensorValues = new HashMap<String, String[]>();
    Boolean macCheck = true;

    //System.out.println("----------------------------DATAIN.JSP----------------------------");

    Map<String, String[]> parameters = request.getParameterMap();

    //System.out.println("parameters.keySet() : " + parameters.keySet());

    for(String key : parameters.keySet()) {
        String value = StringEscapeUtils.escapeHtml(parameters.get(key)[0]);

        //System.out.println("value : " + value);

        if (key.toUpperCase().equals("MAC")) {
            if (Pattern.matches("(^[a-zA-Z0-9]*$)", value) == true)
                mac = value;
            else {
                macCheck = false;
                break;
            }
        }
        else if (key.toUpperCase().equals("SIG")) sig = replaceValidParam(value);
        else if (key.toUpperCase().equals("BAT")) bat = replaceValidParam(value);
        else if (key.toUpperCase().equals("SMODEL")) smodel = replaceValidParam(value);
        else if (Pattern.matches("(^C\\d{3}$)", key.toUpperCase())) {
            String str = replaceValidParam(value);
            String elems[] = str.split("\\|");
            String timestamp = elems[0];
            List<String> listValues = new ArrayList<String>();
            for (int i = 1 ; i < elems.length ; i++)
                listValues.add(elems[i]);

            String values[] = new String[listValues.size()];
            listValues.toArray(values);
            sensorValues.put(timestamp, values);
        }
        else if (Pattern.matches("(^P\\d{3}$)", key.toUpperCase())) {
            String str = replaceValidParam(value);
            String elems[] = str.split("\\|");
            String timestamp = elems[0];
            List<String> listValues = new ArrayList<String>();
            for (int i = 1 ; i < elems.length ; i++)
                listValues.add(elems[i]);

            String values[] = new String[listValues.size()];
            listValues.toArray(values);
            sensorValues.put(timestamp, values);
        }
    }

    //System.out.println("macCheck : " + macCheck);
    //System.out.println("mac : " + mac);

    if ((macCheck == true) && (!mac.equals("") && mac != null)) {
        try{

            DriverManager.registerDriver(new com.mysql.cj.jdbc.Driver());

            String url = "jdbc:mysql://localhost:3306/tomcat?serverTimezone=UTC";
            String userName = "root";
            String password = "";

            Connection con = DriverManager.getConnection(url, userName, password);
            Statement st = con.createStatement();

            ResultSet rs = st.executeQuery("SELECT * FROM RN400_DEVICEINFO WHERE MAC='" + mac + "'");
            if (rs.next()) {
                String sample_rate = rs.getString("SAMPLE_RATE");
                String interval_value = rs.getString("INTERVAL_VALUE");
                String ipaddr = rs.getString("IP");
                String tag_names[] = { rs.getString("CH1_TAG_NAME"), rs.getString("CH2_TAG_NAME"), rs.getString("CH3_TAG_NAME"),
                        rs.getString("CH4_TAG_NAME"), rs.getString("CH5_TAG_NAME"), rs.getString("CH6_TAG_NAME") };

                String sql = "INSERT INTO RN400_REFRIGERRATOR " +
                        "(TIMESTAMP_VALUE, MAC, MODEL, IP, SAMPLE_RATE, INTERVAL_VALUE, WIRELESS_SIGNAL, " +
                        "CH1_TAG_NAME, CH1_DATE_VALUE, CH2_TAG_NAME, CH2_DATE_VALUE, CH3_TAG_NAME, CH3_DATE_VALUE, " +
                        "CH4_TAG_NAME, CH4_DATE_VALUE, CH5_TAG_NAME, CH5_DATE_VALUE, CH6_TAG_NAME, CH6_DATE_VALUE, " +
                        "DATETIME) ";
                int cnt = 0;
                for (String key : sensorValues.keySet()) {
                    String values[] = sensorValues.get(key);
                    int timestamp = Integer.parseInt(key);

                    String up_sql = "SELECT COUNT(1) FROM RN400_REFRIGERRATOR WHERE TIMESTAMP_VALUE=" + timestamp + " AND MAC='" + mac + "'";
                    ResultSet chk_rs = st.executeQuery(up_sql);

                    if (chk_rs.next() && chk_rs.getInt(1) > 0) {
                        up_sql = "UPDATE RN400_REFRIGERRATOR SET SAMPLE_RATE='" + sample_rate + "', INTERVAL_VALUE='" + interval_value + "', WIRELESS_SIGNAL='" + sig + "'";
                        for (int i = 0 ; i < 6 ; i++) {
                            up_sql += ", CH" + (i + 1) + "_TAG_NAME='" + tag_names[i] + "', CH" + (i + 1) + "_DATE_VALUE='";
                            if (i < values.length)
                                up_sql += values[i] + "'";
                            else
                                up_sql += "'";
                        }
                        up_sql += " WHERE TIMESTAMP_VALUE=" + timestamp + " AND MAC='" + mac + "'";
                        st.execute(up_sql);
                    }
                    else {
                        //System.out.println("ELSE AREA, CNT : " + cnt);
                        if (cnt > 0)
                            sql += " UNION ALL ";
                        sql += "SELECT " + timestamp + ", '" + mac + "', '" + smodel + "', '" + ipaddr + "', '" + sample_rate + "', '" + interval_value + "', '" + sig + "'";
                        for (int i = 0 ; i < 6 ; i++) {
                            sql += ", '" + tag_names[i] + "', '";
                            if (i < values.length)
                                sql += values[i] + "'";
                            else sql += "'";
                        }

                        sql += ", DATE_FORMAT(FROM_UNIXTIME(";
                        sql += timestamp;
                        sql += "), '%Y-%m-%d %H:%i:%s');";

                        //System.out.println(sql);
                        cnt++;
                    }
                    chk_rs.close();
                }

                if (cnt > 0) st.execute(sql);
            }
            else Ok = "Error : please check your value.";

            rs.close();
            st.close();
            con.close();
        } catch (SQLException e) {
            Ok = e.getMessage();
            e.printStackTrace();
        } catch (Exception e) {
            Ok = e.getMessage();
            e.printStackTrace();
        }
    } else Ok = "Insufficient argument value or Inappropriate input or No Database Error";
%>
<script>
    let is_ok = '<%=Ok%>';
    let timestamp = + new Date();

    if(is_ok == 'ok')
        alert("Data-in SUCCESS !\n" + "timestamp : " + timestamp);
    else
        alert("Data-in Fail !\n" + "Caused by : " + is_ok + "\n" + "timestamp : " + timestamp);
    location.href="Show_Database.jsp";
</script>