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
			int damua = rs.getInt("damua");
			Date ngaymua = rs.getDate("NgayMua");
			
			lst.add(new LichSuMuaHang (makh, tensach, gia, soluongmua, thanhtien, damua, ngaymua));
		}
		return lst;
	}
}
