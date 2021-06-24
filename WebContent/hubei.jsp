<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>

<head>
    <meta charset="utf-8">
    <title>echarts图形插件使用</title>
</head>
<body>
<div id="main" style="height:800px;"></div>
<script type="text/JavaScript" src="js/echarts.min.js"></script>
<script type="text/JavaScript" src="js/map/hubei.js"></script>
<script type="text/javascript">
        var chart = echarts.init(document.getElementById('main'));
        chart.setOption({
            series: [{
                type: 'map',
                map: 'hubei'
            }]
        });
</script>
</body>

</html>