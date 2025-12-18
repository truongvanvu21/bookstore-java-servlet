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
  	<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/7.0.1/css/all.min.css">
  	
  	<style>
		/* Navbar */
  		.navbar-custom {
  			background: linear-gradient(to right, #2d2f31, #1a1c1d);
  			box-shadow: 0 2px 4px rgba(0,0,0,.1);
  		}
  		.navbar-brand {
  			font-weight: 700;
  			letter-spacing: 1px;
  		}
  	</style>
</head>
<body>	
	<nav class="navbar navbar-expand-lg navbar-dark navbar-custom sticky-top">
	  <div class="container">
	    <a class="navbar-brand" href="javascript:void(0)">
	    	<i class="fa-solid fa-book"></i> BookStore
	    </a>
	    <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#mynavbar">
	      <span class="navbar-toggler-icon"></span>
	    </button>
	    <div class="collapse navbar-collapse" id="mynavbar">
	      <ul class="navbar-nav me-auto mb-2 mb-lg-0">
	        <li class="nav-item">
	          <a class="nav-link" href="tcController">
	          	<i class="fa-solid fa-house"></i> Trang chủ
	          </a>
	        </li>
	        <li class="nav-item">
	          <a class="nav-link" href="giohangController">
	          	<i class="fa-solid fa-cart-shopping"></i> Giỏ hàng
	          </a>
	        </li>
	        <li class="nav-item">
	          <a class="nav-link" href="thanhtoanController">
	          	<i class="fa-solid fa-credit-card"></i> Thanh toán
	          </a>
	        </li>
	        <li class="nav-item">
	          <a class="nav-link" href="HtLichSuController">
	          	<i class="fa-solid fa-clock-rotate-left"></i> Lịch sử
	          </a>
	        </li>
			<li class="nav-item">
				<a class="nav-link active" href="dangnhapController">
					<i class="fa-solid fa-right-to-bracket"></i> Đăng nhập
				</a>
			</li>
			<li class="nav-item">
   				<a class="nav-link" href="dangkyController">
   					<i class="fa-solid fa-user-plus"></i> Đăng ký
   				</a>
 			</li>
	      </ul>
	      
	      <form class="d-flex" action="tcController">
	      	<div class="input-group">
	        	<input class="form-control" type="text" placeholder="Tìm kiếm sách..." name="input_search">
	        	<button class="btn btn-primary" type="submit">
	        		<i class="fa-solid fa-magnifying-glass"></i>
	        	</button>
	        </div>
	      </form>
	    </div>
	  </div>
	</nav>
	
	<div class="row">		
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
				  	<c:if test="${sessionScope.failedCount >= 3}">
					    <img class="mt-2" src="simpleCaptcha.jpg" /><br>
					    <input type="text" name="answer" /><br>
					</c:if>
					
					<button type="submit" class="btn btn-primary mt-4 w-100">Đăng nhập</button>
					
					<p style="color:red;">
					    <c:out value="${error}" />
					</p>
				  	
		        </form>
		    </div>
		</div>
	</div>
</body>
</html>