package Controller;

import java.io.IOException;
import java.util.ArrayList;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import Models.HoaDonBO;
import Models.HoaDonChiTietSachDTO;
import Models.KhachHang;
import Models.LichSuMuaHangBO;
import Models.LoaiBO;

/**
 * Servlet implementation class HtThanhToanController
 */
@WebServlet("/HtThanhToanController")
public class HtThanhToanController extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public HtThanhToanController() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		try {			
			request.setCharacterEncoding("UTF-8");
			response.setCharacterEncoding("UTF-8");

			HttpSession session = request.getSession();
			KhachHang user = (KhachHang) session.getAttribute("user");
			
			if(user != null) {
				LoaiBO lbo = new LoaiBO();
				request.setAttribute("dsLoai", lbo.getLoai());
				
				HoaDonBO hdbo = new HoaDonBO();
				request.setAttribute("dsHDTT", hdbo.getHoaDonDaMuaChuaTT(user.getMaKhachHang()));
				
				// xem chi tiết
				String maHoaDonStr = request.getParameter("maHoaDon");				
				if(maHoaDonStr != null && !maHoaDonStr.isEmpty()) {
					long maHoaDon = Long.parseLong(maHoaDonStr);
					ArrayList<HoaDonChiTietSachDTO> dsSachInHD = hdbo.getDSSachTrongHoaDon(user.getMaKhachHang(), maHoaDon);
					request.setAttribute("dsSachInHD", dsSachInHD);
					
					request.setAttribute("selectedMaHoaDon", maHoaDon);
				}
				
				request.getRequestDispatcher("ThanhToan.jsp").forward(request, response);
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
