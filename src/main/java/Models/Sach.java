package Models;

import java.sql.Date;

public class Sach {
	public Sach(String maSach, String tenSach, long soLuong, long gia, String maLoai, String soTap, String anh,
			Date ngayNhap, String tacGia) {
		super();
		this.maSach = maSach;
		this.tenSach = tenSach;
		this.soLuong = soLuong;
		this.gia = gia;
		this.maLoai = maLoai;
		this.soTap = soTap;
		this.anh = anh;
		this.ngayNhap = ngayNhap;
		this.tacGia = tacGia;
	}

	private String maSach;
	private String tenSach;
	private long soLuong;
	private long gia;
	private String maLoai;
	private String soTap;
	private String anh;
	private Date ngayNhap;
	private String tacGia;
	
	public Sach() {
		super();
		// TODO Auto-generated constructor stub
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

	public String getMaLoai() {
		return maLoai;
	}

	public void setMaLoai(String maLoai) {
		this.maLoai = maLoai;
	}

	public String getSoTap() {
		return soTap;
	}

	public void setSoTap(String soTap) {
		this.soTap = soTap;
	}

	public String getAnh() {
		return anh;
	}

	public void setAnh(String anh) {
		this.anh = anh;
	}

	public Date getNgayNhap() {
		return ngayNhap;
	}

	public void setNgayNhap(Date ngayNhap) {
		this.ngayNhap = ngayNhap;
	}

	public String getTacGia() {
		return tacGia;
	}

	public void setTacGia(String tacGia) {
		this.tacGia = tacGia;
	}
	
	
}
