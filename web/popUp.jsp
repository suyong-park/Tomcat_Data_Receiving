<%--
  Created by IntelliJ IDEA.
  User: suyong
  Date: 2021/07/14
  Time: 1:55 오후
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <!-- Compiled and minified CSS -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/materialize/1.0.0/css/materialize.min.css">
    <!-- Compiled and minified JavaScript -->
    <script src="https://cdnjs.cloudflare.com/ajax/libs/materialize/1.0.0/js/materialize.min.js"></script>
    <!--Import Google Icon Font-->
    <link href="https://fonts.googleapis.com/icon?family=Material+Icons" rel="stylesheet">

    <script type="text/javascript" src="https://code.jquery.com/jquery-3.6.0.js"></script>

    <meta charset="UTF-8">
    <title>Set Up</title>

    <link rel="stylesheet" href="style_popup.css">
</head>
<body>
<h5 class="align">Setting</h5>
<br>

<form method="post" action="showDatabase.jsp" id="setting_data">

    <div class="row">
        <div class="input-field col s10">
            <input disabled value="" id="disabled" type="text" class="validate" name="disabled">
            <label for="disabled">MAC</label>
        </div>
    </div>

    <script>
        let mac = opener.$('#device_list option:selected').text();
        $('input[name=disabled]').attr('value', mac);
    </script>

    <div class="row">
        <div class="input-field col s10">
            <input id="ch1" type="text" name="ch1">
            <label for="ch1">CH1_DATA_VALUE THRESHOLD</label>
        </div>
    </div>

    <div class="row">
        <div class="input-field col s10">
            <input id="ch2" type="text" name="ch2">
            <label for="ch2">CH2_DATA_VALUE THRESHOLD</label>
        </div>
    </div>

    <div class="row">
        <div class="input-field col s10">
            <input id="ch3" type="text" name="ch3">
            <label for="ch3">CH3_DATA_VALUE THRESHOLD</label>
        </div>
    </div>

    <div class="row">
        <div class="input-field col s10">
            <input id="ch4" type="text" name="ch4">
            <label for="ch4">CH4_DATA_VALUE THRESHOLD</label>
        </div>
    </div>

    <div class="row">
        <div class="input-field col s10">
            <input id="ch5" type="text" name="ch5">
            <label for="ch5">CH5_DATA_VALUE THRESHOLD</label>
        </div>
    </div>

    <div class="row">
        <div class="input-field col s10">
            <input id="ch6" type="text" name="ch6">
            <label for="ch6">CH6_DATA_VALUE THRESHOLD</label>
        </div>
    </div>

    <div class="row">
        <div class="input-field col s10">
            <input id="transmission" type="text" name="transmission">
            <label for="transmission">TRANSMISSION CYCLE</label>
        </div>
    </div>

    <div class="row">
        <div class="input-field col s10">
            <input id="censoring" type="text" name="censoring">
            <label for="censoring">CENSORING CYCLE</label>
        </div>
    </div>

    <div class="input-field col s10">
        <button class="btn waves-effect waves-light" type="submit" name="button" form="setting_data" id="btn_setup" onclick="onClose()">SET UP
            <i class="material-icons right">send</i>
        </button>
    </div>
</form>
<script>
    function onClose() {
        window.close();
    }
</script>
</body>
</html>
