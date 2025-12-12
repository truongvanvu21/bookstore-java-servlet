package Models;

public class ChiTietBO {
	ChiTietDAO ctDAO = new ChiTietDAO();
	public int Them(String masach, Long soluong) throws Exception {
		return ctDAO.Them(masach, soluong);
	}
}
