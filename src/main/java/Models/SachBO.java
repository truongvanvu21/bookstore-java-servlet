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
	
	public ArrayList<Sach> getDanhSachPhanTrang(int page, int pageSize, String ml, String key) throws Exception {
		return sdao.getDanhSachPhanTrang(page, pageSize, ml, key);
	}
	
	public int getTongSach(String ml, String key) throws Exception {
		return sdao.getTongSach(ml, key);
	}
	
	public ArrayList<Sach> TimKiemMa(String maLoai) throws Exception {
		ds = sdao.TimKiemMa(maLoai);
		return ds;
	}
	
	public ArrayList<Sach> TimKiemSearch(String key) throws Exception {
		ds = sdao.TimKiemSearch(key);
		return ds;
	}
}
