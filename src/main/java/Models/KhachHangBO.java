package Models;

public class KhachHangBO {
	KhachHangDAO khdao= new KhachHangDAO();
	public KhachHang ktDangNhap(String tendn, String pass) throws Exception{
	   return khdao.ktDangNhap(tendn, pass);
	}
	
	public int Them(KhachHang kh) throws Exception {
		return khdao.Them(kh);
	}
}
