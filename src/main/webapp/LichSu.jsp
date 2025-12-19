<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@page import="java.util.ArrayList"%>
<%@page import="Models.Sach"%>
<%@page import="Models.KhachHang" %>
<%@page import="Models.LichSuMuaHang" %>
<%@page import="Models.Loai"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<title>Lịch sử mua hàng</title>
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
  		
  		/* Sidebar Categories */
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
       
       /* Status */
       .status-badge {
		   padding: 6px 12px;
		   border-radius: 30px;
		   font-size: 0.75rem;
		   font-weight: 600;
		   display: inline-flex;
		   align-items: center;
		   gap: 5px;
	   }
	   
	   .status-paid {
		   background-color: #d1e7dd;
		   color: #0f5132;
	   }
	   
	   .status-unpaid {
		   background-color: #fff3cd;
		   color: #856404;
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
	          <a class="nav-link" href="HtThanhToanController">
	          	<i class="fa-solid fa-credit-card"></i> Thanh toán
	          </a>
	        </li>
	        <li class="nav-item">
	          <a class="nav-link active" href="HtLichSuController">
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
		<div class="row">
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
			<div class="col-sm-9 content-wrapper">
				<c:choose>
					<c:when test="${not empty dsLS }">
						<div class=" table-responsive">
			                <h3 class="mb-4"><i class="fa-solid fa-calendar-days"></i> Lịch sử mua hàng</h3>
			                <table class="table table-bordered history-table table-hover">
			                    <thead class ="table-dark">
			                        <tr>
			                            <th>Mã KH</th>
			                            <th>Tên sách</th>
			                            <th>Giá</th>
			                            <th>Số lượng</th>
			                            <th>Thành tiền</th>
			                            <th>Trạng thái</th>
			                            <th>Ngày mua</th>
			                        </tr>
			                    </thead>
			
			                    <tbody>
			                        <c:forEach var="ls" items="${dsLS}">
									    <tr>
									        <td>${ls.makh}</td>
									        <td>${ls.tenSach}</td>
									        <td>${ls.gia}</td>
									        <td>${ls.soLuongMua}</td>
									        <td>${ls.thanhTien}</td>
									        <td>
									            <c:choose>
									                <c:when test="${ls.daMua}">
									                    <span class="status-badge status-paid">
									                    	<i class="fa-regular fa-circle-check"></i>Đã thanh toán
									                    </span>
									                </c:when>
									                <c:otherwise>
									                    <span class="status-badge status-unpaid">Chưa thanh toán</span>
									                </c:otherwise>
									            </c:choose>
									        </td>
									        <td>${ls.ngayMua}</td>
									    </tr>
									</c:forEach>                     
			                    </tbody>
			                </table>
			            </div>
					</c:when>
					<c:otherwise>
						<div class="text-center py-5">
				        	<i class="fa-brands fa-cash-app fa-4x text-muted mb-3"></i>
				        	<h4 class="text-muted">Chưa có đơn hàng thanh toán</h4>
				        </div>
					</c:otherwise>
				</c:choose>
			</div>
		</div>
	</div>
</body>
</html>