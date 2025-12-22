package Models;

import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

public class HoaDonDAO {
	public int Them(Long makh) throws Exception {
		KetNoi kn = new KetNoi();
		kn.ketnoi();
		
		String sql = "INSERT INTO hoadon(makh, NgayMua, damua) VALUES (?,GETDATE(), 0)";
		PreparedStatement ps = kn.cn.prepareStatement(sql);
		
		ps.setLong(1, makh);
		int kq = ps.executeUpdate();
		kn.cn.close();
		return kq;
	}
	
	// Lấy ra danh sách hóa đơn hôm nay
	public ArrayList<ThongKeDonHang>  getHoaDonHomNay() throws Exception {
		ArrayList<ThongKeDonHang> lst = new ArrayList<ThongKeDonHang>();
		KetNoi kn = new KetNoi();
		kn.ketnoi();
		String sql = "SELECT KhachHang.makh, KhachHang.hoten, SUM(ChiTietHoaDon.SoLuongMua) AS tongsoluong, SUM(sach.gia * ChiTietHoaDon.SoLuongMua) AS thanhtien, hoadon.damua, hoadon.MaHoaDon\r\n"
				+ "FROM     hoadon INNER JOIN\r\n"
				+ "                  KhachHang ON hoadon.makh = KhachHang.makh INNER JOIN\r\n"
				+ "                  ChiTietHoaDon ON hoadon.MaHoaDon = ChiTietHoaDon.MaHoaDon INNER JOIN\r\n"
				+ "                  sach ON ChiTietHoaDon.MaSach = sach.masach\r\n"
				+ "WHERE  (DATEDIFF(day, hoadon.NgayMua, CAST(GETDATE() AS date)) = 0) AND (hoadon.damua IN (1, 2, 3))\r\n"
				+ "GROUP BY KhachHang.makh, KhachHang.hoten, hoadon.MaHoaDon, hoadon.damua";
		
		PreparedStatement ps = kn.cn.prepareStatement(sql);
		ResultSet rs = ps.executeQuery();
		while(rs.next()) {
			long maKh = rs.getLong("makh");
		    String hoTen = rs.getString("hoten");
		    long tongSoLuong = rs.getLong("tongsoluong");
		    long thanhTien = rs.getLong("thanhtien");
		    int daMua = rs.getInt("damua");
		    long maHoaDon = rs.getLong("MaHoaDon");
		    
		    lst.add(new ThongKeDonHang(maKh, hoTen, tongSoLuong, thanhTien, daMua, maHoaDon));
		}
		kn.cn.close();
		return lst;
	}
	
	// Lấy ra danh sách hóa đơn chưa thanh toán của 1 khach hang
	public ArrayList<HoaDonDTO> getHoaDonDaMuaChuaTT(long maKh) throws Exception {
		ArrayList<HoaDonDTO> ds = new ArrayList<>();
		KetNoi kn = new KetNoi();
		kn.ketnoi();
		
		String sql = "SELECT hd.MaHoaDon, hd.NgayMua, SUM(ct.SoLuongMua * s.gia) AS TongTien\r\n"
				+ "FROM     hoadon AS hd INNER JOIN\r\n"
				+ "			ChiTietHoaDon AS ct ON hd.MaHoaDon = ct.MaHoaDon INNER JOIN\r\n"
				+ "				sach AS s ON ct.MaSach = s.masach\r\n"
				+ "GROUP BY hd.MaHoaDon, hd.NgayMua, hd.damua, hd.makh\r\n"
				+ "HAVING (hd.makh = ?) AND (hd.damua = 0)\r\n"
				+ "ORDER BY hd.NgayMua DESC";
		PreparedStatement ps = kn.cn.prepareStatement(sql);
		ps.setLong(1, maKh);
		
		ResultSet rs = ps.executeQuery();
		while(rs.next()) {
			long maHoaDon = rs.getLong("MaHoaDon");
			Date ngaymua = rs.getDate("NgayMua");
			long tongtien = rs.getLong("TongTien");
			
			HoaDonDTO hd = new HoaDonDTO(maKh, maHoaDon, null, 0, ngaymua, tongtien);
			ds.add(hd);
		}
		kn.cn.close();
		return ds;
	}
	
