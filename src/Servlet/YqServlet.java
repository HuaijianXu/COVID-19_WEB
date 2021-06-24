package Servlet;

import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.google.gson.Gson;

import Bean.Info;
import Dao.Get;


/**
 * Servlet implementation class SearchConfirmedServlet
 */
@WebServlet("/YqServlet")
public class YqServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    Get get=new Get();
    /**
     * @see HttpServlet#HttpServlet()
     */
    public YqServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

    /**
     * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
     */
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String method = request.getParameter("method");
        if(method.equals("getAllProvince")) {
            getAllProvince(request, response);
        }else if(method.equals("getAllConfirmed")) {
            getAllConfirmed(request, response);
        }else if(method.equals("getChina")) {
        	getChina(request,response);
        }else if(method.equals("getWorld")) {
            getWorld(request,response);
        }else if(method.equals("everydayinfo")) {
            everydayinfo(request,response);
        }
    }

    private void everydayinfo(HttpServletRequest request, HttpServletResponse response) throws IOException {
        // TODO Auto-generated method stub
        response.setCharacterEncoding("UTF-8");
        List<Info> list=get.listEverydayInfo();
        Gson gson=new Gson();
        String json=gson.toJson(list);
        System.out.println(json);
        response.getWriter().write(json);
    }

    private void getWorld(HttpServletRequest request, HttpServletResponse response) throws IOException {
        // TODO Auto-generated method stub
        response.setCharacterEncoding("UTF-8");
        Date currentTime=new Date();
        SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd");
        String time = formatter.format(currentTime);//获取当前时间
        List<Info> list=get.listAllWorld(time);
        Gson gson=new Gson();
        String json=gson.toJson(list);
        System.out.println(json);
        response.getWriter().write(json);
    }

    private void getChina(HttpServletRequest request, HttpServletResponse response) throws ServletException,IOException {
		// TODO Auto-generated method stub
        response.setCharacterEncoding("UTF-8");
		String time=request.getParameter("time");
		List<Info> list=get.listAllChina(time);
		Gson gson=new Gson();
		String json=gson.toJson(list);
		System.out.println(json);
		response.getWriter().write(json);
	}

	/**
     * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
     */
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // TODO Auto-generated method stub
        doGet(request, response);
    }
    protected void getAllProvince(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.setCharacterEncoding("UTF-8");
        String date1 = request.getParameter("date1");
        String date2 = request.getParameter("date2");
        List<Info> list = get.listAll(date1,date2);
        request.setAttribute("list",list);
        request.setAttribute("date1",date1);
        request.setAttribute("date2",date2);
        request.getRequestDispatcher("bar.jsp").forward(request, response);
    }
    
    protected void getAllConfirmed(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.setCharacterEncoding("UTF-8");
        String date1 = request.getParameter("date1");
        String date2 = request.getParameter("date2");
        System.out.println(date1);
        System.out.println(date2);
        List<Info> list = get.listAll(date1,date2);
        HttpSession session = request.getSession();
        session.setAttribute("list",list);
        Gson gson = new Gson();
        String json = gson.toJson(list);
        response.getWriter().write(json);
    }
}