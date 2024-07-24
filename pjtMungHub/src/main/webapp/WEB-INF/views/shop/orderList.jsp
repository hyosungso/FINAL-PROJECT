<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<%@ include file="../common/header.jsp"%>
<div class="container mt-5">
    <h2>주문 내역</h2>
    <table class="table table-striped">
        <thead>
            <tr>
                <th scope="col">주문 번호</th>
                <th scope="col">결제일</th>
                <th scope="col">배송 진행 상황</th>
                <th scope="col">총 가격</th>
                <th scope="col">상세 보기</th>
            </tr>
        </thead>
        <tbody>
        	<c:forEach items="${orderList }" var="order">
        	  <tr>
                <th scope="row">${order.merchantUid }</th>
                <td>${order.payDate }</td>
                <td>${order.process }</td>
                <td><fmt:formatNumber type="number" maxFractionDigits="0" value="${order.totalPrice }"/>원</td>
                <td><a href="/pjtMungHub/orderDetail/${order.merchantUid }" class="btn btn-info btn-sm">상세 보기</a></td>
            </tr>
        	</c:forEach>
        </tbody>
    </table>
    <a href="/pjtMungHub/list.sp" class="btn btn-primary">계속 쇼핑하기</a>
</div>
</body>
</html>