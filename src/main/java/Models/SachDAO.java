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
	
	public int getTongSachOfAdmin(String key) throws Exception {
	    KetNoi kn = new KetNoi();
	    kn.ketnoi();

	    String sql = "SELECT COUNT(*) FROM sach WHERE maloai LIKE ? OR tensach LIKE ? OR tacgia LIKE ?";

	    PreparedStatement ps = kn.cn.prepareStatement(sql);
	    String mau = "%" + key + "%";

	    ps.setString(1, mau);
	    ps.setString(2, mau);
	    ps.setString(3, mau);

	    ResultSet rs = ps.executeQuery();
	    int total = 0;
	    if (rs.next()) total = rs.getInt(1);

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
			sql += "AND ( tensach LIKE ? OR tacgia LIKE ? ) ";
		}		
		sql += "ORDER BY masach OFFSET ? ROWS FETCH NEXT ? ROWS ONLY";
		
		PreparedStatement ps = kn.cn.prepareStatement(sql);
	    int index = 1;

	    if (ml != null && !ml.isEmpty()) {
	        ps.setString(index++, ml);
	    }
	    if (key != null && !key.isEmpty()) {
	        ps.setString(index++, "%" + key + "%");
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
	
	public ArrayList<Sach> getDanhSachPhanTrangOfAdmin(int page, int pageSize, String key) throws Exception {
	    ArrayList<Sach> ds = new ArrayList<>();
	    KetNoi kn = new KetNoi();
	    kn.ketnoi();

	    int offset = (pageSize * page) - pageSize; 
	    String sql = "SELECT * FROM sach WHERE maloai LIKE ? OR tensach LIKE ? OR tacgia LIKE ? "
	    		 	+ "ORDER BY masach OFFSET ? ROWS FETCH NEXT ? ROWS ONLY";

	    PreparedStatement ps = kn.cn.prepareStatement(sql);
	    String mau = "%" + key + "%";

	    ps.setString(1, mau);
	    ps.setString(2, mau);
	    ps.setString(3, mau);
	    ps.setInt(4, offset);
	    ps.setInt(5, pageSize);

	    ResultSet rs = ps.executeQuery();
	    while (rs.next()) {
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
	
	public int addSach(Sach s) throws Exception {
	    KetNoi kn = new KetNoi();
	    kn.ketnoi();
	    
	    String sql = " INSERT INTO sach (masach, tensach, soluong, gia, maloai, sotap, anh, NgayNhap, tacgia) VALUES (?,?,?,?,?,?,?,?,?)";
	    PreparedStatement pr = kn.cn.prepareStatement(sql);  
	    pr.setString(1, s.getMaSach());
	    pr.setString(2, s.getTenSach());
	    pr.setLong(3, s.getSoLuong());
	    pr.setLong(4, s.getGia());
	    pr.setString(5, s.getMaLoai());
	    pr.setString(6, s.getSoTap());
	    pr.setString(7, s.getAnh());
	    pr.setDate(8, s.getNgayNhap());
	    pr.setString(9, s.getTacGia());

	    int kq = pr.executeUpdate();
		kn.cn.close();
		return kq;
	}
	
	public int updateSach(Sach s) throws Exception {
	    KetNoi kn = new KetNoi();
	    kn.ketnoi();
	    
	    String sql = "UPDATE sach " 
	    			+ "SET tensach = ?, soluong = ?, gia = ?, maloai = ?, sotap = ?, anh = ?, NgayNhap = ?, tacgia = ? "
	    			+ "WHERE masach = ?";
	    PreparedStatement pr = kn.cn.prepareStatement(sql);  
	    pr.setString(1, s.getTenSach());
	    pr.setLong(2, s.getSoLuong());
	    pr.setLong(3, s.getGia());
	    pr.setString(4, s.getMaLoai());
	    pr.setString(5, s.getSoTap());
	    pr.setString(6, s.getAnh());
	    pr.setDate(7, s.getNgayNhap());
	    pr.setString(8, s.getTacGia());
	    
	    pr.setString(9, s.getMaSach());

	    int kq = pr.executeUpdate();
		kn.cn.close();
		return kq;
	}
	
	public int deleteSach(String maLoai) throws Exception {
		KetNoi kn = new KetNoi();
	    kn.ketnoi();
	    
	    String sql = "DELETE FROM sach WHERE masach = ?";
	    PreparedStatement pr = kn.cn.prepareStatement(sql);  
	    pr.setString(1, maLoai);
	    
	    int kq = pr.executeUpdate();
		kn.cn.close();
		return kq;
	}
	
	// Thống kê top 10 sách bán nhiều nhất
	public ArrayList<ThongKeTopSachDTO> getTop10SachBanChay() throws Exception {
	    ArrayList<ThongKeTopSachDTO> ds = new ArrayList<>();
	    KetNoi kn = new KetNoi();
	    kn.ketnoi();

	    String sql = "SELECT TOP (10) s.masach, s.tensach, SUM(ct.SoLuongMua) AS TongSoLuongBan\r\n"
	    		+ "FROM     loai AS l INNER JOIN\r\n"
	    		+ "                  sach AS s ON l.maloai = s.maloai INNER JOIN\r\n"
	    		+ "                  ChiTietHoaDon AS ct ON s.masach = ct.MaSach INNER JOIN\r\n"
	    		+ "                  hoadon AS hd ON ct.MaHoaDon = hd.MaHoaDon\r\n"
	    		+ "WHERE  (hd.damua = 1)\r\n"
	    		+ "GROUP BY l.maloai, l.tenloai, s.masach, s.tensach\r\n"
	    		+ "ORDER BY TongSoLuongBan DESC";

	    PreparedStatement ps = kn.cn.prepareStatement(sql);
	    ResultSet rs = ps.executeQuery();

	    while (rs.next()) {
	        ds.add(new ThongKeTopSachDTO (rs.getString("masach"), rs.getString("tensach"), rs.getLong("TongSoLuongBan")));
	    }

	    kn.cn.close();
	    return ds;
	}
	
	// Thống kê các sách có số lượng tồn kho ( < 10 quyển)
	public ArrayList<ThongKeTopSachDTO> getSachSapHet() throws Exception {
	    ArrayList<ThongKeTopSachDTO> ds = new ArrayList<>();
	    KetNoi kn = new KetNoi();
	    kn.ketnoi();

	    String sql = "SELECT masach,tensach,soluong\r\n"
	    		+ "FROM sach\r\n"
	    		+ "WHERE soluong < 10\r\n"
	    		+ "ORDER BY soluong ASC";

	    PreparedStatement ps = kn.cn.prepareStatement(sql);
	    ResultSet rs = ps.executeQuery();

	    while (rs.next()) {
	        ds.add(new ThongKeTopSachDTO (rs.getString("masach"), rs.getString("tensach"), rs.getLong("soluong")));
	    }

	    kn.cn.close();
	    return ds;
	}
	
	// Thống kê doanh thu theo tháng
	public ArrayList<ThongKeDoanhThuThangDTO> getDoanhThuThang() throws Exception {
	    ArrayList<ThongKeDoanhThuThangDTO> ds = new ArrayList<>();
	    KetNoi kn = new KetNoi();
	    kn.ketnoi();

	    String sql = "SELECT MONTH(hd.NgayMua) AS Thang,SUM(s.Gia * cthd.SoLuongMua) AS DoanhThu\r\n"
	    		+ "FROM HoaDon hd\r\n"
	    		+ "	JOIN ChiTietHoaDon cthd ON hd.MaHoaDon = cthd.MaHoaDon\r\n"
	    		+ "	JOIN Sach s ON cthd.MaSach = s.MaSach\r\n"
	    		+ "WHERE hd.DaMua = 1 AND YEAR(hd.NgayMua) = YEAR(GETDATE())\r\n"
	    		+ "GROUP BY MONTH(hd.NgayMua)\r\n"
	    		+ "ORDER BY Thang;";

	    PreparedStatement ps = kn.cn.prepareStatement(sql);
	    ResultSet rs = ps.executeQuery();

	    while (rs.next()) {
	        ds.add(new ThongKeDoanhThuThangDTO (rs.getLong("Thang"), rs.getLong("DoanhThu")));
	    }

	    kn.cn.close();
	    return ds;
	}
 
}
