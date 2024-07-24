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
    <div class="card">
        <div class="card-header bg-primary text-white">
            <h4>주문 내역</h4>
        </div>
        <div class="card-body">
            <h5 class="card-title">주문 정보</h5>
            <p class="card-text"><strong>주문 번호:</strong> ${order.merchantUid }</p>
            <p class="card-text"><strong>배송 진행 상황:</strong> ${order.process }</p>
            <p class="card-text"><strong>결제일:</strong> ${order.payDate }</p>
            <p class="card-text"><strong>도착 예정일:</strong> ${order.payDate }</p>
            <h5 class="mt-4">주문한 상품 목록</h5>
            <ul class="list-group">
            <c:forEach items="${itemList }" var="i" varStatus="status">
            
                <li class="list-group-item">
                    <strong>제품명:</strong> <a href="/pjtMungHub/detail.sp/${i.productNo }"> ${i.productName }</a><br>
                    <strong>수량:</strong> ${itemQuantity[status.index] }<br>
                    <strong>가격:</strong> 
                    	<fmt:formatNumber type="number" maxFractionDigits="0"
					value="${(i.price-(i.price/i.discount))*itemQuantity[status.index]}" />원
                </li>
            </c:forEach>
            </ul>
            <p class="card-text mt-3"><strong>총 가격: </strong><fmt:formatNumber type="number" maxFractionDigits="0" value="${order.totalPrice }"/></p>
            <a href="/pjtMungHub/list.sp" class="btn btn-primary">계속 쇼핑하기</a>
        </div>
    </div>
</div>
</body>
</html>