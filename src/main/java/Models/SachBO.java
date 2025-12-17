package Models;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

public class SachBO {
	SachDAO sdao = new SachDAO();
	ArrayList<Sach> ds;
	public ArrayList<Sach> getSach() throws Exception {
		ds = sdao.getSach();
		return ds;
	}
	
	public int getTongSach(String ml, String key) throws Exception {
		return sdao.getTongSach(ml, key);
	}
	
	public int getTongSachOfAdmin(String key) throws Exception {
		return sdao.getTongSachOfAdmin(key);
	}
	
	public ArrayList<Sach> getDanhSachPhanTrang(int page, int pageSize, String ml, String key) throws Exception {
		return sdao.getDanhSachPhanTrang(page, pageSize, ml, key);
	}
	
	public ArrayList<Sach> getDanhSachPhanTrangOfAdmin(int page, int pageSize, String key) throws Exception {
		return sdao.getDanhSachPhanTrangOfAdmin(page, pageSize, key);
	}
	
	public ArrayList<Sach> TimKiemMa(String maLoai) throws Exception {
		ds = sdao.TimKiemMa(maLoai);
		return ds;
	}
	
	public ArrayList<Sach> TimKiemSearch(String key) throws Exception {
		ds = sdao.TimKiemSearch(key);
		return ds;
	}
	
	public int addSach(Sach s) throws Exception {
		return sdao.addSach(s);
	}
	
	public int updateSach(Sach s) throws Exception {
		return sdao.updateSach(s);
	}
	
	public int deleteSach(String maLoai) throws Exception {
		return sdao.deleteSach(maLoai);
	}
}
