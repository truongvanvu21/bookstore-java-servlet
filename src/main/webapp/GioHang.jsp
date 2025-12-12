<%-- <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %> --%>
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
	<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.css">
  	<style>
  		.navbar-custom {
  			background-color: #2d2f31;
  			color: #fff;
  		}
  		.navbar-custom a {
            color: #adb5bd;
            text-decoration: none;
            padding: 6px 10px;
            display: block;
        }
        .navbar-custom a:hover,
        .navbar-custom a.active {
            background-color: #505a64;
            color: #fff;
        }
        .btn-custom {
		    background-color: #2d2f31;
		    color: #adb5bd;
		    border: none;
		    padding: 7px 15px;
		    border-radius: 5px;
		    transition: 0.2s;
		    font-size: 14px;
		}
		.btn-custom:hover {
		    background-color: #505a64;
		    color: #fff;
		}
 	    .content-wrapper {
           margin-top: 20px;
       }
  	</style>
</head>
<body>
	<nav class="navbar navbar-expand-sm navbar-dark navbar-custom">
	  <div class="container-fluid">
	    <a class="navbar-brand" href="javascript:void(0)">Công ty sách</a>
	    <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#mynavbar">
	      <span class="navbar-toggler-icon"></span>
	    </button>
	    <div class="collapse navbar-collapse" id="mynavbar">
	      <ul class="navbar-nav me-auto">
	        <li class="nav-item">
	          <a class="nav-link" href="tcController">
	          	<i class="bi bi-house"></i> Trang chủ
	          </a>
	        </li>
	        <li class="nav-item">
	          <a class="nav-link active" href="giohangController">
	          	<i class="bi bi-cart"></i> Giỏ hàng
	          </a>
	        </li>
	        <li class="nav-item">
	          <a class="nav-link" href="thanhtoanController">
	          	<i class="bi bi-credit-card"></i> Thanh toán
	          </a>
	        </li>
	        <li class="nav-item">
	          <a class="nav-link" href="HtLichSuController">
	          	<i class="bi bi-receipt"></i> Lịch sử mua hàng
	          </a>
	        </li>

			<%KhachHang user=(KhachHang)session.getAttribute("user");
			if(user!=null){%>
			<li class="nav-item">
				<a class="nav-link" href="#">Xin chào: <%=user.getHoTen() %></a>
			</li>
			<li class="nav-item">
          		<a class="nav-link" href="dangxuatController">
          			<i class="bi bi-box-arrow-right"></i> Đăng xuất
          		</a>
        	</li>
			<%}else{ %>
			<li class="nav-item">
				<a class="nav-link" href="dangnhapController">
					<i class="bi bi-box-arrow-in-right"></i> Đăng nhập
				</a>
			</li>
			<li class="nav-item">
   				<a class="nav-link" href="dangkyController">
   					<i class="bi bi-person-plus"></i> Đăng ký
   				</a>
 			</li>
			<%} %>

			<%-- <c:choose>
        		<c:when test="${not empty sessionScope.user}">
        			<li class="nav-item">
	          			<a class="nav-link" href="#" style="color: red">
	          				xin chao ${sessionScope.user}
	          			</a>
	        		</li>
	        		<li class="nav-item">
          				<a class="nav-link" href="dangxuatController">Đăng xuất</a>
        			</li>
        		</c:when>
        		<c:otherwise>
        			<li class="nav-item">
          				<a class="nav-link" href="dangnhapController">Đăng nhập</a>
        			</li>
        		</c:otherwise>
	        </c:choose> --%>
	      </ul>
	      <form class="d-flex" action="tcController">
	        <input class="form-control me-2" type="text" placeholder="Search" name="input_search">
	        <button class="btn btn-primary" type="submit">Search</button>
	      </form>
	    </div>
	  </div>
	</nav>
	
	<div class="row">
		<div class="col-sm-3">
