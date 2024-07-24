<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>${wedding.petName }의 상세페이지입니다</title>
<style>
.form_area {
	margin: 100px;
}

#reg_form {
	margin: 100px;
}

input {
	border: none;
}

input[type=file] {
	display: none;
}

textarea {
	width: 70%;
	resize: none;
}

ul {
	list-style: none;
}

li {
	float: left;
}
#confirmBtn{
	display: none;
}
</style>
</head>
<body>
<%@ include file="/WEB-INF/views/common/header.jsp"%>
	<div class="form_area">
			<input type="hidden" name="kindNo" value="${wedding.weddingNo}">
			<input type="hidden" name="userNo" value="${wedding.userNo }">
			<ul>
				<li>
					<div class="container mt-3" id="reg_upFile">
						<div class="card img-fluid" style="width: 500px">
							<img class="card-img-top"
								src="/pjtMungHub/${wedding.changeName}" alt=""
								style="width: 100%">
							<div class="card-img-overlay"></div>
						</div>
					</div>
				</li>
				<li>
					<div class="input_area">
						<table class="table table-hover" id="reg_form">
							<thead>
								<tr>
									<th>이름</th>
									<td><input type="text" value="${wedding.petName }" readonly>

								</tr>
							</thead>
							<tbody>
								<tr>
									<th>견종</th>
									<td><input type="text" name="breed" value="${wedding.breed }"
										readonly></td>
								</tr>
								<tr>
									<th>나이</th>
									<td><input type="text" name="petAge"
										value="${wedding.petAge }" readonly></td>
								</tr>
								<tr>
									<th>성별</th>
									<td><c:choose>
											<c:when test="${wedding.gender eq 'F' }">
                                    공주님
                                </c:when>
											<c:otherwise>
                                    왕자님
                                </c:otherwise>
										</c:choose></td>
								</tr>
								<tr>
									<th>몸무게</th>
									<td>${wedding.weight }</td>
								</tr>
 								<tr>
									<th>만남방식</th>
									<td><input type="text" name="meetingMethod"
										value="${wedding.meetingMethod }"></td>
								</tr>
								<tr>
									<th>소개</th>
									<td>${wedding.petIntro }</td>
								</tr>
								<tr>
									<th>특이사항</th>
									<td>${wedding.petNote }</td>
								</tr>
 								<c:choose>
									<c:when test="${wedding.approval eq 'N' }">
										<tr>
											<th>관리자 승인여부</th>
											<td>관리자 승인대기중</td>
										</tr>
									</c:when>
									<c:when test="${wedding.approval eq 'R' }">
										<tr>
											<th>수락여부</th>
											<td>신청이 거절(또는 취소)되었습니다...</td>
										</tr>
										<tr> 
											<th>거절 사유</th>
											<c:if test="${wedding.reason == null }">
											<td>상대방 견주의 개인 사정으로 만남이 취소되었습니다...૮ ㅜﻌㅜა</td>
											</c:if>
											<td>${wedding.reason}</td>
										</tr>
									</c:when>
									<c:when test="${wedding.approval eq 'Y' }">
										<tr>
											<th>관리자 승인여부</th>
											<td>신청이 승인되었습니다^-^! ${wedding.petName }가 좋은 짝을 만나기를 바랍니다!</td>
										</tr>
									</c:when>
									<c:when test="${wedding.approval eq 'W'}">
										<tr>
											<th>수락여부</th>
											<td>대기중</td>
										</tr>
									</c:when>
									<c:otherwise>
										<tr>
											<th>수락여부</th>
											<td>상대방이 수락했습니다૮₍⑅˶•▿•˶⑅₎ა <br>
											${wedding.petName }(이)가 행복한 만남이 되길 바랄게요 ♡(ᐢ ᴥ ᐢし)
											</td>
										</tr>
									</c:otherwise>
								</c:choose>
								<tr> 
								<td> </td>
								<td class="text-end"> 
								<br> <br> <br> <br> <br> <br>
										<c:choose>
										<c:when test="${loginUser.userId ne 'admin' }">
										<a type="button" class="btn btn-warning" href="regList.wd?userNo=${loginUser.userNo }">목록으로</a>
										</c:when>
										<c:otherwise>
										<a type="button" class="btn btn-warning" href="admin.wd">목록으로</a>
										</c:otherwise>
										</c:choose>
										<c:choose>
										<c:when test="${wedding.approval eq 'N' && loginUser.userNo eq wedding.userNo }">
										<a type="button" class="btn btn-outline-info" href="update.wd?weddingNo=${wedding.weddingNo }">신청수정</a>
										<button type="button" class="btn btn-secondary" id="cancelBtn">신청철회</button>
										</c:when>
										<c:when test="${wedding.approval eq 'W' && loginUser.userNo ne wedding.userNo }">
										<button type="button" class="btn btn-primary" id="acceptBtn">만남수락</button>
										<button type="button" id="confirmBtn" data-bs-toggle="modal" data-bs-target="#confirmModal"></button>
										<button type="button" class="btn btn-secondary" data-bs-toggle="modal" data-bs-target="#rejectModal">
										만남거절
										</button>
										</c:when>
										<c:when test="${loginUser.userId eq 'admin' && wedding.approval eq 'N' }">
										<button class="btn btn-primary" id="approveBtn">신청승인</button>
										<button type="button" class="btn btn-secondary" data-bs-toggle="modal" data-bs-target="#rejectModal">
										신청거절
										</button>
										</c:when>
										</c:choose>
								
								</td>
								</tr>
							</tbody>
						</table>
					</div>
				</li>
			</ul>
	</div>
	<!-- The Modal -->
