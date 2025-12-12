package Models;

import java.sql.PreparedStatement;
import java.sql.ResultSet;

public class AdminDAO {
	public Admin ktDangNhap(String tendn, String pass) throws Exception{
		KetNoi kn = new KetNoi();
		kn.ketnoi();
		 String sql = "select * from dangnhap where TenDangNhap = ? and MatKhau = ?";
		 PreparedStatement cmd = kn.cn.prepareStatement(sql);
		
		 cmd.setString(1, tendn);
		 cmd.setString(2, pass);
		 
		 ResultSet rs = cmd.executeQuery();
		 
		 Admin ad = null;
		 if(rs.next()) {
			 String tenDangNhap = rs.getString("TenDangNhap");
			 String matKhau = rs.getString("MatKhau");
			 
			 ad = new Admin(tenDangNhap, matKhau);
		 }
		 rs.close();
		 kn.cn.close();
		 return ad;
	}
	
	public int Them(Admin ad) throws Exception {
		KetNoi kn = new KetNoi();
		kn.ketnoi();
		
		String sql = "INSERT INTO dangnhap (TenDangNhap, MatKhau, Quyen)"
					+ "VALUES (?, ?, 0)";
		PreparedStatement pr = kn.cn.prepareStatement(sql);
		
		pr.setString(1, ad.getTenDangNhap());
		pr.setString(2, ad.getMatKhau());
		
		int kq = pr.executeUpdate();
		kn.cn.close();
		return kq;
	}
}
