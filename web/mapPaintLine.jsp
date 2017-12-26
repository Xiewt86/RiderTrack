<%--
  Created by IntelliJ IDEA.
  User: computer
  Date: 2017/12/20
  Time: 21:47
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <meta name="viewport" content="initial-scale=1.0, user-scalable=no"/>
    <style type="text/css">
        body, html, #allmap {
            width: 100%;
            height: 100%;
            overflow: hidden;
            margin: 0;
            font-family: "微软雅黑", serif;
        }
    </style>
    <script type="text/javascript"
            src="http://api.map.baidu.com/api?v=2.0&ak=0mxjSf6gGLHKmRoyuRCVl9OEklpcITq6"></script>
    <title>折线上添加方向箭头</title>
</head>
<body>
<div id="allmap"></div>
</body>
</html>
<script type="text/javascript">
    // 百度地图API功能
    var map = new BMap.Map("allmap");    // 创建Map实例
    map.centerAndZoom(new BMap.Point(116.404, 39.915), 14);  // 初始化地图,设置中心点坐标和地图级别
    map.enableScrollWheelZoom(true);     //开启鼠标滚轮缩放
    var sy = new BMap.Symbol(BMap_Symbol_SHAPE_BACKWARD_OPEN_ARROW, {
        scale: 0.6,//图标缩放大小
        strokeColor: '#fff',//设置矢量图标的线填充颜色
        strokeWeight: '2'//设置线宽
    });
    var geolocation = new BMap.Geolocation();
    var lastUpdate = "1000-00-00 00:00:00";

    window.setInterval(location1, 5000);

    var icons = new BMap.IconSequence(sy, '10', '30');
    // 创建polyline对象
    var pois = [
        new BMap.Point(116.350658, 39.938285),
        new BMap.Point(116.386446, 39.939281),
        new BMap.Point(116.389034, 39.913828),
        new BMap.Point(116.442501, 39.914603)
    ];

    var x = 116.331398;
    var y = 39.897445;

    var polyline = new BMap.Polyline(pois, {
        enableEditing: false,//是否启用线编辑，默认为false
        enableClicking: true,//是否响应点击事件，默认为true
        icons: [icons],
        strokeWeight: '8',//折线的宽度，以像素为单位
        strokeOpacity: 0.8,//折线的透明度，取值范围0 - 1
        strokeColor: "#18a45b" //折线颜色
    });

    map.addOverlay(polyline);          //增加折线
    var marker = new BMap.Marker(new BMap.Point(116.442501, 39.914603));
    map.addOverlay(marker);

    function ajax() {

        console.log("Enter ajax");

        if (window.ActiveXObject) { //IE浏览器

            xmlHttpRequest = new ActiveXObject("Microsoft.XMLHTTP");

        }
        else if (window.XMLHttpRequest) { //非IE浏览器

            xmlHttpRequest = new XMLHttpRequest;
        }

        if (null !== xmlHttpRequest) {

            var v1 = x;
            var v2 = y;

            //采用POST提交
            xmlHttpRequest.open("POST", "AjaxServlet", true);

            //Ajax的回调函数
            xmlHttpRequest.onreadystatechange = ajaxCallBack;

            //采用POST提交要设置请求头参数
            xmlHttpRequest.setRequestHeader("Content-type",
                "application/x-www-form-urlencoded");
            xmlHttpRequest.send("v1=" + v1 + "&v2=" + v2 + "&lastUpdate=" + lastUpdate);//真正的发送请求
        }
    }


    //Ajax的回调函数
    function ajaxCallBack() {

        if (xmlHttpRequest.readyState === 4) { //Ajax引擎4个阶段，4为最后一个阶段

            if (xmlHttpRequest.status === 200) {

                // Download (x, y) as well as bean of each participant.
                var responseText = xmlHttpRequest.responseText;
                var json = JSON.parse(responseText);
                lastUpdate = getNowFormatDate();
                plotLines(json);
            }
            else {
                alert("Server error!");
            }

        }
    }

    function location1() {
        geolocation.getCurrentPosition(function (r) {
            if (this.getStatus() === BMAP_STATUS_SUCCESS) {
                var mk = new BMap.Marker(r.point);
                map.addOverlay(mk);
                map.panTo(r.point);
                x = r.point.lng;
                y = r.point.lat;
                ajax();
            }
            else {
                alert('failed' + this.getStatus());
            }
        }, {enableHighAccuracy: true});
    }

    function getNowFormatDate() {
        var date = new Date();
        var seperator1 = "-";
        var seperator2 = ":";
        var month = date.getMonth() + 1;
        var strDate = date.getDate();
        if (month >= 1 && month <= 9) {
            month = "0" + month;
        }
        if (strDate >= 0 && strDate <= 9) {
            strDate = "0" + strDate;
        }
        return date.getFullYear() + seperator1 + month + seperator1 + strDate
            + " " + date.getHours() + seperator2 + date.getMinutes()
            + seperator2 + date.getSeconds();
    }

    function plotLines(json) {
        for (var k in json) {
            var points = json[k].positions;
            var pointsBD = [];
            for (var i = 0; i < points.length; i++) {
                pointsBD.push(new BMap.Point(points[i][0], points[i][1]));
            }

            var icons = new BMap.IconSequence(sy, '10', '30');

            console.log(pointsBD);

            var polyline = new BMap.Polyline(pointsBD, {
                enableEditing: false,//是否启用线编辑，默认为false
                enableClicking: true,//是否响应点击事件，默认为true
                icons: [icons],
                strokeWeight: '8',//折线的宽度，以像素为单位
                strokeOpacity: 0.8,//折线的透明度，取值范围0 - 1
                strokeColor: "#18a45b" //折线颜色
            });

            map.addOverlay(polyline);          //增加折线
            var marker = new BMap.Marker(new BMap.Point(116.442501, 39.914603));
            map.addOverlay(marker);


        }

    }

</script>
