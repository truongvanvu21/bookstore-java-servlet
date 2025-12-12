<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<title>Đăng nhập</title>
  	<meta charset="utf-8">
  	<meta name="viewport" content="width=device-width, initial-scale=1">
  	<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
  	<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
  	<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.css">
  	<style>
  		.navbar-custom {
  			background-color: #2d2f31;
  			color: #fff;
  		}
  		.navbar-custom a {
            color: #adb5bd;
            text-decoration: none;
            padding: 6px 10px;
            display: block;
        }
        .navbar-custom a:hover,
        .navbar-custom a.active {
            background-color: #505a64;
            color: #fff;
        }
        .btn-custom {
		    background-color: #2d2f31;
		    color: #adb5bd;
		    border: none;
		    padding: 7px 15px;
		    border-radius: 5px;
		    transition: 0.2s;
		    font-size: 14px;
		}
		.btn-custom:hover {
		    background-color: #505a64;
		    color: #fff;
		}
   		.login-box {
			margin-top: 30px;
  		}
  	</style>
</head>
<body>
	<nav class="navbar navbar-expand-sm navbar-dark navbar-custom">
	  <div class="container-fluid">
	    <a class="navbar-brand" href="javascript:void(0)">Logo</a>
	    <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#mynavbar">
	      <span class="navbar-toggler-icon"></span>
	    </button>
	    <div class="collapse navbar-collapse" id="mynavbar">
	      <ul class="navbar-nav me-auto">
	        <li class="nav-item">
	          <a class="nav-link" href="tcController">
	          	<i class="bi bi-house"></i> Trang chủ
	          </a>
	        </li>
	        <li class="nav-item">
	          <a class="nav-link" href="giohangController">
	          	<i class="bi bi-cart"></i> Giỏ hàng
	          </a>
	        </li>
	        <li class="nav-item">
	          <a class="nav-link" href="thanhtoanController">
	          	<i class="bi bi-credit-card"></i> Thanh toán
	          </a>
	        </li>
	        <li class="nav-item">
	          <a class="nav-link" href="HtLichSuController">
	          	<i class="bi bi-receipt"></i> Lịch sử mua hàng
	          </a>
	        </li>
	        <li class="nav-item">
	          <a class="nav-link active" href="dangnhapController">
	          	<i class="bi bi-box-arrow-in-right"></i> Đăng nhập
	          </a>
	        </li>
	        <li class="nav-item">
    			<a class="nav-link" href="dangkyController">
    				<i class="bi bi-person-plus"></i> Đăng ký
    			</a>
  			</li>
	      </ul>
	      <form class="d-flex">
	        <input class="form-control me-2" type="text" placeholder="Search">
	        <button class="btn btn-primary" type="button">Search</button>
	      </form>
	    </div>
	  </div>
	</nav>
	
	<div class="row">
		<%-- <div class="col-12 col-md-6 col-lg-4 d-flex justify-content-center login-box">
			<form action="dangnhapController" method="post" class="w-100 border p-4 rounded">
				<h3 class="text-center">Đăng nhập</h3>
				<div class="mt-3">
				    <label for="username">Tên đăng nhập:</label><br>
				    <input class="form-control" id="username" type="text" name="txt_user" required>
				</div>
				<div class="mt-2">
				    <label for="password">Mật khẩu:</label><br>
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
				<p style="color:red;">
			  		<%= (request.getAttribute("error") != null ? request.getAttribute("error") : "") %>
			  		<c:out value="${error}" default=""/>
			  	</p>
		  </form>
		</div> --%>
		
		<div class="col-md-9 ms-sm-auto col-lg-10 px-4 py-4">
		    <div class="d-flex justify-content-center align-items-center" style="min-height: 90vh;">
		        <form action="dangnhapController" method="post" class="border p-4 rounded bg-white shadow w-100" style="max-width: 420px;">
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
					<p style="color:red;">
				  		<%= (request.getAttribute("error") != null ? request.getAttribute("error") : "") %>
				  	</p>
		        </form>
		    </div>
		</div>
	</div>
</body>
</html>