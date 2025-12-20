<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %> 
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Loại Admin</title>
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
                            <i class="fas fa-home me-2"></i> Trang chủ
                        </a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link active" href="qlLoaiAdminController">
                            <i class="fas fa-list me-2"></i> Quản lý loại
                        </a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="qlSachAdminController">
                            <i class="fas fa-book me-2"></i> Quản lý sách
                        </a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="xacnhanthanhtoanAdminController">
                            <i class="fas fa-check-circle me-2"></i> Xác nhận đơn hàng
                        </a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="lichsuhoadonAdminController">
                            <i class="fas fa-file-invoice-dollar me-2"></i> Hóa đơn đã thanh toán
                        </a>
                    </li>
                </ul>
            </div>
        </nav>

        <div class="col-md-9 ms-sm-auto col-lg-10 px-4">          
            <!-- bảng thống kê loại -->
            <div class="card card-custom">
                <div class="card-header bg-white d-flex align-items-center justify-content-between gap-2">
                    <h5 class="mb-0"><i class="fa-solid fa-table-list"></i> Danh sách loại</h5>
                    <button type="button" data-bs-toggle="modal" data-bs-target="#formThemLoai" class="btn btn-success d-flex align-items-center justify-content-center gap-1">
                        <i class="fas fa-plus-circle"></i> Thêm
                    </button>
                </div>
                <div class="card-body table-responsive">
                    <table class="table table-hover table-bordered align-middle">
                        <thead class="table-dark">
                            <tr>
                                <th>Mã Loại</th>
                                <th>Tên Loại</th>
                                <th>Số Lượng Sách</th>
                                <th>Sửa</th>
                                <th>Xóa</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:forEach var="l" items="${dsLoai}">
                                <tr>
                                    <td>${l.maLoai}</td>
                                    <td>${l.tenLoai}</td>
                                    <td>
                                        <c:out value="${not empty mapSL[l.maLoai] ? mapSL[l.maLoai] : 0}" />
                                    </td>
                                    <td>
                                        <button class="btn btn-warning" data-bs-toggle="modal" data-bs-target="#formSua${fn:replace(l.maLoai, ' ', '')}">
                                            <i class="fas fa-edit"></i>
                                        </button>
                                    </td>
                                    <td>
                                        <button class="btn btn-danger" data-bs-toggle="modal" data-bs-target="#formXoa${fn:replace(l.maLoai, ' ', '')}">
                                            <i class="fas fa-trash"></i>
                                        </button>
                                    </td>
                                </tr>
                            </c:forEach>
                        </tbody>
                    </table>
                      
                    <!-- Modal Thêm loại -->
                    <div class="modal fade" id="formThemLoai" tabindex="-1" aria-labelledby="formThemLoaiLabel" aria-hidden="true">
                        <div class="modal-dialog modal-dialog-centered">
                            <div class="modal-content border-0 shadow-lg">
                                <div class="modal-header">
                                    <h5 class="modal-title fw-bold fs-3" id="formThemLoaiLabel">Thêm Loại Sách Mới</h5>
                                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                                </div>
                                <form action="qlLoaiAdminController" method="post">
                                    <div class="modal-body p-4">
                                        <input type="hidden" name="action" value="add">
                                        <div class="mb-2">
                                            <label class="form-label">Mã loại</label>
                                            <input type="text" name="maloai_add" class="form-control" required>
                                        </div>
                                        <div class="mb-2">
                                            <label class="form-label">Tên loại sách</label>
                                            <input type="text" name="tenloai_add" class="form-control" required>
                                        </div>
                                    </div>
                                    <div class="modal-footer bg-light">
                                        <button type="button" class="btn btn-secondary px-4" data-bs-dismiss="modal">Hủy</button>
                                        <button type="submit" name="btnloai_add" class="btn btn-success px-4">Thêm ngay</button>
                                    </div>
                                </form>
                            </div>
                        </div>
                    </div>
                      
                    <!-- Modal sửa -->
                    <c:forEach var="l" items="${dsLoai}">
                        <div class="modal fade" id="formSua${fn:replace(l.maLoai, ' ', '')}" tabindex="-1">
                            <div class="modal-dialog">
                                <div class="modal-content">
                                    <form method="post" action="qlLoaiAdminController">						
                                        <div class="modal-header">
                                            <h5 class="modal-title fw-bold fs-3">Chỉnh sửa</h5>
                                            <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
                                        </div>
                                        <div class="modal-body">
                                            <input type="hidden" name="action" value="update">
                                            <div class="mb-3">
                                                <label class="form-label">Mã loại</label>
                                                <input type="text" name="maloai_update" class="form-control" readonly value="${l.maLoai}" required>
                                            </div>
                                            <div class="mb-3">
                                                <label class="form-label">Tên loại</label>
                                                <input type="text" name="tenloai_update" class="form-control" value="${l.tenLoai}" required>
                                            </div>
                                        </div>
                                        <div class="modal-footer">
                                            <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Hủy</button>
                                            <button type="submit" class="btn btn-warning">Cập nhật</button>
                                        </div>
                                    </form>	 					
                                </div>
                            </div>
                        </div>

                        <!-- Modal xóa -->
                        <div class="modal fade" id="formXoa${fn:replace(l.maLoai, ' ', '')}" tabindex="-1">
                            <div class="modal-dialog modal-dialog-centered">
                                <div class="modal-content">
                                    <form method="post" action="qlLoaiAdminController">						
                                        <div class="modal-header">
                                            <h5 class="modal-title fw-bold fs-3">Xóa</h5>
                                            <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
                                        </div>	
                                        <div class="modal-body">
                                            <input type="hidden" name="action" value="delete">
                                            <h5 class="modal-title">Bạn có chắc chắn xóa loại sách này không?</h5>
                                            <div class="mt-3">
                                                <p>Mã loại: <strong>${l.maLoai}</strong></p>   
                                                <input type="hidden" name="maloaiDelete" value="${l.maLoai}">
                                            </div>
                                        </div>
                                        <div class="modal-footer">
                                            <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Hủy</button>
                                            <button type="submit" class="btn btn-danger">Xóa</button>
                                        </div>
                                    </form>	 					
                                </div>
                            </div>
                        </div>
                    </c:forEach>
                </div>
            </div>
        </div>
    </div>
    
    <!-- TOAST MESSAGE -->
    <div class="toast-container position-fixed top-0 end-0 p-3" style="z-index: 1100; margin-top: 50px;">
        <c:if test="${not empty sessionScope.success}">
            <div id="toastSuccess" class="toast hide border-0 shadow-lg" role="alert" aria-live="assertive" aria-atomic="true">
                <div class="toast-header bg-success text-white">
                    <i class="fas fa-check-circle me-2"></i>
                    <strong class="me-auto">Thành công</strong>
                    <button type="button" class="btn-close btn-close-white" data-bs-dismiss="toast"></button>
                </div>
                <div class="toast-body">
                    ${sessionScope.success}
                </div>
            </div>
            <c:remove var="success" scope="session" />
        </c:if>

        <c:if test="${not empty sessionScope.error}">
            <div id="toastError" class="toast hide border-0 shadow-lg" role="alert" aria-live="assertive" aria-atomic="true">
                <div class="toast-header bg-danger text-white">
                    <i class="fas fa-exclamation-triangle me-2"></i>
                    <strong class="me-auto">Lỗi</strong>
                    <button type="button" class="btn-close btn-close-white" data-bs-dismiss="toast"></button>
                </div>
                <div class="toast-body">
                    ${sessionScope.error}
                </div>
            </div>
            <c:remove var="error" scope="session" />
        </c:if>
    </div>
</div>

<script>
    document.addEventListener("DOMContentLoaded", function() {
        var toastOptions = {delay: 3000, autohide: true};

        var successEl = document.getElementById('toastSuccess');
        if (successEl) {
            var toastS = new bootstrap.Toast(successEl, toastOptions);
            toastS.show();
        }

        var errorEl = document.getElementById('toastError');
        if (errorEl) {
            var toastE = new bootstrap.Toast(errorEl, toastOptions);
            toastE.show();
        }
    });
</script>
</body>
</html>