<div class="modal fade" id="rejectModal">
  <div class="modal-dialog">
    <div class="modal-content">

      <!-- Modal Header -->
      <div class="modal-header">
        <h4 class="modal-title">신청 거절을 선택하셨습니다...</h4>
        <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
      </div>
		
      <!-- Modal body -->
        <form action="reject.wd" method="post">
      <div class="modal-body">
      	<input type="hidden" name="weddingNo" value="${wedding.weddingNo}">
        <textarea rows="4" cols="50" name="reason" placeholder="견주님 마음 상하지 않게 거절 이유를 친절하게 적어주세요." required></textarea>
      </div>

      <!-- Modal footer -->
      <div class="modal-footer">
        <button type="submit" class="btn btn-danger">신청 거절하기</button>
        <button class="btn btn-secondary" data-bs-dismiss="modal">창 닫기</button>
      </div>
        </form>

    </div>
  </div>
</div>
	<!-- The Modal -->
<div class="modal fade" id="confirmModal">
  <div class="modal-dialog">
    <div class="modal-content">

      <!-- Modal Header -->
      <div class="modal-header">
        <h4 class="modal-title">회원인증</h4>
        <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
      </div>
		
      <!-- Modal body -->
      <div class="modal-body">
        <p>만남을 수락하시면 회원님의 연락처가 상대방에게 전달됩니다.</p>
        <p>상대방에게 개인정보(회원님의 성함,전화번호,이메일) 제공을 </p>
        <p>동의하신다면 비밀번호를 입력해주세요.</p>
      <div class="input-group mb-3">
      	<span class="input-group-text">비밀번호</span>
 		 <input type="password" class="form-control" id="checkPwd">
      </div>
      </div>

      <!-- Modal footer -->
      <div class="modal-footer">
        <button type="button" class="btn btn-primary" id="certBtn">만남 수락하기</button>
        <button class="btn btn-secondary" data-bs-dismiss="modal">창 닫기</button>
      </div>

    </div>
  </div>
</div>
<script>
$("#approveBtn").click(function() {
	var flag = confirm("정말 승인하시겠습니까?");
	if(flag){
		location.href="approve.wd?weddingNo=${wedding.weddingNo}";
	}
});
$("#acceptBtn").click(function () {
	var yn = confirm("정말 수락하시겠습니까?");
	if(yn){
		$("#confirmBtn").click();
	}
});
$("#certBtn").click(function () {
	var checkPwd = $("#checkPwd").val();
	$.ajax({
		url:"${pageContext.request.contextPath}/confirm.wd",
		type:"post",
		data:{userPwd:checkPwd},
		success:function(checkPwd){
			if(checkPwd){
			location.href="accept.wd?weddingNo=${wedding.weddingNo}";
			}else{
				alert("비밀번호가 틀렸습니다. 다시 입력해주세요.");
			}
		},
		error: function () {
			console.log("통신실패");
		}
	});
});
$(function(){
	var reason = $("textarea[name=inputNAME]");
	console.log(reason);
});
</script>
		
</body>
</html>