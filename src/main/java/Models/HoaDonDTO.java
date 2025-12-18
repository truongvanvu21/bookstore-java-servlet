package Models;

import java.sql.Date;

public class HoaDonDTO {
	public HoaDonDTO() {
		super();
		// TODO Auto-generated constructor stub
	}
	public HoaDonDTO(long maHoaDon, boolean daMua, Date ngayMua, long tongTien) {
		super();
		this.maHoaDon = maHoaDon;
		this.daMua = daMua;
		this.ngayMua = ngayMua;
		this.tongTien = tongTien;
	}
	// Hiển thị hóa đơn lên thanh toán
	private long maHoaDon;
	private boolean daMua;
	private Date ngayMua; 
	private long tongTien;
	public long getMaHoaDon() {
		return maHoaDon;
	}
	public void setMaHoaDon(long maHoaDon) {
		this.maHoaDon = maHoaDon;
	}
	public boolean isDaMua() {
		return daMua;
	}
	public void setDaMua(boolean daMua) {
		this.daMua = daMua;
	}
	public Date getNgayMua() {
		return ngayMua;
	}
	public void setNgayMua(Date ngayMua) {
		this.ngayMua = ngayMua;
	}
	public long getTongTien() {
		return tongTien;
	}
	public void setTongTien(long tongTien) {
		this.tongTien = tongTien;
	}
	
}
