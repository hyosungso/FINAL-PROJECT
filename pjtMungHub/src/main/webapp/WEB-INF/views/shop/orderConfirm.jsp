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
        <div class="card-header bg-success text-white">
            <h4>주문 성공</h4>
        </div>
        <div class="card-body">
            <div class="alert alert-success" role="alert">
                주문이 성공적으로 완료되었습니다!
            </div>
            <h5 class="card-title">주문 상세 정보</h5>
            <p class="card-text"><strong>주문 번호:</strong> ${orderInfo.merchantUid }</p>
            <p class="card-text"><strong>제품명:</strong> <c:forEach items="${pList }" var="p">
             <a href="/pjtMungHub/detail.sp/${p.productNo }">${p.productName }</a> ${p.quantity }개 , </c:forEach>
            </p>
            <p class="card-text"><strong>총 가격:</strong> ${orderInfo.totalPrice }</p>
            <a href="/pjtMungHub/list.sp" class="btn btn-primary">계속 쇼핑하기</a>
            <a href="/pjtMungHub/orderList/${loginUser.userNo }" class="btn btn-secondary">주문 내역 보기</a>
        </div>
    </div>
</div>

</body>
</html>