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
 * Servlet implementation class htgiohangController
 */
@WebServlet("/htgiohangController")
public class htgiohangController extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public htgiohangController() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");
        response.setCharacterEncoding("UTF-8");
//		try {
//			LoaiBO lbo = new LoaiBO();
//			request.setAttribute("dsLoai", lbo.getLoai());
//			
//			HttpSession session = request.getSession();
//			GioHangBO gbo ;
//			if(session.getAttribute("gh") == null) {
//				gbo = new GioHangBO();
//				session.setAttribute("gbo", gbo);
//			}
//			else {
//				gbo = (GioHangBO) session.getAttribute("gbo");
//			}
//			
//			String maSach = request.getParameter("ms");
//			String tenSach = request.getParameter("ts");
//			String soLuong = request.getParameter("sl");
//			String gia = request.getParameter("gia");
//			String anh = request.getParameter("anh");
//			String action = request.getParameter("action");
//			
//			// Thêm
////			if(maSach != null && tenSach != null && gia != null && soLuong != null && anh != null){
////				gbo.Them(maSach, tenSach, Long.parseLong(soLuong), Long.parseLong(gia), anh);
////				
////				session.setAttribute("gh", gbo);
////			}
//			
//			//Xóa 1 sp
//			if("delete".equals(action)) {
//				String msXoa = request.getParameter("ms");
//				if(msXoa != null) {
//					gbo.Xoa(maSach);
//				}
//			}
//			
//			// Xóa all
//			if("deleteAll".equals(action)) {
//				gbo.XoaAll();
//			}
//			
//			//Update sl
//			if("update".equals(action)) {
//				String ms = request.getParameter("ms");
//				String sl = request.getParameter("txtSuaSL");
//				gbo.Sua(ms, Long.parseLong(sl));
//			}
//			
//			request.setAttribute("giohang", gbo);
//			
//			RequestDispatcher rd = request.getRequestDispatcher("GioHang.jsp");
//			rd.forward(request, response);
//		}
//		catch (Exception e) {
//			e.printStackTrace();
//		}
		
		try {
	        LoaiBO lbo = new LoaiBO();
	        request.setAttribute("dsloai", lbo.getLoai());
	        request.getRequestDispatcher("tc.jsp").forward(request, response);
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
