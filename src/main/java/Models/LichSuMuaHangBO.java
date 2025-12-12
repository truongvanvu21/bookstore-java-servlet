package Models;

import java.util.ArrayList;

public class LichSuMuaHangBO {
	LichSuMuaHangDAO lsmhDAO = new LichSuMuaHangDAO();
	ArrayList<LichSuMuaHang> ds;
	
	public ArrayList<LichSuMuaHang> getLichSu(long makh) throws Exception {
		return lsmhDAO.getLichSu(makh);
	}
	
//	public ArrayList<LichSuMuaHang> getLichSuMuaHang(String userName, String password) throws Exception {
//		ds = lsmhDAO.getSach(userName, password);
//		return ds;
//	}
	
	public int CapNhatHoaDon(String userName, String pasword) throws Exception {
		int ketqua = lsmhDAO.CapNhatHoaDon(userName, pasword);
		return ketqua;
	}
	
	public int CapNhatChiTietHoaDonTHeoMaHd(int maHd, String maSach, long soLuongMua) throws Exception {
		int ketqua = lsmhDAO.CapNhatChiTietHoaDonTheoMaHd(maHd, maSach, soLuongMua);
		return ketqua;
	}
}
