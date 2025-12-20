package Models;

public class ThongKeTopSachDTO {
	public ThongKeTopSachDTO() {
		super();
		// TODO Auto-generated constructor stub
	}
	public ThongKeTopSachDTO(String maSach, String tenSach, long tongSoLuongBan) {
		super();
		this.maSach = maSach;
		this.tenSach = tenSach;
		this.tongSoLuongBan = tongSoLuongBan;
	}
	private String maSach;
    private String tenSach;
    private long tongSoLuongBan;
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
	public long getTongSoLuongBan() {
		return tongSoLuongBan;
	}
	public void setTongSoLuongBan(long tongSoLuongBan) {
		this.tongSoLuongBan = tongSoLuongBan;
	}
}
