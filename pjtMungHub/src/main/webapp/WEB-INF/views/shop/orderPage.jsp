<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
 <title>주문 정보</title>
    <script src="https://cdn.iamport.kr/v1/iamport.js"></script>
   
    <style>
        body {
            background-color: #f4f4f4;
        }
        .container {
            margin-top: 50px;
            background-color: #fff;
            padding: 30px;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
        }
        .order-details, .payment-details, .customer-details {
            margin-top: 20px;
        }
        .order-details label, .payment-details label, .customer-details label {
            font-weight: bold;
            color: #555;
        }
        .order-details span, .payment-details span, .customer-details span {
            color: #777;
        }
    </style>
</head>
<body>
<%@ include file="../common/header.jsp" %>
	 <script type="text/javascript">
	    var IMP=window.IMP;
	    IMP.init("imp38300310");
	    
	    var date= new Date();
	    var hours = date.getHours();
	    var minutes = date.getMinutes();
	    var seconds = date.getSeconds();
	    var milliseconds = date.getMilliseconds();
	    var merchantUid = hours+minutes+seconds+milliseconds;
	    
	    function pay(){
	    	var totalPrice=${totalPrice};
	    	var usePoint=$("#usePoint").val();
	    	var shipFee=$("#shipFee").val();
	    	var address="${shipInfo.address }";
	    	
	    	if(address.includes('제주특별자치도')){
	    		shipFee+=Number(1500);
	    	}
	    	
	    	 var recipient="${shipInfo.recipient }";
	    	 var phone="${shipInfo.phone}";
	    	 var addr = "${shipInfo.address} ${shipInfo.addressDetail}";
	    	 
	    	
	    	 
	    	
	    	 
	    	 var productList = "";
	   	  
	    	IMP.request_pay({
	    		pg : 'html5_inicis',
	    		pay_method : 'card',
	    		merchant_uid: "IMP"+merchantUid,
	    		name : '${itemList}',
	    		amount : ((totalPrice-usePoint)+Number(shipFee)),
	    		custom_data : {
	    			message : $("#request-area").val()
	    			},
	    		buyer_name : recipient,
	    		buyer_tel : phone,
	    		buyer_addr : addr,
	    		},function(rsp){
	    			if(rsp.success) {
	    				alert('결제완료!');
	    				$.ajax({
	    					url : "insertOrderInfo.sp",
	    					type : "post",
	    					data : {
	    						 merchantUid : rsp.merchant_uid,
	    						 items : "${itemsNo}",
	    						 itemsQuantity : "${itemsQuantity}",
	    						 totalPrice : rsp.paid_amount,
	    						 userNo : ${loginUser.userNo},
	    						 message : rsp.custom_data,
	    						 address : "${shipInfo.address } ${shipInfo.addressDetail}",
	    						 recipient : "${shipInfo.recipient }",
	    						 phone : "${shipInfo.phone }"
	    					},
	    					success: function(result){
	    						
	    						if(result>0){
	    							var point=0;
									
									$("input[name=mileage]").each(function(index){
											point+=parseInt($(this).val());
									});
	    							$.ajax({
	    								url : "/pjtMungHub/updatePoint.sp",
	    								type : "post",
	    								data : {userNo : ${loginUser.userNo}
	    										,point : point-Number(usePoint)},
	    								success : function(result){
	    									console.log("포인트 적립 성공");
	    								},error : function(){
	    									console.log("포인트 적립 오류");
	    								}
	    								
	    								
	    							});
	    							location.href="/pjtMungHub/orderConfirm/"+rsp.merchant_uid;
	    						}else{
	    							alert("배송정보 저장에 오류가 발생했습니다. \n관리자에게 문의하세요.");
	    						}
	    					},
	    					error: function(){
	    						console.log("통신 실패");
	    					}
	    				
	    				});
	    				
	    			}else{
	    				console.log(rsp);
	    			}
	    		});
	    		
	    	
	    		
	    		
	    	}
	    	
	    
	    
	    </script>
    <div class="container">
        <h1 class="text-center">주문 정보</h1>
        <div class="row mt-4">
            <div class="col-md-5 order-details mr-5">
                <h3>주문한 물품</h3>
                <c:forEach items="${orderList }" var="order">
                <div class="card sm-3 my-3">
                <div class="row g-0">
                <div class="col-sm-4">
                <img class="img-fluid" src="${order.img }">
                </div>
                <div class="col-sm-8">
                    <div class="card-body">
                        <h3 class="card-title" name="productList">${order.productName }</h3>
                        
                        <p class="card-text">${order.amount }개</p>
                         <p class="card-text"><strong style="color:red">${order.discount }%</strong> <small class="text-muted"><del>${order.price*order.amount }원</del></small><br>
                         <strong style="color:red">
                         <fmt:formatNumber type="number"
						maxFractionDigits="0"
						value="${((order.price -(order.price/order.discount))/200)*order.amount}" />P</strong> 적립</p>
						
						<input type="hidden" value="${((order.price -(order.price/order.discount))/200)*order.amount}" name="mileage"> <!-- 마일리지 값 -->
						
                        <p class="card-text"><fmt:formatNumber type="number"
										maxFractionDigits="0" value="${(order.price-(order.price/order.discount))*order.amount }" />원</p>
                        <p class="card-text"><small class="text-muted">${order.brandName }  ${order.categoryName }</small></p>
                       
                    </div>
                </div>
                </div>
                </div>
                </c:forEach>
            </div>
            <div class="col"></div>
            <div class="col-md-6">
                <div class="payment-details ml-5">
                    <h3>결제 정보</h3>
                    <div class="form-group row">
                        <label for="price" class="col-sm-4 col-form-label">가격:</label>
                        <div class="col-sm-8">
                            <span id="price" class="form-control-plaintext">₩
                            <fmt:formatNumber type="number"
							maxFractionDigits="0" value="${totalPrice }" /> 원</span>
                        </div>
                    </div>
                    <div class="form-group row">
                        <label for="tax" class="col-sm-4 col-form-label">배송비:</label>
                        <div class="col-sm-8">
                            <span id="tax" class="form-control-plaintext">
		
						 <c:if test="${totalPrice > 30000 }">
						 <input type="hidden" id="shipFee" value="0">배송비 무료</c:if>
						 <c:if test="${totalPrice < 30000 }">
						 <input type="hidden" id="shipFee" value="2500">₩2,500 원</c:if>

							</span>
                        </div>
                        
                    </div>
                    
                              <div class="form-group row">
                        <label for="tax" class="col-sm-4 col-form-label">적립 포인트:</label>
                        <div class="col-sm-8">
                            <span id="point" class="form-control-plaintext">
									
									<script type="text/javascript">
										$(function(){
											
											var point=0;
											
											$("input[name=mileage]").each(function(index){
													point+=parseInt($(this).val());
											});
											
											$("#point").html(point.toLocaleString("ko-KR")+" P");
											
										});
									
									</script>

							</span>
                        </div>
                    </div>
                    
                    <div class="form-group row">
                        <label for="total" class="col-sm-4 col-form-label">총 결제 금액:</label>
                        <div class="col-sm-8">
                            <span id="total" class="form-control-plaintext">
                           <c:if test="${totalPrice > 30000 }">₩
             				 <fmt:formatNumber type="number"
							maxFractionDigits="0" value="${totalPrice }" /> 원</c:if>
						 <c:if test="${totalPrice < 30000 }">₩
              					<fmt:formatNumber type="number"
							maxFractionDigits="0" value="${totalPrice+2500 }" /> 원</c:if>
                            </span>
                         
                        
                    </div>
                </div>
                
                 <div class="form-group row">
                  <label for="point" class="col-sm-4 col-form-label">보유 포인트 :</label>
                        <div class="col-sm-8">
                            <span id="point" class="form-control-plaintext">
                            ${point.point }P
                            </span>
                        </div>
                 
                 </div>
                  <div class="form-group row">
                  <label for="usePoint" class="col-sm-4 col-form-label">사용 포인트 :</label>
                  <input type="text" class="col-sm-6" value="0" id="usePoint">
                 </div>
                 
                 <script>
                 $(function(){
                	 
                 $("#usePoint").keyup(function() {
                	var result=0;
                	 var regExp=/^[0-9]+$/;
                	var point=$("#usePoint").val();
                	if(regExp.test(point)){
                		
                		if(${point.point }<point){
                    		alert("소지한 point보다 많이 입력되었습니다.");
                    		$("#usePoint").val(${point.point });
                		}else if(${totalPrice}<point){
                			alert("결제금액보다 point가 많이 입력되었습니다.");
                    		$("#usePoint").val(${totalPrice});
            			}else{
                		
	                	 result=${totalPrice}-point;
	                	 
	                	 if(${totalPrice}<30000){
	                		 result+=2500;
	                	 }
	                	 
	                	 $("#total").text("₩ "+result.toLocaleString("ko-KR")+" 원");
                		}
                	
                	}else{
                		alert("숫자만 입력해 주십시오.");
                		$("#usePoint").val(0);
                		
                	}
                	});
                 });
                 
                 </script>
                <div class="customer-details mt-5 ml-5">
                    <h3>주문자 정보</h3>
                    <div class="form-group row">
                        <label for="name" class="col-sm-4 col-form-label">이름:</label>
                        <div class="col-sm-8">
                            <span id="name" class="form-control-plaintext">${shipInfo.recipient }</span>
                        </div>
                    </div>
                    <div class="form-group row">
                        <label for="phone" class="col-sm-4 col-form-label">전화번호:</label>
                        <div class="col-sm-8">
                            <span id="phone" class="form-control-plaintext">${shipInfo.phone }</span>
                        </div>
                    </div>
                    <div class="form-group row">
                        <label for="address" class="col-sm-4 col-form-label">주소:</label>
                        <div class="col-sm-8">
                            <span id="address" class="form-control-plaintext">${shipInfo.address }</span>
                        </div>
                    </div>
                     <div class="form-group row">
                        <label for="addressDetail" class="col-sm-4 col-form-label">상세주소:</label>
                        <div class="col-sm-8">
                            <span id="addressDetail" class="form-control-plaintext">${shipInfo.addressDetail }</span>
                        </div>
                    </div>
                     <div class="form-group row">
                        <label for="address" class="col-sm-4 col-form-label">요청사항:</label>
                        <div class="col-sm-8">
                            <div id="request" class="form-control-plaintext">
								<select id="request-option" onchange="request()" style="width:100%">
									<option>직접 입력(현관비밀번호,요청사항)</option>
									<option>안전운전 부탁드립니다.</option>
									<option>초인종 울리지 말아주세요</option>
									<option>조심히 배달 부탁드립니다.</option>
									<option>부재 시 경비실에 맡겨주세요.</option>
								</select>
							</div>
							<div>
								<textarea class="form-control" rows="3" id="request-area" style="resize:none"></textarea>
							</div>
							
							
							<script>
								function request(){
									if($("#request-option option:selected").text()=='직접 입력(현관비밀번호,요청사항)'){
										$("#request-area").val("");
									}else{
										$("#request-area").val($("#request-option option:selected").text());
									}
								}
							
							</script>
                        </div>
                        
                        <div class="my-3 d-grid col-6 mx-auto" align="center">
                        <button type="button" class="btn btn-outline-dark flex-shrink-0" onclick="pay()"> <i class="bi bi-credit-card-fill"></i> 결제</button>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
    </div>
</body>
</html>

	
