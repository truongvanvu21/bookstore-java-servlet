<%@page import="java.util.ArrayList"%>
<%@page import="java.util.Map"%>
<%@page import="Models.Loai"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %> 
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Đăng nhập Admin</title>
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
                    <li class="nav-item">
                        <a class="nav-link active" href="dangnhapAdminController">
                            <i class="fa-solid fa-right-to-bracket"></i> Đăng nhập
                        </a>
                    </li>
                    <li class="nav-item border-bottom">
                        <a class="nav-link" href="dangkyAdminController">
                            <i class="fa-solid fa-user-plus"></i> Đăng ký
                        </a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="tcAdminController">
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
		    <div class="d-flex justify-content-center">
		        <form action="dangnhapAdminController" method="post" class="border p-4 rounded bg-white shadow w-100" style="max-width: 460px;">
		            <h3 class="text-center mb-4">Đăng nhập</h3>
		            <div class="mt-3">
		                <label for="username">Tên đăng nhập:</label>
		                <input class="form-control" id="username" type="text" name="txt_user" required>
		            </div>
		            <div class="mt-3">
		                <label for="password">Mật khẩu:</label>
		                <input class="form-control" id="password" type="password" name="txt_pass" required>
		            </div>
		            <%
						Integer d  = (Integer)(session.getAttribute("failedCount"));
						if(d >= 3){
					%>
						<img class="mt-2" src="simpleCaptcha.jpg" /></br>
						<input type="text" name="answer" /><br>
	 				<% }%>
		            <button type="submit" class="btn btn-primary mt-4 w-100">Đăng nhập</button>
		            <p class="text-danger mt-2">
		                <%= (request.getAttribute("error") != null ? request.getAttribute("error") : "") %>
			  			<%-- <c:out value="${error}" default=""/> --%>
		            </p>
		        </form>
		    </div>
		</div>	  
    </div>
</div>
</body>
</html>