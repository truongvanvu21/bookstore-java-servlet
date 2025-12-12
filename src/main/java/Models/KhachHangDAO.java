package Models;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

public class KhachHangDAO {
	public KhachHang ktDangNhap(String tendn, String pass) throws Exception {
		//b1: Kết nối vao csdl
	      KetNoi kn= new KetNoi();
	      kn.ketnoi();
	    //b2: Thiet lap cau lenh sql
	      String sql= "select * from khachhang where tendn=? and pass=?";
	      PreparedStatement cmd= kn.cn.prepareStatement(sql);
	    //b3: Truyen tham so vao cau lẹnh sql (neu co)
	      cmd.setString(1, tendn);
	      cmd.setString(2,pass);
	      //b4: Cho thuc hien cau lenh sql
	      ResultSet rs= cmd.executeQuery();
	    //b5: Duyet rs va luu vao mang dong
	      KhachHang kh= null;
	      if(rs.next()) {//Neu dang nhap thanh cong
	    	  long makh=rs.getLong("makh");
	    	  String hoten=rs.getString("hoten");
	    	  String diachi=rs.getString("diachi");
	    	  String sodt=rs.getString("sodt");
	    	  String email=rs.getString("email");
	    	  kh= new KhachHang(makh, hoten, diachi, sodt, email, tendn, pass);
	      }
	    //b6: Dong  cac doi tuong dang mo: rs, ket noi
	      rs.close();kn.cn.close();
	      return kh;
	}

	public int Them(KhachHang kh) throws Exception {
		KetNoi kn = new KetNoi();
		kn.ketnoi();
		
		String sql = "INSERT INTO KhachHang (hoten, diachi, sodt, email, tendn, pass)\r\n"
				+ "VALUES (?, ?, ?, ?, ?, ?) ";
		PreparedStatement ps = kn.cn.prepareStatement(sql);
		
		ps.setString(1, kh.getHoTen());
		ps.setString(2, kh.getDiaChi());
		ps.setString(3, kh.getSdt());
		ps.setString(4, kh.getEmail());
		ps.setString(5, kh.getTendn());
		ps.setString(6, kh.getPass());
		
		int kq = ps.executeUpdate();
		kn.cn.close();
		return kq;
	}
}
