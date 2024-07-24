<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>MUNGHUBSHOP</title>
<style>
.order-info{
font-size: 20px;
font-weight: bold;
}

.info:hover{
	background-color: lightgray;
	cursor: pointer;
}
#choosed{
color : red;
}
.empty-cart {
display: flex;
flex-direction: column;
justify-content: center;
align-items: center;
height: 50vh;
text-align: center;
}
.empty-cart .message {
color: gray;
font-size: 2em;
margin-bottom: 20px;
}

</style>
</head>
<body>
	<%@ include file="../common/header.jsp"%>
	<div class="jumbotron">
		<div class="container" >
			<h2>장바구니</h2>
		</div>
	</div>
	<script>
	
	
		function loadShipInfo(){
			$.ajax({
				url : "selectShipInfoList.sp",
				data : {userNo : ${loginUser.userNo}},
				success : function(result){
					var str=""; /* 데이터 유무에 따라 등록 메서드 버튼이나 조회 메서드 html 값을 담을 변수 */
					var str2=""; /* list모달 html 값 담을 변수 */
					var choosed="";
					var choosedNo=0;
					if(result.length==0){
						str="<button class='btn btn-outline-primary'"
						+"type='button' data-bs-toggle='modal'"
						+"data-bs-target='#shipinfo-insert'>"
						+"<i class='bi bi-truck'></i> 배송지 등록</button>"
						
						$("#form").on("submit",function(e){
							 alert("배송지를 등록해주세요");
							 e.preventDefault(); //요소작동 정지
							 e.stopPropagatuin(); //부모태그에게 전달되는 것 막기
						});
						
						
					}else{
							str="<p class='order-info'>주문자 정보</p>"
							+"<div class='order-info-conten'>"
							+"<span><i class='bi bi-person-circle'></i>"+result[0].recipient+"</span>"
							+"<span> | </span>"
							+"<span><i class='bi bi-telephone'></i>"+result[0].phone+" </span>"
							+"</div>"
							+"</div>"
							+"<div align='center'>"
							+"<span class='address'> 주소 :"+result[0].address+" "+result[0].addressDetail+"  </span> <br>"
							+"</div><br>"
							+"<div align='center'>"
							+"<button class='btn btn-outline-secondary'"
							+"type='button'"
							+"data-bs-toggle='modal'" 
							+"data-bs-target='#ship-infoList'>"
							+"<i class='bi bi-truck'></i> 배송지 정보수정</button>"
							for(var i in result){
								if(result[i].choosed=='Y'){
									choosed="<i class='bi bi-check-lg' id='choosed'></i>";
									choosedNo=1;
								}else{
									choosed="";
									choosedNo=0;
								}
								str2+="<div class='row my-1 ml-3'>"
								+"<div class='col-sm-1'>"+choosed+"</div>"
								+"<div class='row col-sm-10 info' align='center' onclick='changeInfo("+result[i].infoNo+");'>"
								+"<div class='col-sm-3'>"+result[i].recipient+"</div>"
								+"<div class='col-sm-3'>"+result[i].phone+"</div>"
								+"<div class='col-sm-6'>"+result[i].address+" "+result[i].addressDetail+"</div>"
								+"</div>"
								+"<div class='col-sm-1 ml-2' align='right'>"
								+"<button type='button' class='btn btn-outline-dark' onclick='removeInfo("+result[i].infoNo+","+choosedNo+")'><i class='bi bi-trash-fill'></i></button>"
								+"</div>"
								+"</div>"
							}
							
							$("#form").unbind();
						}
					
					$("#shippingInfoDiv").html(str);
					$("#modalShipInfoList").html(str2);
					},
					
					
				error: function(){
					console.log("통신오류");
				}
				
			});
		}
		
		$(function(){
			loadShipInfo();
		});
		
		function changeInfo(num){
			$.ajax({
				url: "changeShipInfo.sp",
				type : "post",
				data : {infoNo: num
					   ,userNo: ${loginUser.userNo}},
				success : function(result){
					console.log("수정성공")
					loadShipInfo();
				},
				error: function(){
					console.log("통신오류");
				}
				
			});
		}
		
		function removeInfo(num,YN){
			var YesOrNot;
			if(YN==1){
				YesOrNot="Y";
			}else{
				YesOrNot="N";
			}
			
			$.ajax({
				url: "removeShipInfo.sp",
				type : "post",
				data : {infoNo: num
					   ,userNo: ${loginUser.userNo}
					   ,choosed: YesOrNot},
				success : function(result){
					console.log("삭제성공")
					loadShipInfo();
				},
				error: function(){
					console.log("통신오류");
				}
				
			});
		}
		
	</script>
	<div class="container">
		<form action="/pjtMungHub/order.sp" id="form" method="post">
		<input type="hidden" name="userNo" value="${loginUser.userNo }"> 
	<div align="center" id="shippingInfoDiv">

	</div>

	 <!-- 배송정보 등록 모달  -->
		<div class="modal fade" id="shipinfo-insert" data-bs-backdrop="static" data-bs-keyboard="false" tabindex="-1" aria-labelledby="staticBackdropLabel" aria-hidden="true">
	  <div class="modal-dialog modal-md">
	    <div class="modal-content">
	      <div class="modal-header">
	        <h1 class="modal-title fs-5" id="staticBackdropLabel">배송정보등록</h1>
	        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
	      </div>
	      <div class="modal-body">
	      <input type="text" id="recipient" placeholder="수령인" value="${loginUser.name }" required> 수령인 <br>
	      <input type="text" id="phone" placeholder="전화번호" value="${loginUser.phone }" required> 전화번호 (-)입력 <br> <br>
	      
	    <input type="text" id="address" placeholder="주소" onclick="execDaumPostcode()" readonly>
		<input type="button" onclick="execDaumPostcode()" value="주소 검색"><br>
	    <input type="text" id="address_detail" placeholder="주소상세">
	    
	<div id="map" style="width:300px;height:300px;margin-top:10px;display:none"></div>

