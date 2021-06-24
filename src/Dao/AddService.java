package Dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;

import util.DBUtil;


public class AddService {
	public void add(String table,String sheng,String xinzeng,String leiji,String zhiyu,String dead,String time,char kind) {
		String sql = "insert into "+table+" (Province,Newconfirmed_num ,Confirmed_num,Cured_num,Dead_num,Time,Kind) values('" + sheng + "','" + xinzeng +"','" + leiji +"','" + zhiyu + "','" + dead+ "','" + time+ "','" + kind+ "')";
		System.out.println(sql);
		Connection conn = DBUtil.getConn();
		Statement state = null;
		int a = 0;
		try {
			state = conn.createStatement();
			a=state.executeUpdate(sql);
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			DBUtil.close(state, conn);
		}		
	}
	
	public void delete_all(String table,String date) {
	    boolean c=false;
        Connection conn=DBUtil.getConn();
        PreparedStatement state=null;
        String sql="delete from "+table+" where date(Time) =?";
        try {
            state=conn.prepareStatement(sql);
            state.setString(1,date);
            int num = state.executeUpdate();
            if(num!=0)
            {
                c= true;
            }
            state.close();
            conn.close();
        } catch (SQLException e) {
            // TODO Auto-generated catch block
            e.printStackTrace();
        }     
    }
}
