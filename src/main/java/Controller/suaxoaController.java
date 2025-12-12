package Controller;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import Models.GioHangBO;

/**
 * Servlet implementation class suaxoaController
 */
@WebServlet("/suaxoaController")
public class suaxoaController extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public suaxoaController() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// Hien thi cac ma sach khi nguoi dung chon nut xoa Chon
		HttpSession session = request.getSession();
		GioHangBO gbo = (GioHangBO) session.getAttribute("gh");
		
		String[] dsxoa = request.getParameterValues("select");
		if(dsxoa != null) {
			gbo.XoaSelect(dsxoa);
			if(gbo.ds.size() == 0) {
				response.sendRedirect("tcController");
				return;
			}
		}
		//Hiển thị ma sach va so luong can sua
		String msSua = request.getParameter("btcsua");
		String slSua = request.getParameter(msSua);

		if(msSua != null) {
			long sl = Long.parseLong(slSua);
			if(sl > 0) {
				gbo.Sua(msSua, sl);
			}
			else {
				gbo.Xoa(msSua);
			}
		}
		
		String action = request.getParameter("action");
		String msXoa = request.getParameter("ms");
		if(msXoa != null && "delete".equals(action)) {
			gbo.Xoa(msXoa);
			if(gbo.ds.size() == 0) {
				response.sendRedirect("tcController");
				return;
			}
		}
		
		
		if("deleteAll".equals(action)) {
			gbo.XoaAll();
			if(gbo.ds.size() == 0) {
				response.sendRedirect("tcController");
				return;
			}
		}
		session.setAttribute("gh", gbo);
		
		response.sendRedirect("giohangController");
		
//		RequestDispatcher rd = request.getRequestDispatcher("giohangController");
//		rd.forward(request, response);
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
