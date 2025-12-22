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
	
	public int thanhToanHD(long maHD) throws Exception {
		return hdDAO.thanhToanHD(maHD);
	}
	
	public int xacNhanHD(long maHD) throws Exception {
		return hdDAO.xacNhanHD(maHD);
	}
	
	public int tuchoiHD(long maHD) throws Exception {
		return hdDAO.tuchoiHD(maHD);
	}
	
	public int deleteHoaDon(long maHD) throws Exception {
		return hdDAO.deleteHoaDon(maHD);
	}
	
//	public ArrayList<HoaDonDTO> getDSHDChuaTTAllKH() throws Exception {
//		return hdDAO.getDSHDChuaTTAllKH();
//	}
	
	public ArrayList<HoaDonDTO> getDSHDDaTTAllKH() throws Exception {
		return hdDAO.getDSHDDaTTAllKH();
	}
	
	public ArrayList<HoaDonDTO> getDSHDDaXacNhanAllKH() throws Exception {
		return hdDAO.getDSHDDaXacNhanAllKH();
	}
}
