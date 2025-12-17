<%@page import="java.util.ArrayList"%>
<%@page import="Models.Sach"%>
<%@page import="Models.Loai"%>
<%@page import="Models.Admin"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %> 
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>Sách Admin</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
	<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/7.0.1/css/all.min.css">
    <style>
        body { background-color: #f8f9f9; }
        .sidebar {
            min-height: 100vh;
            background-color: #343a40;
            color: white;
        }
        .sidebar a {
            color: #adb5bd;
            text-decoration: none;
            padding: 10px 15px;
            display: block;
        }
        .sidebar a:hover, .sidebar a.active {
            background-color: #495057;
            color: white;
        }
        .card-custom {
            box-shadow: 0 4px 6px rgba(0,0,0,0.1);
            border: none;
        }
        .book-img {
            width: 60px; height: 80px; object-fit: cover;
        }
    </style>
</head>
<body>

<div class="container-fluid">
    <div class="row">
        <!-- Sidebar -->
        <nav class="col-md-3 col-lg-2 sidebar d-md-block show">
            <div class="pt-3">
                <ul class="nav flex-column">
                <% Admin user = (Admin)session.getAttribute("username");
					if(user != null){%>
	                <li class="nav-item">
                        <div class="d-flex flex-column align-items-center py-1">
                        	<i class="fa-solid fa-circle-user" style="font-size: 55px"></i>
                        	<h5>Admin, <%= user.getTenDangNhap() %></h5>
                        </div>
                    </li>
                    <li class="nav-item border-bottom">
                        <a class="nav-link text-danger" href="dangxuấtAdminController">
                            <i class="fas fa-sign-out-alt me-2"></i> Đăng xuất
                        </a>
                    </li>
					<%}else{ %>
					<li class="nav-item">
                        <a class="nav-link text-danger" href="dangnhapAdminController">
                            <i class="fa-solid fa-right-to-bracket"></i> Đăng nhập
                        </a>
                    </li>
                    <li class="nav-item border-bottom">
                        <a class="nav-link text-danger" href="dangkyAdminController">
                            <i class="fa-solid fa-user-plus"></i> Đăng ký
                        </a>
                    </li>
					<%} %>
				
                    <li class="nav-item">
                        <a class="nav-link" href="tcAdminController">
                            <i class="fas fa-home me-2"></i>Trang chủ
                        </a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="qlLoaiAdminController">
                            <i class="fas fa-list me-2"></i>Quản lý loại
                        </a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link active" href="qlSachAdminController">
                            <i class="fas fa-book me-2"></i>Quản lý sách
                        </a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="AdminController?action=xacnhan">
                            <i class="fas fa-check-circle me-2"></i>Xác nhận đơn hàng
                        </a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="AdminController?action=hoadondathanhtoan">
                            <i class="fas fa-file-invoice-dollar me-2"></i>Hóa đơn đã thanh toán
                        </a>
                    </li>
                </ul>
            </div>
        </nav>

        <div class="col-md-9 ms-sm-auto col-lg-10 px-3 py-1">
            <p class="text-success"><%= request.getAttribute("success") != null ? request.getAttribute("success") : "" %></p>
            <p class="text-danger"><%= request.getAttribute("error") != null ? request.getAttribute("error") : "" %></p>
			
            <!-- Form thêm sách -->
            <%-- <div class="card card-custom p-3 mb-4">
                <h5>Thêm sách mới</h5>
                <form action="AdminController" method="post" enctype="multipart/form-data" class="row g-3">
                    <input type="hidden" name="action" value="addsach">

                    <div class="col-md-3">
                        <label class="form-label">Mã sách</label>
                        <input type="text" name="masach" class="form-control" required>
                    </div>

                    <div class="col-md-5">
                        <label class="form-label">Tên sách</label>
                        <input type="text" name="tensach" class="form-control" required>
                    </div>

                    <div class="col-md-2">
                        <label class="form-label">Giá</label>
                        <input type="number" name="gia" class="form-control" required>
                    </div>

                    <div class="col-md-2">
                        <label class="form-label">Số lượng</label>
                        <input type="number" name="soluong" class="form-control" required>
                    </div>

                    <div class="col-md-3">
                        <label class="form-label">Loại</label>
                        <select name="maloai" class="form-control">
                            <c:forEach var="l" items="${dsLoai}">
                                <option value="${l.maLoai}">${l.tenLoai}</option>
                            </c:forEach>
                        </select>
                    </div>

                    <div class="col-md-4">
                        <label class="form-label">Ảnh</label>
                        <input type="file" name="anh" class="form-control">
                    </div>

                    <div class="col-md-5">
                        <label class="form-label">Mô tả</label>
                        <input type="text" name="mota" class="form-control">
                    </div>

                    <div class="col-12">
                        <button class="btn btn-primary"><i class="fas fa-plus-circle"></i> Thêm sách</button>
                    </div>
                </form>
            </div> --%>

            <!-- List sách -->
            <div class="card card-custom">
                <div class="card-header bg-white d-flex flex-column flex-md-row justify-content-between align-items-md-center gap-2">
				    <div class="d-flex align-items-center justify-content-between gap-2">
				    	<h5 class="mb-0 text-nowrap">
					        <i class="fas fa-table me-2"></i>Danh sách sách
					    </h5>
					    <button type="submit" name="btnsach_add" data-bs-toggle="modal" data-bs-target="#formThemSach" class="btn btn-success d-flex align-items-center justify-content-center gap-1">
	                        <i class="fas fa-plus-circle"></i> Thêm
	                    </button>
				    </div>
				    <form class="d-flex w-100 w-md-auto" action="qlSachAdminController">
				        <input class="form-control me-2" type="text" placeholder="Search" name="input_search">
				        <button class="btn btn-primary" type="submit">Search</button>
				    </form>
				</div>           

                <div class="card-body table-responsive">
                	<%
						if(request.getAttribute("empty") != null){
					%>
							<p><%= request.getAttribute("empty")%></p>
					<% 
						return;
					}%>
                    <table class="table table-hover table-bordered align-middle">
                        <thead class="table-dark">
                            <tr>
                                <th class="col-2 col-md-1">Ảnh</th>
		                        <th class="col-2 col-md-1">Mã sách</th>
		                        <th class="col-4 col-md-3">Tên sách</th>
		                        <th class="col-2 col-md-1">Giá</th>
		                        <th class="col-2 col-md-1">Số lượng</th>
		                        <th class="col-2 col-md-1">Loại</th>
		                        <th class="col-2 col-md-1">Số tập</th>
		                        <th class="col-4 col-md-2">Tác giả</th>
		                        <th class="col-4 col-md-2">Ngày nhập</th>
		                        <th class="col-1">Sửa</th>
		                        <th class="col-1">Xóa</th>
                            </tr>
                        </thead>

                        <tbody>                     	
							<%
                                ArrayList<Sach> dsSach = (ArrayList<Sach>) request.getAttribute("dsSach");
                                for(Sach s : dsSach){
                            %>
                            <tr>
                                <td>
                                	<img src="<%= s.getAnh() %>" alt="<%= s.getTenSach() %> " class="book-img">
                                </td>
                                <td><%=s.getMaSach()%></td>
                                <td><%=s.getTenSach()%></td>
                                <td><%=s.getGia()%></td>
                                <td><%=s.getSoLuong()%></td>
                                <td><%=s.getMaLoai()%></td>
                                <td><%=s.getSoTap()%></td>
                                <td><%=s.getTacGia()%></td>
                                <td><%=s.getNgayNhap()%></td>
								<!-- btn sửa  -->
                                <td>
                                    <button class="btn btn-warning btn-sm" data-bs-toggle="modal" data-bs-target="#formSuaSach<%=s.getMaSach().replace(" ", "")%>">
                                        <i class="fas fa-edit"></i>
                                    </button>
                                </td>

                                <!-- btn xóa -->
                                <td>
                                    <button class="btn btn-danger btn-sm" data-bs-toggle="modal" data-bs-target="#formXoaSach<%=s.getMaSach().replace(" ", "")%>">
                                        <i class="fas fa-trash"></i>
                                    </button>
                                </td>
                            </tr>
                            <% } %>
                        </tbody>
                        
                    </table>
                </div>
				<div class="col-sm-12">
				    <ul class="pagination justify-content-center flex-wrap">
				        <%
				            int totalPage = (int) request.getAttribute("totalPage");
				            int currentPage = (int) request.getAttribute("page");
				            String mlLink = (String) request.getAttribute("mlLink");
				            String keyLink = (String) request.getAttribute("keyLink");
				            int delta = 1;
				        %>
				        <%-- Button lùi 1 trang --%>
				        <li class="page-item <%= (currentPage == 1 ? "disabled" : "") %>">
				            <a class="page-link" href="qlSachAdminController?page=<%= currentPage - 1 %>&ml=<%= mlLink %>&input_search=<%= keyLink %>">
				                <i class="fa-solid fa-caret-left"></i>
				            </a>
				        </li>
				        
				        <%-- Trang đầu --%>
				        <li class="page-item <%= (currentPage == 1 ? "active" : "") %>">
				            <a class="page-link" href="qlSachAdminController?page=1&ml=<%= mlLink %>&input_search=<%= keyLink %>">
				                1
				            </a>
				        </li>
				        <%-- Dấu ... bên trái --%>
				        <% if (currentPage > delta + 2) {%>
				            <li class="page-item disabled">
				                <span class="page-link">...</span>
				            </li>
				        <% }%>	
				        <%-- 2 trang 2 bên trang hiện tại --%>
				        <% for (int i = Math.max(2,currentPage - delta); i <= Math.min(totalPage - 1,currentPage + delta); i++){ %>
				            <li class="page-item <%= (i == currentPage ? "active" : "") %>">
				                <a class="page-link" href="qlSachAdminController?page=<%= i %>&ml=<%= mlLink %>&input_search=<%= keyLink %>">
				                    <%= i %>
				                </a>
				            </li>
				        <% }%>
				        <%-- Dấu ... bên phải --%>
				        <% if (currentPage < totalPage - delta - 1) {%>
				            <li class="page-item disabled">
				                <span class="page-link">...</span>
				            </li>
				        <%	}%>
				        <%-- Trang cuối --%>
				        <% if (totalPage > 1) {%>
				        <li class="page-item <%= (currentPage == totalPage ? "active" : "") %>">
				            <a class="page-link" href="qlSachAdminController?page=<%= totalPage %>&ml=<%= mlLink %>&input_search=<%= keyLink %>">
				                <%= totalPage %>
				            </a>
				        </li>
				        <% }%>
				        
				        <li class="page-item <%= (currentPage == totalPage ? "disabled" : "") %>">
				            <a class="page-link" href="qlSachAdminController?page=<%= currentPage + 1 %>&ml=<%= mlLink %>&input_search=<%= keyLink %>">
				                <i class="fa-solid fa-caret-right"></i>
				            </a>
				        </li>
				    </ul>
				</div>
            </div>
        </div>
        
        <!-- Modal Thêm sách -->
        <div class="modal fade" id="formThemSach" tabindex="-1">
		    <div class="modal-dialog modal-lg modal-dialog-centered">
		        <div class="modal-content">
		            <form action="qlSachAdminController" method="post" enctype="multipart/form-data">
		                <input type="hidden" name="action" value="addsach">
		
		                <div class="modal-header">
		                    <h5 class="modal-title fw-bold fs-3">Thêm sách mới</h5>
		                    <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
		                </div>
		
		                <div class="modal-body row g-3">
		                    <div class="col-md-4">
		                        <label>Mã sách</label>
		                        <input type="text" name="masach" class="form-control" required>
		                    </div>
		                    <div class="col-md-8">
		                        <label>Tên sách</label>
		                        <input type="text" name="tensach" class="form-control" required>
		                    </div>
		                    <div class="col-md-4">
		                        <label>Giá</label>
		                        <input type="number" name="gia" class="form-control" required>
		                    </div>
		
		                    <div class="col-md-4">
		                        <label>Số lượng</label>
		                        <input type="number" name="soluong" class="form-control" required>
		                    </div>
		                    <div class="col-md-4">
		                        <label>Số tập</label>
		                        <input type="number" name="sotap" class="form-control">
		                    </div>
		
		                    <div class="col-md-6">
		                        <label>Tác giả</label>
		                        <input type="text" name="tacgia" class="form-control">
		                    </div>
		                    <div class="col-md-6">
		                        <label>Loại</label>
		                        <select name="maloai" class="form-select">
		                            <%-- <c:forEach var="l" items="${dsLoai}">
		                                <option value="${l.maLoai}">${l.tenLoai}</option>
		                            </c:forEach> --%>
		                             <%
		                             	ArrayList<Loai> dsLoai = (ArrayList<Loai>) request.getAttribute("dsLoai");
		                            	for(Loai l : dsLoai){
		                            %>
		                            		<option value="<%= l.getMaLoai()%>"><%= l.getTenLoai() %></option>
		                            <% }%>
		                        </select>
		                    </div>
		                    <div class="col-md-6">
		                        <label>Ảnh</label>
		                        <input type="file" name="anh" class="form-control">
		                    </div>
		                    <div class="col-md-6">
							    <label>Ngày nhập</label>
							    <input type="date" name="ngaynhap" class="form-control" required>
							</div>
		                </div>
		
		                <div class="modal-footer">
		                    <button class="btn btn-secondary" data-bs-dismiss="modal">Hủy</button>
		                    <button class="btn btn-success">Lưu</button>
		                </div>
		            </form>
		        </div>
		    </div>
		</div>   
		
		<!-- Modal sửa-->
        <% for(Sach s : dsSach){ %>						
		<div class="modal fade" id="formSuaSach<%=s.getMaSach().replace(" ", "")%>" tabindex="-1">
		  <div class="modal-dialog modal-dialog-centered">
		    <div class="modal-content">
		    	<form method="post" action="qlSachAdminController" enctype="multipart/form-data">						
				      <div class="modal-header">
				        <h5 class="modal-title fw-bold fs-3">Chỉnh sửa</h5>
				        <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
				      </div>
			
				      <div class="modal-body row g-3">
						<input type="hidden" name="action" value="updateSach">
						<div class="col-md-4">
							<label >Mã sách</label>
						    <input type="text" name="masach_update" class="form-control" readonly value="<%=s.getMaSach()%>">
						</div>
						<div class="col-md-8">
	                        <label >Tên sách</label>
	                        <input type="text" name="tensach_update" class="form-control" value="<%=s.getTenSach()%>">
	                    </div>
	                    <div class="col-md-4">
	                        <label>Giá</label>
	                        <input type="number" name="gia_update" class="form-control" value="<%=s.getGia()%>">
	                    </div>
	
	                    <div class="col-md-4">
	                        <label>Số lượng</label>
	                        <input type="number" name="soluong_update" class="form-control" value="<%=s.getSoLuong()%>">
	                    </div>
	                    <div class="col-md-4">
	                        <label>Số tập</label>
	                        <input type="number" name="sotap_update" class="form-control" value="<%=s.getSoTap()%>">
	                    </div>
	
	                    <div class="col-md-6">
	                        <label>Tác giả</label>
	                        <input type="text" name="tacgia_update" class="form-control" value="<%=s.getTacGia()%>">
	                    </div>
	                    <div class="col-md-6">
	                        <label>Loại</label>
	                        <select name="maloai_update" class="form-select">
	                            <%-- <c:forEach var="l" items="${dsLoai}">
	                                <option value="${l.maLoai}">${l.tenLoai}</option>
	                            </c:forEach> --%>
	                             <%	for(Loai l : dsLoai){ 
	                             		String selected = l.getMaLoai().equals(s.getMaLoai()) ? "selected" : "";
	                             %>
	                            		<option value="<%= l.getMaLoai()%>" <%= selected %>><%= l.getTenLoai() %></option>
	                            <% }%>
	                        </select>
	                    </div>
	                    <div class="col-md-5">
						    <label>Ảnh hiện tại</label><br>
						    <img src="<%= s.getAnh() %>" class="img-thumbnail" style="max-height:120px">	    
						    <input type="hidden" name="anhcu" value="<%= s.getAnh() %>">
	                    </div>
	                    <div class="col-md-7">		
						    <label>Chọn ảnh mới (nếu có)</label>
						    <input type="file" name="anh_update" class="form-control">
	                    </div>
	                    <div class="col-md-6">
						    <label>Ngày nhập</label>
						    <input type="date" name="ngaynhap_update" class="form-control" value="<%=s.getNgayNhap()%>">
						</div>
				      </div>
					<div class="modal-footer">
					    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Hủy</button>
					    <button type="submit" class="btn btn-warning">Cập nhật</button>
					</div>
		       </form>		 			
		    </div>
		  </div>
		</div>
		<% } %>
		
		<!-- Modal Xóa sách -->
		<% for(Sach s : dsSach){ %>
		<div class="modal fade" id="formXoaSach<%=s.getMaSach().replace(" ", "")%>" tabindex="-1">
		    <div class="modal-dialog modal-dialog-centered">
		        <div class="modal-content">
		
		            <form action="qlSachAdminController" method="post">
		                <input type="hidden" name="action" value="deleteSach">	
		                <div class="modal-header">
		                    <h5 class="modal-title fs-3">Xóa </h5>
		                    <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
		                </div>
		
		                <div class="modal-body">
		                    <h5 class="modal-title mb-2">
		                        Bạn có chắc chắn xóa sách này không?
		                    </h5>
		                    <div class="col-md-12">
				               <label class="form-label">Mã sách : <%=s.getMaSach() %></label>   
				               <input type="hidden" name="masachDelete" class="form-control" value="<%=s.getMaSach()%>">
				           </div>
				           <div class="col-md-12">
				               <label class="form-label">Tên sách : <%=s.getTenSach() %></label>   
				               <input type="hidden" name="tensachDelete" class="form-control" value="<%=s.getTenSach()%>">
				           </div>
				           <div class="col-md-12">
							    <img src="<%= s.getAnh() %>" class="img-thumbnail" style="max-height:120px">
							    <input type="hidden" name="anhDelete" value="<%=s.getAnh() %>">	    
		                    </div>
		                </div>
		                    
		                <div class="modal-footer">
			                <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Hủy</button>
			                <button type="submit" class="btn btn-danger">Xóa</button>
			            </div>
		            </form>
		        </div>
		    </div>
		</div>
		<% } %>
		
    </div>
</div>

</body>
</html>
