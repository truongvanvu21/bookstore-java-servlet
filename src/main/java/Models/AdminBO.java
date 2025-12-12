package Models;

public class AdminBO {
	AdminDAO adao = new AdminDAO();
	public Admin ktDangNhap(String tendn, String pass) throws Exception {
		return adao.ktDangNhap(tendn, pass);
	}
	
	public int Them(Admin ad) throws Exception {
		return adao.Them(ad);
	}
}
