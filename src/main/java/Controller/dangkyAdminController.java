package Controller;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import Models.Admin;
import Models.AdminBO;
import Models.MD5Util;

/**
 * Servlet implementation class dangkyAdminController
 */
@WebServlet("/dangkyAdminController")
public class dangkyAdminController extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public dangkyAdminController() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		try {
			String username = request.getParameter("username");
			String password = request.getParameter("password");
			
			if(username == null || password == null) {
				request.getRequestDispatcher("DangKy_Admin.jsp").forward(request, response);
			}
			String passMD5 = MD5Util.md5(password);
			
			Admin ad = new Admin(username, passMD5);
			AdminBO abo = new AdminBO();
			abo.Them(ad);
			response.sendRedirect("dangnhapAdminController");
			
		} catch (Exception e) {
			// TODO Auto-generated catch block
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
