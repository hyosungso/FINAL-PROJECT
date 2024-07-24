<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<style>
        .content {
            margin: 70px;
        }
        .card {
            margin: 20px;
        }
        img {
			width: 300px;
		}
</style>
<title>${loginUser.name}님의 댕댕이 웨딩플랜 신청/접수 내역입니다</title>
</head>
<body>
	<%@ include file="/WEB-INF/views/common/header.jsp"%>
	<div class="container mt-3">
		<table class="table">
			<thead>
				<tr>
					<th class="text-center">우리 강아지 이름</th>
					<th class="text-center">상대방 강아지 이름</th>
					<th class="text-center">승인 여부</th>
				</tr>
			</thead>
			<tbody>
				<c:choose>
					<c:when test="${empty weddingList}">
						<tr>
							<td></td>
							<td class="text-center">신청 내역이 없습니다!<br>
							지금 등록되어있는 강아지들을 보러 가볼까요 (ᐡ-ܫ•ᐡ)?
							</td>
							<td></td>
						</tr>
						<tr>
							<td></td>
							<td class="text-center"><a href="wedList.wd" class="btn btn-success">등록되어있는 강아지들 구경하러 가기</a></td>
							<td></td>
						</tr>
					</c:when>
				</c:choose>
				<!-- 승인 된 예약은 초록색 행으로 출력 -->
				<c:forEach items="${weddingList}" var="w">
					<c:choose>
						<c:when test="${w.approval == 'A' }">
							<tr class="table-success">
								<td class="text-center">${w.petName }</td>
								<td class="text-center">${w.partnerName }</td>
								<td class="text-center"> 
								<input type="hidden" value="${w.weddingNo }">
								<b style="color: blue;">수락</b>&ensp; 
								<a class="btn btn-primary btn-sm" href="detail.wd?weddingNo=${w.weddingNo}">상세보기</a>
								&ensp;<button type="button" class="btn btn-primary btn-sm contactBtn" data-bs-toggle="modal" data-bs-target="#infoModal">연락처</button>
								&ensp;<button class="btn btn-secondary btn-sm cancelApplied">만남취소</button>
								 <!-- The Modal -->
								<div class="modal fade" id="infoModal">
								  <div class="modal-dialog">
								    <div class="modal-content">
								
								      <!-- Modal Header -->
								      <div class="modal-header">
								        <h4 class="modal-title">댕댕이 부모님 연락처</h4>
								        <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
								      </div>
								
								      <!-- Modal body -->
								      <div class="modal-body">
								        <table class="table table-striped contactTable">
									    <thead>
									      <tr>
									        <th>이름</th>
									        <th>전화번호</th>
									        <th>이메일주소</th>
									      </tr>
									    </thead>
									    <tbody>
									    </tbody>
									  </table>
								      </div>
								
								      <!-- Modal footer -->
								      <div class="modal-footer">
								        <button type="button" class="btn btn-danger" data-bs-dismiss="modal">닫기</button>
								      </div>
								
								    </div>
								  </div>
								</div>
								</td>
							</tr>
						</c:when>
						<c:when test="${w.approval == 'W' }">
							<!-- 대기중인 예약은 회색 행으로 출력 -->
							<tr class="table-warning">
								<td class="text-center">${w.petName }</td>
								<td class="text-center">${w.partnerName }</td>
								<td class="text-center">대기중&ensp; 
									<a class="btn btn-primary btn-sm" href="detail.wd?weddingNo=${w.weddingNo}">상세보기</a>
									<c:choose>
									<c:when test="${w.userNo eq loginUser.userNo }">
								&ensp;<a href="update.wd?weddingNo=${w.weddingNo}" class="btn btn-primary btn-sm">신청수정</a>&ensp;
								&ensp;<button class="btn btn-secondary btn-sm cancelBtn">만남취소</button>
									<input type="hidden" value="${w.weddingNo}">
									</c:when>
									</c:choose>
								</td>
							</tr>
						</c:when>
						<c:when test="${w.approval =='R' }">
						<tr class="table-secondary"> 
						<td class="text-center">${w.petName }</td>
						<c:choose>
						<c:when test="${empty w.partnerName }">
						<td class="text-center">(해당 없음)</td>
						</c:when>
						<c:otherwise>
						<td class="text-center">${w.partnerName }</td>
						</c:otherwise>						
						</c:choose>
						<td class="text-center">만남거절&ensp;
						<a class="btn btn-secondary btn-sm" href="detail.wd?weddingNo=${w.weddingNo}">상세보기</a>
						 </td>
						</tr>
						</c:when>
						<c:when test="${w.approval =='Y' }">
						<tr class="table-primary"> 
						<td class="text-center">${w.petName }</td>
						<td class="text-center">(해당 없음)</td>
						<td class="text-center" style="color: blue;">관리자 승인 완료&ensp;
						<a class="btn btn-primary btn-sm" href="detail.wd?weddingNo=${w.weddingNo}">상세보기</a>
						 </td>
						</tr>
						</c:when>
						<c:otherwise>
						<tr class="table-secondary"> 
						<td class="text-center">${w.petName }</td>
						<td class="text-center">(해당 없음)</td>
						<td class="text-center">관리자 승인 대기중&ensp;
						<a class="btn btn-secondary btn-sm" href="detail.wd?weddingNo=${w.weddingNo}">상세보기</a>
						 </td>
						</tr>
						</c:otherwise>
					</c:choose>
				</c:forEach>
			</tbody>
		</table>
	</div>
    <script>
    $(function() {
		$(".cancelBtn").click(function() {
			if (confirm("정말 만남을 취소하시겠습니까?")) {
				var weddingNo = $(this).siblings(':eq(2)').val();
				$.ajax({
					url:"${pageContext.request.contextPath}/delete.wd",
					data: {weddingNo:weddingNo},
					success:function(result){
						if(result>0){
							alert("만남이 성공적으로 취소되었습니다(´ᴥ`)");
							location.href = "${pageContext.request.contextPath}/regList.wd?userNo=${loginUser.userNo}";
						}else{
							alert("만남 취소 실패ㅠㅅㅠ... 다시 시도해주세요!");
						}
					},error:function(){
						console.log("통신 실패");
					}
				});
			} else {
				return false;
			}
		});
		$(".cancelApplied").click(function () {
			if(confirm("이미 확정된 만남을 취소하시면 웨딩플래너 서비스가 14일간 제한됩니다. 그래도 취소하실건가요8ㅅ8?")){
				var weddingNo =$(this).siblings(':eq(0)').val();
  				$.ajax({
					url : "${pageContext.request.contextPath}/cancel.wd",
					type:"post",
					data:{
						weddingNo : weddingNo,
						userNo : ${loginUser.userNo}
					},
					success:function(response){
						alert(response.message);
						location.href = "${pageContext.request.contextPath}/";
					},
					error:function(){
						console.log("통신실패");
					}
				});
			}
		});
	});
    $(".contactBtn").click(function () {
    	var weddingNo = $(this).siblings(':eq(0)').val();
    	  $.ajax({
			url:"${pageContext.request.contextPath}/getContactInfo.wd",
			type:"post",
			data:{weddingNo:weddingNo},
			success: function (contactList) {
				var str = "";
				for (var i = 0; i < contactList.length; i++) {
					str+="<tr><td>"
						+contactList[i].name+"</td><td>"
						+contactList[i].phone+"</td><td>"
						+contactList[i].email+"</td></tr>";
				}
				$(".contactTable>tbody").html(str);
			},
			error:function(){
				console.log("통신실패");
			}
			
		}); 
    	  });
    </script>
</body>
</html>