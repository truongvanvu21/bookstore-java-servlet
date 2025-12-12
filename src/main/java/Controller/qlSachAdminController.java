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
import Models.Sach;
import Models.SachBO;


/**
 * Servlet implementation class qlSachAdminController
 */
@WebServlet("/qlSachAdminController")
public class qlSachAdminController extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public qlSachAdminController() {
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
			SachBO sbo = new SachBO();
			ArrayList<Sach> ds = sbo.getSach();
			String action = request.getParameter("action");		
			String key = request.getParameter("input_search");
			
			Admin ad = (Admin) session.getAttribute("username");
			if(ad == null) {
				response.sendRedirect("dangnhapAdminController");
				return;
			}
			
			if(key != null) {
				ds = sbo.TimKiemSearch(key);
				if(ds.isEmpty()) {
					request.setAttribute("empty", "Dữ liệu không hợp lệ");
				}
			}
			
//			if("add".equals(action)) {
//				String maLoai = request.getParameter("maloai_add");
//				String tenloai = request.getParameter("tenloai_add");
//				
//				lbo.addLoai(maLoai, tenloai);
//				response.sendRedirect("qlLoaiAdminController");
//				return;
//			}
//			
//			if("update".equals(action)) {
//				String maLoai = request.getParameter("maloai_update");
//				String tenloai = request.getParameter("tenloai_update");
//				
//				lbo.updateLoai(maLoai, tenloai);
//				response.sendRedirect("qlLoaiAdminController");
//				return;
//			}
//			
//			if("delete".equals(action)) {
//				String maLoai = request.getParameter("maloaiDelete");
//				if(lbo.CheckSachTrongLoai(maLoai)) {
//					request.setAttribute("error", "Loại này vẫn còn sách, không thể xóa!");
//				}
//				else {
//					lbo.deleteLoai(maLoai);
////					request.setAttribute("success", "Xóa loại thành công!");
//					response.sendRedirect("qlLoaiAdminController");
//					return;
//				}
//			}
			request.setAttribute("dsSach", ds);
			
			request.getRequestDispatcher("QLSach_Admin.jsp").forward(request, response);
			
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
