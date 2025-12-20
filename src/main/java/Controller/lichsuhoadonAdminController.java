package Controller;

import java.io.IOException;
import java.util.ArrayList;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import Models.Admin;
import Models.HoaDonBO;
import Models.HoaDonChiTietSachDTO;

/**
 * Servlet implementation class lichsuhoadonAdminController
 */
@WebServlet("/lichsuhoadonAdminController")
public class lichsuhoadonAdminController extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public lichsuhoadonAdminController() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("utf-8");
		response.setCharacterEncoding("utf-8");
		try {
			HttpSession session = request.getSession();     
	        Admin ad = (Admin) session.getAttribute("username");
	        if(ad == null) {
	            response.sendRedirect("dangnhapAdminController");
	            return;
	        }

	        HoaDonBO hdbo = new HoaDonBO();
	        String maHoaDonStr = request.getParameter("maHoaDon");
	        String maKHStr = request.getParameter("maKH");

	        // 3. Xử lý Xem chi tiết (Chỉ chạy khi có maHoaDon và maKH, và không có action thanh toán/xóa)
	        if(maHoaDonStr != null && maKHStr != null && !maKHStr.isEmpty()) {
	            long maHoaDon = Long.parseLong(maHoaDonStr);
	            long maKH = Long.parseLong(maKHStr);
	            ArrayList<HoaDonChiTietSachDTO> dsSachInHD = hdbo.getDSSachTrongHoaDon(maKH, maHoaDon);
	            request.setAttribute("dsSachInHD", dsSachInHD);
	            request.setAttribute("selectedMaHoaDon", maHoaDon);
	        }

	        // Load danh sách hiển thị
	        request.setAttribute("dsHDDaTTAll", hdbo.getDSHDDaTTAllKH());
	        request.getRequestDispatcher("LichSuHoaDon_Admin.jsp").forward(request, response);
		} catch (Exception e) {
			// TODO Auto-generated catch block
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
