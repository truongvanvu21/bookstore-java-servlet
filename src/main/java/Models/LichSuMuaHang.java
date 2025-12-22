package Models;

import java.sql.Date;

public class LichSuMuaHang {
	private long makh;
	private String tenSach;
	private long gia;
	private long soLuongMua;
	private long thanhTien;
	private int daMua;
	private Date ngayMua;
	
	public LichSuMuaHang() {
		super();
		// TODO Auto-generated constructor stub
	}
	
	public LichSuMuaHang(long makh, String tenSach, long gia, long soLuongMua, long thanhTien, int daMua,
			Date ngayMua) {
		super();
		this.makh = makh;
		this.tenSach = tenSach;
		this.gia = gia;
		this.soLuongMua = soLuongMua;
		this.thanhTien = thanhTien;
		this.daMua = daMua;
		this.ngayMua = ngayMua;
	}

	public long getMakh() {
		return makh;
	}
	public void setMakh(long makh) {
		this.makh = makh;
	}
	public String getTenSach() {
		return tenSach;
	}
	public void setTenSach(String tenSach) {
		this.tenSach = tenSach;
	}
	public long getGia() {
		return gia;
	}
	public void setGia(long gia) {
		this.gia = gia;
	}
	public long getSoLuongMua() {
		return soLuongMua;
	}
	public void setSoLuongMua(long soLuongMua) {
		this.soLuongMua = soLuongMua;
	}
	public long getThanhTien() {
		return thanhTien;
	}
	public void setThanhTien(long thanhTien) {
		this.thanhTien = thanhTien;
	}

	public Date getNgayMua() {
		return ngayMua;
	}
	public void setNgayMua(Date ngayMua) {
		this.ngayMua = ngayMua;
	}

	public int getDaMua() {
		return daMua;
	}

	public void setDaMua(int daMua) {
		this.daMua = daMua;
	}
	
	
}
