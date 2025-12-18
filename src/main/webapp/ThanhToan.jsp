<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!-- Các import giữ nguyên -->
<%@ page import = "Models.GioHang" %>
<%@ page import = "Models.Loai" %>
<%@ page import = "Models.Sach" %>
<%@ page import = "Models.KhachHang" %>
<%@ page import="java.util.ArrayList"%>
<%@ page import = "Models.GioHangBO" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<title>Thanh toán hóa đơn</title>
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
	         
	   /* Header row styling */
	   .header-row {
	       background-color: #f1f3f5;
	       border-radius: 8px;
	       padding: 12px 0;
	       font-weight: 700;
	       color: #495057;
	       font-size: 0.95rem;
	       text-transform: uppercase;
	       letter-spacing: 0.5px;
	   }
	
	   /* Invoice Card Item */
	   .invoice-item {
	       background-color: #fff;
	       border-radius: 10px;
	       border: 1px solid #e9ecef;
	       transition: all 0.3s ease;
	       margin-bottom: 15px;
	   }
	   .invoice-item:hover {
	       box-shadow: 0 5px 15px rgba(0,0,0,0.08);
	       transform: translateY(-2px);
	       border-color: #dee2e6;
	   }
	
	   /* Invoice ID */
	   .invoice-id {
	       background-color: #e9ecef;
	       padding: 5px 10px;
	       border-radius: 6px;
	       font-family: monospace;
	       font-weight: bold;
	       color: #495057;
	       display: inline-block;
	   }
	
	   /* Status Badge */
	   .status-badge {
	   	   display: inline-block;
	       padding: 6px 12px;
	       border-radius: 30px;
	       font-size: 0.85rem;
	       font-weight: 600;
	       min-width: 130px;
	   }
	   .status-paid {
	       background-color: #d1e7dd;
	       color: #0f5132;
	   }
	   .status-unpaid {
	       background-color: #fff3cd;
	       color: #856404;
	   }
	
	   /* Price Styling */
	   .price-text {
	       font-weight: 700;
	       font-size: 1.1rem;
	       color: #dc3545; 
	   }
	
	   /* Buttons */
	   .btn-action-group {
	       display: flex;
	       gap: 5px;
	       justify-content: flex-end;
	       flex-wrap: wrap;
	   }
	   .btn-sm-custom {
	   	   padding: 0.375rem 0.75rem;
	   	   font-size: 0.875rem;
	   	   display: flex;
	   	   align-items: center;
	   	   gap: 5px;
	   }
	   /* --- CSS Modal Chi tiết --- */
       .book-thumb {
       		width: 50px;
       		height: 70px;
       		object-fit: cover;
       		border-radius: 4px;
       		box-shadow: 0 2px 4px rgba(0,0,0,0.1);
       }
       .table-detail th {
       		background-color: #f8f9fa;
       		font-weight: 600;
       }
       .table-detail td {
       		vertical-align: middle;
       }
  	</style>