	// Lấy ra các sách trong hóa đơn của 1 khách hàng
	public ArrayList<HoaDonChiTietSachDTO> getDSSachTrongHoaDon(long maKhachHang, long maHoaDon) throws Exception {
	    ArrayList<HoaDonChiTietSachDTO> ds = new ArrayList<>();
	    KetNoi kn = new KetNoi();
	    kn.ketnoi();
	    
	    String sql = "SELECT hd.MaHoaDon, s.masach, s.tensach, s.anh, s.gia, cthd.SoLuongMua, s.gia * cthd.SoLuongMua AS ThanhTien, hd.NgayMua\r\n"
	    		+ "FROM     hoadon AS hd INNER JOIN\r\n"
	    		+ "                  ChiTietHoaDon AS cthd ON hd.MaHoaDon = cthd.MaHoaDon INNER JOIN\r\n"
	    		+ "                  sach AS s ON cthd.MaSach = s.masach\r\n"
	    		+ "WHERE  (hd.makh = ?) AND (hd.MaHoaDon = ?)";

        PreparedStatement ps = kn.cn.prepareStatement(sql);
        ps.setLong(1, maKhachHang);
        ps.setLong(2, maHoaDon);

        ResultSet rs = ps.executeQuery();
        while (rs.next()) {
            HoaDonChiTietSachDTO dto = new HoaDonChiTietSachDTO(
                rs.getLong("MaHoaDon"),
                rs.getString("masach"),
                rs.getString("tensach"),
                rs.getString("anh"),
                rs.getLong("gia"),
                rs.getLong("SoLuongMua"),
                rs.getLong("ThanhTien"),
                rs.getDate("NgayMua")
            );
            
            ds.add(dto);
	    }
        
        kn.cn.close();
	    return ds;
	}
	
	// thanh toán hóa đơn
	public int thanhToanHD(long maHD) throws Exception {
		KetNoi kn  = new KetNoi();
		kn.ketnoi();
		
		String sql = "UPDATE hoadon SET damua = 1, NgayMua = GETDATE() WHERE MaHoaDon = ?";
		PreparedStatement ps = kn.cn.prepareStatement(sql);
		ps.setLong(1, maHD);	
		int kq = ps.executeUpdate();
		
		String sql2 = "UPDATE ChiTietHoaDon SET damua = 1 WHERE MaHoaDon = ?";
		PreparedStatement ps2 = kn.cn.prepareStatement(sql2);
		ps2.setLong(1, maHD);
		kq += ps2.executeUpdate();
		
		kn.cn.close();
		return kq;
	}
	
	// Admin xác nhận hóa đơn
	public int xacNhanHD(long maHD) throws Exception {
		KetNoi kn  = new KetNoi();
		kn.ketnoi();
		
		// lấy danh sách sách, số lượng trong hóa đơn
		String sqlGetSach = "SELECT MaSach, SoLuongMua FROM ChiTietHoaDon WHERE MaHoaDon = ?";
		PreparedStatement psGet = kn.cn.prepareStatement(sqlGetSach);
		psGet.setLong(1, maHD);
		ResultSet rs = psGet.executeQuery();
		
		String sqlUpdateKho = "UPDATE sach SET soluong = soluong - ? WHERE masach = ?";
		PreparedStatement psUpdateKho = kn.cn.prepareStatement(sqlUpdateKho);
		
		while(rs.next()) {
			String maSach = rs.getString("MaSach");
			long soLuongMua = rs.getLong("SoLuongMua");
			
			psUpdateKho.setLong(1, soLuongMua);
			psUpdateKho.setString(2, maSach);
			
			psUpdateKho.executeUpdate();
		}
		
		String sql = "UPDATE hoadon SET damua = 2, NgayMua = GETDATE() WHERE MaHoaDon = ?";
		PreparedStatement ps = kn.cn.prepareStatement(sql);
		ps.setLong(1, maHD);	
		int kq = ps.executeUpdate();
		
		String sql2 = "UPDATE ChiTietHoaDon SET damua = 2 WHERE MaHoaDon = ?";
		PreparedStatement ps2 = kn.cn.prepareStatement(sql2);
		ps2.setLong(1, maHD);
		kq += ps2.executeUpdate();
		
		kn.cn.close();
		return kq;
	}
	
	// Admin từ chối hóa đơn
	public int tuchoiHD(long maHD) throws Exception {
		KetNoi kn  = new KetNoi();
		kn.ketnoi();
		
		String sql = "UPDATE hoadon SET damua = 3, NgayMua = GETDATE() WHERE MaHoaDon = ?";
		PreparedStatement ps = kn.cn.prepareStatement(sql);
		ps.setLong(1, maHD);	
		int kq = ps.executeUpdate();
		
		String sql2 = "UPDATE ChiTietHoaDon SET damua = 3 WHERE MaHoaDon = ?";
		PreparedStatement ps2 = kn.cn.prepareStatement(sql2);
		ps2.setLong(1, maHD);
		kq += ps2.executeUpdate();
		
		kn.cn.close();
		return kq;
	}
	
