<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@page import="java.util.ArrayList"%>
<%@page import="Models.Sach"%>
<%@page import="Models.KhachHang" %>
<%@page import="Models.Loai"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<title>Trang chủ sách</title>
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
  		
  		/* Sidebar loai */
  		.category-card {
  			background: white;
  			border-radius: 8px;
  			box-shadow: 0 2px 8px rgba(0,0,0,0.1);
  			overflow: hidden;
  		}
  		.category-header {
  			background-color: #2d2f31;
  			color: white;
  			padding: 12px 15px;
  			font-weight: 600;
  		}
  		.list-group-item-action {
  			transition: all 0.2s;
  			border-left: 3px solid transparent;
  		}
  		.list-group-item-action:hover {
  			background-color: #f1f3f5;
  			color: #0d6efd;
  			border-left: 3px solid #0d6efd;
  			padding-left: 20px;
  		}
  		
  		.card-img-wrapper {
  			height: 280px; 
  			overflow: hidden;
  			display: flex;
  			align-items: center;
  			justify-content: center;
  			padding: 10px;
  			background-color: #fff;
  			border-bottom: 1px solid #eee;
  		}
  		.book-title {
  			font-size: 1rem;
  			font-weight: 600;
  			color: #333;
  			margin-bottom: 5px;
  			display: -webkit-box;
  			-webkit-line-clamp: 2;
  			-webkit-box-orient: vertical;
  			overflow: hidden;
  			height: 45px;
    		font-size: 16px;
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
	          <a class="nav-link active" href="tcController">
	          	<i class="fa-solid fa-house"></i> Trang chủ
	          </a>
	        </li>
	        <li class="nav-item">
	          <a class="nav-link" href="giohangController">
	          	<i class="fa-solid fa-cart-shopping"></i> Giỏ hàng
	          </a>
	        </li>
	        <li class="nav-item">
	          <a class="nav-link" href="HtThanhToanController">
	          	<i class="fa-solid fa-credit-card"></i> Thanh toán
	          </a>
	        </li>
	        <li class="nav-item">
	          <a class="nav-link" href="HtLichSuController">
	          	<i class="fa-solid fa-clock-rotate-left"></i> Lịch sử
	          </a>
	        </li>

	        <c:choose>
        		<c:when test="${not empty sessionScope.user}">
	        		<li class="nav-item ">
						<a class="nav-link text-danger fw-bold" href="#">Xin chào: ${sessionScope.user.hoTen}</a>
					</li>
					<li class="nav-item">
		          		<a class="nav-link" href="dangxuatController">
		          			<i class="fa-solid fa-right-from-bracket"></i> Đăng xuất
		          		</a>
		        	</li>
        		</c:when>
        		<c:otherwise>
        			<li class="nav-item">
          				<a class="nav-link" href="dangnhapController">
          					<i class="fa-solid fa-right-to-bracket"></i> Đăng nhập
          				</a>
          			</li>
        			<li class="nav-item">
          				<a class="nav-link" href="dangkyController">
          					<i class="fa-solid fa-user-plus"></i> Đăng ký
          				</a>
          			</li>
        		</c:otherwise>
	        </c:choose>
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
	
	<div class=" p-4">
		<div class=" row">
			<div class="col-lg-3 col-md-4 mb-4">
				<div class="category-card">
					<div class="category-header">
						<i class="fa-solid fa-list-ul"></i> DANH MỤC SÁCH
					</div>
					<div class="list-group list-group-flush">
						<c:forEach items="${dsLoai}" var="l">
							<a href="tcController?ml=${l.maLoai }" class="list-group-item list-group-item-action">
				                ${l.tenLoai}
				            </a>
						</c:forEach>
					</div>
				</div>
			</div>
			<div class="col-sm-9 row">
				<c:choose>
				    <c:when test="${not empty emptys}">
				        <div>${emptys}</div>
				    </c:when>
				    <c:otherwise>
				        <c:forEach items="${dsSach}" var="s">
							<div class="col-sm-3 text-center mb-4">
									<img src="${s.anh }" alt="${s.tenSach }" class="card-img-wrapper">
									<div class="book-title">${s.tenSach }</div>
									<div>${s.tacGia }</div>
									<div>${s.gia }</div>
									<a href="giohangController?ms=${s.maSach }&ts=${s.tenSach }&sl=${s.soLuong }&gia=${s.gia }&anh=${s.anh}">
										<img src="buynow.jpg">
									</a>
								</div>
						</c:forEach>
						<div class="col-sm-12 mt-3">
						    <ul class="pagination justify-content-center flex-wrap">
							    <c:set var="delta" value="1"/>
							    <c:set var="currentPage" value="${page}"/>
							
							    <!-- Nút lùi 1 trang -->
							    <li class="page-item ${currentPage == 1 ? 'disabled' : ''}">
							        <a class="page-link"
							           href="tcController?page=${currentPage - 1}&ml=${mlLink}&input_search=${keyLink}">
							            <i class="fa-solid fa-caret-left"></i>
							        </a>
							    </li>
							
							    <!-- Trang đầu -->
							    <li class="page-item ${currentPage == 1 ? 'active' : ''}">
							        <a class="page-link"
							           href="tcController?page=1&ml=${mlLink}&input_search=${keyLink}">
							            1
							        </a>
							    </li>
							
							    <!-- Dấu ... bên trái -->
							    <c:if test="${currentPage > delta + 2}">
							        <li class="page-item disabled">
							            <span class="page-link">...</span>
							        </li>
							    </c:if>
							
							    <!-- Các trang xung quanh trang hiện tại -->
							    <c:forEach
							        begin="${currentPage - delta < 2 ? 2 : currentPage - delta}"
							        end="${currentPage + delta > totalPage - 1 ? totalPage - 1 : currentPage + delta}"
							        var="i">
							
							        <li class="page-item ${i == currentPage ? 'active' : ''}">
							            <a class="page-link"
							               href="tcController?page=${i}&ml=${mlLink}&input_search=${keyLink}">
							                ${i}
							            </a>
							        </li>						
							    </c:forEach>
							
							    <!-- Dấu ... bên phải -->
							    <c:if test="${currentPage < totalPage - delta - 1}">
							        <li class="page-item disabled">
							            <span class="page-link">...</span>
							        </li>
							    </c:if>
							
							    <!-- Trang cuối -->
							    <c:if test="${totalPage > 1}">
							        <li class="page-item ${currentPage == totalPage ? 'active' : ''}">
							            <a class="page-link"
							               href="tcController?page=${totalPage}&ml=${mlLink}&input_search=${keyLink}">
							                ${totalPage}
							            </a>
							        </li>
							    </c:if>
							
							    <!-- Nút tiến 1 trang -->
							    <li class="page-item ${currentPage == totalPage ? 'disabled' : ''}">
							        <a class="page-link"
							           href="tcController?page=${currentPage + 1}&ml=${mlLink}&input_search=${keyLink}">
							            <i class="fa-solid fa-caret-right"></i>
							        </a>
							    </li>
							</ul>
						</div>
				    </c:otherwise>
				</c:choose>
			</div>
		</div>
	</div>
</body>
</html>