<%-- 			<c:forEach var="l" items="${dsLoai}">
				<a href="tcController?ml=${l.maLoai}" style="display:block; min-width: 200px" class="btn btn-dark my-3">
					${l.maLoai}
				</a>
			</c:forEach> --%>
			
			<%
				ArrayList<Loai> dsLoai = (ArrayList<Loai>) request.getAttribute("dsLoai");
				for(Loai l : dsLoai) {
			%>
		            <a href="tcController?ml=<%= l.getMaLoai() %>" style="display:block; min-width: 200px" class="btn my-2 btn-custom">
		                <%= l.getTenLoai() %>
		            </a>
			<%	}%>
		</div>
		<div class="col-sm-9 content-wrapper mt-2">
			<h3 class="mb-3">
				<i class="bi bi-cart-dash-fill"></i> Danh sách các hàng trong giỏ
			</h3>
			<%-- <%
				GioHangBO gbo = (GioHangBO) request.getAttribute("gh");		
				if(gbo != null) {
				%>
				<form>
					<table class="table table-hover table-bordered">
						<thead class="table-dark">
							<tr>
								<th>Ảnh</th>
								<th>Tên Sách</th>
								<th>Số lượng</th>
								<th>Giá</th>
								<th>Thành tiền</th>
								<th></th>
							</tr>
						</thead>
						
						<tbody>
							<%for(int i=0; i<gbo.ds.size(); i++){ %>
							<tr>
								<td>
									<img src="<%=gbo.ds.get(i).getAnh()%>">
								</td>
								<td><%= gbo.ds.get(i).getTenSach() %></td>
								<td>
									<%= gbo.ds.get(i).getSoLuong() %>
									<form method="get" action="giohangController">
										<input type="hidden" name="action" value="update">
										<input type="hidden" name="ms" value="<%= gbo.ds.get(i).getMaSach()%>">
										<input type="number" name="txtSuaSL" class="form-control mt-2 mb-2" style="width: 200px">
										<input type="submit" name="tt" value="sửa" class="btn btn-secondary btn-sm">
									</form>	
								</td>
								<td><%= gbo.ds.get(i).getGia() %></td>
								<td><%= gbo.ds.get(i).getThanhTien()%></td>
								<td>
									<a href="giohangController?action=delete&ms=<%=gbo.ds.get(i).getMaSach() %>" class="btn btn-danger">Xóa</a>
								</td>
							</tr>
						</tbody>
							<%} %>
					</table>
					
					<div class ="d-flex justify-content-between">
						<div>
							<a href="tcController" class="btn btn-secondary">Tiếp tục mua hàng</a>
							<a href="giohangController?action=deleteAll" class="btn btn-dark">Xóa tất cả</a>
						</div>
						<div class="fw-bold">Tổng tiền: <%= gbo.TongTien()%></div>
					</div>
				</form>
				<%} %> --%>
				
				<%
				    // Lấy đối tượng giỏ hàng từ session hoặc request (tùy cách bạn lưu)
				    GioHangBO gh = (GioHangBO) session.getAttribute("gh");
				    if (gh != null && gh.ds != null && !gh.ds.isEmpty()) {
				%>
				        <form action="suaxoaController">
				        <% for (int i = 0; i < gh.ds.size(); i++) {
				               GioHang item = gh.ds.get(i);
				        %>
				            <div class="row">
				                <div class="col-sm-1">
				                    <input type="checkbox" value="<%= item.getMaSach() %>" name="select">
				                </div>
				                <div class="col-sm-3">
				                    <img src="<%= item.getAnh() %>" alt="<%= item.getTenSach() %>">
				                </div>
				                <div class="col-sm-2"><%= item.getTenSach() %></div>
				                <div class="col-sm-1"><%= item.getGia() %></div>
				                <div class="col-sm-1"><%= item.getSoLuong() %></div>
				                <div class="col-sm-2">
				                    <input type="number" min="0" class="form-control mb-2" name="<%= item.getMaSach() %>" style="width:70px">
				                    <button type="submit" name="btcsua" class="btn btn-warning" value="<%= item.getMaSach() %>">
				                    	<i class="bi bi-pencil-square"></i> Sửa
				                    </button>
				                </div>
				                <div class="col-sm-1"><%= item.getThanhTien() %></div>
				                <div class="col-sm-1">
				                    <a href="suaxoaController?action=delete&ms=<%= item.getMaSach() %>" class="btn btn-danger">
				                    	Xóa
				                    </a>
				                </div>
				            </div>
				        <% } %>
				
				        <div class="d-flex justify-content-between my-3">
				            <div>
				                <button type="submit" value="deleteSelect" name="action" class="btn btn-secondary">Xóa chọn</button>
				                <!-- <a href="lichsumuahangController" class="btn btn-dark">Mua hàng</a> -->
				            </div>
				            <div class="fw-bold text-danger">
				                Tổng tiền: <%= gh.TongTien() %>
				            </div>
				        </div>
				        </form>
				        <form action="lichsuController">
				        	<button type="submit" class = "btn btn-success">Xác nhận mua</button>
				        </form>
				<%
				    } else {
				%>
				        <p>Giỏ hàng rỗng</p>
				<%
				    }
				%>
				
				
			<%-- <c:choose>
				<c:when test="${not empty gh}">
					<form action="suaxoaController">
						<c:forEach var="item" items="${gh.ds}">
							<div class="row">
								<div class="col-sm-1">
									 <input type="checkbox" value="${item.maSach}" name="cxoa">
								</div>
								<div class="col-sm-3">
									<img src="${item.anh}" alt="${item.tenSach}">
								</div>
								<div class="col-sm-2">${item.tenSach}</div>
								<div class="col-sm-1">${item.gia}</div>
								<div class="col-sm-1">
									${item.soLuong}
								</div>
								<div class="col-sm-2">
									<input type="number" min=0 name="${item.maSach }" style="width:60px" >
							        <button type="submit" name="btcsua" value="${item.maSach }">+</button>	
								</div>
								<div class="col-sm-1">${item.thanhTien}</div>
								<div class="col-sm-1">
									<a href="suaxoaController?action=delete&ms=${item.maSach}" class="btn btn-danger">Xóa</a>
								</div>
							</div>
						</c:forEach>							
						
						<div class ="d-flex justify-content-between">
							<div>
								<button type="submit" value="deleteSelect" name="action">Xóa chọn</button>
								<a href="" class="btn btn-dark">Mua hàng</a>
							</div>
							<div class="fw-bold">
								Tổng tiền: ${gh.tongTien}
							</div>
						</div>
					</form>
				</c:when>
				<c:otherwise>
					<p>Giỏ hàng rỗng</p>
				</c:otherwise>
			</c:choose> --%>
		</div>
	</div>
</body>
</html>