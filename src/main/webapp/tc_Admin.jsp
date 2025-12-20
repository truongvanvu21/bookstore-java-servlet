<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Trang chủ Admin</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.2/css/all.min.css">
    <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
    
    <style>
        body { background-color: #f8f9f9; }
        /* CSS Sidebar đồng bộ hoàn toàn */
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
        
        /* CSS Nội dung */
        .card-custom { 
	        box-shadow: 0 4px 6px rgba(0,0,0,0.1); 
	        border: none; 
	        border-radius: 12px; 
        }
        .card-custom:hover { 
	        transform: translateY(-3px); 
	        transition: 0.3s; 
        }
        .table-container { 
	        background: white; 
	        border-radius: 12px; 
	        padding: 20px; 
	        box-shadow: 0 4px 12px rgba(0,0,0,0.05); 
        }
        
        .table thead { 
	        background-color: #f1f3f5; 
	        color: #495057; 
	        text-transform: uppercase; 
	        font-size: 0.85rem; 
	        letter-spacing: 0.5px; 
        }
        .invoice-id { 
	        font-family: 'Courier New', Courier, monospace; 
	        font-weight: bold; color: #3498db; 
	        background: #eef6fc; 
	        padding: 2px 8px; 
	        border-radius: 4px; 
        }
        .status-badge { 
	        padding: 6px 12px; 
	        border-radius: 30px; 
	        font-size: 0.8rem; 
	        font-weight: 600; 
	        display: inline-block; 
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
<div class="container-fluid">
    <div class="row">
        <!-- Sidebar - ĐÃ CHUYỂN SANG JSTL -->
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
                        <a class="nav-link active" href="tcAdminController">
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
                        <a class="nav-link " href="xacnhanthanhtoanAdminController">
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
        
        <!-- Main Content -->
        <main class="col-md-9 ms-sm-auto col-lg-10 px-md-4 py-4">
            <div class="d-flex justify-content-between align-items-center pt-3 pb-2 mb-4 border-bottom">
                <h1 class="h3 fw-bold text-dark">Thống kê hệ thống</h1>
            </div>
		
            <!-- Biểu đồ doanh thu  -->
            <div class="row mb-4">
                <div class="col-12">
                    <div class="card card-custom bg-white p-4">
                        <h6 class="fw-bold mb-4 text-secondary"><i class="fas fa-chart-line me-2 text-primary"></i>Xu hướng doanh thu các tháng</h6>
                        <div style="height: 280px;">
                            <canvas id="monthlyRevenueChart"></canvas>
                        </div>
                    </div>
                </div>
            </div>
		
            <!-- Hai biểu đồ tròn và cột -->
            <div class="row mb-4">
                <div class="col-lg-6">
                    <div class="card card-custom bg-white p-4">
                        <h6 class="fw-bold mb-4 text-secondary"><i class="fas fa-chart-bar me-2 text-primary"></i>Top 10 Sách Bán Chạy</h6>
                        <div style="height: 280px;"><canvas id="topBooksChart"></canvas></div>
                    </div>
                </div>
                <div class="col-lg-6">
                    <div class="card card-custom bg-white p-4">
                        <h6 class="fw-bold mb-4 text-secondary"><i class="fas fa-chart-pie me-2 text-success"></i>Doanh thu theo loại</h6>
                        <div style="height: 280px;"><canvas id="categoryRevenueChart"></canvas></div>
                    </div>
                </div>
            </div>
		
            <div class="row">
                <div class="col-lg-8 mb-4">
                    <div class="table-container h-100 border-0 shadow-sm">
                        <div class="d-flex justify-content-between align-items-center mb-4">
                            <h6 class="fw-bold text-secondary mb-0"><i class="fas fa-shopping-basket me-2 text-warning"></i>Đơn hàng mới hôm nay</h6>
                            <span class="badge bg-primary rounded-pill">${dsHoaDonHomNay.size()} đơn</span>
                        </div>
                        <div class="table-responsive">
                            <table class="table table-hover align-middle">
                                <thead>
                                    <tr>
                                        <th>Mã KH</th>
                                        <th>Khách Hàng</th>
                                        <th class="text-center">Số Lượng</th>
                                        <th>Thành Tiền</th>
                                        <th class="text-center">Trạng Thái</th>
                                        <th class="text-center">Mã HĐ</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <c:forEach var="tk" items="${dsHoaDonHomNay}">
                                        <tr>
                                            <td class="text-muted invoice-id">#${tk.maKh}</td>
                                            <td class="">${tk.hoTen}</td>
                                            <td class="text-center"><span class="text-dark">${tk.tongSoLuong}</span></td>
                                            <td class="">
                                                <fmt:formatNumber value="${tk.thanhTien}" type="number"/> đ
                                            </td>
                                            <td class="text-center">
                                                <c:choose>
                                                    <c:when test="${tk.daMua}">
                                                        <span class="status-badge status-paid"><i class="fa-solid fa-check me-1"></i>Đã thanh toán</span>
                                                    </c:when>
                                                    <c:otherwise>
                                                        <span class="status-badge status-unpaid"><i class="fa-regular fa-clock me-1"></i>Chưa thanh toán</span>
                                                    </c:otherwise>
                                                </c:choose>
                                            </td>
                                            <td class="text-center"><span class="">${tk.maHoaDon}</span></td>
                                        </tr>
                                    </c:forEach>
                                    <c:if test="${empty dsHoaDonHomNay}">
                                        <tr><td colspan="6" class="text-center py-4 text-muted">Hôm nay chưa có đơn hàng nào mới.</td></tr>
                                    </c:if>
                                </tbody>
                            </table>
                        </div>
                    </div>
                </div>
		
                <!-- CẢNH BÁO KHO -->
                <div class="col-lg-4 mb-4">
                    <div class="table-container h-100 border-top border-danger border-4 shadow-sm">
                        <h6 class="fw-bold text-danger mb-4"><i class="fas fa-box-open me-2"></i>Cảnh báo tồn kho (< 10)</h6>
                        <div class="list-group list-group-flush">
                            <c:forEach var="s" items="${dsSachSapHet}">
                                <div class="list-group-item d-flex justify-content-between align-items-center px-0 border-0 mb-2">
                                    <div style="max-width: 70%;">
                                        <div class="fw-bold text-truncate">${s.tenSach}</div>
                                        <small class="text-muted">Mã: ${s.maSach}</small>
                                    </div>
                                    <span class="badge bg-danger rounded-pill">Tồn: ${s.tongSoLuongBan}</span> 
                                </div>
                            </c:forEach>
                        </div>
                        <div class="mt-4">
                            <a href="qlSachAdminController" class="btn btn-sm btn-outline-danger w-100">Quản lý kho sách</a>
                        </div>
                    </div>
                </div>
            </div>
        </main>
    </div>
</div>

<script>
    // Config Chart.js
    
    // --- TOP 10 SÁCH ---
    const labelsBooks = [<c:forEach var="s" items="${dsTop10Sach}">"${s.tenSach}",</c:forEach>];
    const dataBooks = [<c:forEach var="s" items="${dsTop10Sach}">${s.tongSoLuongBan},</c:forEach>];
    new Chart(document.getElementById('topBooksChart'), {
        type: 'bar',
        data: {
            labels: labelsBooks,
            datasets: [{
                label: 'Số lượng bán',
                data: dataBooks,
                backgroundColor: 'rgba(52, 152, 219, 0.7)',
                borderRadius: 5
            }]
        },
        options: { indexAxis: 'y', responsive: true, maintainAspectRatio: false, plugins: { legend: { display: false } } }
    });

    // --- DOANH THU THEO LOẠI ---
    const labelsCat = [<c:forEach var="c" items="${ds}">"${c.tenLoai}",</c:forEach>];
    const dataCat = [<c:forEach var="c" items="${ds}">${c.doanhThu},</c:forEach>];
    new Chart(document.getElementById('categoryRevenueChart'), {
        type: 'doughnut',
        data: {
            labels: labelsCat,
            datasets: [{ data: dataCat, backgroundColor: ['#2ecc71', '#3498db', '#9b59b6', '#f1c40f', '#e67e22', '#e74c3c'] }]
        },
        options: { responsive: true, maintainAspectRatio: false, plugins: { legend: { position: 'right' } } }
    });
    
    // --- DOANH THU THEO THÁNG ---
    const monthlyData = [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0];
    <c:forEach var="m" items="${dsDoanhThuThang}">monthlyData[${m.thang} - 1] = ${m.doanhThu};</c:forEach>
    new Chart(document.getElementById('monthlyRevenueChart'), {
        type: 'line',
        data: {
            labels: ["T1", "T2", "T3", "T4", "T5", "T6", "T7", "T8", "T9", "T10", "T11", "T12"],
            datasets: [{
                label: 'Doanh thu',
                data: monthlyData,
                borderColor: '#3498db',
                backgroundColor: 'rgba(52, 152, 219, 0.1)',
                fill: true,
                tension: 0.4
            }]
        },
        options: { responsive: true, maintainAspectRatio: false }
    });
</script>
</body>
</html>