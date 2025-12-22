package Models;

public class ThongKeDonHang {
	public ThongKeDonHang(long maKh, String hoTen, long tongSoLuong, long thanhTien, int daMua,
			long maHoaDon) {
		super();
		this.maKh = maKh;
		this.hoTen = hoTen;
		this.tongSoLuong = tongSoLuong;
		this.thanhTien = thanhTien;
		this.daMua = daMua;
		this.maHoaDon = maHoaDon;
	}
	public ThongKeDonHang() {
		super();
		// TODO Auto-generated constructor stub
	}
	private long maKh;
    private String hoTen;
    private long tongSoLuong;
    private long thanhTien;
    private int daMua;
    private long maHoaDon;
	public long getMaKh() {
		return maKh;
	}
	public void setMaKh(long maKh) {
		this.maKh = maKh;
	}
	public String getHoTen() {
		return hoTen;
	}
	public void setHoTen(String hoTen) {
		this.hoTen = hoTen;
	}
	public long getTongSoLuong() {
		return tongSoLuong;
	}
	public void setTongSoLuong(long tongSoLuong) {
		this.tongSoLuong = tongSoLuong;
	}
	public long getThanhTien() {
		return thanhTien;
	}
	public void setThanhTien(long thanhTien) {
		this.thanhTien = thanhTien;
	}

	public long getMaHoaDon() {
		return maHoaDon;
	}
	public void setMaHoaDon(long maHoaDon) {
		this.maHoaDon = maHoaDon;
	}
	public int getDaMua() {
		return daMua;
	}
	public void setDaMua(int daMua) {
		this.daMua = daMua;
	}

    
}
