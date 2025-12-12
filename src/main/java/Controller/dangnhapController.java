package Controller;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import Models.KhachHang;
import Models.KhachHangBO;
import Models.MD5Util;
import nl.captcha.Captcha;

/**
 * Servlet implementation class dangnhapController
 */
@WebServlet("/dangnhapController")
public class dangnhapController extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public dangnhapController() {
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
	    	 
	    	String user=request.getParameter("txt_user");
	        String pass=request.getParameter("txt_pass");
	        RequestDispatcher rds= request.getRequestDispatcher("dangnhap.jsp");
	        RequestDispatcher rdd= request.getRequestDispatcher("tcController");
	        
	        // Kiểm tra captcha nếu đăng nhập sai quá 3 lần
	        if(failedCount >= 3) {
	        	Captcha captcha = (Captcha) session.getAttribute(Captcha.NAME);
				request.setCharacterEncoding("UTF-8");
				String answer = request.getParameter("answer");
				if(answer==null) {
					rds.forward(request, response);
					return;
				}
				else
					// sai thì trở về tc
					if (!captcha.isCorrect(answer)) {
						request.setAttribute("error", "Đăng nhập sai");
						rds.forward(request, response);
						return;
					}
	        }
	        
	        if(user!=null&&pass!=null) {
	        	String passMD5 = MD5Util.md5(pass);
	        	
	        	KhachHangBO khbo= new KhachHangBO();
	        	KhachHang kh= khbo.ktDangNhap(user, passMD5);
		        if(kh!=null){ //Dang nhap dung
		            session.setAttribute("user",kh);
		            session.removeAttribute("failedCount");
		            rdd.forward(request, response);
		        }else {
		        	failedCount ++;
		        	session.setAttribute("failedCount", failedCount);
		            request.setAttribute("error", "Đăng nhập sai");
		            rds.forward(request, response);
		        }
	        }
	        else{//Chay lan dau
	            rds.forward(request, response);
	        }
		} catch (Exception e) {
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
