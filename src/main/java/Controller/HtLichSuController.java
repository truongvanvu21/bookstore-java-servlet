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
import Models.LichSuMuaHang;
import Models.LichSuMuaHangBO;
import Models.LoaiBO;

/**
 * Servlet implementation class HtLichSuController
 */
@WebServlet("/HtLichSuController")
public class HtLichSuController extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public HtLichSuController() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		try {
			HttpSession session = request.getSession();
			if(session.getAttribute("user") != null) {
				LoaiBO lbo = new LoaiBO();
				request.setAttribute("dsLoai", lbo.getLoai());
				KhachHang kh = (KhachHang) session.getAttribute("user");
				LichSuMuaHangBO ls = new LichSuMuaHangBO();
				request.setAttribute("dsLS", ls.getLichSu(kh.getMaKhachHang()));
				request.getRequestDispatcher("LichSu.jsp").forward(request, response);
			}
			else {
				response.sendRedirect("dangnhapController");
			}
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
