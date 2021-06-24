<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>全球疫情信息可视化</title>
<link href="${pageContext.request.contextPath }/bootstrap-3.3.7-dist/css/bootstrap.min.css"  rel="stylesheet">
<script src="${pageContext.request.contextPath }/js/jquery-1.8.3.min.js"></script>
<script src="${pageContext.request.contextPath }/bootstrap-3.3.7-dist/js/bootstrap.min.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath }/js/echarts.min.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath }/js/world.js"></script>
</head>
<style>
#title{
    background:black;
    border: solid 1px;
    font-family:"黑体";
    text-align:center;
    font-color:red;
    height:80px;
    width:1260px;
    float:left;
}
#time{
    background:black;
    border: solid 1px;
    font-family:"黑体";
    text-align:center;
    font-color:#333;
    width:259px;
    height:80px;
    float:left;
}
#left{
    background:black;
    overflow-x: auto; overflow-y: auto;
    border: solid 1px;
    font-family:"黑体";
    text-align:center;
    font-color:#333;
    width:250px;
    height:640px;
    float:left;
}
#left1{
    background:black;
    overflow-x: auto; overflow-y: auto;
    border: solid 1px;
    font-family:"黑体";
    text-align:center;
    font-color:#333;
    width:250px;
    height:490px;
    float:left;
}
#left2{
    background:black;
    overflow-x: auto; overflow-y: auto;
    border: solid 1px;
    font-family:"黑体";
    text-align:center;
    font-color:#333;
    width:250px;
    height:140px;
    float:left;
}
#right{
    background:black;
    border: solid 1px;
    font-family:"黑体";
    text-align:center;
    font-color:#333;
    width:419px;
    height:430px;
    float:left;
}
#right1{
    background:black;
    overflow-x: auto; overflow-y: auto;
    border: solid 1px;
    font-family:"黑体";
    text-align:center;
    font-color:#333;
    width:205px;
    height:440px;
    float:left;
}
#right2{
    background:black;
    overflow-x: auto; overflow-y: auto;
    border: solid 1px;
    font-family:"黑体";
    text-align:center;
    font-color:#333;
    width:205px;
    height:440px;
    float:right;
}
#main{
    background:black;
    border: solid 1px;
    font-family:"黑体";
    text-align:center;
    font-color:#333;
    width:850px;
    height:640px;
    float:left;
}
#line{
background-color:#5c5c5c;
    border: solid 1px;
    width:419px;
    height:210px;
    float:left;
}
</style>
<body>
    <div>
        <div id="title"><span style="color:white;font-size:50px">全球疫情信息可视化</span></div>
        <div id="time"><span id="localtime" style="color:white;font-size:27px">当地时间</span></div>
    </div>
    <div id="left">
        <div id="left1"></div>
        <div id="left2"></div>
    </div>    
    <div id="main"></div>    
    <div id="right">
        <div id="right1">死亡人数</div>
        <div id="right2">治愈人数</div>    
    </div>
    <div id="line"></div>
