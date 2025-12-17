package Controller;

import java.io.File;
import java.io.IOException;
import java.nio.file.Paths;
import java.sql.Date;
import java.util.ArrayList;

import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.servlet.http.Part;

import Models.Admin;
import Models.LoaiBO;
import Models.Sach;
import Models.SachBO;


/**
 * Servlet implementation class qlSachAdminController
 */
@WebServlet("/qlSachAdminController")
@MultipartConfig(
	    fileSizeThreshold = 1024 * 1024,   // 1MB
	    maxFileSize = 1024 * 1024 * 5,      // 5MB
	    maxRequestSize = 1024 * 1024 * 10   // 10MB
	)
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
			LoaiBO lbo = new LoaiBO();
			String action = request.getParameter("action");		
			
			
			Admin ad = (Admin) session.getAttribute("username");
			if(ad == null) {
				response.sendRedirect("dangnhapAdminController");
				return;
			}
			
			String key = request.getParameter("input_search");
			if(key == null || key.trim().isEmpty() || "null".equals(key)) key = "";	
			int page = 1;
			int pageSize = 5;
			
			if(request.getParameter("page") != null) {
				page = Integer.parseInt(request.getParameter("page"));
			}
			
			int tongSach = sbo.getTongSachOfAdmin(key);
			int totalPage = (int) Math.ceil((float) tongSach / pageSize);		
			ArrayList<Sach> ds = sbo.getDanhSachPhanTrangOfAdmin(page, pageSize, key);
			
			System.out.println(ds.size());
			if(ds.isEmpty()) {
				request.setAttribute("empty", "Dữ liệu không hợp lệ");
			}
		
			if ("addsach".equals(action)) {
                String masach = request.getParameter("masach");
                String tensach = request.getParameter("tensach");
                long gia = Long.parseLong(request.getParameter("gia"));
                long soluong = Long.parseLong(request.getParameter("soluong"));
                String sotap = request.getParameter("sotap");
                String tacgia = request.getParameter("tacgia");
                String maloai = request.getParameter("maloai");
                Date ngaynhap = Date.valueOf(request.getParameter("ngaynhap"));

                // 2Upload ảnh
                Part filePart = request.getPart("anh");
                String fileName = Paths.get(filePart.getSubmittedFileName()).getFileName().toString();

                String uploadPath = request.getServletContext().getRealPath("")+ File.separator + "image_sach";

                File uploadDir = new File(uploadPath);
                if (!uploadDir.exists()) uploadDir.mkdir();

                String filePath = uploadPath + File.separator + fileName;
                filePart.write(filePath);

                String anh = "image_sach/" + fileName;

                Sach s = new Sach(masach,tensach,soluong,gia,maloai,sotap,anh,ngaynhap,tacgia);
                sbo.addSach(s);

                response.sendRedirect("qlSachAdminController");
                return;
            }
			
			if("updateSach".equals(action)) {
				String masach = request.getParameter("masach_update");
				String tensach = request.getParameter("tensach_update");
                long gia = Long.parseLong(request.getParameter("gia_update"));
                long soluong = Long.parseLong(request.getParameter("soluong_update"));
                String sotap = request.getParameter("sotap_update");
                String tacgia = request.getParameter("tacgia_update");
                String maloai = request.getParameter("maloai_update");
                Date ngaynhap = Date.valueOf(request.getParameter("ngaynhap_update"));
                
                String anhCu = request.getParameter("anhcu");
                String anh = anhCu;
                
                Part filePart = request.getPart("anh_update");
                if(filePart != null && filePart.getSize() > 0) {
                	String fileName = Paths.get(filePart.getSubmittedFileName()).getFileName().toString();
                	String uploadPath = request.getServletContext().getRealPath("") + File.separator + "image_sach";
                	
                	File uploadDir = new File(uploadPath);
                	if(!uploadDir.exists()) uploadDir.mkdir();
                	
                	String filePath = uploadPath + File.separator + fileName;
                	filePart.write(filePath);
                	
                	anh = "image_sach/" + fileName;
                }
				Sach sach = new Sach(masach,tensach,soluong,gia,maloai,sotap,anh,ngaynhap,tacgia);
				sbo.updateSach(sach);
				
				response.sendRedirect("qlSachAdminController");             
				return;
			}

			if("deleteSach".equals(action)) {
				String masach = request.getParameter("masachDelete");
				String anh = request.getParameter("anhDelete");
				
				if(anh != null && !anh.trim().isEmpty()) {
					String realPath = request.getServletContext().getRealPath("/");
					File file = new File(realPath + anh);
					if(file.exists()) file.delete();
				}
				
				sbo.deleteSach(masach);
				response.sendRedirect("qlSachAdminController");
				return;
			}
			request.setAttribute("keyLink", key);
			
			request.setAttribute("dsSach", ds);
			request.setAttribute("page", page);
			request.setAttribute("totalPage", totalPage);
			
			request.setAttribute("dsLoai", lbo.getLoai());
			
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
