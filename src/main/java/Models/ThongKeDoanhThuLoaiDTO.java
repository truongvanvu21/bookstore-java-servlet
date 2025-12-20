package Models;

public class ThongKeDoanhThuLoaiDTO {
	public ThongKeDoanhThuLoaiDTO() {
		super();
		// TODO Auto-generated constructor stub
	}
	public ThongKeDoanhThuLoaiDTO(String maLoai, String tenLoai, long doanhThu) {
		super();
		this.maLoai = maLoai;
		this.tenLoai = tenLoai;
		this.doanhThu = doanhThu;
	}
	private String maLoai;
	private String tenLoai;
	private long doanhThu;
	public String getMaLoai() {
		return maLoai;
	}
	public void setMaLoai(String maLoai) {
		this.maLoai = maLoai;
	}
	public String getTenLoai() {
		return tenLoai;
	}
	public void setTenLoai(String tenLoai) {
		this.tenLoai = tenLoai;
	}
	public long getDoanhThu() {
		return doanhThu;
	}
	public void setDoanhThu(long doanhThu) {
		this.doanhThu = doanhThu;
	}

}
