package Models;

import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;

public class LichSuMuaHangDAO {
	public ArrayList<LichSuMuaHang> getLichSu(long makh) throws Exception {
		ArrayList<LichSuMuaHang> lst = new ArrayList<LichSuMuaHang>();
		KetNoi kn = new KetNoi();
		kn.ketnoi();
		String sql = "SELECT * FROM VLS WHERE makh=?";
		PreparedStatement ps = kn.cn.prepareStatement(sql);
		ps.setLong(1, makh);
		ResultSet rs = ps.executeQuery();
		while(rs.next()) {
			String tensach = rs.getString("tensach");
			long gia = rs.getLong("gia");
			long soluongmua = rs.getLong("SoLuongMua");
			long thanhtien = rs.getLong("Thành tiền");
			Boolean damua = rs.getBoolean("damua");
			Date ngaymua = rs.getDate("NgayMua");
			
			lst.add(new LichSuMuaHang (makh, tensach, gia, soluongmua, thanhtien, damua, ngaymua));
		}
		return lst;
	}
	
//	public ArrayList<LichSuMuaHang> getSach(String userName, String password) throws Exception {
//		ArrayList<LichSuMuaHang> lsmh = new ArrayList();
//		KetNoi kn = new KetNoi();
//		kn.ketnoi();
//		String sql = "SELECT * FROM VLS WHERE tendn = ? AND pass = ?";
//		try(PreparedStatement ps = kn.cn.prepareStatement(sql)){
//			ps.setString(1, userName);
//			ps.setString(2, password);
//			ResultSet rs = ps.executeQuery();
//			
//			while(rs.next()) {
//				String makh = rs.getString(1);
//				String tensach = rs.getString(2);
//				long gia =rs.getLong(3);
//				long soluongmua = rs.getLong(4);
//				long thanhtien = rs.getLong(5);
//				boolean damua = rs.getBoolean(6);
//				Date ngaymua = rs.getDate(7);
//				
//				LichSuMuaHang lst = new LichSuMuaHang(makh, tensach, gia, soluongmua, thanhtien, damua, ngaymua);
//				lsmh.add(lst);
//			}
//		}
//		catch (Exception e) {
//			e.printStackTrace();
//		}
//		return lsmh;
//	}

	// Lấy MaKhachHang tu ten dang nhap + mk
	public int getMaKh(String userName, String password) throws Exception {
		KetNoi kn = new KetNoi();
		kn.ketnoi();
		String sql = "SELECT makh FROM KhachHang WHERE tendn = ? AND pass = ?";
		PreparedStatement ps = kn.cn.prepareStatement(sql);
		ps.setString(1, userName);
		ps.setString(2, password);
		ResultSet rs = ps.executeQuery();
		
		int makh = -1;
		if(rs.next()) makh = rs.getInt("makh");
		return makh;
	}
	
	// Them hoa don moi va tra ve MaHoaDon vua tao
	public int CapNhatHoaDon(String userName, String password) throws Exception {
		KetNoi kn = new KetNoi();
		kn.ketnoi();
		
		int makh = getMaKh(userName, password);
		String sql = "INSERT INTO hoadon(makh, NgayMua, damua) VALUES (?, ?, ?)";
		PreparedStatement ps = kn.cn.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS);
		ps.setInt(1, makh);
		ps.setDate(2, java.sql.Date.valueOf(java.time.LocalDate.now()));
		ps.setBoolean(3, true);
		
		int rows = ps.executeUpdate();
		if(rows == 0) {
			throw new SQLException("Không thể tạo hóa đơn mới");
		}
		
		int maHd = -1;
		ResultSet rs = ps.getGeneratedKeys();
		if(rs.next()) {
			maHd = rs.getInt(1);
		}
		return maHd;
	}
	
	// Them chi tiet hoa don
	public int CapNhatChiTietHoaDonTheoMaHd(int maHd, String maSach, long soLuongMua) throws Exception{
		KetNoi kn = new KetNoi();
		kn.ketnoi();
		String sql = "INSERT INTO ChiTietHoaDon(MaSach, SoLuongMua, MaHoaDon, damua) VALUES (?, ?, ?, ?)";
		PreparedStatement ps = kn.cn.prepareStatement(sql);
		ps.setString(1, maSach);
		ps.setLong(2, soLuongMua);
		ps.setInt(3, maHd);
		ps.setBoolean(4,  true);
		
		return ps.executeUpdate();
	}
}
