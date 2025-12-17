package Controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import Models.LoaiBO;
import Models.Sach;
import Models.SachBO;

/**
 * Servlet implementation class tcController
 */
@WebServlet("/tcController")
public class tcController extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public tcController() {
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
			LoaiBO lbo = new LoaiBO();
			request.setAttribute("dsLoai", lbo.getLoai());
			
			String ml = request.getParameter("ml");
			if(ml == null || ml.trim().isEmpty() ) ml = null;
			String key = request.getParameter("input_search");
			if(key == null || key.trim().isEmpty()) key = null;
			
			int page = 1;
			int pageSize = 8;
			
			if(request.getParameter("page") != null) {
				page = Integer.parseInt(request.getParameter("page"));
			}
			
			SachBO sbo = new SachBO();
			
			int tongSach = sbo.getTongSach(ml, key);
			int totalPage = (int) Math.ceil((float) tongSach / pageSize);
			
			ArrayList<Sach> ds = sbo.getDanhSachPhanTrang(page, pageSize, ml, key);
			
			if(ds.isEmpty()) {
				request.setAttribute("empty", "Dữ liệu không hợp lệ");
			}
			
			request.setAttribute("mlLink", ml);
			request.setAttribute("keyLink", key);
			
			request.setAttribute("dsSach", ds);
			request.setAttribute("page", page);
			request.setAttribute("totalPage", totalPage);
			
			request.getRequestDispatcher("tc.jsp").forward(request, response);
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