<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<script src="//dapi.kakao.com/v2/maps/sdk.js?appkey=13a263ddbec24d8114711ac7bcacac75&libraries=services"></script>
<script>
    var mapContainer = document.getElementById('map'), // 지도를 표시할 div
        mapOption = {
            center: new daum.maps.LatLng(37.537187, 127.005476), // 지도의 중심좌표
            level: 5 // 지도의 확대 레벨
        };

    //지도를 미리 생성
    var map = new daum.maps.Map(mapContainer, mapOption);
    //주소-좌표 변환 객체를 생성
    var geocoder = new daum.maps.services.Geocoder();
    //마커를 미리 생성
    var marker = new daum.maps.Marker({
        position: new daum.maps.LatLng(37.537187, 127.005476),
        map: map
    });


    function execDaumPostcode() {
        new daum.Postcode({
            oncomplete: function(data) {
                var addr = data.address; // 최종 주소 변수

                // 주소 정보를 해당 필드에 넣는다.
                document.getElementById("address").value = addr;
                // 주소로 상세 정보를 검색
                geocoder.addressSearch(data.address, function(results, status) {
                    // 정상적으로 검색이 완료됐으면
                    if (status === daum.maps.services.Status.OK) {

                        var result = results[0]; //첫번째 결과의 값을 활용

                        // 해당 주소에 대한 좌표를 받아서
                        var coords = new daum.maps.LatLng(result.y, result.x);
                        // 지도를 보여준다.
                        mapContainer.style.display = "block";
                        map.relayout();
                        // 지도 중심을 변경한다.
                        map.setCenter(coords);
                        // 마커를 결과값으로 받은 위치로 옮긴다.
                        marker.setPosition(coords)
                    }
                });
            }
        }).open();
    }
</script>
	      </div>
	      <div class="modal-footer">
	        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">취소</button>
	        <button type="button" class="btn btn-primary" onclick="saveAddressInfo();">저장</button>
	      </div>
	    </div>
	  </div>
	</div>
	

<!-- 배송리스트 모달 -->
<div class="modal fade" id="ship-infoList" data-bs-backdrop="static" data-bs-keyboard="false" tabindex="-1" aria-labelledby="staticBackdropLabel" aria-hidden="true">
  <div class="modal-dialog modal-lg">
    <div class="modal-content">
      <div class="modal-header">
        <h1 class="modal-title fs-5" id="staticBackdropLabel">배송정보선택</h1>
        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
      </div>
      <div class="modal-body" id="modalShipInfoList">
   
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>
        <button type="button" class="btn btn-primary" data-bs-dismiss="modal" data-bs-toggle='modal'
		data-bs-target='#shipinfo-insert'><i class='bi bi-truck'></i> 배송지 등록</button>
      </div>
    </div>
  </div>
