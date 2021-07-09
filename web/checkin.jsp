<%--
  Created by IntelliJ IDEA.
  User: suyong
  Date: 2021/07/07
  Time: 9:41 오전
  To change this template use File | Settings | File Templates.
--%>

<%@ page import = "java.util.*" %>
<%@ page import = "java.util.regex.*" %>
<%@ page import = "java.sql.*" %>
<%@ page import = "javax.servlet.http.HttpServletRequest.*" %>
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
    String ver = "";
    String model = "";
    String ip = "";
    String splrate = "";
    String interval_value = "";
    String tags[] = null;
    String xmlResponse = "<xml>";
    xmlResponse += "<root><ack>";
    String xmlOk = "ok";
    Boolean macCheck = true;

    Map<String, String[]> parameters = request.getParameterMap();

    //System.out.println("----------------------------CHECKIN.JSP----------------------------");
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
        else if (key.toUpperCase().equals("VER")) ver = replaceValidParam(value);
        else if (key.toUpperCase().equals("MODEL")) model = replaceValidParam(value);
        else if (key.toUpperCase().equals("IP")) {
            if (Pattern.matches("([0-9]{1,3})\\.([0-9]{1,3})\\.([0-9]{1,3})\\.([0-9]{1,3})", value) == true) {
                System.out.println("IP VALUE WHAT ? : " + value);
                ip = value;
            }
            else {
                macCheck = false;
                break;
            }
        }
        else if (key.toUpperCase().equals("SPLRATE")) splrate = replaceValidParam(value);
        else if (key.toUpperCase().equals("INTERVAL")) interval_value = replaceValidParam(value);
        else if (key.toUpperCase().equals("TAGS")) {
            String str = replaceValidParam(value);
            String elems[] = str.split("\\|");
            List<String> listTags = new ArrayList<String>();
            for (int i = 0 ; i < elems.length ; i++)
                listTags.add(elems[i]);

            tags = new String[listTags.size()];
            listTags.toArray(tags);
        }
    }

    /*
    System.out.println("macCheck : " + macCheck);
    System.out.println("mac : " + mac);
    System.out.println("model : " + model);
    System.out.println("ip : " + ip);
    */
    if ((macCheck == true) && (!mac.equals("") && mac != null) && (!model.equals("") && model != null) && (!ip.equals("") && ip != null)) {
        try {

            DriverManager.registerDriver(new com.mysql.cj.jdbc.Driver());
            String url = "jdbc:mysql://localhost:3306/tomcat?serverTimezone=UTC";
            String userName = "root";
            String password = "";

            Connection con = DriverManager.getConnection(url, userName, password);
            Statement st = con.createStatement();

            String sql = "SELECT COUNT(1) FROM RN400_DEVICEINFO WHERE MAC='" + mac + "'";
            ResultSet rs = st.executeQuery(sql);

            //System.out.println("EXCEPTION OUT !!!!!!!! : " + rs.getRow());
            if (rs.next() && rs.getInt(1) > 0) {
                //System.out.println("EXCEPTION IN !!!!!!!!");
                sql = "UPDATE RN400_DEVICEINFO SET MODEL='" + model + "', IP='" + ip + "', VER='" + ver +
                        "', SAMPLE_RATE='" + splrate + "', INTERVAL_VALUE='" + interval_value + "', " +
                        "CH1_TAG_NAME='" + tags[0] + "', CH2_TAG_NAME='" + tags[1] + "', CH3_TAG_NAME='" + tags[2] +
                        "', CH4_TAG_NAME='" + tags[3] + "', CH5_TAG_NAME='" + tags[4] + "', CH6_TAG_NAME='" + tags[5] + "' " +
                        "WHERE MAC='" + mac + "'";
            }
            else {
                sql = "INSERT INTO RN400_DEVICEINFO " +
                        "(MAC, MODEL, IP, VER, SAMPLE_RATE, INTERVAL_VALUE, CH1_TAG_NAME, CH2_TAG_NAME, CH3_TAG_NAME, CH4_TAG_NAME, CH5_TAG_NAME, CH6_TAG_NAME) " +
                        "VALUES ('" + mac + "', '" + model + "', '" + ip + "', '" + ver + "', '" + splrate + "', '" + interval_value + "', '" +
                        tags[0] + "', '" + tags[1] + "', '" + tags[2] + "', '" + tags[3] + "', '" + tags[4] + "', '" + tags[5] + "')";
            }

            st.execute(sql);

            rs.close();
            st.close();
            con.close();
        } catch (SQLException se) {
            xmlOk = "error SQLException";
            se.printStackTrace();
        } catch (Exception e) {
            xmlOk = "error Exception";
            e.printStackTrace();
        }
    } else xmlOk = "No Database error";

    xmlResponse += xmlOk;
    xmlResponse += "</ack>";
    xmlResponse += "<timestamp>";
    xmlResponse += System.currentTimeMillis() / 1000L;
    xmlResponse += "</timestamp>";
    xmlResponse += "</root></xml>";

    response.setContentType("text/xml");
    out.println(xmlResponse);
%>
