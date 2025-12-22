package Models;

import java.sql.Date;

public class HoaDonDTO {
	public HoaDonDTO(long maKH, long maHoaDon, String hoTen, int daMua, Date ngayMua, long tongTien) {
		super();
		this.maKH = maKH;
		this.maHoaDon = maHoaDon;
		this.hoTen = hoTen;
		this.daMua = daMua;
		this.ngayMua = ngayMua;
		this.tongTien = tongTien;
	}
	public HoaDonDTO() {
		super();
		// TODO Auto-generated constructor stub
	}
	// Hiển thị hóa đơn lên thanh toán
	private long maKH;
	private long maHoaDon;
	private String hoTen;
	private int daMua;
	private Date ngayMua; 
	private long tongTien;
	public long getMaHoaDon() {
		return maHoaDon;
	}
	public void setMaHoaDon(long maHoaDon) {
		this.maHoaDon = maHoaDon;
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
	public long getMaKH() {
		return maKH;
	}
	public void setMaKH(long maKH) {
		this.maKH = maKH;
	}
	public String getHoTen() {
		return hoTen;
	}
	public void setHoTen(String hoTen) {
		this.hoTen = hoTen;
	}
	public int getDaMua() {
		return daMua;
	}
	public void setDaMua(int daMua) {
		this.daMua = daMua;
	}
	
}
