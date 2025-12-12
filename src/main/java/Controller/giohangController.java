package Controller;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import Models.GioHangBO;
import Models.LoaiBO;

/**
 * Servlet implementation class giohangController
 */
@WebServlet("/giohangController")
public class giohangController extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public giohangController() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        response.setCharacterEncoding("UTF-8");
		try {
			LoaiBO lbo = new LoaiBO();
			request.setAttribute("dsLoai", lbo.getLoai());
			
			String maSach = request.getParameter("ms");
			String tenSach = request.getParameter("ts");
			String gia = request.getParameter("gia");
			String anh = request.getParameter("anh");
			// Thêm
			if(maSach != null && tenSach != null && gia != null){
				HttpSession session = request.getSession();
				GioHangBO gbo ;
				if(session.getAttribute("gh") == null) {
					gbo = new GioHangBO();
					session.setAttribute("gh", gbo);
				}
				gbo = (GioHangBO) session.getAttribute("gh");
				gbo.Them(maSach, tenSach, 1, Long.parseLong(gia), anh);				
				session.setAttribute("gh", gbo);
				
				response.sendRedirect("giohangController");
				return;
			}
					
			RequestDispatcher rd = request.getRequestDispatcher("GioHang.jsp");
			rd.forward(request, response);
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