	public int deleteHoaDon(long maHD) throws Exception {
		KetNoi kn = new KetNoi();
		kn.ketnoi();
		
		// xóa bảng CT hóa đơn
		String sql1 = "DELETE FROM ChiTietHoaDon WHERE MaHoaDon = ?";
		PreparedStatement ps1 = kn.cn.prepareStatement(sql1);
		ps1.setLong(1, maHD);
		int kq = ps1.executeUpdate();
		
		//xóa bảng hóa đơn
		String sql2 = "DELETE FROM hoadon WHERE MaHoaDon = ?";
		PreparedStatement ps2 = kn.cn.prepareStatement(sql2);
		ps2.setLong(1, maHD);
		kq += ps2.executeUpdate();
		
		kn.cn.close();
		return kq;
	}
	
	// Lấy danh sách hóa đơn đã thanh toán (Chưa xác nhận của admin) của all khách hàng
	public ArrayList<HoaDonDTO> getDSHDDaTTAllKH() throws Exception {
		ArrayList<HoaDonDTO> ds = new ArrayList<>();
		KetNoi kn = new KetNoi();
		kn.ketnoi();
		
		String sql = "SELECT KhachHang.makh, KhachHang.hoten, hd.NgayMua, SUM(ct.SoLuongMua * s.gia) AS TongTien, hd.MaHoaDon\r\n"
				+ "FROM     hoadon AS hd INNER JOIN\r\n"
				+ "                  ChiTietHoaDon AS ct ON hd.MaHoaDon = ct.MaHoaDon INNER JOIN\r\n"
				+ "                  sach AS s ON ct.MaSach = s.masach INNER JOIN\r\n"
				+ "                  KhachHang ON hd.makh = KhachHang.makh\r\n"
				+ "GROUP BY hd.MaHoaDon, hd.NgayMua, hd.damua, hd.makh, KhachHang.makh, KhachHang.hoten\r\n"
				+ "HAVING (hd.damua = 1)\r\n"
				+ "ORDER BY hd.NgayMua DESC";
		PreparedStatement ps = kn.cn.prepareStatement(sql);
		
		ResultSet rs = ps.executeQuery();
		while(rs.next()) {
			long maKh = rs.getLong("makh");
			String hoTen = rs.getString("hoten");
			Date ngaymua = rs.getDate("NgayMua");
			long maHoaDon = rs.getLong("MaHoaDon");
			long tongtien = rs.getLong("TongTien");
			
			HoaDonDTO hd = new HoaDonDTO(maKh, maHoaDon, hoTen, 2, ngaymua, tongtien);
			ds.add(hd);
		}
		kn.cn.close();
		
		return ds;
	}
	
	// Lấy danh sách hóa đơn đã thanh toán ( Được xác nhận của admin) của all KH 
	public ArrayList<HoaDonDTO> getDSHDDaXacNhanAllKH() throws Exception {
		ArrayList<HoaDonDTO> ds = new ArrayList<>();
		KetNoi kn = new KetNoi();
		kn.ketnoi();
		
		String sql = "SELECT KhachHang.makh, KhachHang.hoten, hd.NgayMua, SUM(ct.SoLuongMua * s.gia) AS TongTien, hd.MaHoaDon\r\n"
				+ "FROM     hoadon AS hd INNER JOIN\r\n"
				+ "                  ChiTietHoaDon AS ct ON hd.MaHoaDon = ct.MaHoaDon INNER JOIN\r\n"
				+ "                  sach AS s ON ct.MaSach = s.masach INNER JOIN\r\n"
				+ "                  KhachHang ON hd.makh = KhachHang.makh\r\n"
				+ "GROUP BY hd.MaHoaDon, hd.NgayMua, hd.damua, hd.makh, KhachHang.makh, KhachHang.hoten\r\n"
				+ "HAVING (hd.damua = 2)\r\n"
				+ "ORDER BY hd.NgayMua DESC";
		PreparedStatement ps = kn.cn.prepareStatement(sql);
		
		ResultSet rs = ps.executeQuery();
		while(rs.next()) {
			long maKh = rs.getLong("makh");
			String hoTen = rs.getString("hoten");
			Date ngaymua = rs.getDate("NgayMua");
			long maHoaDon = rs.getLong("MaHoaDon");
			long tongtien = rs.getLong("TongTien");
			
			HoaDonDTO hd = new HoaDonDTO(maKh, maHoaDon, hoTen, 2, ngaymua, tongtien);
			ds.add(hd);
		}
		kn.cn.close();
		
		return ds;
	}
}
