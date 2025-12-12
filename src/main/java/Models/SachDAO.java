package Models;

import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

public class SachDAO {
	public ArrayList<Sach> getSach() throws Exception{
	    ArrayList<Sach> ds= new ArrayList<Sach>();
	    //b1: Kết nối vao csdl
	      KetNoi kn= new KetNoi();
	      kn.ketnoi();
	    //b2: Thiet lap cau lenh sql
	      String sql= "select * from sach";
	      PreparedStatement cmd= kn.cn.prepareStatement(sql);
	    //b3: Truyen tham so vao cau lẹnh sql (neu co)
	      //b4: Cho thuc hien cau lenh sql
	      ResultSet rs= cmd.executeQuery();
	    //b5: Duyet rs va luu vao mang dong
	      while(rs.next()) {
	    	  String masach =rs.getString("masach");
	    	  String tensach =rs.getString("tensach");
	    	  String tacgia = rs.getString("tacgia");
	    	  long soluong = rs.getLong("soluong");
	    	  long gia = rs.getLong("gia");
	    	  String maloai =rs.getString("maloai");
	    	  String anh =rs.getString("anh");
	    	  String sotap = rs.getString("sotap");
	    	  Date ngaynhap = rs.getDate("NgayNhap");
	    	  
	    	  ds.add(new Sach(masach, tensach, soluong, gia, maloai, sotap, anh, ngaynhap, tacgia));
	      }
	    //b6: Dong  cac doi tuong dang mo: rs, ket noi
	      rs.close();kn.cn.close();
	    return ds;
	}
	
	public ArrayList<Sach> TimKiemMa(String maLoai) throws Exception {
		ArrayList<Sach> lst = new ArrayList<Sach>();
		KetNoi kn = new KetNoi();
		kn.ketnoi();
		String sql = "SELECT * FROM Sach WHERE maloai = ?";
		PreparedStatement pr = kn.cn.prepareStatement(sql);
		pr.setString(1, maLoai);
		ResultSet rs = pr.executeQuery();
		while(rs.next()) {
			String masach =rs.getString("masach");
	    	  String tensach =rs.getString("tensach");
	    	  String tacgia = rs.getString("tacgia");
	    	  long soluong = rs.getLong("soluong");
	    	  long gia = rs.getLong("gia");
	    	  String maloai =rs.getString("maloai");
	    	  String anh =rs.getString("anh");
	    	  String sotap = rs.getString("sotap");
	    	  Date ngaynhap = rs.getDate("NgayNhap");
	    	  
	    	  lst.add(new Sach(masach, tensach, soluong, gia, maloai, sotap, anh, ngaynhap, tacgia));
		}
		
		return lst;
	}
	
	public ArrayList<Sach> TimKiemSearch(String key) throws Exception {
		ArrayList<Sach> lst = new ArrayList<Sach>();
		KetNoi kn = new KetNoi();
		kn.ketnoi();
		String sql = "SELECT * \r\n"
				+ "FROM sach \r\n"
				+ "WHERE tensach LIKE ? OR maloai LIKE ? OR tacgia LIKE ?";
		PreparedStatement pr = kn.cn.prepareStatement(sql);
		String mau = "%" + key + "%";
		pr.setString(1, mau);
		pr.setString(2, mau);
		pr.setString(3, mau);
		ResultSet rs = pr.executeQuery();
		while(rs.next()) {
			String masach =rs.getString("masach");
	    	  String tensach =rs.getString("tensach");
	    	  String tacgia = rs.getString("tacgia");
	    	  long soluong = rs.getLong("soluong");
	    	  long gia = rs.getLong("gia");
	    	  String maloai =rs.getString("maloai");
	    	  String anh =rs.getString("anh");
	    	  String sotap = rs.getString("sotap");
	    	  Date ngaynhap = rs.getDate("NgayNhap");
	    	  
	    	  lst.add(new Sach(masach, tensach, soluong, gia, maloai, sotap, anh, ngaynhap, tacgia));
		}
		
		return lst;
	}
	
	public int getTongSach(String ml, String key) throws Exception {
		KetNoi kn = new KetNoi();
		kn.ketnoi();
		
		String sql = "SELECT COUNT(*) FROM sach WHERE 1=1";
		
		if(ml != null) {
			sql += " AND maloai=?";
		}
		if(key != null) {
			sql += " AND tensach LIKE ?";
		}
		
		PreparedStatement ps = kn.cn.prepareStatement(sql);
		
		int index = 1;
		if(ml != null ) ps.setString(index++, ml);
		if(key != null) ps.setString(index++, "%" + key + "%");
		
		
		ResultSet rs = ps.executeQuery();
		int total = 0;
		if(rs.next()) total = rs.getInt(1);
		
		rs.close();
		kn.cn.close();
		return total;
	}
	
	public ArrayList<Sach> getDanhSachPhanTrang(int page, int pageSize, String ml, String key) throws Exception {
		ArrayList<Sach> ds = new ArrayList<Sach>();
		KetNoi kn = new KetNoi();
		kn.ketnoi();
		
		int offset = (pageSize * page) - pageSize; 
		String sql = "SELECT * FROM sach WHERE 1=1 ";	
		if(ml != null) {
			sql += "AND maloai=? ";
		}
		if(key != null) {
			sql += "AND tensach LIKE ? ";
		}		
		sql += "ORDER BY masach OFFSET ? ROWS FETCH NEXT ? ROWS ONLY";
		
		PreparedStatement ps = kn.cn.prepareStatement(sql);
	    int index = 1;

	    if (ml != null && !ml.isEmpty()) {
	        ps.setString(index++, ml);
	    }
	    if (key != null && !key.isEmpty()) {
	        ps.setString(index++, "%" + key + "%");
	    }
		
		ps.setInt(index++, offset);
		ps.setInt(index++, pageSize);
		
		ResultSet rs = ps.executeQuery();
		while(rs.next()) {			
			String masach =rs.getString("masach");
			String tensach =rs.getString("tensach");
			String tacgia = rs.getString("tacgia");
			long soluong = rs.getLong("soluong");
			long gia = rs.getLong("gia");
			String maloai =rs.getString("maloai");
			String anh =rs.getString("anh");
			String sotap = rs.getString("sotap");
			Date ngaynhap = rs.getDate("NgayNhap");
			  
			ds.add(new Sach(masach, tensach, soluong, gia, maloai, sotap, anh, ngaynhap, tacgia));
		}
		rs.close();
		kn.cn.close();
		return ds;
	}
}
