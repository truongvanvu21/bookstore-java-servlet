<%@page import="java.util.ArrayList"%>
<%@page import="Models.ThongKeDonHang"%>
<%@page import="Models.Admin"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %> 
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Trang Chủ Admin</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
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
            box-shadow: 0 4px 6px rgba(0,0,0,0.2);
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
                        <a class="nav-link active" href="tcAdminController">
                            <i class="fas fa-home me-2"></i> Trang chủ
                        </a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="qlLoaiAdminController">
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
            <div class="row mb-4">
                <div class="col-md-4">
                    <div class="card card-custom bg-primary text-white p-3">
                        <h5>Đơn hàng mới hôm nay</h5>
<%--                         <h3>${fn:length(dsDonHangHomNay)}</h3> </div> --%>
                </div>
            </div>

            <div class="card card-custom">
                <div class="card-header bg-white">
                    <h5 class="mb-0"><i class="fas fa-clock me-2"></i>Danh sách đơn hàng ngày hôm nay</h5>
                </div>
                <div class="card-body">
                    <div class="table-responsive">
                        <table class="table table-hover table-bordered align-middle">
                            <thead class="table-dark">
                                <tr>
                                    <th>Mã KH</th>
                                    <th>Họ Tên</th>
                                    <th>Tổng Số Lượng</th>
                                    <th>Tổng giá (VND)</th>
                                    <th>Thành Tiền</th>
                                    <th>Mã Hóa Đơn</th>
                                </tr>
                            </thead>
                            <tbody>
                                <%
                                	ArrayList<ThongKeDonHang> dsThongKeDonHang = (ArrayList<ThongKeDonHang>)request.getAttribute("dsHoaDonHomNay");
                                	for(ThongKeDonHang tkdh : dsThongKeDonHang){
                                %>
                                	<tr>
			                            <td><%= tkdh.getMakh() %></td>
			                            <td><%= tkdh.getHoten() %></td>
			                            <td><%= tkdh.getTongSoLuong() %></td>
			                            <td><%= tkdh.getTongGia() %></td>
			                            <td><%= tkdh.getThanhTien() %></td>
			                            <td><%= tkdh.getMaHoaDon() %></td>
			                        </tr>
                                <% }%>
                            </tbody>
                        </table>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
</body>
</html>