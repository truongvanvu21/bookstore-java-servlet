package Models;

public class ThongKeDonHang {
	public ThongKeDonHang() {
		super();
		// TODO Auto-generated constructor stub
	}
	public ThongKeDonHang(long makh, String hoten, long tongSoLuong, long tongGia, long thanhTien, long maHoaDon) {
		super();
		this.maKh = makh;
		this.hoTen = hoten;
		this.tongSoLuong = tongSoLuong;
		this.tongGia = tongGia;
		this.thanhTien = thanhTien;
		this.maHoaDon = maHoaDon;
	}
	private long maKh;
    private String hoTen;
    private long tongSoLuong;
    private long tongGia;
    private long thanhTien;
    private long maHoaDon;
    
	public long getMakh() {
		return maKh;
	}
	public void setMakh(long makh) {
		this.maKh = makh;
	}
	public String getHoten() {
		return hoTen;
	}
	public void setHoten(String hoten) {
		this.hoTen = hoten;
	}
	public long getTongSoLuong() {
		return tongSoLuong;
	}
	public void setTongSoLuong(long tongSoLuong) {
		this.tongSoLuong = tongSoLuong;
	}
	public long getTongGia() {
		return tongGia;
	}
	public void setTongGia(long tongGia) {
		this.tongGia = tongGia;
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
}