</div>

	<script>
	function saveAddressInfo(){
		
		var userNo = ${loginUser.userNo};
		var recipient = $("#recipient").val();
		var phone = $("#phone").val();
		var address = $("#address").val();
		var addressDetail = $("#address_detail").val();
		var errorMsg ="";
		
		var regExp = /^\d{3}-{1}\d{4}-{1}\d{4}$/;
		
		if(recipient=="" || phone=="" || addressDetail=="" || address==""){
			if(recipient==""){
				errorMsg+="수령인(수취인)을 입력해주세요.\n"
			}
			if(phone==""){
				errorMsg+="전화번호를 입력해주세요.\n"
			}
			
			if(!regExp.test(phone)){
				errorMsg+="연락처 형식을 다시 입력해주세요. ex:010-0000-0000\n"
			}
			if(address==""){
				errorMsg+="주소를 입력해주세요.\n"
			}
			if(addressDetail==""){
				errorMsg+="상세주소를 입력해주세요.\n"
			}
			alert(errorMsg);
		}else{
			
		$.ajax({
			url: "insertShipInfo.sp",
			type : "post",
			data : { userNo : userNo,
					 recipient : recipient,
					 phone : phone,
					 address : address,
					 addressDetail : addressDetail},
			success : function (result){
				alert("배송정보를 저장했습니다.");
				$('#shipinfo-insert').modal('hide');
				loadShipInfo();
				
			},
			error : function (){
				console.log("통신오류");
			}
		});
		}
	}
	</script>
			<table width="100%" style="margin: 10px">
				<tr>
					<td align="right">
						<button id="clean" class="btn btn-outline-dark flex-shrink-0"
							type="button" onclick="removeItems();">
							<i class="bi bi-trash2-fill"></i> 카트비우기
						</button>
					
						<button id="order" class="btn btn-outline-dark flex-shrink-0"
							type="submit">
							<i class="bi bi-credit-card-fill"></i> 주문하기
						</button>
					
					</td>
				</tr>
			</table>
			<script>
 		$(function(){
 			
 			shoppingList();
 		});
 			
 			function removeItems(){
 				var arr = [];
 					$('input[name=chooseOrNot]:checked').each(function(index){
 					arr.push($(this).val());
 				});
 				$.ajax({
 					url: "/pjtMungHub/removeCartItem.sp",
 					type: "post",
 				    traditional: true, /* 배열 넘기는 ajax 옵션 */
 					data : { 
 						items : arr,
 						userNo : ${loginUser.userNo}
 					},
 					success : function(result){
 						shoppingList();
 					},
 					error : function(){
 						console.log("통신오류");
 					}
 					
 					
 				});
 			}
 			
 				

 		function deleteItem(num){
 			var arr = [num];
 		$.ajax({
				url: "/pjtMungHub/removeCartItem.sp",
				type: "post",
			    traditional: true, /* 배열 넘기는 ajax 옵션 */
				data : { 
					items : arr,
					userNo : ${loginUser.userNo}
				},
				success : function(result){
					shoppingList();
				},
				error : function(){
					console.log("통신오류");
				}
		});
 		}
 		
 		function updateAmount(pNo,uNo,aNo){
 			
			const popoverTriggerList = document.querySelectorAll('[data-bs-toggle="popover"]');
			const popoverList = [...popoverTriggerList].map(popoverTriggerEl => new bootstrap.Popover(popoverTriggerEl)); //부트스트랩 팝오버 초기화(사용준비)
 			
 				if($("#pAmount").text()==1 && aNo==-1 ){
 					$("div").remove(".popover-body,.popover-arrow,.popover");
 					$("#minus").attr("data-bs-toggle","popover");
 					$("#minus").attr("data-bs-content","0이하의 숫자로는 지정할 수 없습니다.");
 					$("#minus").attr("data-bs-placement","left");
 				}else if($("#pAmount").text()==99 && aNo==1){
 					$("div").remove(".popover-body,.popover-arrow,.popover");
 					$("#plus").attr("data-bs-toggle","popover");
 	 				$("#plus").attr("data-bs-content","99이상의 숫자로는 지정할 수 없습니다.");
 	 				$("#plus").attr("data-bs-placement","right");
 					}else{
 					
 				$("#minus").removeAttr("data-bs-toggle");
 				$("#minus").removeAttr("data-bs-content");
 				$("#minus").removeAttr("data-bs-placement");
 				$("#plus").removeAttr("data-bs-toggle");
 				$("#plus").removeAttr("data-bs-content");
 				$("#plus").removeAttr("data-bs-placement");
 				$("div").remove(".popover-body,.popover-arrow,.popover");
 			$.ajax({
 				url : "updateCartAmount.sp",
 				type : "post",
 				data : {productNo : pNo,
 						userNo : uNo,
 						amount : aNo },
 				success : function(result){
 					shoppingList();
 				},
 				error : function(){
 					console.log("통신오류");
 				}
 				
 			});
 				}
 					
 			 		}
 				
 				
 		
 		
 		function shoppingList(){
 			
 			$.ajax({
 				url : "cartList.sp",
 				data : {
 					userNo : ${loginUser.userNo}
 				},
 				success : function(result){
 					
 						
 					var str = "";
 					var finalPrice= 0;
 					
 					if(result==""){
 						
 						str="<div class='container empty-cart'>"
 					    +"<div class='message'>"
 				        +"등록된 상품이 없습니다."
 				    	+"</div>"
 				   		+"<a href='/pjtMungHub/list.sp' class='btn btn-primary'>쇼핑하러 가기</a>"
 						+"</div>"
 						
 						$("#clean").attr("disabled","true");
 						$("#order").attr("disabled","true");
 						
 						$("#shoppingList").html(str);
 					}else{
 					
 					for(var i in result){
 						
 						var productNo = result[i].productNo;
 						var productName = result[i].productName;
 						var img = result[i].img;
 						var amount = result[i].amount;
 						var totalPrice = (result[i].price-(result[i].price/result[i].discount))*result[i].amount;
 						var price = (result[i].price-(result[i].price/result[i].discount));
 						finalPrice+=totalPrice;
 						str +="<tr>"
							+"<td><input class='form-check-input' type='checkbox'"
							+"name='chooseOrNot' checked value='"+productNo+"'></td>"
							
							+"<td><a href='/pjtMungHub/detail.sp/"+productNo+"'>"+productName;
							if(result[i].imgType=='image'){
								
							str+="<img src='"+img+"' class='img-fluid' style='max-height:400px'></a></td>";
							}else{
							str+="<video src='"+img+"' class='img-fluid' style='max-height:400px' autoplay loop></a></td>";
							}
							
							str+="<td>"+price.toLocaleString('ko-KR')+" 원</td>"
							+"<td><div class='btn-group' role='group' aria-label='amount'>"
							+"<button class='btn btn-dark' id='minus' type='button' onclick='updateAmount("+productNo+","+${loginUser.userNo}+","+-1+");' ><i class='bi bi-dash-square'></i></button>"
							+"<button class='btn btn-outline-dark' id='pAmount' type='button' disabled>"+amount.toLocaleString('ko-KR')+"</button>" 
							+"<button class='btn btn-dark' id='plus' type='button' onclick='updateAmount("+productNo+","+${loginUser.userNo}+","+1+");' ><i class='bi bi-plus-square'></i></button>"
							+"</div>"
							+"</td>"
							+"<td>"+totalPrice.toLocaleString('ko-KR')+" 원</td>"
							+"<td><button class='btn btn-outline-dark flex-shrink-0' type='button'"
							+"onclick='deleteItem("+productNo+");'>"
							+"<i class='bi bi-trash3-fill'></i></button></td>"
							+"</tr>";
 					}
 							str+="<tr><td colspan=6 align='right' id='total'>총합 : "+finalPrice.toLocaleString('ko-KR')+"</td></tr>";
 					$("#shoppingList tbody").html(str);
 				}},
 				error : function(){
 					console.log("통신오류");
 				}
 			});
 		}
 	</script>

			<div style="padding-top: 50px">
				<table id="shoppingList" class="table table-hover">
					<thead>
					<tr>
						<th scope="col"></th>
						<th scope="col">상품</th>
						<th scope="col">가격</th>
						<th scope="col">수량</th>
						<th scope="col">소계</th>
						<th scope="col">비고</th>
					</tr>
					</thead>
					<tbody>
					
					</tbody>
				</table>
				
			</div>
		</form>
	</div>
</body>
</html>