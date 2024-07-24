<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>${pet.petName }의${registration.visitDate}날 등록상담 수정 페이지</title>
<style>
#reg_form {
	margin: 50px;
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

		<form method="post" action="updateReg.do" enctype="multipart/form-data">
			<input type="hidden" name="kindNo" value="${registration.kindNo}">
			<input type="hidden" name="reservNo" value="${registration.reservNo }">
			<input type="hidden" name="userNo" value="${loginUser.userNo }">
			<ul>
				<li>
					<div class="container mt-3" id="reg_upFile">
						<div class="card img-fluid" style="width: 500px">
							<img class="card-img-top" src="" alt="" style="width: 100%">
							<div class="card-img-overlay">

								<p class="card-text">강아지 사진을 올려주세요!</p>
								<input type="file" name="reupFile" id="upFile" onchange="loadImg(this,1);" required></input> <label
									for="upFile"><img
									src="/pjtMungHub/${registration.changeName}"
									alt="" style="width: 500px"></label>

							</div>
						</div>
					</div>
				</li>
				<li>
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
								<td><input type="text" name="petAge" value="${pet.petAge }"
									readonly></td>
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
								<td><input type="date" name="visitDate" value="${registration.visitDate}"></td>
							</tr>
							<tr>
								<th>소개</th>
								<td><textarea rows="4" cols="50" name="petIntro">${registration.petIntro }</textarea></td>
							</tr>
							<tr>
								<th>특이사항</th>
								<td><textarea rows="4" cols="50" name="petNote">${registration.petNote }</textarea></td>
							</tr>
							<tr>
								<td></td>
								<td style="text-align: center;">
									<a href="regList.do?userNo=${loginUser.userNo }" class="btn btn-outline-primary">목록으로</a>
									<button type="submit" class="btn btn-outline-success">수정하기</button>
								</td>
							</tr>
						</tbody>

					</table>
				</li>
			</ul>
		</form>
	</div>
	<script>
function loadImg(inputFile,num) {
	if(inputFile.files.length==1){
		var reader = new FileReader();
		reader.readAsDataURL(inputFile.files[0]);
		reader.onload = function (e) {
			switch (num) {
			case 1:
				$("label>img").attr("src",e.target.result);
				break;
			}
		}
	}else{
		switch (num) {
		case 1:
			$("label>img").attr("src","/pjtMungHub/resources/uploadFiles/kindergarten/css/dogPhotoIcon.png");
			break;
		}
	}
}
	</script>
</body>
</html>