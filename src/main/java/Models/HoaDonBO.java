package Models;

import java.util.ArrayList;

public class HoaDonBO {
	HoaDonDAO hdDAO = new HoaDonDAO();
	public int Them(Long makh) throws Exception {
		return hdDAO.Them(makh);
	}
	
	public ArrayList<ThongKeDonHang>  getHoaDonHomNay() throws Exception {
		return hdDAO.getHoaDonHomNay();
	}
	
	public ArrayList<HoaDonDTO> getHoaDonDaMuaChuaTT(long maKh) throws Exception {
		return hdDAO.getHoaDonDaMuaChuaTT(maKh);
	}
	
	public ArrayList<HoaDonChiTietSachDTO> getDSSachTrongHoaDon(long maKhachHang, long maHoaDon) throws Exception {
		return hdDAO.getDSSachTrongHoaDon(maKhachHang, maHoaDon);
	}
}
