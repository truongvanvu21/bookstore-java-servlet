<%-- <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %> --%>
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
        .card-custom {
            box-shadow: 0 4px 6px rgba(0,0,0,0.2);
            border: none;
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
	          <a class="nav-link" href="giohangController">
	          	<i class="bi bi-cart"></i> Giỏ hàng
	          </a>
	        </li>
	        <li class="nav-item">
	          <a class="nav-link" href="thanhtoanController">
	          	<i class="bi bi-credit-card"></i> Thanh toán
	          </a>
	        </li>
	        <li class="nav-item">
	          <a class="nav-link active" href="HtLichSuController">
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
				<%} %>
	        	
	        	<%-- <c:choose>
	        		<c:when test="${not empty sessionScope.user}">
	        			<li class="nav-item">
		          			<a class="nav-link" href="#" style="color: red">
		          				xin chao ${sessionScope.user.hoTen}
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
			<%-- <c:forEach var="l" items="${dsLoai}">
				<a href="tcController?ml=${l.maLoai}" style="display:block; min-width: 200px" class="btn btn-dark my-3">
					<%= l.getMaLoai() %> 
					${l.maLoai}
				</a>
			</c:forEach> --%>
			
			<%
				ArrayList<Loai> dsLoai = (ArrayList<Loai>) request.getAttribute("dsLoai");
				for(Loai l : dsLoai) {
			%>
		            <a href="tcController?ml=<%= l.getMaLoai() %>" style="display:block; min-width: 200px" class="btn btn-custom my-3">
		                <%= l.getTenLoai() %>
		            </a>
			<%	}%>
		</div>
		<div class="col-sm-9 content-wrapper">
			<%-- <h3>Danh sách lịch sử mua hàng</h3>
			<%
				ArrayList<LichSuMuaHang> dsLS = (ArrayList<LichSuMuaHang>) request.getAttribute("dsLS");
				for(LichSuMuaHang ls : dsLS){
			%>
					<div class=" row">
						<div class="col-sm-1"><%= ls.getMakh() %></div>
						<div class="col-sm-3"><%= ls.getTenSach() %></div>
						<div class="col-sm-1"><%= ls.getGia() %></div>
						<div class="col-sm-1"><%= ls.getSoLuongMua() %></div>
						<div class="col-sm-1"><%= ls.getThanhTien() %></div>
						<div class="col-sm-2"><%= ls.isDaMua() ? "Đã thanh toán" : "Chưa thanh toán" %></div>
						<div class="col-sm-3"><%= ls.getNgayMua() %></div>
					</div>
			<% 	}%> --%>
			<div class=" table-responsive">
                <h3 class="mb-4"><i class="bi bi-clock-history"></i> Lịch sử mua hàng</h3>
                <table class="table table-bordered history-table">
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
                        <% 
                            ArrayList<LichSuMuaHang> dsLS = (ArrayList<LichSuMuaHang>) request.getAttribute("dsLS");
                            for(LichSuMuaHang ls : dsLS) {
                        %>
                        <tr>
                            <td><%= ls.getMakh() %></td>
                            <td><%= ls.getTenSach() %></td>
                            <td><%= ls.getGia() %></td>
                            <td><%= ls.getSoLuongMua() %></td>
                            <td><%= ls.getThanhTien() %></td>
                            <td>
                                <% if(ls.isDaMua()) { %>
                                    <span>Đã thanh toán</span>
                                <% } else { %>
                                    <span>Chưa thanh toán</span>
                                <% } %>
                            </td>
                            <td><%= ls.getNgayMua() %></td>
                        </tr>
                        <% } %>
                    </tbody>
                </table>
            </div>
		</div>
	</div>
</body>
</html>