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
	
	public ArrayList<ThongKeDonHang>  getHoaDonHomNay() throws Exception {
		ArrayList<ThongKeDonHang> lst = new ArrayList<ThongKeDonHang>();
		KetNoi kn = new KetNoi();
		kn.ketnoi();
		String sql = "SELECT dbo.KhachHang.makh, dbo.KhachHang.hoten,\r\n"
				+ "SUM(dbo.ChiTietHoaDon.SoLuongMua) AS tongsoluong, SUM(dbo.sach.gia) AS tonggia,\r\n"
				+ "SUM(dbo.sach.gia * dbo.ChiTietHoaDon.SoLuongMua) AS thanhtien, dbo.hoadon.MaHoaDon\r\n"
				+ "FROM dbo.hoadon \r\n"
				+ "	INNER JOIN dbo.KhachHang ON dbo.hoadon.makh = dbo.KhachHang.makh \r\n"
				+ "	INNER JOIN dbo.ChiTietHoaDon ON dbo.hoadon.MaHoaDon = dbo.ChiTietHoaDon.MaHoaDon\r\n"
				+ "	INNER JOIN dbo.sach ON dbo.ChiTietHoaDon.MaSach = dbo.sach.masach\r\n"
				+ "WHERE (dbo.hoadon.damua = 0) AND (DATEDIFF(day, dbo.hoadon.NgayMua, CAST(GETDATE() AS date)) = 0)\r\n"
				+ "GROUP BY dbo.KhachHang.makh, dbo.KhachHang.hoten,dbo.hoadon.MaHoaDon, dbo.hoadon.NgayMua";
		
		PreparedStatement ps = kn.cn.prepareStatement(sql);
		ResultSet rs = ps.executeQuery();
		while(rs.next()) {
			long maKh = rs.getLong("makh");
		    String hoTen = rs.getString("hoten");
		    long tongSoLuong = rs.getLong("tongsoluong");
		    long tongGia = rs.getLong("tonggia");
		    long thanhTien = rs.getLong("thanhtien");
		    long maHoaDon = rs.getLong("MaHoaDon");
		    
		    lst.add(new ThongKeDonHang(maKh, hoTen, tongSoLuong, tongGia, thanhTien, maHoaDon));
		}
		return lst;
	}
	
	public ArrayList<HoaDonDTO> getHoaDonDaMuaChuaTT(long maKh) throws Exception {
		ArrayList<HoaDonDTO> ds = new ArrayList<>();
		KetNoi kn = new KetNoi();
		kn.ketnoi();
		
		String sql = "SELECT hd.MaHoaDon, hd.NgayMua, hd.damua, SUM(ct.SoLuongMua * s.gia) AS TongTien\r\n"
				+ "FROM     hoadon AS hd INNER JOIN\r\n"
				+ "                  ChiTietHoaDon AS ct ON hd.MaHoaDon = ct.MaHoaDon INNER JOIN\r\n"
				+ "                  sach AS s ON ct.MaSach = s.masach\r\n"
				+ "GROUP BY hd.MaHoaDon, hd.NgayMua, hd.damua, hd.makh\r\n"
				+ "HAVING (hd.makh = ?)\r\n"
				+ "ORDER BY hd.NgayMua DESC";
		PreparedStatement ps = kn.cn.prepareStatement(sql);
		ps.setLong(1, maKh);
		
		ResultSet rs = ps.executeQuery();
		while(rs.next()) {
			long maHoaDon = rs.getLong("MaHoaDon");
			Boolean damua = rs.getBoolean("damua");
			Date ngaymua = rs.getDate("NgayMua");
			long tongtien = rs.getLong("TongTien");
			
			HoaDonDTO hd = new HoaDonDTO(maHoaDon, damua, ngaymua, tongtien);
			ds.add(hd);
		}
		
		return ds;
	}
	
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
        
	    return ds;
	}

}
