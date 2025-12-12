<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@page import="java.util.ArrayList"%>
<%@page import="Models.Sach"%>
<%@page import="Models.KhachHang" %>
<%@page import="Models.Loai"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<title>Trang chủ sách</title>
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
	          <a class="nav-link active" href="tcController">
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
	          <a class="nav-link" href="HtLichSuController">
	          	<i class="bi bi-receipt"></i> Lịch sử mua hàng
	          </a>
	        </li>

<%--   			<%KhachHang user=(KhachHang)session.getAttribute("user");
				if(user!=null){%>
				<li class="nav-item">
					<a class="nav-link" href="#">Xin chào: <%=user.getHoTen() %></a>
				</li>
				<li class="nav-item">
	          		<a class="nav-link" href="dangxuatController">Đăng xuất</a>
	        	</li>
				<%}else{ %>
				<li class="nav-item">
					<a class="nav-link" href="dangnhapController">Đăng nhập</a>
				</li>
				<%} %> --%>
	        	
	        	<c:choose>
	        		<c:when test="${not empty sessionScope.user}">
	        			<li class="nav-item">
		          			<a class="nav-link" href="#" style="">
		          				Xin chào: ${sessionScope.user.hoTen}
		          			</a>
		        		</li>
		        		<li class="nav-item">
	          				<a class="nav-link" href="dangxuatController">
	          					<i class="bi bi-box-arrow-right"></i> Đăng xuất
	          				</a>
	        			</li>
	        		</c:when>
	        		<c:otherwise>
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
	        		</c:otherwise>
	        	</c:choose>
	        	
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
		            <a href="tcController?ml=<%= l.getMaLoai() %>" style="display:block; min-width: 200px" class="btn my-2 btn-custom">
		                <%= l.getTenLoai() %>
		            </a>
			<%	}%>
		</div>
		<div class="col-sm-9 row">
			<%
				if(request.getAttribute("empty") != null){
			%>
					<div><%= request.getAttribute("empty")%></div>
			<% 
				return;
			}%>
			
			<%-- <c:forEach var="s" items="${dsSach}">
				<div class="col-sm-3 ">
					<img src="${s.anh}" alt="${s.tenSach}"><br>
					${s.tenSach}<br>
					${s.tacGia}<br>
					${s.gia}<br>
					<a href="giohangController?ms=${s.maSach}&ts=${s.tenSach}&sl=${s.soLuong}&gia=${s.gia}&anh=${s.anh}">
						<img src="buynow.jpg">
					</a>
				</div>
			</c:forEach> --%>	
			
			<%
				ArrayList<Sach> dsSach = (ArrayList<Sach>) request.getAttribute("dsSach");
				for(Sach s : dsSach){
			%>	
					<div class="col-sm-3 ">
						<img src="<%= s.getAnh() %>" alt="<%= s.getTenSach() %>"><br>
						<%= s.getTenSach()%><br>
						<%= s.getTacGia()%><br>
						<%= s.getGia()%><br>
						<a href="giohangController?ms=<%= s.getMaSach() %>&ts=<%= s.getTenSach() %>&sl=<%= s.getSoLuong() %>&gia=<%= s.getGia() %>&anh=<%= s.getAnh() %>">
							<img src="buynow.jpg">
						</a>
					</div>
			<%} %>
			
			<div class ="col-sm-12 mt-3">
				<ul class="pagination d-flex">
					<%
						int totalPage = (int) request.getAttribute("totalPage");
						int currentPage = (int) request.getAttribute("page");
						String mlLink =  (String) request.getAttribute("mlLink");
						String keyLink = (String) request.getAttribute("keyLink");				
						
						for(int i= 1 ; i<=totalPage; i++){
					%>
							<li class ="page-item">
								<a href="tcController?page=<%= i%>&ml=<%=mlLink %>&input_search=<%=keyLink %>" class ="page-link">
									<%= i%>
								</a>
							</li>
					<%	} %>
				</ul>
			</div>
		</div>
	</div>
</body>
</html>