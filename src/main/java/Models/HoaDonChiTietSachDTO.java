package Models;

import java.util.Date;

public class HoaDonChiTietSachDTO {
    public HoaDonChiTietSachDTO(long maHoaDon, String maSach, String tenSach, String anh, long gia, long soLuongMua,
			long thanhTien, Date ngayMua) {
		super();
		this.maHoaDon = maHoaDon;
		this.maSach = maSach;
		this.tenSach = tenSach;
		this.anh = anh;
		this.gia = gia;
		this.soLuongMua = soLuongMua;
		this.thanhTien = thanhTien;
		this.ngayMua = ngayMua;
	}

	private long maHoaDon;
    private String maSach;
    private String tenSach;
    private String anh;
    private long gia;
    private long soLuongMua;
    private long thanhTien;
    private Date ngayMua;

    public HoaDonChiTietSachDTO() {
    }

    public long getMaHoaDon() {
        return maHoaDon;
    }

    public void setMaHoaDon(long maHoaDon) {
        this.maHoaDon = maHoaDon;
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

	public String getAnh() {
		return anh;
	}

	public void setAnh(String anh) {
		this.anh = anh;
	}
}
