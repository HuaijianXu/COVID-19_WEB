<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core"  prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<script src="js/jquery-1.8.3.min.js" type="text/javascript"></script>
<script type="text/javascript" src="js/echarts.min.js"></script>
<script type="text/javascript" src="js/china.js"></script>
<title>Insert title here</title>
</head>
<body>

    <!-- 为ECharts准备一个具备大小（宽高）的Dom -->
        <div id="main" style="width: 800px;;height:600px;"></div>    
  
<script>

var myChart = echarts.init(document.getElementById('main'));
//myChart.showLoading();
var province = "${province}";
//var list = "${list}";


$.get("mapjson/"+ province +".json", function (geoJson) {

    myChart.hideLoading();

    echarts.registerMap(province, geoJson);

    myChart.setOption(option = {
        title: {
            text: province + '地区疫情情况',
        },
        tooltip: {
            trigger: 'item',
            formatter: '{b}<br/>{c} (确诊 / 人)'
        },
        toolbox: {
            show: true,
            orient: 'vertical',
            left: 'right',
            top: 'center',
            feature: {
                dataView: {readOnly: false},
                restore: {},
                saveAsImage: {}
            }
        },
        visualMap: {
            min: 0,
            max: 50000,
            text: ['High', 'Low'],
            inRange: {
                color: ['lightskyblue', 'yellow', 'orangered']
            }
        },
        series: [
            {
                name: province + '地区疫情情况',
                type: 'map',
                mapType: province, // 自定义扩展图表类型
                label: {
                    show: true
                }
            }
        ]
    });
});



$.ajax({
    url:"info?method=d",
    async:true,
    type:"POST",
    data:{"province":province},
    success:function(data){
        alert(data.length);
        var mydata1 = new Array(0);
        for(var i=0;i<data.length;i++){
            var c = {};
            c["name"] = data[i].name;
            c["value"] = data[i].value;
            mydata1.push(c);
        }
        myChart.setOption({        //加载数据图表
            series: [{
                data: mydata1
            }]
        });
    },
    error:function(){
        alert("请求失败");
    },
    dataType:"json"
});




</script>


</body>
</html>