<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page import = "Models.GioHang" %>
<%@ page import = "Models.Loai" %>
<%@ page import = "Models.Sach" %>
<%@ page import = "Models.KhachHang" %>
<%@page import="java.util.ArrayList"%>
<%@ page import = "Models.GioHangBO" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<title>Giỏ hàng sách</title>
	<meta charset="utf-8">
	<meta name="viewport" content="width=device-width, initial-scale=1">
	<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
  	<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
  	<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.2/css/all.min.css">
  	
  	<style>
		/* Navbar*/
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
 	    .content-wrapper {
           margin-top: 20px;
       }
       
       /* Cart Custom CSS */
       .cart-item {
           background-color: #fff;
           border-radius: 8px;
           box-shadow: 0 1px 3px rgba(0,0,0,0.1);
           transition: transform 0.2s;
       }
       .cart-item:hover {
           box-shadow: 0 4px 6px rgba(0,0,0,0.1);
       }
       .cart-img-wrapper {
           height: 120px;
           display: flex;
           align-items: center;
           justify-content: center;
           overflow: hidden;
           border-radius: 6px;
           background-color: #f8f9fa;
       }
       .cart-img-wrapper img {
           max-height: 100%;
           max-width: 100%;
           object-fit: contain;
       }
       .price-text {
           font-weight: 600;
           font-size: 1.1rem;
       }
       .header-row {
           background-color: #f8f9fa;
           border-radius: 8px;
           padding: 10px 0;
           font-weight: 600;
           color: #6c757d;
           font-size: 0.9rem;
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
	          <a class="nav-link active" href="giohangController">
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
	
	<div class="m-4">
		<div class="row justify-content-center">
			<!-- Sidebar -->
			<div class="col-lg-3 col-md-4 mb-4">
				<div class="category-card sticky-top" style="top: 80px; z-index: 1;">
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
			
			<!-- Cart Content -->
			<div class="col-lg-9 col-md-8 content-wrapper mt-0">
				<div class="card border-0 shadow-sm">
					<div class="card-body p-4">
						<h3 class="mb-4 border-bottom pb-2">
							<i class="fa-solid fa-cart-shopping"></i> Giỏ hàng của bạn
						</h3>
						
						<c:choose>
						    <c:when test="${not empty sessionScope.gh and not empty sessionScope.gh.ds}">			
						        <form action="suaxoaController" method="post">		 
						            <div class="row header-row mb-3 d-none d-md-flex text-center align-items-center">
						            	<div class="col-1"><input type="checkbox" class="form-check-input" disabled></div>
						            	<div class="col-2">Sản phẩm</div>
						            	<div class="col-3">Tên sách</div>
						            	<div class="col-2">Giá</div>
						            	<div class="col-2">Số lượng / Cập nhật</div>
						            	<div class="col-2">Thành tiền / Xóa</div>
						            </div>
						
						            <!-- Cart Items -->
						            <c:forEach var="item" items="${sessionScope.gh.ds}">
						                <div class="row align-items-center mb-3 p-3 cart-item border border-light">
						
						                    <!-- Checkbox -->
						                    <div class="col-md-1 col-2 text-center">
						                        <input class="form-check-input p-2" type="checkbox" value="${item.maSach}" name="select" style="cursor: pointer;">
						                    </div>
						
						                    <!-- Image -->
						                    <div class="col-md-2 col-4">
						                    	<div class="cart-img-wrapper">
						                        	<img src="${item.anh}" alt="${item.tenSach}" class="img-fluid">
						                        </div>
						                    </div>
						
						                    <div class="col-md-3 col-6">
						                    	<h6 class="mb-1 text-dark fw-bold">${item.tenSach}</h6>
						                    </div>
						
						                    <div class="col-md-2 text-center">
						                    	<span class="price-text d-none d-md-block">${item.gia}</span>
						                    	<small class="text-muted d-md-none">Đơn giá: ${item.gia}</small>
						                    </div>
						
						                    <!-- số lương & Update btn -->
						                    <div class="col-md-2 col-12 mt-2 mt-md-0 d-flex justify-content-between align-items-center flex-md-column">
						                    	<label class="d-md-none fw-bold">Số lượng:</label>
						                    	<div class="fw-bold mb-md-2">${item.soLuong}</div>
						                    	<div class="input-group input-group-sm">		
						                        	<input type="number" min="0" class="form-control text-center" name="${item.maSach}" value="0" placeholder="SL mới">
						                        	<button type="submit" name="btcsua" value="${item.maSach}" class="btn btn-warning">
						                            	<i class="fa-solid fa-rotate"></i>
						                        	</button>
						                        </div>
						                    </div>
						
						                    <!-- Thành tiền & Delete btn -->
						                    <div class="col-md-2 col-12 mt-2 mt-md-0 text-md-end text-center d-flex justify-content-between align-items-center flex-md-column">
						                    	<div class="d-md-none fw-bold">Tổng:</div>
						                    	<div class="fw-bold mb-md-2">${item.thanhTien}</div>
						                        <a href="suaxoaController?action=delete&ms=${item.maSach}" class="btn btn-sm btn-danger w-100">
						                            <i class="fa-solid fa-trash-can"></i> Xóa
						                        </a>
						                    </div>	
						                </div>
						            </c:forEach>
						
						            <!-- Footer -->
						            <div class="card bg-light mt-4">
						            	<div class="card-body">
							            	<div class="row align-items-center">
							            		<div class="col-md-6 mb-3 mb-md-0">
							            			<button type="submit" name="action" value="deleteSelect" class="btn btn-secondary">
								                        <i class="fa-regular fa-square-check"></i> Xóa mục đã chọn
								                    </button>
							            		</div>
							            		<div class="col-md-6 text-md-end">
							            			<h4 class="mb-0">
							            				Tổng tiền: <span class="text-danger fw-bold">${sessionScope.gh.tongTien} đ</span>
							            			</h4>
							            		</div>
							            	</div>
						            	</div>
						            </div>
						        </form>
								
								<!-- Checkout Button -->
						        <div class="text-end mt-4">
							        <form action="thanhtoanController" method="post">
							            <button type="submit" class="btn btn-success px-5 shadow">
							                Xác nhận mua hàng
							            </button>
							        </form>		
						        </div>
						    </c:when>
						    <c:otherwise>
						        <div class="text-center py-5">
						        	<i class="fa-solid fa-cart-arrow-down fa-4x text-muted mb-3"></i>
						        	<h4 class="text-muted">Giỏ hàng của bạn đang trống</h4>
						        </div>
						    </c:otherwise>			
						</c:choose>
					</div>
				</div>
			</div>
		</div>
	</div>
</body>
</html>