<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %> 
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>Sách Admin</title>
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
        .book-img {
            width: 60px; height: 80px; object-fit: cover;
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
                        <a class="nav-link active" href="qlSachAdminController">
                            <i class="fas fa-book me-2"></i>Quản lý sách
                        </a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="xacnhanthanhtoanAdminController">
                            <i class="fas fa-check-circle me-2"></i>Xác nhận đơn hàng
                        </a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="lichsuhoadonAdminController">
                            <i class="fas fa-file-invoice-dollar me-2"></i>Hóa đơn đã thanh toán
                        </a>
                    </li>
                </ul>
            </div>
        </nav>

        <div class="col-md-9 ms-sm-auto col-lg-10 px-3 py-1">
            <!-- List sách -->
            <div class="card card-custom">
                <div class="card-header bg-white d-flex flex-column flex-md-row justify-content-between align-items-md-center gap-2">
				    <div class="d-flex align-items-center justify-content-between gap-2">
				    	<h5 class="mb-0 text-nowrap">
					        <i class="fas fa-table me-2"></i>Danh sách sách
					    </h5>
					    <button type="button" data-bs-toggle="modal" data-bs-target="#formThemSach" class="btn btn-success d-flex align-items-center justify-content-center gap-1">
	                        <i class="fas fa-plus-circle"></i> Thêm
	                    </button>
				    </div>
				    <form class="d-flex w-100 w-md-auto" action="qlSachAdminController">
				        <input class="form-control me-2" type="text" placeholder="Search" name="input_search">
				        <button class="btn btn-primary" type="submit">Search</button>
				    </form>
				</div>           

                <div class="card-body table-responsive">
                    <c:choose>
                        <c:when test="${not empty requestScope.emptys}">
                            <p>${requestScope.emptys}</p>
                        </c:when>
                        <c:otherwise>
                            <table class="table table-hover table-bordered align-middle">
                                <thead class="table-dark">
                                    <tr>
                                        <th class="col-2 col-md-1">Ảnh</th>
                                        <th class="col-2 col-md-1">Mã sách</th>
                                        <th class="col-4 col-md-3">Tên sách</th>
                                        <th class="col-2 col-md-1">Giá</th>
                                        <th class="col-2 col-md-1">Số lượng</th>
                                        <th class="col-2 col-md-1">Loại</th>
                                        <th class="col-2 col-md-1">Số tập</th>
                                        <th class="col-4 col-md-2">Tác giả</th>
                                        <th class="col-4 col-md-2">Ngày nhập</th>
                                        <th class="col-1">Sửa</th>
                                        <th class="col-1">Xóa</th>
                                    </tr>
                                </thead>
                                <tbody>                     	
                                    <c:forEach var="s" items="${dsSach}">
                                        <tr>
                                            <td>
                                                <img src="${s.anh}" alt="${s.tenSach}" class="book-img">
                                            </td>
                                            <td>${s.maSach}</td>
                                            <td>${s.tenSach}</td>
                                            <td>${s.gia}</td>
                                            <td>${s.soLuong}</td>
                                            <td>${s.maLoai}</td>
                                            <td>${s.soTap}</td>
                                            <td>${s.tacGia}</td>
                                            <td>${s.ngayNhap}</td>
                                            <td>
                                                <button class="btn btn-warning btn-sm" data-bs-toggle="modal" data-bs-target="#formSuaSach${fn:replace(s.maSach, ' ', '')}">
                                                    <i class="fas fa-edit"></i>
                                                </button>
                                            </td>
                                            <td>
                                                <button class="btn btn-danger btn-sm" data-bs-toggle="modal" data-bs-target="#formXoaSach${fn:replace(s.maSach, ' ', '')}">
                                                    <i class="fas fa-trash"></i>
                                                </button>
                                            </td>
                                        </tr>
                                    </c:forEach>
                                </tbody>
                            </table>
                        </c:otherwise>
                    </c:choose>
                </div>

                <c:if test="${empty requestScope.emptys}">
				<div class="col-sm-12 pb-3">
				    <ul class="pagination justify-content-center flex-wrap">
				        <li class="page-item ${page == 1 ? 'disabled' : ''}">
				            <a class="page-link" href="qlSachAdminController?page=${page - 1}&ml=${mlLink}&input_search=${keyLink}">
				                <i class="fa-solid fa-caret-left"></i>
				            </a>
				        </li>
				        
				        <li class="page-item ${page == 1 ? 'active' : ''}">
				            <a class="page-link" href="qlSachAdminController?page=1&ml=${mlLink}&input_search=${keyLink}">1</a>
				        </li>

				        <c:if test="${page > 3}">
				            <li class="page-item disabled"><span class="page-link">...</span></li>
				        </c:if>

				        <c:forEach var="i" begin="${page - 1 > 2 ? page - 1 : 2}" end="${page + 1 < totalPage ? page + 1 : totalPage - 1}">
				            <li class="page-item ${i == page ? 'active' : ''}">
				                <a class="page-link" href="qlSachAdminController?page=${i}&ml=${mlLink}&input_search=${keyLink}">${i}</a>
				            </li>
				        </c:forEach>

				        <c:if test="${page < totalPage - 2}">
				            <li class="page-item disabled"><span class="page-link">...</span></li>
				        </c:if>

				        <c:if test="${totalPage > 1}">
				            <li class="page-item ${page == totalPage ? 'active' : ''}">
				                <a class="page-link" href="qlSachAdminController?page=${totalPage}&ml=${mlLink}&input_search=${keyLink}">${totalPage}</a>
				            </li>
				        </c:if>
				        
				        <li class="page-item ${page == totalPage ? 'disabled' : ''}">
				            <a class="page-link" href="qlSachAdminController?page=${page + 1}&ml=${mlLink}&input_search=${keyLink}">
				                <i class="fa-solid fa-caret-right"></i>
				            </a>
				        </li>
				    </ul>
				</div>
                </c:if>
            </div>
        </div>
        
        <!-- Modal Thêm sách -->
        <div class="modal fade" id="formThemSach" tabindex="-1">
		    <div class="modal-dialog modal-lg modal-dialog-centered">
		        <div class="modal-content">
		            <form action="qlSachAdminController" method="post" enctype="multipart/form-data">
		                <input type="hidden" name="action" value="addsach">
		
		                <div class="modal-header">
		                    <h5 class="modal-title fw-bold fs-3">Thêm sách mới</h5>
		                    <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
		                </div>
		
		                <div class="modal-body row g-3">
		                    <div class="col-md-4">
		                        <label>Mã sách</label>
		                        <input type="text" name="masach" class="form-control" required>
		                    </div>
		                    <div class="col-md-8">
		                        <label>Tên sách</label>
		                        <input type="text" name="tensach" class="form-control" required>
		                    </div>
		                    <div class="col-md-4">
		                        <label>Giá</label>
		                        <input type="number" name="gia" class="form-control" required>
		                    </div>
		                    <div class="col-md-4">
		                        <label>Số lượng</label>
		                        <input type="number" name="soluong" class="form-control" required>
		                    </div>
		                    <div class="col-md-4">
		                        <label>Số tập</label>
		                        <input type="number" name="sotap" class="form-control">
		                    </div>
		                    <div class="col-md-6">
		                        <label>Tác giả</label>
		                        <input type="text" name="tacgia" class="form-control">
		                    </div>
		                    <div class="col-md-6">
		                        <label>Loại</label>
		                        <select name="maloai" class="form-select">
		                            <c:forEach var="l" items="${dsLoai}">
		                                <option value="${l.maLoai}">${l.tenLoai}</option>
		                            </c:forEach>
		                        </select>
		                    </div>
		                    <div class="col-md-6">
		                        <label>Ảnh</label>
		                        <input type="file" name="anh" class="form-control">
		                    </div>
		                    <div class="col-md-6">
							    <label>Ngày nhập</label>
							    <input type="date" name="ngaynhap" class="form-control" required>
							</div>
		                </div>
		
		                <div class="modal-footer">
		                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Hủy</button>
		                    <button type="submit" class="btn btn-success">Lưu</button>
		                </div>
		            </form>
		        </div>
		    </div>
		</div>   
		
		<!-- Modal sửa-->
        <c:forEach var="s" items="${dsSach}">
            <div class="modal fade" id="formSuaSach${fn:replace(s.maSach, ' ', '')}" tabindex="-1">
              <div class="modal-dialog modal-dialog-centered">
                <div class="modal-content">
                    <form method="post" action="qlSachAdminController" enctype="multipart/form-data">						
                          <div class="modal-header">
                            <h5 class="modal-title fw-bold fs-3">Chỉnh sửa</h5>
                            <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
                          </div>
                
                          <div class="modal-body row g-3">
                            <input type="hidden" name="action" value="updateSach">
                            <div class="col-md-4">
                                <label>Mã sách</label>
                                <input type="text" name="masach_update" class="form-control" readonly value="${s.maSach}">
                            </div>
                            <div class="col-md-8">
                                <label>Tên sách</label>
                                <input type="text" name="tensach_update" class="form-control" value="${s.tenSach}">
                            </div>
                            <div class="col-md-4">
                                <label>Giá</label>
                                <input type="number" name="gia_update" class="form-control" value="${s.gia}">
                            </div>
                            <div class="col-md-4">
                                <label>Số lượng</label>
                                <input type="number" name="soluong_update" class="form-control" value="${s.soLuong}">
                            </div>
                            <div class="col-md-4">
                                <label>Số tập</label>
                                <input type="number" name="sotap_update" class="form-control" value="${s.soTap}">
                            </div>
                            <div class="col-md-6">
                                <label>Tác giả</label>
                                <input type="text" name="tacgia_update" class="form-control" value="${s.tacGia}">
                            </div>
                            <div class="col-md-6">
                                <label>Loại</label>
                                <select name="maloai_update" class="form-select">
                                    <c:forEach var="l" items="${dsLoai}">
                                        <option value="${l.maLoai}" ${l.maLoai == s.maLoai ? 'selected' : ''}>${l.tenLoai}</option>
                                    </c:forEach>
                                </select>
                            </div>
                            <div class="col-md-5">
                                <label>Ảnh hiện tại</label><br>
                                <img src="${s.anh}" class="img-thumbnail" style="max-height:120px">	    
                                <input type="hidden" name="anhcu" value="${s.anh}">
                            </div>
                            <div class="col-md-7">		
                                <label>Chọn ảnh mới (nếu có)</label>
                                <input type="file" name="anh_update" class="form-control">
                            </div>
                            <div class="col-md-6">
                                <label>Ngày nhập</label>
                                <input type="date" name="ngaynhap_update" class="form-control" value="${s.ngayNhap}">
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
        </c:forEach>
		
		<!-- Modal Xóa sách -->
		<c:forEach var="s" items="${dsSach}">
            <div class="modal fade" id="formXoaSach${fn:replace(s.maSach, ' ', '')}" tabindex="-1">
                <div class="modal-dialog modal-dialog-centered">
                    <div class="modal-content">
                        <form action="qlSachAdminController" method="post">
                            <input type="hidden" name="action" value="deleteSach">	
                            <div class="modal-header">
                                <h5 class="modal-title fs-3">Xóa</h5>
                                <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
                            </div>
                            <div class="modal-body">
                                <h5 class="modal-title mb-2">Bạn có chắc chắn xóa sách này không?</h5>
                                <div class="col-md-12">
                                   <label class="form-label">Mã sách : ${s.maSach}</label>   
                                   <input type="hidden" name="masachDelete" value="${s.maSach}">
                               </div>
                               <div class="col-md-12">
                                   <label class="form-label">Tên sách : ${s.tenSach}</label>   
                               </div>
                               <div class="col-md-12">
                                    <img src="${s.anh}" class="img-thumbnail" style="max-height:120px">
                                    <input type="hidden" name="anhDelete" value="${s.anh}">	    
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
		
		<!--TOAST MESSAGE -->
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
</div>

<script>
	document.addEventListener("DOMContentLoaded", function() {
	    var toastOptions = { delay: 3000, autohide: true };
	
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