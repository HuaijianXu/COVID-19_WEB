package Dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;


import Bean.Info;
import util.DBUtil;



/**
 * @author 王正帅
 * @date: 2020年3月3日 下午3:39:20 
 * 
 */
public class InfoDao {

    /**
     * @return
     * @throws SQLException 
     */

    public List<Info> getListC(String date,String province) throws SQLException {
        
        List<Info> list = new ArrayList<>();
        Connection conn=DBUtil.getConn();
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        String sql = "select * from info1 where date = ? and province =?";
        try {
            pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, date);
            pstmt.setString(2, province);
            System.out.println(pstmt);
            rs = pstmt.executeQuery();
            while (rs.next()) {
                Info yq = new Info();
                yq.setId(rs.getInt(1));
                yq.setDate(rs.getString(2));
                yq.setProvince(rs.getString(3));
                yq.setCity(rs.getString(4));
                yq.setConfirmed_num(rs.getString(5));
                yq.setYisi_num(rs.getString(6));
                yq.setCured_num(rs.getString(7));
                yq.setDead_num(rs.getString(8));
                list.add(yq);
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            try {
                conn.close();
            } catch (Exception e) {
                e.printStackTrace();
            }
        }
        return list;
    }
    
}