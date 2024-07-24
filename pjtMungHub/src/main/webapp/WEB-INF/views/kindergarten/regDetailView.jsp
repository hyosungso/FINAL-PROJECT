<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>${pet.petName }의${registration.visitDate}날등록상담</title>
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
</style>
</head>
<body>
	<%@ include file="/WEB-INF/views/common/header.jsp"%>
	<div class="form_area">
			<input type="hidden" name="kindNo" value="${kindergarten.kindNo}">
			<input type="hidden" name="userNo" value="${loginUser.userNo }">
			<ul>
				<li>
					<div class="container mt-3" id="reg_upFile">
						<div class="card img-fluid" style="width: 500px">
							<img class="card-img-top"
								src="/pjtMungHub/${registration.changeName}" alt=""
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
									<td><input type="text" value="${pet.petName }" readonly>
										<input type="hidden" name="petNo" value="${pet.petNo}"></td>

								</tr>
							</thead>
							<tbody>
								<tr>
									<th>견종</th>
									<td><input type="text" name="breed" value="${pet.breed }"
										readonly></td>
								</tr>
								<tr>
									<th>나이</th>
									<td><input type="text" name="petAge"
										value="${pet.petAge }" readonly></td>
								</tr>
								<tr>
									<th>성별</th>
									<td><c:choose>
											<c:when test="${pet.petGender eq 'F' }">
                                    공주님
                                </c:when>
											<c:otherwise>
                                    왕자님
                                </c:otherwise>
										</c:choose></td>
								</tr>
								<tr>
									<th>몸무게</th>
									<td>${pet.weight }</td>
								</tr>
								<tr>
									<th>방문희망일</th>
									<td><input type="date" name="visitDate"
										value="${registration.visitDate }"></td>
								</tr>
								<tr>
									<th>소개</th>
									<td>${registration.petIntro }</td>
								</tr>
								<tr>
									<th>특이사항</th>
									<td>${registration.petNote }</td>
								</tr>
								<c:choose>
									<c:when test="${registration.approval eq 'N' }">
										<tr>
											<th>승인여부</th>
											<td>승인대기중</td>
										</tr>
									</c:when>
									<c:when test="${registration.approval eq 'R' }">
										<tr>
											<th>승인여부</th>
											<td>상담이 거절되었습니다...</td>
										</tr>
										<tr> 
											<th>거절 사유</th>
											<td>${registration.reason}</td>
										</tr>
									</c:when>
									<c:otherwise>
										<tr>
											<th>승인여부</th>
											<td>승인완료! 상담일날 뵈어요^^</td>
										</tr>
									</c:otherwise>
								</c:choose>
								<tr>
									<td></td>
									<td style="text-align: center;"><br> <br> <br>
										<br> <br> <br>
										<c:choose>
										<c:when test="${loginUser.userGrade eq 2 }">
										<a type="button" class="btn btn-warning" href="regList2.do">목록으로</a>
										</c:when>
										<c:otherwise>
										<a type="button" class="btn btn-warning" href="regList.do">목록으로</a>
										</c:otherwise>
										</c:choose>
										<c:choose>
										<c:when test="${registration.approval eq 'N' && loginUser.userNo eq registration.userNo }">
										<a type="button" class="btn btn-outline-info" href="updateReg.do?reservNo=${registration.reservNo }">신청수정</a>
										<button type="button" class="btn btn-secondary" id="cancelBtn">신청서철회</button>
										</c:when>
										<c:when test="${loginUser.userNo eq kindergarten.directorId && registration.approval eq 'N' }">
										<button class="btn btn-primary" id="approveBtn">상담 승인</button>
  
  <button type="button" class="btn btn-secondary" data-bs-toggle="modal" data-bs-target="#myModal">
    상담 거절
  </button>

<!-- The Modal -->
<div class="modal fade" id="myModal">
  <div class="modal-dialog">
    <div class="modal-content">

      <!-- Modal Header -->
      <div class="modal-header">
        <h4 class="modal-title">상담 거절을 선택하셨습니다...</h4>
        <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
      </div>
		
      <!-- Modal body -->
        <form action="reject.do" method="post">
      <div class="modal-body">
      	<input type="hidden" name="reservNo" value="${registration.reservNo}">
        <textarea rows="4" cols="50" name="reason" placeholder="견주님 마음 상하지 않게 거절 이유를 친절하게 적어주세요." required></textarea>
      </div>

      <!-- Modal footer -->
      <div class="modal-footer">
        <button type="submit" class="btn btn-danger">상담 거절하기</button>
        <button class="btn btn-secondary" data-bs-dismiss="modal">창 닫기</button>
      </div>
        </form>

    </div>
  </div>
</div>
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
	<script>
	$(function () {
		$("#approveBtn").click(function() {
			var formObj = $("<form>");
			var inputObj = $("<input>");
			formObj.prop("action","approve.do").prop("method","post");
			inputObj.prop("type","hidden").prop("name","reservNo").prop("value","${registration.reservNo}");
			var obj = formObj.append(inputObj);
			$("body").append(obj);
			obj.submit();
		});
		
		$("#cancelBtn").click(function() {
			if (confirm("정말 상담을 취소하시겠습니까?")) {
				var reservNo = ${registration.reservNo};
				location.href="deleteReg.do?reservNo="+reservNo;
			} else {
				return false;
			}
		});
	});
	</script>
</body>
</html>