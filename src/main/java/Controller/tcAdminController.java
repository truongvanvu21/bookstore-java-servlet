package Controller;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import Models.Admin;
import Models.ChiTietBO;
import Models.GioHang;
import Models.GioHangBO;
import Models.HoaDonBO;
import Models.KhachHang;
import Models.LichSuMuaHangBO;
import Models.LoaiBO;
import Models.SachBO;

/**
 * Servlet implementation class tcAdminController
 */
@WebServlet("/tcAdminController")
public class tcAdminController extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public tcAdminController() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		try {
			HttpSession session = request.getSession();
			Admin ad = (Admin) session.getAttribute("username");
			if(ad == null) {
				response.sendRedirect("dangnhapAdminController");
				return;
			}
			HoaDonBO hdBO = new HoaDonBO();
			SachBO sbo = new SachBO();
			LoaiBO lbo = new LoaiBO();
			
			request.setAttribute("dsSachSapHet", sbo.getSachSapHet());
			request.setAttribute("dsDoanhThuThang", sbo.getDoanhThuThang());
			request.setAttribute("ds", lbo.getDoanhThuLoai());
			request.setAttribute("dsTop10Sach", sbo.getTop10SachBanChay());
			request.setAttribute("dsHoaDonHomNay", hdBO.getHoaDonHomNay());
			request.getRequestDispatcher("tc_Admin.jsp").forward(request, response);
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
