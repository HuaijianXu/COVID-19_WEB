package Servlet;

import java.io.IOException;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.google.gson.Gson;

import Bean.City;
import Bean.Info;
import Dao.InfoDao;

@WebServlet("/info")
public class InfoServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    InfoDao dao = new InfoDao();
    public InfoServlet() {
        super();
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        response.setCharacterEncoding("UTF-8");
        String method = request.getParameter("method");        
        if(method.equals("city")) {
            try {
                city(request, response);
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }else if(method.equals("d")) {
            try {
                d(request, response);
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
        //response.getWriter().append("Served at: ").append(request.getContextPath());
    }
    /**
     * @param request
     * @param response
     */
    private void d(HttpServletRequest request, HttpServletResponse response)throws SQLException, ServletException, IOException {
        // TODO Auto-generated method stub
        String province = request.getParameter("province");
        String time = "2020-02-12 10:14:15";
        List<Info> list = dao.getListC(time,province);
        List<City> data = new ArrayList<City>();
        for(int i=1; i<list.size();i++) {
            City city = new City();
            city.setName(list.get(i).getCity());
            city.setValue(Integer.parseInt(list.get(i).getConfirmed_num()));
            data.add(city);
        }
        Gson gson = new Gson();
        String json = gson.toJson(data);
        System.out.println(json);
        response.getWriter().write(json);
    }

    /**
     * @param request
     * @param response
     */
    private void city(HttpServletRequest request, HttpServletResponse response)throws SQLException, ServletException, IOException {
        // TODO Auto-generated method stub
        String province = request.getParameter("province");
        String time = "2020-02-12 10:14:15";
        List<Info> list = dao.getListC(time,province);
        List<City> data = new ArrayList<City>();
        for(int i=1; i<list.size();i++) {
            City city = new City();
            city.setName(list.get(i).getCity());
            city.setValue(Integer.parseInt(list.get(i).getConfirmed_num()));
            data.add(city);
        }
        Gson gson = new Gson();
        String json = gson.toJson(data);
        System.out.println(json);
        request.setAttribute("list", json);
        request.setAttribute("province", province);
        request.getRequestDispatcher("city.jsp").forward(request, response);
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doGet(request, response);
    }

}
