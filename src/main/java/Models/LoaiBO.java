package Models;

import java.util.ArrayList;
import java.util.Map;

public class LoaiBO {
	LoaiDAO ldao = new LoaiDAO();
	public ArrayList<Loai> getLoai() throws Exception {
		return ldao.getLoai();
	}
	
	public Map<String, Long> getSoLuongSachTheoLoai() throws Exception {
		return ldao.getSoLuongSachTheoLoai();
	}
	
	public int updateLoai(String maLoai, String tenMoi) throws Exception {
		return ldao.updateLoai(maLoai, tenMoi);
	}
	
	public int addLoai(String maLoai, String tenLoai) throws Exception {
		return ldao.addLoai(maLoai, tenLoai);
	}
	
	public int deleteLoai(String maLoai) throws Exception {
		return ldao.deleteLoai(maLoai);
	}
	
	public boolean CheckSachTrongLoai(String maLoai) throws Exception { 
		return ldao.CheckSachTrongLoai(maLoai);
	}
}
