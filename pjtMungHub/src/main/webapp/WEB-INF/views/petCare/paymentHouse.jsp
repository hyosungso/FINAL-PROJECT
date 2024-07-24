<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>장기돌봄 결제</title>
<style>
    .order-section {
        background-color: #f8f9fa;
        padding: 15px;
        margin-bottom: 20px;
        border-radius: 5px;
    }
    .order-title {
        font-weight: bold;
        font-size: 1.2em;
    }
    .order-summary {
        background-color: #e9ecef;
        padding: 10px;
        border-radius: 5px;
        margin-bottom: 15px;
    }
    
    /* 펫시터 리스트 css */
    .sitter-card {
        border: 1px solid #ddd;
        padding: 20px;
        margin: 10px 0;
        display: flex;
        align-items: center;
    }
    .sitter-info {
        flex: 1;
    }
    .sitter-photo {
        width: 100px;
        height: 100px;
        border-radius: 50%;
        object-fit: cover;
        margin-left: 20px;
    }
    .popular-style {
        color: #ff4081;
        font-weight: bold;
    }
    .form-section {
      margin-bottom: 2rem;
    }
    .form-section h5 {
      margin-bottom: 1rem;
    }
</style>
</head>
<body>
	<%@include file="/WEB-INF/views/common/header.jsp" %>
	<input type="hidden" id="differentNo" value="2"> <!-- 예약구분 -->
	<input type="hidden" id="userNo" value="${loginUser.userNo }"> 
	<input type="hidden" id="userId" value="${loginUser.userId }"> 
	<input type="hidden" id="reservationHouseNo" value="${reservationHouseNo }"> 
	
	 <div class="container mt-5">
	 <h3>장기돌봄 결제</h3>
	 
        <div class="order-section">
            <h5>예약정보 확인</h5>
            <div class="mb-3">
                <label for="petOwnerName" class="form-label">견주 성함</label>
                <input type="text" class="form-control" id="petOwnerName" name="petOwnerName" value="${hr.petOwnerName}" disabled>
            </div>
            <div class="mb-3">
                <label for="phone" class="form-label">견주 연락처</label>
                <input type="text" class="form-control" id="phone" name="phone" value="${hr.phone}" disabled>
            </div>
            <div class="mb-3">
	            <label for="visitDate" class="form-label">예약하신 날짜</label>
	            <input type="text" class="form-control" id="visitDate" name="visitDate" value="${hr.startDate}" disabled>
	        </div>
        </div>

        <div class="order-section">
	        <h5>돌보미 집정보</h5>
	        <div class='sitter-card'>
	        	<div class='sitter-info'>
	        		<h4>집주인 성함 : ${house.ownerName }</h4>
	        		<div id="address">${house.houseAddress }</div>
				 	<img src='/pjtMungHub/${house.filePath }${house.originName01}' class='sitter-photo'>
	        	</div>
	        </div>
	    </div>
      <!-- 결제수단 섹션 -->
        <div class="order-section">
	        <h5>고객님께서 받을 서비스와 총 결제 금액입니다.</h5>
	        <div class="form-group">
	            일정은 <input type="text" class="form-control" name="totalPrice" id="priceName" value="${price.stayName }" style="width:300px;" readonly>이며,
	            상품 가격은 <input type="text" class="form-control" name="totalAmount" id="totalPrice" value="${price.price }" style="width:300px;" readonly> 원 입니다.
	        </div>
            <div class="order-title">결제수단</div>
            <select class="form-select" id="payment">
                <option value="card" selected>카드결제</option>
                <option value="cash">현장결제</option>
                <option value="bank">무통장입금</option>
            </select>
        </div>

        <!-- 최종 결제금액 섹션 -->
        <div class="order-section">
            <div class="order-summary">
                <button class="btn btn-success w-100 mt-3" onclick="requestPay();">결제하기</button>
            </div>
        </div>
        <br><br>
    </div>
        
	<script type="text/javascript" src="https://cdn.iamport.kr/js/iamport.payment-1.2.0.js"></script>
	<script>
	
		var payMethod = "";
		$(function(){
			payMethod = $('#payment').val();
			$('#payment').change(function(){
				payMethod = $(this).val();
			});
		});
			
		//결제 api
		var IMP = window.IMP;
        IMP.init("imp57634033");
        var today = new Date();
        var hours = today.getHours(); // 시
        var minutes = today.getMinutes();  // 분
        var seconds = today.getSeconds();  // 초
        var milliseconds = today.getMilliseconds();
        var makeMerchantUid = hours +  minutes + seconds + milliseconds;
        function requestPay() {
        	
        	var productName = $("#priceName").val();//선택된 상품명
        	var totalPrice = $('#totalPrice').val();//상품 가격
        	var userName = $('#petOwnerName').val();//견주이름
        	var phone = $('#phone').val();//연락처
        	var address = $('#address').text();//주소
           	var userNo = $('#userNo').val();//회원번호
           	var userId = $('#userId').val();//회원아이디
           	var differentNo = $('#differentNo').val();
           	var reservationHouseNo =$('#reservationHouseNo').val();
           	var reservationNo = 0;
        	
            IMP.request_pay({
            	merchant_uid : "IMP"+makeMerchantUid,
                pg : 'html5_inicis',
                buyer_name : userName,
                amount : totalPrice,
                buyer_tel : phone,
                buyer_addr : address,
                pay_method : payMethod,
                name : productName,
                buyer_email : differentNo,
                custom_data : {
                	reservationNo : reservationNo,
                	reservationHouseNo : reservationHouseNo,
                	userNo : userNo,
                	userId : userId
                }
            }, function (rsp) { // callback
                if (rsp.success) {//결제 성공시
                    console.log(rsp);
                	//결제 성공시 비동기 처리로 응답데이터 서버에 전달하기
                	$.ajax({
                    	url : "insertPayment.re",
                    	data : {
                    		paymentId : rsp.merchant_uid,
                    		pgName : rsp.pg_provider,
                    		userName : rsp.buyer_name,
                    		amount : rsp.paid_amount,
                    		phone : rsp.buyer_tel,
                    		address : rsp.buyer_addr,
                    		paymentMethod : rsp.pay_method,
                    		productName : rsp.name,
                    		differentNo : rsp.buyer_email,
                    		customData : rsp.custom_data
                    	}, //rsp 객체를 그대로 전달해보기(응답데이터 키값으로 넘어감)
                    	success : function(result){
                    		if(result>0){
                    			//결제 성공 후 내역 페이지로
                    			location.href="payDetail.re?uid="+rsp.merchant_uid;
                    		}else{
                    			//결제 실패
                    			alert("결제정보 오류 [관리자에게 문의하세요]");
                    			location.href="/pjtMungHub/";
                    		}
                    	},
                    	error : function(){
                    		console.log("통신실패");
                    	}
                    });
                } else {
                    console.log(rsp);
                }
            });
        }
	</script>
</body>
</html>