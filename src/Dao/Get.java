package Dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.List;

import Bean.Info;
import util.DBUtil;

public class Get {
	public List<Info> listAll(String date1,String date2) {
		ArrayList<Info> list = new ArrayList<>();
		Connection conn=DBUtil.getConn();
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql="select * from myinfo where Time between ? and ?";
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, date1);
			pstmt.setString(2, date2);
			rs = pstmt.executeQuery();
			while (rs.next()) {
				Info yq = new Info();
//				yq.setId(rs.getInt(1));
//				yq.setDate(rs.getString(2));
//				yq.setProvince(rs.getString(3));
//				yq.setCity(rs.getString(4));
//				yq.setConfirmed_num(rs.getString(5));
//				yq.setYisi_num(rs.getString(6));
//				yq.setCured_num(rs.getString(7));
//				yq.setDead_num(rs.getString(8));
//				yq.setCode(rs.getString(9));
                yq.setId(rs.getInt(1));
                yq.setDate(rs.getString(8));
                yq.setProvince(rs.getString(2));
                yq.setConfirmed_num(rs.getString(4));
                yq.setYisi_num(rs.getString(5));
                yq.setCured_num(rs.getString(6));
                yq.setDead_num(rs.getString(7));
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

	public List<Info> listAllChina(String time) {
		// TODO Auto-generated method stub
		ArrayList<Info> list = new ArrayList<>();
		Connection conn=DBUtil.getConn();
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql="select * from myinfo where date(Time) = ?";
		System.out.println(sql);
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, time);
			System.out.println(pstmt);
			rs = pstmt.executeQuery();
			while (rs.next()) {
				Info yq = new Info();
                yq.setId(rs.getInt(1));
                yq.setDate(rs.getString(8));
                yq.setProvince(rs.getString(2));
                yq.setConfirmed_num(rs.getString(4));
                yq.setYisi_num(rs.getString(5));
                yq.setCured_num(rs.getString(6));
                yq.setDead_num(rs.getString(7));
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

    public List<Info> listAllWorld(String time) {
        // TODO Auto-generated method stub
        // TODO Auto-generated method stub
        ArrayList<Info> list = new ArrayList<>();
        Connection conn=DBUtil.getConn();
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        String sql="select * from worldinfo where date(Time) = ?";
        System.out.println(sql);
        try {
            pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, time);
            System.out.println(pstmt);
            rs = pstmt.executeQuery();
            while (rs.next()) {
                Info yq = new Info();
                yq.setId(rs.getInt(1));
                yq.setDate(rs.getString(8));
                yq.setProvince(rs.getString(2));
                yq.setConfirmed_num(rs.getString(4));
                yq.setYisi_num(rs.getString(5));
                yq.setCured_num(rs.getString(6));
                yq.setDead_num(rs.getString(7));
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

    public List<Info> listEverydayInfo() {
        // TODO Auto-generated method stub
        ArrayList<Info> list = new ArrayList<>();
        Connection conn=DBUtil.getConn();
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        String sql="select * from worldinfo";
        System.out.println(sql);
        try {
            pstmt = conn.prepareStatement(sql);
            System.out.println(pstmt);
            rs = pstmt.executeQuery();
            int t=0;
            int sum=0;
            String date="";
            while (rs.next()) {
                t++;
                Info yq = new Info();
                yq.setDate(rs.getString(8));
                if(t==1) {
                    date= yq.getDate();
                }
                if(date.equals(yq.getDate())) {
                    sum+=Integer.parseInt(rs.getString(4));
                }
                else {
                    Info info = new Info();
                    info.setDate(date.substring(0,10));
                    info.setConfirmed_num(String.valueOf(sum));
                    list.add(info);
                    System.out.println(list);
                    date= yq.getDate();
                    sum=Integer.parseInt(rs.getString(4));
                }
            }
            Info info = new Info();
            info.setDate(date.substring(0,10));
            info.setConfirmed_num(String.valueOf(sum));
            list.add(info);
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
