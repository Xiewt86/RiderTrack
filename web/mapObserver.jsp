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
            font-family: "宋体", serif;
        }
    </style>
    <script type="text/javascript"
            src="http://api.map.baidu.com/api?v=2.0&ak=0mxjSf6gGLHKmRoyuRCVl9OEklpcITq6"></script>
    <title>浏览器定位</title>
</head>
<body>
<div unselectable="on" class=" BMap_stdMpCtrl BMap_stdMpType0 BMap_noprint anchorTL"
     style="width: 62px; height: 192px; bottom: auto; right: auto; top: 10px; left: 10px; position: absolute; z-index: 1100; text-size-adjust: none;">
    <a type="button" class="btn btn-default" href="#" onClick="history.back();"><span class="glyphicon glyphicon-chevron-left" aria-hidden="true"></span>Back</a>
</div>
<div id="allmap"></div>
</body>
</html>
<script type="text/javascript">
    // 百度地图API功能
    var map = new BMap.Map("allmap");
    var point = new BMap.Point(116.331398, 39.897445);
    map.centerAndZoom(point, 12);
    var x = 116.331398;
    var y = 39.897445;

    window.setInterval(location1, 5000);
    //    while (++i <= 10) {
    //        geolocation.getCurrentPosition(function (r) {
    //            if (this.getStatus() === BMAP_STATUS_SUCCESS) {
    //                var mk = new BMap.Marker(r.point);
    //                map.addOverlay(mk);
    //                map.panTo(r.point);
    //                x = r.point.lng;
    //                y = r.point.lat;
    //                ajax();
    //            }
    //            else {
    //                alert('failed' + this.getStatus());
    //            }
    //            var xmlHttpRequest = null;
    //        }, {enableHighAccuracy: true})
    //
    //    }
    //关于状态码
    //BMAP_STATUS_SUCCESS	检索成功。对应数值“0”。
    //BMAP_STATUS_CITY_LIST	城市列表。对应数值“1”。
    //BMAP_STATUS_UNKNOWN_LOCATION	位置结果未知。对应数值“2”。
    //BMAP_STATUS_UNKNOWN_ROUTE	导航结果未知。对应数值“3”。
    //BMAP_STATUS_INVALID_KEY	非法密钥。对应数值“4”。
    //BMAP_STATUS_INVALID_REQUEST	非法请求。对应数值“5”。
    //BMAP_STATUS_PERMISSION_DENIED	没有权限。对应数值“6”。(自 1.1 新增)
    //BMAP_STATUS_SERVICE_UNAVAILABLE	服务不可用。对应数值“7”。(自 1.1 新增)
    //BMAP_STATUS_TIMEOUT	超时。对应数值“8”。(自 1.1 新增)

</script>
