package Models;

public class KhachHang {
	public KhachHang() {
		super();
		// TODO Auto-generated constructor stub
	}
	public KhachHang(long maKhachHang, String hoTen, String diaChi, String sdt, String email, String tendn,
			String pass) {
		super();
		this.maKhachHang = maKhachHang;
		this.hoTen = hoTen;
		this.diaChi = diaChi;
		this.sdt = sdt;
		this.email = email;
		this.tendn = tendn;
		this.pass = pass;
	}
	
	public KhachHang(String hoTen, String diaChi, String sdt, String email, String tendn, String pass) {
		super();
		this.hoTen = hoTen;
		this.diaChi = diaChi;
		this.sdt = sdt;
		this.email = email;
		this.tendn = tendn;
		this.pass = pass;
	}
	private long maKhachHang;
	private String hoTen;
	private String diaChi;
	private String sdt;
	private String email;
	private String tendn;
	private String pass;
	public long getMaKhachHang() {
		return maKhachHang;
	}
	public void setMaKhachHang(long maKhachHang) {
		this.maKhachHang = maKhachHang;
	}
	public String getHoTen() {
		return hoTen;
	}
	public void setHoTen(String hoTen) {
		this.hoTen = hoTen;
	}
	public String getDiaChi() {
		return diaChi;
	}
	public void setDiaChi(String diaChi) {
		this.diaChi = diaChi;
	}
	public String getSdt() {
		return sdt;
	}
	public void setSdt(String sdt) {
		this.sdt = sdt;
	}
	public String getEmail() {
		return email;
	}
	public void setEmail(String email) {
		this.email = email;
	}
	public String getTendn() {
		return tendn;
	}
	public void setTendn(String tendn) {
		this.tendn = tendn;
	}
	public String getPass() {
		return pass;
	}
	public void setPass(String pass) {
		this.pass = pass;
	}
	
	
}
