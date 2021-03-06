<%--<!DOCTYPE html>--%>
<html>
<head>
    <script type="text/javascript" src="js/jquery-3.2.1.js"></script>
    <script type="text/javascript" src="js/jquery.form.js"></script>
    <script type="text/javascript" src="js/pointtransfertools.js"></script>
    <link href="css/my-css.css" rel="stylesheet">
    <link href="css/map.css" rel="stylesheet">
    <meta name="viewport" content="initial-scale=1.0, user-scalable=no"/>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <title>Hello, World</title>
    <style type="text/css">
        html {
            height: 100%
        }

        body {
            height: 100%;
            margin: 0px;
            padding: 0px
        }

        #container {
            height: 100%;
            margin: 20px;
        }

        p {
            word-break: break-all;
        }

        .comment-pic {
            margin-left: 50px;
            max-height: 150px;
        }
    </style>
    <link href="https://cdn.bootcss.com/bootstrap/3.3.7/css/bootstrap.min.css" rel="stylesheet">
    <link href="css/map.css" rel="stylesheet">
    <script type="text/javascript" src="http://api.map.baidu.com/api?v=2.0&ak=YWdGplhYjUGQ3GtpKNeuTM2S"></script>
</head>

<body>
    <%
    String current_username = (String) session.getAttribute("username");
    String current_name = (String) session.getAttribute("name");
%>

<nav class="navbar navbar-default nav-justified navbar-fixed-top" role="navigation">
    <div class="container-fluid">
        <div class="navbar-right">
            <ul class="nav navbar-nav">
                <li><a onClick="history.back(-1);">close&nbsp;<span class="glyphicon glyphicon-remove"
                                                                    aria-hidden="true"></span></a></li>
            </ul>
        </div>
        <div class="navbar-header">
            <a class="navbar-brand" href="#">Activity</a>
        </div>
        <div>
            <ul class="nav navbar-nav">
                <%--<button class="btn btn-primary" data-toggle="onComment" data-target="#myModal"><span class="glyphicon glyphicon-content" aria-hidden="true"></span>content</button>--%>
                <%--<li><button class="btn btn-primary"  data-toggle="onComment" data-target="#myModal">content&nbsp;<span class="glyphicon glyphicon-content" aria-hidden="true"></span></button></li>--%>
                <li>
                    <button class="btn btn-primary" onclick='onComment()' style="position:absolute; margin-top:8px;">
                        comments&nbsp;<span class="glyphicon glyphicon-content" aria-hidden="true"></span></button>
                </li>
            </ul>
        </div>
    </div>
</nav>


<!-- 模态框（Modal） -->
<div id="modal-overlay">
    <div class="modal-data">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" onclick='onComment()' class="close">
                </button>
                <h4 class="modal-title" id="myModalLabel">
                    COMMENT
                </h4>
            </div>
            <div class="modal-body">
                <div class="row pre-scrollable">
                    <table class="table table-hover">
                        <tbody id="table">
                        <tr>
                            <td class="content-td"><b>No comment...</b>
                            </td>
                        </tr>
                        </tbody>
                    </table>
                </div>
            </div>
            <div class="modal-footer">
                <form id="ajax_form" class="ajax_form" name="ajax_form">
                    <div class="form-group">
                        <input type="text" class="form-control" id="comment_text"
                               placeholder="What do you want to comment" name="comment"></div>
                    <span id="filename"
                          style="vertical-align: middle;font-size: small;color: #00699c;font-weight: lighter">No picture</span>
                    <button class="btn btn-default file-button" type="button"
                            onclick="document.getElementById('file-input').click();">Upload picture
                    </button>
                    <input type="file" accept="image/gif,image/jpeg,image/jpg,image/png"
                           onchange="loadFile(this.files[0])" id="file-input" style="display:none" name="file">
                    <button type="button" class="btn btn-primary" onclick="onSubmit()">Submit</button>

                </form>
            </div>
        </div><!-- /.onComment-content -->
    </div><!-- /.onComment -->
</div>


