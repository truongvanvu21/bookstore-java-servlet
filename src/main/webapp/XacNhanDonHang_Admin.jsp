<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>Xác nhận đơn hàng</title>
    <style>
        table { border-collapse: collapse; width: 100%; }
        th, td { padding: 8px; border: 1px solid #ccc; }
        th { background: #f2f2f2; }
        .btn { padding: 5px 10px; text-decoration: none; }
        .btn-confirm { background: green; color: white; }
    </style>
</head>
<body>
<div style="max-width:1100px;margin:20px auto">
    <h2>Danh sách đơn hàng CHƯA xác nhận</h2>

    <c:if test="${empty dsHoaDon}">
        <p>Không có đơn hàng cần xác nhận</p>
    </c:if>

    <c:if test="${not empty dsHoaDon}">
        <table>
            <tr>
                <th>Mã hóa đơn</th>
                <th>Mã KH</th>
                <th>Ngày mua</th>
                <th>Trạng thái</th>
                <th>Hành động</th>
            </tr>

            <c:forEach var="hd" items="${dsHoaDon}">
                <tr>
                    <td>${hd.maHoaDon}</td>
                    <td>${hd.maKH}</td>
                    <td>
                        <fmt:formatDate value="${hd.ngayMua}" pattern="dd/MM/yyyy HH:mm"/>
                    </td>
                    <td>Chưa xác nhận</td>
                    <td>
                        <a class="btn btn-confirm"
                           href="${pageContext.request.contextPath}/admin/order/confirm?ma=${hd.maHoaDon}"
                           onclick="return confirm('Xác nhận đơn hàng này?')">
                            Xác nhận
                        </a>
                    </td>
                </tr>
            </c:forEach>
        </table>
    </c:if>
</div>
</body>
</html>