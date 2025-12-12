package Models;

import java.util.ArrayList;

public class GioHangBO {
//	private
	public ArrayList<GioHang> ds = new ArrayList<GioHang>();
	
	public ArrayList<GioHang> getDs() {
        return ds;
    }
	
	public void Them(String maSach, String tenSach, long soLuong, long gia, String anh) {
		int n = ds.size();
		for(int i=0; i<n; i++) {
			if(ds.get(i).getMaSach().toLowerCase().trim().equals(maSach.toLowerCase().trim())) {
				long soLuongMoi = ds.get(i).getSoLuong() + soLuong;
				ds.get(i).setSoLuong(soLuongMoi);
				ds.get(i).setThanhTien(ds.get(i).getGia() * soLuongMoi);
				return;
			}
		}
		GioHang gh = new GioHang(maSach, tenSach, soLuong, gia, anh);
		ds.add(gh);
	}
	
	public void Sua(String maSach, long soLuong) {
		int n = ds.size();
		for(int i=0; i<n; i++) {
			if(ds.get(i).getMaSach().toLowerCase().trim().equals(maSach.toLowerCase().trim())) {
				ds.get(i).setSoLuong(soLuong);
				ds.get(i).setThanhTien(ds.get(i).getGia() * soLuong);
				break;
			}
		}
	}
	
	public void Xoa(String maSach) {
		int n = ds.size();
		for(int i=0; i<n; i++) {
			if(ds.get(i).getMaSach().toLowerCase().trim().equals(maSach.toLowerCase().trim())) {
				ds.remove(i);
				break;
			}
		}
	}
	
	public void XoaAll() {
		ds.clear();
	}
	
	public void XoaSelect (String[] lst) {
		for(String name : lst) {
			Xoa(name);
		}
	}
	
	public long TongTien() {
		int n= ds.size();
		long s = 0;
		for(int i =0; i<n; i++) {
			s += ds.get(i).getThanhTien();
		}
		return s;
	}
	
	public long getTongTien() {
		return TongTien();
	}
}
