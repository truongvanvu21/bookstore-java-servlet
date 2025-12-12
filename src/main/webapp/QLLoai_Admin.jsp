<%@page import="java.util.ArrayList"%>
<%@page import="java.util.Map"%>
<%@page import="Models.Loai"%>
<%@page import="Models.Admin"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %> 
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Loại Admin</title>
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
    </style>
</head>
<body>

<div class="container-fluid">
    <div class="row">
        <nav class="col-md-3 col-lg-2 d-md-block sidebar collapse show">
            <div class="position-sticky pt-3">
                <ul class="nav flex-column">
                <%Admin user = (Admin)session.getAttribute("username");
				if(user != null){%>
	                <li class="nav-item">
                        <div class="d-flex flex-column align-items-center py-1">
                        	<i class="fa-solid fa-circle-user" style="font-size: 55px"></i>
                        	<h5>Admin, <%= user.getTenDangNhap() %></h5>
                        </div>
                    </li>
                    <li class="nav-item border-bottom">
                        <a class="nav-link text-danger" href="dangxuatAdminController">
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
                            <i class="fas fa-home me-2"></i> Trang chủ
                        </a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link active" href="qlLoaiAdminController">
                            <i class="fas fa-list me-2"></i> Quản lý loại
                        </a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="qlSachAdminController">
                            <i class="fas fa-book me-2"></i> Quản lý sách
                        </a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="AdminController?action=xacnhan">
                            <i class="fas fa-check-circle me-2"></i> Xác nhận đơn hàng
                        </a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="AdminController?action=hoadondathanhtoan">
                            <i class="fas fa-file-invoice-dollar me-2"></i> Hóa đơn đã thanh toán
                        </a>
                    </li>
                </ul>
            </div>
        </nav>

        <div class="col-md-9 ms-sm-auto col-lg-10 px-4 py-4">
			<h3 class="mb-4"><i class="fas fa-list me-2"></i>Quản lý loại sách</h3>
			<p style="color:green;">
		  		<%= (request.getAttribute("success") != null ? request.getAttribute("success") : "") %>
		  	</p>
			<p style="color:red;">
		  		<%= (request.getAttribute("error") != null ? request.getAttribute("error") : "") %>
		  	</p>
            <!-- form thêm loại -->
            <div class="card card-custom mb-4 p-3">
                <h5 class="mb-3">Thêm loại mới</h5>
                <form action="qlLoaiAdminController" method="post" class="row g-3">
                    <input type="hidden" name="action" value="add">
                    <div class="col-md-4">
                        <label class="form-label">Mã loại</label>
                        <input type="text" name="maloai_add" class="form-control" required>
                    </div>
                    <div class="col-md-6">
                        <label class="form-label">Tên loại</label>
                        <input type="text" name="tenloai_add" class="form-control" required>
                    </div>

                    <div class="col-md-2 d-flex align-items-end">
                        <button type="submit" name="btnloai_add" class="btn btn-primary w-100">
                        	<i class="fas fa-plus-circle"></i> Thêm
                        </button>
                    </div>
                </form>
            </div>
            
            <!-- bảng thống kê loại -->
            <div class="card card-custom">
                <div class="card-header bg-white">
                    <h5 class="mb-0"><i class="fas fa-clock me-2"></i>Danh sách đơn hàng ngày hôm nay</h5>
                </div>
                <div class="card-body table-responsive">
                      <table class="table table-hover table-bordered align-middle">
                          <thead class="table-dark">
                              <tr>
                                  <th>Mã Loại</th>
                                  <th>Tên Loại</th>
                                  <th>Số Lượng Sách</th>
                                  <th>Sửa</th>
                                  <th>Xóa</th>
                              </tr>
                          </thead>
                          <tbody>
                          <%
                              ArrayList<Loai> dsLoai = (ArrayList<Loai>) request.getAttribute("dsLoai");
                              Map<String, Long> mapSL = (Map<String, Long>) request.getAttribute("mapSL");

                              for(Loai l : dsLoai){
                                  long soLuong = 0;
                                  if (mapSL.containsKey(l.getMaLoai())) {
						        soLuong = mapSL.get(l.getMaLoai());
						    }
                          %>
                          <tr>
                              <td><%=l.getMaLoai()%></td>
                              <td><%=l.getTenLoai()%></td>
                              <td><%=soLuong%></td>

						<!-- btn sửa  -->
                              <td>
                                  <button class="btn btn-warning" data-bs-toggle="modal" data-bs-target="#formSua<%=l.getMaLoai().replaceAll(" ", "")%>">
                                      <i class="fas fa-edit"></i>
                                  </button>
                              </td>

                              <!-- XÓA -->
                              <td>
<%--                                     <a href="qlLoaiAdminController?action=delete&maloaiDelete=<%=l.getMaLoai()%>" class="btn btn-danger">
                                       <i class="fas fa-trash"></i>
                                    </a> --%>
                                  <button class="btn btn-danger" data-bs-toggle="modal" data-bs-target="#formXoa<%=l.getMaLoai().replaceAll(" ", "")%>">
                                      <i class="fas fa-trash"></i>
                                  </button>
                              </td>
                          </tr>

                          <% } %>
                      	</tbody>
                      </table>
                      
                       <% for(Loai l : dsLoai){ %>						
					<!-- Modal sửa-->
					<div class="modal fade" id="formSua<%=l.getMaLoai().replaceAll(" ", "")%>" tabindex="-1">
					  <div class="modal-dialog modal-dialog-centered">
					    <div class="modal-content">
					    	<form method="post" action="qlLoaiAdminController">						
						      <div class="modal-header">
						        <h5 class="modal-title">Chỉnh sửa</h5>
						        <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
						      </div>
						
						      <div class="modal-body">

						        	<input type="hidden" name="action" value="update">
						        	<div class="col-md-6">
						        		<label class="form-label">Mã loại</label>
						               <input type="text" name="maloai_update" class="form-control" readonly value="<%=l.getMaLoai()%>" required>
						           </div>
						        	<div class="col-md-6">
						               <label class="form-label">Tên loại</label>
						               <input type="text" name="tenloai_update" class="form-control" value="<%=l.getTenLoai()%>" required>
						           </div>

						      </div>
						
					            <div class="modal-footer">
					                <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Hủy</button>
					                <button type="submit" class="btn btn-success">Cập nhật</button>
					            </div>
					        </form>	 					
					    </div>
					  </div>
					</div>
					<% } %>
					
					<% for(Loai l : dsLoai){ %>						
					<!-- Modal delete-->
					<div class="modal fade" id="formXoa<%=l.getMaLoai().replaceAll(" ", "")%>" tabindex="-1">
					  <div class="modal-dialog modal-dialog-centered">
					    <div class="modal-content">
					    	<form method="post" action="qlLoaiAdminController">						
						      <div class="modal-header">
						        <h5 class="modal-title">Xóa</h5>
						        <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
						      </div>	
						      					
						      <div class="modal-body">
						        	<input type="hidden" name="action" value="delete">
						        	<h5 class="modal-title">Bạn có chắc chắn xóa loại sách này không?</h5>
						        	<div class="col-md-6">
						               <label class="form-label">Mã loại : <%=l.getMaLoai() %></label>   
						               <input type="hidden" name="maloaiDelete" class="form-control" value="<%=l.getMaLoai()%>" required>
						           </div>
						      </div>
						      
					            <div class="modal-footer">
					                <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Hủy</button>
					                <button type="submit" class="btn btn-danger">Có</button>
					            </div>
					        </form>	 					
					    </div>
					  </div>
					</div>
					<% } %>
                </div>
            </div>
        </div>
    </div>
</div>
</body>
</html>