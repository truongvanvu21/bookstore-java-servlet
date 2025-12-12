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
                <%Admin user = (Admin)session.getAttribute("username");
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

        <div class="col-md-9 ms-sm-auto col-lg-10 px-4 py-4">

            <h3 class="mb-4"><i class="fas fa-book me-2"></i>Quản lý sách</h3>

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

            <!-- Bảng sách -->
            <div class="card card-custom">
                <div class="card-header bg-white d-flex flex-column flex-md-row justify-content-between align-items-md-center gap-2">
				    <h5 class="mb-0">
				        <i class="fas fa-table me-2"></i>Danh sách sách
				    </h5>
				    <form class="d-flex w-100 w-md-auto" action="qlSachAdminController">
				        <input class="form-control me-2" type="text" placeholder="Search" name="input_search">
				        <button class="btn btn-primary" type="submit">Search</button>
				    </form>
				</div>           

                <div class="card-body table-responsive">
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
                                    <button class="btn btn-warning btn-sm" data-bs-toggle="modal" data-bs-target="#formSua">
                                        <i class="fas fa-edit"></i>
                                    </button>
                                </td>

                                <!-- XÓA -->
                                <td>
<%--                                     <a href="qlLoaiAdminController?action=delete&maloaiDelete=<%=l.getMaLoai()%>" class="btn btn-danger">
                                       <i class="fas fa-trash"></i>
                                    </a> --%>
                                    <button class="btn btn-danger btn-sm" data-bs-toggle="modal" data-bs-target="#formXoa">
                                        <i class="fas fa-trash"></i>
                                    </button>
                                </td>
                            </tr>

                            <% } %>
                        </tbody>
                    </table>
                </div>

            </div>

        </div>
    </div>

</div>

</body>
</html>
