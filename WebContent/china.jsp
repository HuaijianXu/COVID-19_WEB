<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link href="${pageContext.request.contextPath }/bootstrap-3.3.7-dist/css/bootstrap.min.css"  rel="stylesheet">
<script src="${pageContext.request.contextPath }/js/jquery-1.8.3.min.js"></script>
<script src="${pageContext.request.contextPath }/bootstrap-3.3.7-dist/js/bootstrap.min.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath }/js/echarts.min.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath }/js/china.js"></script>
</head>
<body style="height: 100%; margin: 0">
    <div class="row" style="background-color: silver; height: 50px">
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;日期 <input type="text" name="time"
            id="time" placeholder="yyyy-MM-dd"> <input
            type="button" value="查询" onclick="tu()">
    </div>
    <div id="main" style="height: 1000%"></div>
</body>
<script type="text/javascript">
    function randomData(){
    	return Math.round(Math.random()*500);
    }
    var dt;
    var mydata1 = new Array(0);
    function tu() {
        time = $("#time").val();
        //alert(time.substring(0, 2));
        $.ajax({
            url : "YqServlet?method=getChina",
            async : true,
            type : "POST",
            data : {
                "time" : time
            },
            success : function(data) {
                dt = data;
                for (var i = 0; i < 33; i++) {
                    var d = {
                        
                    };
                    d["name"] = dt[i].province;//.substring(0, 2);
                    d["value"] = dt[i].confirmed_num;
                    d["yisi_num"] = dt[i].yisi_num;
                    d["cured_num"] = dt[i].cured_num;
                    d["dead_num"] = dt[i].dead_num;
                    mydata1.push(d);
                }
                
                //var mdata = JSON.stringify(mydata1);
                var optionMap = {
                    backgroundColor : '#FFFFFF',
                    title : {
                        text : '全国地图大数据',
                        subtext : '该页面数据仅供参考',
                        x : 'center'
                    },
                    tooltip : {
                        formatter : function(params) {
                            return params.name + '<br/>' + '确诊人数 : '
                                    + params['data']['value'] + '<br/>' + '死亡人数 : '
                                    + params['data']['dead_num'] + '<br/>' + '治愈人数 : '
                                    + params['data']['cured_num'] + '<br/>'+ '疑似患者人数 : '
                                    + params['data']['yisi_num'];
                        }//数据格式化
                    },

                    //左侧小导航图标
                    visualMap : {
                        min : 0,
                        max : 35000,
                        text : [ '多', '少' ],
                        realtime : false,
                        calculable : true,
                        inRange : {
                            color : [ 'lightskyblue', 'yellow', 'orangered' ]
                        }
                    },

                    //配置属性
                    series : [ {
                        type : 'map',
                        mapType : 'china',
                        label : {
                            show : true
                        },
                        data : mydata1,
//                         nameMap : {

//                             '南海诸岛' : '南海诸岛',
//                             '北京' : '北京市',
//                             '天津' : '天津市',
//                             '上海' : '上海市',
//                             '重庆' : '重庆市',
//                             '河北' : '河北省',
//                             '河南' : '河南省',
//                             '云南' : '云南省',
//                             '辽宁' : '辽宁省',
//                             '黑龙江' : '黑龙江省',
//                             '湖南' : '湖南省',
//                             '安徽' : '安徽省',
//                             '山东' : '山东省',
//                             '新疆' : '新疆维吾尔自治区',
//                             '江苏' : '江苏省',
//                             '浙江' : '浙江省',
//                             '江西' : '江西省',
//                             '湖北' : '湖北省',
//                             '广西' : '广西壮族自治区',
//                             '甘肃' : '甘肃省',
//                             '山西' : '山西省',
//                             '内蒙古' : "内蒙古自治区",
//                             '陕西' : '陕西省',
//                             '吉林' : '吉林省',
//                             '福建' : '福建省',
//                             '贵州' : '贵州省',
//                             '广东' : '广东省',
//                             '青海' : '青海省',
//                             '西藏' : '西藏自治区',
//                             '四川' : '四川省',
//                             '宁夏' : '宁夏回族自治区',
//                             '海南' : '海南省',
//                             '台湾' : '台湾',
//                             '香港' : '香港',
//                             '澳门' : '澳门'
//                         }

                    } ]
                };
                //初始化echarts实例
                var myChart = echarts.init(document.getElementById('main'));
                myChart.on('click', function (params) {
                    var url = "info?method=city&province=" + params.name+"省&time="+time;
                    window.location.href = url;
                });
                //使用制定的配置项和数据显示图表
                myChart.setOption(optionMap);
            },
            error : function() {
                alert("请求失败");
            },
            dataType : "json"
        });
    }
</script>
</html>