<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %> 
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>Lịch sử hóa đơn Admin</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.2/css/all.min.css">
    <style>
        body { 
        	background-color: #f8f9f9; 
        }
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
        .btn-sm-custom {
            padding: 0.375rem 0.75rem;
            font-size: 0.875rem;
            display: flex;
            align-items: center;
            gap: 5px;
        }
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
                    <c:choose>
                        <c:when test="${not empty sessionScope.username}">
                            <li class="nav-item">
                                <div class="d-flex flex-column align-items-center py-1">
                                    <i class="fa-solid fa-circle-user" style="font-size: 55px"></i>
                                    <h5>Admin, ${sessionScope.username.tenDangNhap}</h5>
                                </div>
                            </li>
                            <li class="nav-item border-bottom">
                                <a class="nav-link text-danger" href="dangxuatAdminController">
                                    <i class="fas fa-sign-out-alt me-2"></i> Đăng xuất
                                </a>
                            </li>
                        </c:when>
                        <c:otherwise>
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
                        </c:otherwise>
                    </c:choose>
                
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
                        <a class="nav-link" href="xacnhanthanhtoanAdminController">
                            <i class="fas fa-check-circle me-2"></i>Xác nhận đơn hàng
                        </a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link active" href="lichsuhoadonAdminController">
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
                        <i class="fa-solid fa-clipboard-check me-2"></i> Danh sách hóa đơn đã thanh toán
                    </h3>
                     
                    <div class="row header-row mb-3 mx-1 text-center d-none d-md-flex">
                        <div class="col-md-1">Mã HĐ</div>
                        <div class="col-md-2">Mã Khách hàng</div>
                        <div class="col-md-3">Tên khách hàng</div>
                        <div class="col-md-2">Ngày thanh toán</div>
                        <div class="col-md-2">Tổng tiền</div>
                        <div class="col-md-2">Thao tác</div>
                    </div>
        
                    <c:forEach var="item" items="${dsHDDaXacNhanAll}">
                        <div class="row align-items-center p-3 invoice-item mx-1 text-center">
                            <div class="col-md-1 col-6 invoice-id">#${item.maHoaDon}</div>
                            <div class="col-md-2 col-6"><span>#${item.maKH}</span></div>
                            <div class="col-md-3 col-12 text-dark">${item.hoTen}</div>
                            <div class="col-md-2 col-6 text-secondary">
                                <i class="fa-regular fa-calendar-check me-1"></i>${item.ngayMua}
                            </div>
                            <div class="col-md-2 col-6">
                                <fmt:formatNumber value="${item.tongTien}" type="number"/> đ
                            </div>
                            <div class="col-md-2 col-12 mt-2 mt-md-0 d-flex justify-content-center">
                                <a href="lichsuhoadonAdminController?maHoaDon=${item.maHoaDon}&maKH=${item.maKH}" class="btn btn-secondary btn-sm-custom">
                                    <i class="fa-solid fa-eye"></i> Xem chi tiết
                                </a>                                
                            </div>
                        </div>
                    </c:forEach>
                        
                    <c:if test="${empty dsHDDaXacNhanAll}">
                        <div class="text-center py-5 text-muted">
                            <i class="fa-solid fa-receipt fa-3x mb-3"></i>
                            <p>Hiện không có hóa đơn nào đã thanh toán.</p>
                        </div>
                    </c:if>
                </div>
            </div>
        </div>
    </div>
    
    <!-- Modal Chi tiết -->
    <c:forEach var="item" items="${dsHDDaXacNhanAll}">     
        <div class="modal fade" id="formXemCT${item.maHoaDon}" tabindex="-1">
          <div class="modal-dialog modal-lg modal-dialog-centered">
            <div class="modal-content">
              <div class="modal-header bg-light">
                <h5 class="modal-title"><i class="fa-solid fa-file-lines me-2"></i>Chi tiết hóa đơn #${item.maHoaDon}</h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
              </div>
              <div class="modal-body"> 
                    <c:choose>
                        <c:when test="${item.maHoaDon == selectedMaHoaDon}">
                            <div class="table-responsive">
                                 <table class="table table-hover table-detail mb-0">
                                        <thead>
                                            <tr>
                                                <th class="text-center">Ảnh</th>
                                                <th>Tên sách</th>
                                                <th class="text-end">Đơn giá</th>
                                                <th class="text-center">SL</th>
                                                <th class="text-end">Thành tiền</th>
                                            </tr>
                                        </thead>
                                        <tbody>
                                            <c:forEach var="s" items="${dsSachInHD}">
                                                <tr>
                                                    <td class="text-center">
                                                        <img src="${s.anh}" class="book-thumb" onerror="this.src='https://via.placeholder.com/50x70?text=No+Img'">
                                                    </td>
                                                    <td class="fw-bold">${s.tenSach}</td>
                                                    <td class="text-end"><fmt:formatNumber value="${s.gia}" type="number"/></td>
                                                    <td class="text-center">${s.soLuongMua}</td>
                                                    <td class="text-end fw-bold"><fmt:formatNumber value="${s.thanhTien}" type="number"/></td>
                                                </tr>
                                            </c:forEach>                     
                                        </tbody>
                                </table>
                            </div>
                            <div class="d-flex justify-content-between align-items-center mt-4 p-3 bg-light rounded">
                                <div>
                                    <span class="text-muted small d-block">Khách hàng: <strong>${item.hoTen}</strong></span>
                                    <span class="text-muted small">Ngày mua: ${item.ngayMua}</span>
                                </div>
                                <div class="text-end">
                                    <span class="text-muted small d-block">Tổng cộng</span>
                                    <span class="fs-4 fw-bolder text-danger"><fmt:formatNumber value="${item.tongTien}" type="number"/> đ</span>
                                </div>
                            </div>
                        </c:when>
                        <c:otherwise>
                            <div class="text-center py-5">
                                <div class="spinner-border text-primary mb-3" role="status"></div>
                                <p class="text-muted">Đang tải dữ liệu...</p>
                            </div>
                        </c:otherwise>
                    </c:choose>
              </div>
              <div class="modal-footer">
                 <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Đóng</button>
              </div>
            </div>
          </div>
        </div>
    </c:forEach>
</div>

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