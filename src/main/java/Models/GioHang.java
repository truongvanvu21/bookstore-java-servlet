package Models;

import java.util.ArrayList;

public class GioHang {
	private String maSach;
	private String tenSach;
	private long soLuong;
	private long gia;
	private String anh;
	private long thanhTien;
	
	public GioHang() {
		super();
		// TODO Auto-generated constructor stub
	}
	
	public GioHang(String maSach, String tenSach, long soLuong, long gia, String anh) {
		super();
		this.maSach = maSach;
		this.tenSach = tenSach;
		this.soLuong = soLuong;
		this.gia = gia;
		this.anh = anh;
		this.thanhTien = soLuong * gia;
	}
	public String getMaSach() {
		return maSach;
	}
	public void setMaSach(String maSach) {
		this.maSach = maSach;
	}
	public String getTenSach() {
		return tenSach;
	}
	public void setTenSach(String tenSach) {
		this.tenSach = tenSach;
	}
	public long getSoLuong() {
		return soLuong;
	}
	public void setSoLuong(long soLuong) {
		this.soLuong = soLuong;
	}
	public long getGia() {
		return gia;
	}
	public void setGia(long gia) {
		this.gia = gia;
	}
	public String getAnh() {
		return anh;
	}
	public void setAnh(String anh) {
		this.anh = anh;
	}
	public long getThanhTien() {
		return soLuong * gia;
	}
	public void setThanhTien(long thanhTien) {
		this.thanhTien = thanhTien;
	}
	
}
