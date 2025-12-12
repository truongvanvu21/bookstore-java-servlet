package Controller;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import Models.Admin;
import Models.AdminBO;
import Models.MD5Util;
import nl.captcha.Captcha;

/**
 * Servlet implementation class dangnhapAdminController
 */
@WebServlet("/dangnhapAdminController")
public class dangnhapAdminController extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public dangnhapAdminController() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		try {
			HttpSession session = request.getSession();
			Integer failedCount = (Integer) session.getAttribute("failedCount");
			if(failedCount == null) {
	    		 failedCount = 0;
	    		 session.setAttribute("failedCount", failedCount);
	    	}
			
			String username = request.getParameter("txt_user");
			String password = request.getParameter("txt_pass");
			RequestDispatcher dnd = request.getRequestDispatcher("tcAdminController");
			RequestDispatcher dns = request.getRequestDispatcher("DangNhap_Admin.jsp");
			
			// Kiểm tra captcha nếu đăng nhập sai quá 3 lần
	        if(failedCount >= 3) {
	        	Captcha captcha = (Captcha) session.getAttribute(Captcha.NAME);
				request.setCharacterEncoding("UTF-8");
				String answer = request.getParameter("answer");
				if(answer==null) {
					dns.forward(request, response);
					return;
				}
				else
					// sai thì trở về tc
					if (!captcha.isCorrect(answer)) {
						request.setAttribute("error", "Đăng nhập sai");
						dns.forward(request, response);
						return;
					}
	        }
			
			if(username != null && password != null) {
				String passMD5 = MD5Util.md5(password);
				
				AdminBO abo = new AdminBO();
				Admin ad = abo.ktDangNhap(username, passMD5);
				if(ad != null) {
					session.setAttribute("username", ad);
					session.removeAttribute("failedCount");
					dnd.forward(request, response);
				}
				else {
					failedCount ++;
		        	session.setAttribute("failedCount", failedCount);
					request.setAttribute("error", "Đăng nhập sai");
					dns.forward(request, response);
				}
			}
			else {
				dns.forward(request, response);
			}
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
