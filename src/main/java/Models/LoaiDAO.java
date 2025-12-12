package Models;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Map;

public class LoaiDAO {
	public ArrayList<Loai> getLoai() throws Exception{
	    ArrayList<Loai> ds= new ArrayList<Loai>();
	    //b1: Kết nối vao csdl
	      KetNoi kn= new KetNoi();
	      kn.ketnoi();
	    //b2: Thiet lap cau lenh sql
	      String sql= "select * from loai";
	      PreparedStatement cmd= kn.cn.prepareStatement(sql);
	    //b3: Truyen tham so vao cau lẹnh sql (neu co)
	      //b4: Cho thuc hien cau lenh sql
	      ResultSet rs= cmd.executeQuery();
	    //b5: Duyet rs va luu vao mang dong
	      while(rs.next()) {
	    	  String maloai =rs.getString("maloai");
	    	  String tenloai=rs.getString("tenloai");
	    	  ds.add(new Loai(maloai, tenloai));
	      }
	    //b6: Dong  cac doi tuong dang mo: rs, ket noi
	      rs.close();kn.cn.close();
	      return ds;
	}
	
	public Map<String, Long> getSoLuongSachTheoLoai() throws Exception {
		KetNoi kn = new KetNoi();
		kn.ketnoi();
		Map<String, Long> mp = new HashMap<>();
		
		String sql = "SELECT MaLoai, COUNT(*) AS SoLuong \r\n"
					+ "FROM Sach \r\n"
					+ "GROUP BY MaLoai";
		PreparedStatement pr = kn.cn.prepareStatement(sql);
		ResultSet rs = pr.executeQuery();
		while(rs.next()) {
			mp.put(rs.getString("MaLoai"), rs.getLong("SoLuong"));
		}
		
		return mp;
	}
	
	public int updateLoai(String maLoai, String tenMoi) throws Exception {
		KetNoi kn = new KetNoi();
		kn.ketnoi();
		
		String sql = "UPDATE loai SET tenloai = ? WHERE maloai = ?";
		PreparedStatement pr = kn.cn.prepareStatement(sql);
		
		pr.setString(1, tenMoi);
		pr.setString(2, maLoai);
		
		int kq = pr.executeUpdate();
		kn.cn.close();
		return kq;
	}
	
	public int addLoai(String maLoai, String tenLoai) throws Exception {
		KetNoi kn = new KetNoi();
		kn.ketnoi();
		
		String sql = "INSERT INTO loai(maloai, tenloai) VALUES(?, ?)";
		PreparedStatement pr = kn.cn.prepareStatement(sql);
		pr.setString(1, maLoai);
		pr.setString(2, tenLoai);
		
		int kq = pr.executeUpdate();
		kn.cn.close();
		return kq;
	}
	
	public int deleteLoai(String maLoai) throws Exception {
		KetNoi kn = new KetNoi();
		kn.ketnoi();
		
		String sql = "DELETE FROM loai WHERE maloai = ?";
		PreparedStatement pr = kn.cn.prepareStatement(sql);
		pr.setString(1, maLoai);
		
		int kq = pr.executeUpdate();
		kn.cn.close();
		return kq;
	}
	
	public boolean CheckSachTrongLoai(String maLoai) throws Exception {
		KetNoi kn = new KetNoi();
		kn.ketnoi();
		
	    String sql = "SELECT COUNT(*) AS SoLuong FROM sach WHERE maloai = ?";
	    PreparedStatement pr = kn.cn.prepareStatement(sql);
	    pr.setString(1, maLoai);
	    
	    ResultSet rs = pr.executeQuery();
        if (rs.next()) {
            return rs.getInt("SoLuong") > 0;
        }
	    return false;
	}

}
