<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>${loginUser.name } 원장님의 상담 신청 내역입니다</title>
</head>
<body>
	<%@ include file="/WEB-INF/views/common/header.jsp"%>
	<div class="container mt-3">
		<table class="table">
			<thead>
				<tr>
					<th>상담 견주명</th>
					<th>강아지 이름</th>
					<th>강아지 견종</th>
					<th>상담 예약 날짜</th>
					<th>승인 여부</th>
				</tr>
			</thead>
			<tbody>
				<!-- 승인 된 예약은 초록색 행으로 출력 -->
				<c:forEach items="${regList}" var="r">
					<c:choose>
						<c:when test="${r.approval == 'Y' }">
							<tr class="table-success">
								<td class="kindName">${r.userName }</td>
								<td>${r.petName}</td>
								<td>${r.breed}</td>
								<td>${r.visitDate }</td>
								<td style="color: blue;">승인
								<a class="btn btn-primary" href="regDetail.do?reservNo=${r.reservNo}">상세보기</a>
								</td>
							</tr>
						</c:when>
						<c:when test="${r.approval == 'N' }">
							<!-- 대기중인 예약은 노랑 행으로 출력 -->
							<tr class="table-warning">
								<td class="userName">${r.userName }</td>
								<td>${r.petName}</td>
								<td>${r.breed}</td>
								<td>${r.visitDate }</td>
								<td>대기중
									<a class="btn btn-primary" href="regDetail.do?reservNo=${r.reservNo}">상세보기</a>
								</td>
							</tr>
						</c:when>
						<c:otherwise>
							<!-- 거절된 예약은 회색 행으로 출력 -->
							<tr class="table-secondary">
								<td class="userName">${r.userName }</td>
								<td>${r.petName}</td>
								<td>${r.breed}</td>
								<td>${r.visitDate }</td>
								<td>상담거절
								<a class="btn btn-primary" href="regDetail.do?reservNo=${r.reservNo}">상세보기</a>
								</td>
							</tr>
						</c:otherwise>
					</c:choose>
				</c:forEach>
			</tbody>
		</table>
	</div>
</body>
</html>



















