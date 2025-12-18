package Controller;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import Models.ChiTietBO;
import Models.GioHang;
import Models.GioHangBO;
import Models.HoaDonBO;
import Models.KhachHang;

/**
 * Servlet implementation class thanhtoanController
 */
@WebServlet("/thanhtoanController")
public class thanhtoanController extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public thanhtoanController() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		try {
			HttpSession session = request.getSession();
			HoaDonBO hd = new HoaDonBO();
			ChiTietBO ct = new ChiTietBO();
		// Neu chua dang nhap thi mo dangnhapController
			KhachHang kh = (KhachHang)session.getAttribute("user");
			if(kh == null) {
				response.sendRedirect("dangnhapController");
				return;
			}
			GioHangBO gh = (GioHangBO) session.getAttribute("gh");
			if(gh != null && !gh.getDs().isEmpty())
			{
				// Tao 1 hoa don
				hd.Them(kh.getMaKhachHang());
				// Duyet gio hang
				for(GioHang g : gh.getDs()) {
					// Tao ra 1 chi tiet hoa don
					ct.Them(g.getMaSach(), g.getSoLuong());
				}
				// Xoa gio hang
				session.removeAttribute("gh");
			}
			response.sendRedirect("HtThanhToanController");
		}
		catch (Exception e) {
			e.printStackTrace();
		}
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
