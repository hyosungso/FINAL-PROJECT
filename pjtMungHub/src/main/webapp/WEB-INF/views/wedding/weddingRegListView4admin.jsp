<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>웨딩플래너 서비스 신청한 댕댕이 리스트입니다</title>
</head>
<body>
<%@ include file="/WEB-INF/views/common/header.jsp"%>
	<div class="container mt-3">
		<table class="table">
			<thead>
				<tr>
					<th>신청 견주명</th>
					<th>강아지 이름</th>
					<th>강아지 견종</th>
					<th>선택한 만남 방식</th>
					<th>승인 여부</th>
				</tr>
			</thead>
			<tbody>
				<!-- 승인 된 예약은 초록색 행으로 출력 -->
				<c:forEach items="${weddingList}" var="w">
					<c:choose>
						<c:when test="${w.approval == 'Y' }">
							<tr class="table-success">
								<td class="kindName">${w.userName }</td>
								<td>${w.petName}</td>
								<td>${w.breed}</td>
								<td>(해당없음)</td>
								<td style="color: blue;">관리자승인
								<a class="btn btn-primary" href="detail.wd?weddingNo=${w.weddingNo}">상세보기</a>
								</td>
							</tr>
						</c:when>
						<c:when test="${w.approval == 'N' }">
						<tr class="table-warning">
								<td class="userName">${w.userName }</td>
								<td>${w.petName}</td>
								<td>${w.breed}</td>
								<td>(해당없음)</td>
								<td>관리자 승인 대기중
									<a class="btn btn-primary" href="detail.wd?weddingNo=${w.weddingNo}">상세보기</a>
								</td>
							</tr>
						</c:when>
						<c:when test="${w.approval == 'W' }">
							<!-- 대기중인 예약은 노랑 행으로 출력 -->
							<tr class="table-warning">
								<td class="userName">${w.userName }</td>
								<td>${w.petName}</td>
								<td>${w.breed}</td>
								<td>${w.meetingMethod }</td>
								<td>대기중
									<a class="btn btn-primary" href="detail.wd?weddingNo=${w.weddingNo}">상세보기</a>
								</td>
							</tr>
						</c:when>
						<c:when test="${w.approval == 'A' }">
						<tr class="table-success">
								<td class="userName">${w.userName }</td>
								<td>${w.petName}</td>
								<td>${w.breed}</td>
								<td>${w.meetingMethod }</td>
								<td style="color: blue;">매칭수락
									<a class="btn btn-primary" href="detail.wd?weddingNo=${w.weddingNo}">상세보기</a>
								</td>
							</tr>
						</c:when>
						<c:otherwise>
							<!-- 거절된 예약은 회색 행으로 출력 -->
							<tr class="table-secondary">
								<td class="userName">${w.userName }</td>
								<td>${w.petName}</td>
								<td>${w.breed}</td>
								<td>${w.meetingMethod }</td>
								<td>매칭거절
								<a class="btn btn-primary" href="detail.wd?weddingNo=${w.weddingNo}">상세보기</a>
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