package Dao;
import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.Date;
import org.jsoup.Jsoup;
import org.jsoup.nodes.Document;
import org.jsoup.nodes.Element;
import org.jsoup.select.Elements;

import com.gargoylesoftware.htmlunit.BrowserVersion;
import com.gargoylesoftware.htmlunit.WebClient;
import com.gargoylesoftware.htmlunit.html.HtmlPage;

 
public class Paqu {
	
	public static void main(String args[]) {
		refesh();
	}

	public static void refesh() {
		// TODO Auto-generated method stub
		String sheng="";
		String xinzeng="";
		String leiji="";
		String zhiyu="";
		String siwang="";
		String country="";
		char kind;
		 String url = "https://wp.m.163.com/163/page/news/virus_report/index.html?_nw_=1&_anw_=1";
		
		int i=0;
		
		try {
			//构造一个webClient 模拟Chrome 浏览器
	        WebClient webClient = new WebClient(BrowserVersion.CHROME);
	        //支持JavaScript
	        webClient.getOptions().setJavaScriptEnabled(true);
	        webClient.getOptions().setCssEnabled(false);
	        webClient.getOptions().setActiveXNative(false);
	        webClient.getOptions().setCssEnabled(false);
	        webClient.getOptions().setThrowExceptionOnScriptError(false);
	        webClient.getOptions().setThrowExceptionOnFailingStatusCode(false);
	        webClient.getOptions().setTimeout(8000);
	        HtmlPage rootPage = webClient.getPage(url);
	        //设置一个运行JavaScript的时间
	        webClient.waitForBackgroundJavaScript(6000);
	        String html = rootPage.asXml();
	        Document doc = Jsoup.parse(html);
			//System.out.println(doc);
	        Element div1 = doc.select(".cover_data_china").first();
	        Element cover_confirm = div1.select(".cover_confirm").select(".number").first();
	        leiji = cover_confirm.text();
	        Element cover_dead = div1.select(".cover_dead").select(".number").first();
            siwang = cover_dead.text();
            Element cover_heal = div1.select(".cover_heal").select(".number").first();
            zhiyu = cover_heal.text();
	        System.out.println("中国累计确诊:"+leiji+"累计死亡:"+siwang+"累计治愈"+zhiyu );
            Date currentTime=new Date();
            SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd HH:mm");
            String time = formatter.format(currentTime);//获取当前时间
            SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
            String date = sdf.format(currentTime);//获取当前日期
            AddService dao=new AddService();
            dao.delete_all("worldinfo",date);
            kind='1';
            dao.add("worldinfo", "中国", xinzeng, leiji, zhiyu, siwang,time,kind);//将爬取到的数据添加至数据库
			Element listdiv11 = doc.getElementById("overseas_list");
			Elements listdiv22 =listdiv11.select(".overseas_list_nation");
			for(Element s:listdiv22) {
			    Elements real_name=s.select(".overseas_list_name");
                Elements real_newconfirm=s.select(".overseas_list_today_confirm");
                Elements real_confirm=s.select(".overseas_list_confirm");
                Elements real_dead=s.select(".overseas_list_dead");
                Elements real_heal=s.select(".overseas_list_heal");
                country=real_name.text();
                xinzeng=real_newconfirm.text();
                leiji=real_confirm.text();
                zhiyu=real_heal.text();
                siwang=real_dead.text();
                System.out.println(country+" 新增确诊:"+xinzeng+" 累计确诊:"+leiji+" 累计治愈:"+zhiyu+" 累计死亡:"+siwang);
                kind='2';//1代表国内省份，2代表海外，为国内外分开查询做基础
                dao.add("worldinfo", country, xinzeng, leiji, zhiyu, siwang,time,kind);//将爬取到的数据添加至数据库           
			}    
			
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
			System.out.println("爬取失败");
		}
	}
	
}