</head>
<body>	
	<!-- Navbar giữ nguyên -->
	<nav class="navbar navbar-expand-lg navbar-dark navbar-custom sticky-top">
	  <div class="container">
	    <a class="navbar-brand" href="javascript:void(0)"><i class="fa-solid fa-book"></i> BookStore</a>
	    <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#mynavbar">
	      <span class="navbar-toggler-icon"></span>
	    </button>
	    <div class="collapse navbar-collapse" id="mynavbar">
	      <ul class="navbar-nav me-auto mb-2 mb-lg-0">
	        <li class="nav-item"><a class="nav-link" href="tcController"><i class="fa-solid fa-house"></i> Trang chủ</a></li>
	        <li class="nav-item"><a class="nav-link" href="giohangController"><i class="fa-solid fa-cart-shopping"></i> Giỏ hàng</a></li>
	        <li class="nav-item"><a class="nav-link active" href="thanhtoanController"><i class="fa-solid fa-credit-card"></i> Thanh toán</a></li>
	        <li class="nav-item"><a class="nav-link" href="HtLichSuController"><i class="fa-solid fa-clock-rotate-left"></i> Lịch sử</a></li>
	        <c:choose>
        		<c:when test="${not empty sessionScope.user}">
	        		<li class="nav-item "><a class="nav-link text-danger fw-bold" href="#">Xin chào: ${sessionScope.user.hoTen}</a></li>
					<li class="nav-item"><a class="nav-link" href="dangxuatController"><i class="fa-solid fa-right-from-bracket"></i> Đăng xuất</a></li>
        		</c:when>
        		<c:otherwise>
        			<li class="nav-item"><a class="nav-link" href="dangnhapController"><i class="fa-solid fa-right-to-bracket"></i> Đăng nhập</a></li>
        			<li class="nav-item"><a class="nav-link" href="dangkyController"><i class="fa-solid fa-user-plus"></i> Đăng ký</a></li>
        		</c:otherwise>
	        </c:choose>
	      </ul>
	      <form class="d-flex" action="tcController">
	      	<div class="input-group">
	        	<input class="form-control" type="text" placeholder="Tìm kiếm sách..." name="input_search">
	        	<button class="btn btn-primary" type="submit"><i class="fa-solid fa-magnifying-glass"></i></button>
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
					<div class="category-header"><i class="fa-solid fa-list-ul"></i> DANH MỤC SÁCH</div>
					<div class="list-group list-group-flush">
						<c:forEach items="${dsLoai}" var="l">
							<a href="tcController?ml=${l.maLoai }" class="list-group-item list-group-item-action">${l.tenLoai}</a>
						</c:forEach>
					</div>
				</div>
			</div>
			
			<!-- Cart Content -->
			<div class="col-lg-9 col-md-8 content-wrapper mt-0">
				<div class="card border-0 shadow-sm">
					<div class="card-body p-4">
						<h3 class="mb-4 pb-2 border-bottom">
							<i class="fa-solid fa-file-invoice-dollar me-2"></i> Danh sách hóa đơn
						</h3>
						
		                <form action="suaxoaController" method="post">		 
				            <div class="row header-row mb-3 mx-1 text-center d-none d-md-flex">
				            	<div class="col-md-1">Mã HĐ</div>
				            	<div class="col-md-3">Ngày mua</div>
				            	<div class="col-md-3">Trạng thái</div>
				            	<div class="col-md-2">Tổng tiền</div>
				            	<div class="col-md-3">Thao tác</div>
				            </div>
				
				            <c:forEach var="item" items="${dsHDTT}">
				                <div class="row align-items-center p-3 invoice-item mx-1">
				                    <div class="col-md-1 col-12 mb-2 mb-md-0 text-md-center">
				                    	<div class="d-md-none text-muted small mb-1">Mã hóa đơn:</div>
				                    	<span class="invoice-id">#${item.maHoaDon}</span>
				                    </div>
				                    <div class="col-md-3 col-12 mb-2 mb-md-0 text-md-center">
				                    	<div class="d-md-none text-muted small mb-1">Ngày mua:</div>
				                    	<span class="text-dark fw-bold"><i class="fa-regular fa-calendar-days me-1 text-secondary"></i>${item.ngayMua}</span>
				                    </div>
				                    <div class="col-md-3 col-6 mb-2 mb-md-0 text-md-center">
				                    	<c:choose>
							                <c:when test="${item.daMua}">
							                    <span class="status-badge status-paid"><i class="fa-solid fa-check me-1"></i>Đã xong</span>
							                </c:when>
							                <c:otherwise>
							                    <span class="status-badge status-unpaid"><i class="fa-regular fa-clock me-1"></i>Chưa thanh toán</span>
							                </c:otherwise>
							            </c:choose>
				                    </div>
				                    <div class="col-md-2 col-6 mb-2 mb-md-0 text-end text-md-center">
				                    	<span class="price-text">${item.tongTien} đ</span>
				                    </div>
				
				                    <!-- Thao Tác -->
				                    <div class="col-md-3 col-12 mt-2 mt-md-0">
				                    	<div class="btn-action-group">
				                    		<!-- UPDATE: Nút xem chi tiết gọi Servlet -->
					                    	<a href="HtThanhToanController?maHoaDon=${item.maHoaDon}" class="btn btn-secondary btn-sm-custom">
											    <i class="fa-solid fa-eye"></i>
											</a>
											
											<button type="button" class="btn btn-danger btn-sm-custom" data-bs-toggle="modal" data-bs-target="#formXoaHD${item.maHoaDon}">
											    <i class="fa-solid fa-trash-can"></i>
											</button>
				                        	
				                        	<button type="submit" name="btcsua" value="" class="btn btn-primary btn-sm-custom">
				                            	<i class="fa-regular fa-credit-card"></i> TT
				                        	</button>
			                        	</div>
				                    </div>	
				                </div>
				            </c:forEach>
				            
				            <c:if test="${empty dsHDTT}">
				            	<div class="text-center py-5 text-muted">
				            		<i class="fa-solid fa-receipt fa-3x mb-3"></i>
				            		<p>Chưa có hóa đơn nào.</p>
				            	</div>
				            </c:if>
				        </form>
					</div>
				</div>
			</div>
		</div>
	</div>
	
	<!-- ===== KHU VỰC MODAL ===== -->
	<c:forEach var="item" items="${dsHDTT}">		
		
		<!-- 1. Modal Xem chi tiết -->
		<div class="modal fade" id="formXemCT${item.maHoaDon}" tabindex="-1">
		  <div class="modal-dialog modal-lg modal-dialog-centered">
		    <div class="modal-content">
		      <div class="modal-header">
		        <h5 class="modal-title">
		          <i class="fa-solid fa-circle-info text-primary me-2"></i>Chi tiết hóa đơn #${item.maHoaDon}
		        </h5>
		        <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
		      </div>
		
		      <div class="modal-body"> 
		      	<!-- Form thanh toán riêng trong modal -->             
               <form action="HtThanhToanController" method="post">         
		         <c:choose>
		         	<c:when test="${item.maHoaDon == selectedMaHoaDon}">
		         		<div class="card border-0 shadow-sm mb-3">
			         		<div class="table-responsive">
						         <table class="table table-hover table-detail mb-0">
					                    <thead class ="table-light">
					                        <tr>
					                        	<th class="text-center" width="15%">Ảnh sách</th>
					                            <th width="35%">Tên sách</th>
					                            <th class="text-end" width="15%">Đơn giá</th>
					                            <th class="text-center" width="15%">SL</th>
					                            <th class="text-end" width="20%">Thành tiền</th>
					                        </tr>
					                    </thead>
					                    <tbody>
					                        <c:forEach var="s" items="${dsSachInHD}">
											    <tr>
											    	<td class="text-center">
											    		<!-- SỬA LẠI THẺ IMG (dùng src thay vì href) -->
											    		<img src="${s.anh}" class="book-thumb" alt="Book Cover" 
											    			onerror="this.src='https://via.placeholder.com/50x70?text=No+Img'">
											    	</td>
											        <td class="fw-bold text-dark">${s.tenSach}</td>
											        <td class="text-end text-muted">${s.gia}</td>
											        <td class="text-center">
											        	<span class="badge bg-secondary rounded-pill">${s.soLuongMua}</span>
											        </td>
											        <td class="text-end text-danger fw-bold">${s.thanhTien}</td>
											    </tr>
											</c:forEach>                     
					                    </tbody>
				                </table>
			                </div>
		                </div>
		                
		                <!-- Footer Modal: Tổng tiền & Nút Action -->
		                <div class="d-flex justify-content-between align-items-center mt-4">
		                	<div class="text-start">
		                		<small class="text-muted d-block">Tổng cộng</small>
		                		<span class="fs-4 fw-bolder text-danger">${item.tongTien} đ</span>
		                	</div>
		                	
		                	<div class="d-flex gap-2">
			                	<button type="button" class="btn btn-light border" data-bs-dismiss="modal">Đóng</button>		                	
				                <button type="submit" name="btcsua" value="ThanhToan" class="btn btn-primary px-4 py-2">
		                           	<i class="fa-regular fa-credit-card me-2"></i> Thanh toán ngay
		                       	</button>
	                       	</div>
                       	</div>
		         	</c:when>
		         	<c:otherwise>
		         		<div class="text-center py-5">
		         			<div class="spinner-border text-primary mb-3" role="status"></div>
		         			<p class="text-muted">Đang tải dữ liệu chi tiết...</p>
		         		</div>
		         	</c:otherwise>
		         </c:choose>
		         
               </form>
		      </div>
		    </div>
		  </div>
		</div>
		
		<!-- 2. Modal Xác nhận Xóa -->
		<div class="modal fade" id="formXoaHD${item.maHoaDon}" tabindex="-1">
		  <div class="modal-dialog modal-dialog-centered">
		    <div class="modal-content">
		      <form action="suaxoaController" method="post">
		        <div class="modal-header bg-danger text-white">
		          <h5 class="modal-title"><i class="fa-solid fa-triangle-exclamation me-2"></i>Xác nhận xóa</h5>
		          <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal"></button>
		        </div>
		        <div class="modal-body text-center py-4">
		          <p class="fs-5">Bạn có chắc muốn xóa hóa đơn này?</p>
		          <h3 class="text-danger fw-bold">#${item.maHoaDon}</h3>
		          <input type="hidden" name="maHoaDon" value="${item.maHoaDon}">
		          <input type="hidden" name="action" value="delete"> 
		        </div>
		        <div class="modal-footer justify-content-center">
		          <button type="button" class="btn btn-secondary px-4" data-bs-dismiss="modal">Hủy</button>
		          <button type="submit" name="btcsua" value="Xoa" class="btn btn-danger px-4">Xóa ngay</button>
		        </div>
		      </form>
		    </div>
		  </div>
		</div>
		
	</c:forEach>
	
	<!-- JS để tự động bật Modal khi Servlet trả về -->
	<script>
	    <c:if test="${not empty selectedMaHoaDon}">
	        document.addEventListener("DOMContentLoaded", function() {
	            var myModal = new bootstrap.Modal(document.getElementById('formXemCT${selectedMaHoaDon}'));
	            myModal.show();
	        });
	    </c:if>
	</script>

</body>
</html>