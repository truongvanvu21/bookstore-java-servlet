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
    <title>Xác nhận đơn hàng - Admin</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
	<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.2/css/all.min.css">
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
	   .invoice-id {
	       background-color: #e9ecef;
	       padding: 5px 10px;
	       border-radius: 6px;
	       font-family: monospace;
	       font-weight: bold;
	       color: #495057;
	       display: inline-block;
	   }
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

<div class="container-fluid">
    <div class="row">
        <!-- Sidebar -->
        <nav class="col-md-3 col-lg-2 sidebar d-md-block show">
            <div class="pt-3">
                <ul class="nav flex-column">
                <% Admin user = (Admin)session.getAttribute("username");
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
                        <a class="nav-link" href="qlSachAdminController">
                            <i class="fas fa-book me-2"></i>Quản lý sách
                        </a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link active" href="AdminController?action=xacnhan">
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

        <div class="col-md-9 ms-sm-auto col-lg-10 px-3 py-1">
            <div class="card border-0 shadow-sm mt-3">
				<div class="card-body p-4">
					<h3 class="mb-4 pb-2 border-bottom">
						<i class="fa-solid fa-clipboard-check me-2"></i> Danh sách đơn hàng cần xác nhận
					</h3>
					 
		            <div class="row header-row mb-3 mx-1 text-center d-none d-md-flex">
		            	<div class="col-md-1">Mã KH</div>
		            	<div class="col-md-3">Họ tên</div>
		            	<div class="col-md-2">Ngày mua</div>
		            	<div class="col-md-2">Tổng tiền</div>
		            	<div class="col-md-1">Mã HĐ</div>
		            	<div class="col-md-3">Thao tác</div>
		            </div>
		
		            <c:forEach var="item" items="${dsHDChuaTTAll}">
		                <div class="row align-items-center p-3 invoice-item mx-1">
		                    <!-- Mã KH -->
		                    <div class="col-md-1 col-12 mb-2 mb-md-0 text-md-center">
		                    	<div class="d-md-none text-muted small mb-1">Mã KH:</div>
		                    	<span class="invoice-id">#${item.maKH}</span>
		                    </div>
		                    <!-- Họ tên -->
		                    <div class="col-md-3 col-12 mb-2 mb-md-0 text-md-center">
		                    	<div class="d-md-none text-muted small mb-1">Họ tên:</div>
		                    	<span class="text-dark">${item.hoTen}</span>
		                    </div>
		                    <!-- Ngày mua -->
		                    <div class="col-md-2 col-6 mb-2 mb-md-0 text-md-center text-secondary">
		                    	<div class="d-md-none text-muted small mb-1">Ngày mua:</div>
		                    	<i class="fa-regular fa-calendar-days me-1"></i>${item.ngayMua}
		                    </div>
		                    <!-- Tổng tiền -->
		                    <div class="col-md-2 col-6 mb-2 mb-md-0 text-end text-md-center">
		                    	<div class="d-md-none text-muted small mb-1">Tổng tiền:</div>
		                    	<span class="">${item.tongTien} đ</span>
		                    </div>
		                    <!-- Mã HĐ -->
							<div class="col-md-1 col-6 mb-2 mb-md-0 text-end text-md-center">
								<div class="d-md-none text-muted small mb-1">Mã HĐ:</div>
		                    	<span class="">#${item.maHoaDon}</span>
		                    </div>
		                    <!-- Thao Tác -->
							<div class="col-md-3 col-12 mt-2 mt-md-0">
							    <div class="btn-action-group">
							        <!-- Nút xem chi tiết (Giữ nguyên) -->
							        <a href="xacnhanthanhtoanAdminController?maHoaDon=${item.maHoaDon}&maKH=${item.maKH}" class="btn btn-secondary btn-sm-custom" title="Xem chi tiết">
							            <i class="fa-solid fa-eye"></i>
							        </a>
							        
							        <!-- Nút Xác nhận: Trỏ vào Modal Xác nhận Thanh toán -->
							        <button type="button" class="btn btn-success btn-sm-custom" data-bs-toggle="modal" data-bs-target="#formXacNhanHD${item.maHoaDon}">
							            <i class="fa-solid fa-check"></i> Xác nhận
							        </button>
							        
							        <!-- Nút Từ chối: Trỏ vào Modal Từ chối/Xóa đơn hàng -->
							        <button type="button" class="btn btn-danger btn-sm-custom" data-bs-toggle="modal" data-bs-target="#formTuChoiHD${item.maHoaDon}">
							            <i class="fa-solid fa-xmark"></i> Từ chối
							        </button>
							        
							        
							    </div>
							</div>
		                </div>
		            </c:forEach>
			            
		            <c:if test="${empty dsHDChuaTTAll}">
		            	<div class="text-center py-5 text-muted">
		            		<i class="fa-solid fa-receipt fa-3x mb-3"></i>
		            		<p>Hiện không có đơn hàng nào chờ xác nhận.</p>
		            	</div>
		            </c:if>
				</div>
			</div>
		</div>
    </div>
    
    <c:forEach var="item" items="${dsHDChuaTTAll}">     
	    <!-- 1. Modal Xem chi tiết (Giữ nguyên logic của bạn) -->
	    <div class="modal fade" id="formXemCT${item.maHoaDon}" tabindex="-1">
	      <div class="modal-dialog modal-lg modal-dialog-centered">
	        <div class="modal-content">
	          <div class="modal-header">
	            <h5 class="modal-title"><i class="fa-solid fa-circle-info me-2"></i>Chi tiết hóa đơn #${item.maHoaDon}</h5>
	            <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
	          </div>
	          <div class="modal-body"> 
	             <form action="HtThanhToanController" method="post">         
	                <c:choose>
	                    <c:when test="${item.maHoaDon == selectedMaHoaDon}">
	                        <input type="hidden" name="maHoaDon" value="${item.maHoaDon}">
	                        <input type="hidden" name="action" value="thanhToanHD">
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
	                                                        <img src="${s.anh}" class="book-thumb" onerror="this.src='https://via.placeholder.com/50x70?text=No+Img'">
	                                                    </td>
	                                                    <td class="fw-bold text-dark">${s.tenSach}</td>
	                                                    <td class="text-end text-muted">${s.gia}</td>
	                                                    <td class="text-center">${s.soLuongMua}</td>
	                                                    <td class="text-end fw-bold">${s.thanhTien}</td>
	                                                </tr>
	                                            </c:forEach>                     
	                                        </tbody>
	                                </table>
	                            </div>
	                        </div>
	                        <div class="d-flex justify-content-between align-items-center mt-4">
	                            <div class="text-start">
	                                <small class="text-muted d-block">Tổng cộng</small>
	                                <span class="fs-4 fw-bolder text-danger">${item.tongTien} đ</span>
	                            </div>
	                            <div class="d-flex gap-2">
	                                <button type="button" class="btn btn-light border" data-bs-dismiss="modal">Đóng</button>                       
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
	
	    <!-- 2. Modal Xác nhận Thanh toán (Dành cho nút Xác nhận) -->
	    <div class="modal fade" id="formXacNhanHD${item.maHoaDon}" tabindex="-1">
	      <div class="modal-dialog modal-dialog-centered">
	        <div class="modal-content">
	          <form action="xacnhanthanhtoanAdminController" method="post">
	            <div class="modal-header">
	              <h5 class="modal-title"><i class="fa-solid fa-check-circle me-2"></i>Xác nhận đơn hàng</h5>
	              <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal"></button>
	            </div>
	            <div class="modal-body text-center py-4">
	              <p class="fs-5">Bạn có chắc chắn xác nhận hóa đơn này?</p>
	              <h3 class="fw-bold">#${item.maHoaDon}</h3>
	              <p class="text-muted">Khách hàng: ${item.hoTen}</p>
	              <input type="hidden" name="maKH" value="${item.maKH}"> 
	              <input type="hidden" name="maHoaDon" value="${item.maHoaDon}">
	              <input type="hidden" name="action" value="thanhToanHD"> 
	            </div>
	            <div class="modal-footer">
	              <button type="button" class="btn btn-secondary px-4" data-bs-dismiss="modal">Hủy</button>
	              <button type="submit" class="btn btn-success px-4">Xác nhận</button>
	            </div>
	          </form>
	        </div>
	      </div>
	    </div>
	
	    <!-- 3. Modal Từ chối/Xóa (Dành cho nút Từ chối) -->
	    <div class="modal fade" id="formTuChoiHD${item.maHoaDon}" tabindex="-1">
	      <div class="modal-dialog modal-dialog-centered">
	        <div class="modal-content">
	          <form action="xacnhanthanhtoanAdminController" method="post">
	            <div class="modal-header">
	              <h5 class="modal-title"><i class="fa-solid fa-triangle-exclamation me-2"></i>Từ chối đơn hàng</h5>
	              <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal"></button>
	            </div>
	            <div class="modal-body text-center py-4">
	              <p class="fs-5">Bạn có chắc chắn muốn từ chối và xóa hóa đơn này?</p>
	              <h3 class="fw-bold">#${item.maHoaDon}</h3>
	              <input type="hidden" name="maKH" value="${item.maKH}">
	              <input type="hidden" name="maHoaDon" value="${item.maHoaDon}">
	              <input type="hidden" name="action" value="deleteHD"> 
	            </div>
	            <div class="modal-footer">
	              <button type="button" class="btn btn-secondary px-4" data-bs-dismiss="modal">Quay lại</button>
	              <button type="submit" class="btn btn-danger px-4">Từ chối đơn</button>
	            </div>
	          </form>
	        </div>
	      </div>
	    </div>
	</c:forEach>
	
	<!-- KHU VỰC TOAST MESSAGE (Góc phải màn hình) -->
	<div class="toast-container position-fixed top-0 end-0 p-3" style="z-index: 21">
	    <c:if test="${not empty sessionScope.message}">
	        <div id="toastMessage" class="toast hide border-0 shadow-lg" role="alert" aria-live="assertive" aria-atomic="true">
	            <div class="toast-header ${sessionScope.messageType == 'success' ? 'bg-success' : 'bg-primary'} text-white">
	                <i class="fa-solid ${sessionScope.messageType == 'success' ? 'fa-circle-check' : 'fa-circle-info'} me-2"></i>
	                <strong class="me-auto">Thông báo</strong>
	                <small>Vừa xong</small>
	                <button type="button" class="btn-close btn-close-white" data-bs-dismiss="toast" aria-label="Close"></button>
	            </div>
	            <div class="toast-body">
	                ${sessionScope.message}
	            </div>
	        </div>
	
	        <!-- Xóa session ngay sau khi lấy dữ liệu -->
	        <c:remove var="message" scope="session" />
	        <c:remove var="messageType" scope="session" />
	    </c:if>
	</div>
</div>
<!-- JS để tự động bật Modal khi Servlet trả về -->
	<script>
		document.addEventListener("DOMContentLoaded", function() {
	        var toastEl = document.getElementById('toastMessage');
	        if (toastEl) {
	            var toast = new bootstrap.Toast(toastEl, {
	                delay: 3000,
	                autohide: true
	            });
	            toast.show();
	        }
	    });
	
	    <c:if test="${not empty selectedMaHoaDon}">
	        document.addEventListener("DOMContentLoaded", function() {
	            var myModal = new bootstrap.Modal(document.getElementById('formXemCT${selectedMaHoaDon}'));
	            myModal.show();
	        });
	    </c:if>
	</script>
</body>
</html>