<div id="container"></div>
<script type="text/javascript">
    //显示文件名
    function loadFile(file) {
        $("#filename").html(file.name);
    }

    function onSubmit() {
//        $.ajax({
//            url:"GiveCommentsServlet",//提交地址
//            data:$("#ajax_form").serialize(),//将表单数据序列化
//            type:"POST",
//            dataType:"json",
//            contentType:"application/x-www-form-urlencoded",
//            success:function(result){
//                if (result === 1) {
//                    console.log(result);
//                    document.getElementById('comment_text').value = "";
//                } else {
//                    alert("Comment failed!")
//                }
//                refresh();
//            }
//        });
        $("#ajax_form").ajaxSubmit(
            {
                url: "GiveCommentsServlet",
                type: "post",
                dataType: "json",
                contentType: "application/x-www-form-urlencoded",
                success: function (data) {
                    document.getElementById('comment_text').value = "";
                    $("#filename").html("No picture");
                    refresh();
                }
            }
        );
    }


    function onComment() {
        var e1 = document.getElementById('modal-overlay');
        e1.style.visibility = (e1.style.visibility === "visible") ? "hidden" : "visible";
        refresh();
    }

    function refresh() {
        $.ajax({
            url: "DisplayCommentsServlet",//提交地址
            type: "GET",
            success: function (jsonString) {
                displayComments(jsonString)
            }
        });
    }

    function displayComments(jsonString) {
        var json = JSON.parse(jsonString);
        console.log(json);
        $("#table").text("");
        for (var i = 0; i <= json.length - 1; i++) {
            addRaw(json[i]);
        }
    }

    function addRaw(commentObj) {

        var imgStr = "";
        for (var i = 0; i < commentObj.urls.length; i++) {
            imgStr += "<img class='img-thumbnail comment-pic' src='" + commentObj.urls[i] + "'/>";
        }
        $("#table").append("<tr><td class='comment-td' align='left'><p><b>" + commentObj.myName + "</b>: " + commentObj.content +
            "</p><span>" + imgStr + "</span><p style='text-align: right;font-size:small; color: #002a80;'>" + commentObj.datetime + "</P>");
        console.log(imgStr);
    }

    function getRandomColor() {
        return "#" + ("00000" + ((Math.random() * 16777215 + 0.5) >> 0).toString(16)).slice(-6);
    }

    function uploadLocation(x1, x2) {
        $.ajax(
            {
                url: "AjaxServlet",
                type: "POST",
                dataType: "json",
                data: {v1: x1, v2: x2, lastUpdate: lastUpdate},
                success: function () {

                }
            }
        );
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
//            console.log(json[k].username);
            var name = json[k].username;
            var myname = json[k].name;
            if (uName.indexOf(name) === -1) {
                uName.push(name);
                clName.push(getRandomColor());
                markers.push(null);
                var title = name + "(" + myname + ")";
                var opts = {
                    title: title, // 信息窗口标题
                    enableMessage: true//设置允许信息窗发送短息
                };
                var content = "email:" + json[k].email;
                infoWindows.push(new BMap.InfoWindow(content, opts));
            }

//            var infoWindow = new BMap.InfoWindow(name + json[k].email);  // 创建信息窗口对象
//            var inforWindow = new BMap.InfoWindow("<h4 style='margin:0 0 5px 0;padding:0.2em 0'>天安门</h4>" + "<p style='margin:0;line-height:1.5;font-size:13px;text-indent:2em'>地点：南方科技大学</p>" + "</div>");
//            console.log(title);
            var points = json[k].positions;
            var pointsBD = [];
            for (var i = 0; i < points.length; i++) {
                pointsBD.push(new BMap.Point(points[i][0], points[i][1]));
            }
            pointsBD = GpsToBaiduPoints(pointsBD);
            allPoints = allPoints.concat(pointsBD);

            var polyline = new BMap.Polyline(pointsBD, {
                enableEditing: false,//是否启用线编辑，默认为false
                enableClicking: true,//是否响应点击事件，默认为true
                strokeWeight: '2',//折线的宽度，以像素为单位
                strokeOpacity: 0.8,//折线的透明度，取值范围0 - 1
                strokeColor: clName[uName.indexOf(name)] //折线颜色
            });


            if (markers[uName.indexOf(name)] === null) {
                <%--console.log(name === "<%=current_username%>");--%>
                if (name === "<%=current_username%>") {
                    markers[uName.indexOf(name)] = new BMap.Marker(pointsBD[pointsBD.length - 1]);
                    markers[uName.indexOf(name)].setAnimation(BMAP_ANIMATION_BOUNCE);
                    map.addOverlay(markers[uName.indexOf(name)]);
                    markers[uName.indexOf(name)].addEventListener("click", function () {
                        this.openInfoWindow(infoWindows[markers.indexOf(this)]); //开启信息窗口
                    });
                } else {
                    markers[uName.indexOf(name)] = new BMap.Marker(pointsBD[pointsBD.length - 1]);
                    map.addOverlay(markers[uName.indexOf(name)]);
                    markers[uName.indexOf(name)].addEventListener("click", function () {
                        this.openInfoWindow(infoWindows[markers.indexOf(this)]); //开启信息窗口
                    });
                }
            } else {
                <%--console.log(name === "<%=current_username%>");--%>
                if (name === "<%=current_username%>") {
                    markers[uName.indexOf(name)].setPosition(pointsBD[pointsBD.length - 1]);
                } else {
                    markers[uName.indexOf(name)].setPosition(pointsBD[pointsBD.length - 1]);
                }
            }

            map.addOverlay(polyline);          //增加折线
        }
        if (isSetzoom === 8) {
            setZoom(allPoints);
            console.log('setzoom');
            isSetzoom = 0;
        }
        isSetzoom++;

    }

    //根据点信息实时更新地图显示范围，让轨迹完整显示。设置新的中心点和显示级别.
    //更新。设置不是每次增加点都重新设置显示范围。因为有可能会想放大了看。
    function setZoom(bPoints) {
        var view = map.getViewport(eval(bPoints));
        var mapZoom = view.zoom;
        var centerPoint = view.center;
        map.centerAndZoom(centerPoint, mapZoom);
        map.oldView = JSON.stringify(view);
    }

    function getPosition() {
        $.ajax(
            {
                url: "AjaxServlet",
                type: "GET",
                dataType: "json",
                data: {lastUpdate: lastUpdate},
                success: function (json) {
                    lastUpdate = getNowFormatDate();
                    plotLines(json);
                }
            }
        );
    }


    function location1() {
        getLocation();

        setTimeout(getPosition, 2000);

        setTimeout(location1, 2000);
    }

    function getLocation() {
        if (navigator.geolocation) {
            navigator.geolocation.getCurrentPosition(showPosition);
        }
        else {

        }
    }

    function showPosition(position) {
        uploadLocation(position.coords.longitude, position.coords.latitude);
    }


    var allPoints = [];
    var isSetzoom = 8;
    var map = new BMap.Map("container");
    map.centerAndZoom(new BMap.Point(103.388611, 35.563611), 5); //初始显示中国。
    map.enableScrollWheelZoom();//滚轮放大缩小

    var lastUpdate = "1000-00-00 00:00:00";

    var uName = [];
    var clName = [];

    var markers = [];
    var infoWindows = [];

    setTimeout(location1, 1000);//动态生成新的点。
</script>