</body>
<script type="text/javascript">
    window.onload = function(){
    	setInterval("document.getElementById('localtime').innerHTML=new Date().toLocaleString();", 1000);
    	var dt;
        var mydata1 = new Array(0);
            $.ajax({
            	url : "YqServlet?method=everydayinfo",
            	async : true ,
            	type : "POST",
            	dataType : "json",
            	success : function(data){
            		dt = data;
            		var myChart = echarts.init(document.getElementById('line'));
            	    var xd = new Array(0)//长度为33
            	    var yd = new Array(0)//长度为33
            	    for(var i=0;i<dt.length;i++){
            	        xd.push(dt[i].date);
            	        yd.push(dt[i].confirmed_num);
            	    }
            	        // 指定图表的配置项和数据
            	       var option = {
            	        title: {
            	            text: '全球疫情增长趋势'
            	        },
            	        tooltip: {
            	            show: true,
            	            trigger: 'axis'
            	            
            	        },
            	        legend: {
            	            data: ['确诊人数']
            	        },
            	        grid: {
            	            left: '3%',
            	            right: '4%',
            	            bottom: '3%',
            	            containLabel: true
            	        },
            	        toolbox: {
            	            feature: {
            	                saveAsImage: {}
            	            }
            	        },
            	        xAxis: {
            	            type: 'category',
            	            boundaryGap: false,
            	            axisLabel:{
            	                                        //横坐标上的文字斜着显示 文字颜色 begin 
            	                                             interval:0,
            	                                             rotate:40,
            	                                             margin:1,
            	                                             textStyle:{color:"#ec6869" }
            	                                        //横坐标上的文字换行显示 文字颜色end
            	                                             },
            	            data: xd
            	        },
            	        yAxis: {
            	            type: 'value'
            	        },
            	        series: [
            	            {
            	                name: '确诊人数',
            	                type: 'line',
            	                stack: '总量',
            	                data: yd,
            	                barWidth:20,
            	                barGap:'10%'
            	            }
            	        ]
            	    };            	      
            	        // 使用刚指定的配置项和数据显示图表。
            	        myChart.setOption(option);
            	},
                error : function() {
                    alert("请求失败");
                },
            });
            $.ajax({
                url : "YqServlet?method=getWorld",
                async : true,
                type : "POST",
                success : function(data) {
                    dt = data;
                    var sum=0;
                    for(var i=0;i<dt.length;i++)
                        sum+= parseInt(dt[i].confirmed_num);
                    var htmltext="<h style='color: white;'>全球确诊人数为："+"<span style='color: red;font-size:50px'>"+sum+"</span></h>";
                    htmltext+="<table>"
                    for(var i=0;i<dt.length;i++)
                        htmltext+="<tr><td>"+"<span style='color: white;'>"+dt[i].province+"</span></td><td><span style='color: red;'>"+dt[i].confirmed_num+"</span></td></tr>";
                    htmltext+="</table>";
                    $("#left1").html(htmltext);
                    
                    var date="";
                    date=dt[0].date;
                    var htmltext="<h style='color: white;font-size:20px'>更新时间："+"<br>"+"<span style='color: red;font-size:30px'>"+date+"</span></h>";
                    $("#left2").html(htmltext);
                    
                    var sum=0;
                    for(var i=0;i<dt.length;i++)
                        sum+= parseInt(dt[i].dead_num);
                    var htmltext="<h style='color: white;'>全球死亡人数为："+"<span style='color: red;font-size:50px'>"+sum+"</span></h>";
                    htmltext+="<table>"
                    for(var i=0;i<dt.length;i++)
                        htmltext+="<tr><td>"+"<span style='color: white;'>"+dt[i].province+"</span></td><td><span style='color: red;'>"+dt[i].dead_num+"</span></td></tr>";
                    htmltext+="</table>";
                    $("#right1").html(htmltext);
                    
                    var sum=0;
                    for(var i=0;i<dt.length;i++)
                        sum+= parseInt(dt[i].cured_num);
                    var htmltext="<h style='color: white;'>全球治愈人数为："+"<span style='color: red;font-size:50px'>"+sum+"</span></h>";
                    htmltext+="<table>"
                    for(var i=0;i<dt.length;i++)
                        htmltext+="<tr><td>"+"<span style='color: white;'>"+dt[i].province+"</span></td><td><span style='color: red;'>"+dt[i].cured_num+"</span></td></tr>";
                    htmltext+="</table>";
                    $("#right2").html(htmltext);
                    for (var i = 0; i < 203; i++) {
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
                        tooltip : {
                            formatter : function(params) {
                                return params.name + '<br/>' + '确诊人数 : '
                                        + params['data']['value'] + '<br/>' + '死亡人数 : '
                                        + params['data']['dead_num'] + '<br/>' + '治愈人数 : '
                                        + params['data']['cured_num'];
                            }//数据格式化
                        },

                        //左侧小导航图标
                        visualMap : {
                            min : 0,
                            max : 200000,
                            text : [ '多', '少' ],
                            realtime : false,
                            calculable : true,
                            inRange : {
                                color : [ 'lightskyblue', 'yellow', 'orangered','red' ]
                            }
                        },

                        //配置属性
                        series : [ {
                            type : 'map',
                            mapType : 'world',
                            label : {
                                show : false//是否显示国家名字
                            },
                            data : mydata1,
                            nameMap : {"Canada": "加拿大",
                                "Turkmenistan": "土库曼斯坦",
                                "Saint Helena": "圣赫勒拿",
                                "Lao PDR": "老挝",
                                "Lithuania": "立陶宛",
                                "Cambodia": "柬埔寨",
                                "Ethiopia": "埃塞俄比亚",
                                "Faeroe Is.": "法罗群岛",
                                "Swaziland": "斯威士兰",
                                "Palestine": "巴勒斯坦",
                                "Belize": "伯利兹",
                                "Argentina": "阿根廷",
                                "Bolivia": "玻利维亚",
                                "Cameroon": "喀麦隆",
                                "Burkina Faso": "布基纳法索",
                                "Aland": "奥兰群岛",
                                "Bahrain": "巴林",
                                "Saudi Arabia": "沙特阿拉伯",
                                "Fr. Polynesia": "法属波利尼西亚",
                                "Cape Verde": "佛得角",
                                "W. Sahara": "西撒哈拉",
                                "Slovenia": "斯洛文尼亚",
                                "Guatemala": "危地马拉",
                                "Guinea": "几内亚",
                                "Dem. Rep. Congo": "刚果（金）",
                                "Germany": "德国",
                                "Spain": "西班牙",
                                "Liberia": "利比里亚",
                                "Netherlands": "荷兰",
                                "Jamaica": "牙买加",
                                "Solomon Is.": "所罗门群岛",
                                "Oman": "阿曼",
                                "Tanzania": "坦桑尼亚",
                                "Costa Rica": "哥斯达黎加",
                                "Isle of Man": "曼岛",
                                "Gabon": "加蓬",
                                "Niue": "纽埃",
                                "Bahamas": "巴哈马",
                                "New Zealand": "新西兰",
                                "Yemen": "也门",
                                "Jersey": "泽西岛",
                                "Pakistan": "巴基斯坦",
                                "Albania": "阿尔巴尼亚",
                                "Samoa": "萨摩亚",
                                "Czech Rep.": "捷克",
                                "United Arab Emirates": "阿拉伯联合酋长国",
                                "Guam": "关岛",
                                "India": "印度",
                                "Azerbaijan": "阿塞拜疆",
                                "N. Mariana Is.": "北马里亚纳群岛",
                                "Lesotho": "莱索托",
                                "Kenya": "肯尼亚",
                                "Belarus": "白俄罗斯",
                                "Tajikistan": "塔吉克斯坦",
                                "Turkey": "土耳其",
                                "Afghanistan": "阿富汗",
                                "Bangladesh": "孟加拉国",
                                "Mauritania": "毛里塔尼亚",
                                "Dem. Rep. Korea": "朝鲜",
                                "Saint Lucia": "圣卢西亚",
                                "Br. Indian Ocean Ter.": "英属印度洋领地",
                                "Mongolia": "蒙古",
                                "France": "法国",
                                "Cura?ao": "库拉索岛",
                                "S. Sudan": "南苏丹",
                                "Rwanda": "卢旺达",
                                "Slovakia": "斯洛伐克",
                                "Somalia": "索马里",
                                "Peru": "秘鲁",
                                "Vanuatu": "瓦努阿图",
                                "Norway": "挪威",
                                "Malawi": "马拉维",
                                "Benin": "贝宁",
                                "St. Vin. and Gren.": "圣文森特和格林纳丁斯",
                                "Korea": "韩国",
                                "Singapore": "新加坡",
                                "Montenegro": "黑山共和国",
                                "Cayman Is.": "开曼群岛",
                                "Togo": "多哥",
                                "China": "中国",
                                "Heard I. and McDonald Is.": "赫德岛和麦克唐纳群岛",
                                "Armenia": "亚美尼亚",
                                "Falkland Is.": "马尔维纳斯群岛（福克兰）",
                                "Ukraine": "乌克兰",
                                "Ghana": "加纳",
                                "Tonga": "汤加",
                                "Finland": "芬兰",
                                "Libya": "利比亚",
                                "Dominican Rep.": "多米尼加",
                                "Indonesia": "印度尼西亚",
                                "Mauritius": "毛里求斯",
                                "Eq. Guinea": "赤道几内亚",
                                "Sweden": "瑞典",
                                "Vietnam": "越南",
                                "Mali": "马里",
                                "Russia": "俄罗斯",
                                "Bulgaria": "保加利亚",
                                "United States": "美国",
                                "Romania": "罗马尼亚",
                                "Angola": "安哥拉",
                                "Chad": "乍得",
                                "South Africa": "南非",
                                "Fiji": "斐济",
                                "Liechtenstein": "列支敦士登",
                                "Malaysia": "马来西亚",
                                "Austria": "奥地利",
                                "Mozambique": "莫桑比克",
                                "Uganda": "乌干达",
                                "Japan": "日本",
                                "Niger": "尼日尔",
                                "Brazil": "巴西",
                                "Kuwait": "科威特",
                                "Panama": "巴拿马",
                                "Guyana": "圭亚那",
                                "Madagascar": "马达加斯加",
                                "Luxembourg": "卢森堡",
                                "American Samoa": "美属萨摩亚",
                                "Andorra": "安道尔",
                                "Ireland": "爱尔兰",
                                "Italy": "意大利",
                                "Nigeria": "尼日利亚",
                                "Turks and Caicos Is.": "特克斯和凯科斯群岛",
                                "Ecuador": "厄瓜多尔",
                                "U.S. Virgin Is.": "美属维尔京群岛",
                                "Brunei": "文莱",
                                "Australia": "澳大利亚",
                                "Iran": "伊朗",
                                "Algeria": "阿尔及利亚",
                                "El Salvador": "萨尔瓦多",
                                "C?te d'Ivoire": "科特迪瓦",
                                "Chile": "智利",
                                "Puerto Rico": "波多黎各",
                                "Belgium": "比利时",
                                "Thailand": "泰国",
                                "Haiti": "海地",
                                "Iraq": "伊拉克",
                                "S?o Tomé and Principe": "圣多美和普林西比",
                                "Sierra Leone": "塞拉利昂",
                                "Georgia": "格鲁吉亚",
                                "Denmark": "丹麦",
                                "Philippines": "菲律宾",
                                "S. Geo. and S. Sandw. Is.": "南乔治亚岛和南桑威奇群岛",
                                "Moldova": "摩尔多瓦",
                                "Morocco": "摩洛哥",
                                "Namibia": "纳米比亚",
                                "Malta": "马耳他",
                                "Guinea-Bissau": "几内亚比绍",
                                "Kiribati": "基里巴斯",
                                "Switzerland": "瑞士",
                                "Grenada": "格林纳达",
                                "Seychelles": "塞舌尔",
                                "Portugal": "葡萄牙",
                                "Estonia": "爱沙尼亚",
                                "Uruguay": "乌拉圭",
                                "Antigua and Barb.": "安提瓜和巴布达",
                                "Lebanon": "黎巴嫩",
                                "Uzbekistan": "乌兹别克斯坦",
                                "Tunisia": "突尼斯",
                                "Djibouti": "吉布提",
                                "Greenland": "格陵兰",
                                "Timor-Leste": "东帝汶",
                                "Dominica": "多米尼克",
                                "Colombia": "哥伦比亚",
                                "Burundi": "布隆迪",
                                "Bosnia and Herz.": "波斯尼亚和黑塞哥维那",
                                "Cyprus": "塞浦路斯",
                                "Barbados": "巴巴多斯",
                                "Qatar": "卡塔尔",
                                "Palau": "帕劳",
                                "Bhutan": "不丹",
                                "Sudan": "苏丹",
                                "Nepal": "尼泊尔",
                                "Micronesia": "密克罗尼西亚",
                                "Bermuda": "百慕大",
                                "Suriname": "苏里南",
                                "Venezuela": "委内瑞拉",
                                "Israel": "以色列",
                                "St. Pierre and Miquelon": "圣皮埃尔和密克隆群岛",
                                "Central African Rep.": "中非",
                                "Iceland": "冰岛",
                                "Zambia": "赞比亚",
                                "Senegal": "塞内加尔",
                                "Papua New Guinea": "巴布亚新几内亚",
                                "Trinidad and Tobago": "特立尼达和多巴哥",
                                "Zimbabwe": "津巴布韦",
                                "Jordan": "约旦",
                                "Gambia": "冈比亚",
                                "Kazakhstan": "哈萨克斯坦",
                                "Poland": "波兰",
                                "Eritrea": "厄立特里亚",
                                "Kyrgyzstan": "吉尔吉斯斯坦",
                                "Montserrat": "蒙特塞拉特",
                                "New Caledonia": "新喀里多尼亚",
                                "Macedonia": "马其顿",
                                "Paraguay": "巴拉圭",
                                "Latvia": "拉脱维亚",
                                "Hungary": "匈牙利",
                                "Syria": "叙利亚",
                                "Honduras": "洪都拉斯",
                                "Myanmar": "缅甸",
                                "Mexico": "墨西哥",
                                "Egypt": "埃及",
                                "Nicaragua": "尼加拉瓜",
                                "Cuba": "古巴",
                                "Serbia": "塞尔维亚",
                                "Comoros": "科摩罗",
                                "United Kingdom": "英国",
                                "Fr. S. Antarctic Lands": "南极洲",
                                "Congo": "刚果（布）",
                                "Greece": "希腊",
                                "Sri Lanka": "斯里兰卡",
                                "Croatia": "克罗地亚",
                                "Botswana": "博茨瓦纳",
                                "Siachen Glacier": "锡亚琴冰川地区"
                        },

                        } ]
                    };
                    //初始化echarts实例
                    var myChart = echarts.init(document.getElementById('main'));

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