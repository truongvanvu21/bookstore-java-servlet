package Models;

import java.sql.PreparedStatement;

public class ChiTietDAO {
	public int Them(String masach, Long soluong) throws Exception {
		KetNoi kn = new KetNoi();
		kn.ketnoi();
		
		String sql = "INSERT INTO ChiTietHoaDon(MaSach, SoLuongMua, MaHoaDon, damua) VALUES (?, ?, (SELECT MAX(MaHoaDon) FROM hoadon), 0)";
		PreparedStatement ps = kn.cn.prepareStatement(sql);
		
		ps.setString(1, masach);
		ps.setLong(2, soluong);
		int kq = ps.executeUpdate();
		kn.cn.close();
		return kq;
				
	}
}
