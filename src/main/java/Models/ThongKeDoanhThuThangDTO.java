package Models;

public class ThongKeDoanhThuThangDTO {
	public ThongKeDoanhThuThangDTO() {
		super();
		// TODO Auto-generated constructor stub
	}
	public ThongKeDoanhThuThangDTO(long thang, long doanhThu) {
		super();
		this.thang = thang;
		this.doanhThu = doanhThu;
	}
	private long thang;
	private long doanhThu;
	public long getThang() {
		return thang;
	}
	public void setThang(long thang) {
		this.thang = thang;
	}
	public long getDoanhThu() {
		return doanhThu;
	}
	public void setDoanhThu(long doanhThu) {
		this.doanhThu = doanhThu;
	}
}
