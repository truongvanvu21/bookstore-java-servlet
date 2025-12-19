package Controller;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import Models.KhachHang;
import Models.KhachHangBO;
import Models.MD5Util;

/**
 * Servlet implementation class dangkyController
 */
@WebServlet("/dangkyController")
public class dangkyController extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public dangkyController() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
			request.setCharacterEncoding("utf-8");
			response.setCharacterEncoding("utf-8");
		
			String hoTen = request.getParameter("hoTen");
			String diaChi = request.getParameter("diaChi");
			String sdt = request.getParameter("sdt");
			String email = request.getParameter("email");
			String tendn = request.getParameter("tendn");
			String pass = request.getParameter("pass");
			
			if (hoTen == null || diaChi == null || sdt == null || email == null || tendn == null || pass == null) {
	            request.getRequestDispatcher("DangKy.jsp").forward(request, response);
	        }
			
			String passMD5 = MD5Util.md5(pass);
			try {
				KhachHang kh = new KhachHang(hoTen, diaChi, sdt, email, tendn, passMD5);
				KhachHangBO khbo = new KhachHangBO();
				khbo.Them(kh);
				response.sendRedirect("dangnhapController");
			}
			catch (Exception e) {
				e.printStackTrace();
				response.getWriter().println("Lỗi trong quá trình đăng ký: " + e.getMessage());
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
