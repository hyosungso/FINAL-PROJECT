<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<div class="innerOuter" style="padding: 5% 10%;">
		<!-- 로그인 후 상태일 경우만 보여지는 글쓰기 버튼 -->
		<div class="content">
			<table id="category-area">
				<tr>
					<td>
						<button name="category" value="0">전체</button>
					</td>
					<c:forEach items="${ctList}" var="ct">
						<td><button name="category" value="${ct.categoryNo}">${ct.categoryName}</button></td>
					</c:forEach>
				</tr>
			</table>
			<table id="sort-list">
				<tr>
					<td><input type="radio" name="sortBy" id="latest" value="latest"><label for="latest">최신순</label></td>
					<td><input type="radio" name="sortBy" id="view" value="view"><label for="view">조회순</label></td>
					<td><input type="radio" name="sortBy" id="recommend" value="recommend"><label for="recommend">추천순</label></td>
				</tr>
			</table>

		<table id="boardList" class="table table-hover" align="center">
				<thead>
					<tr>
						<th>글번호</th>
						<th>카테고리</th>
						<th>제목</th>
						<th>작성자</th>
						<th>추천수</th>
						<th>조회수</th>
						<th>업로드날짜</th>
					</tr>
				</thead>
				<tbody>
					<c:choose>
						<c:when test="${empty list}">
							<tr>
								<th colspan='6'>
							</tr>
							<tr>
								<td colspan='6'>${keyword}에 조회된 게시글이 없습니다.</td>
							</tr>
						</c:when>
						<c:otherwise>
							<c:forEach items="${list}" var="b">
								<tr>
									<td>${b.boardNo}</td>
									<td>${b.category}</td>
									<td>${b.boardTitle}</td>
									<td>${b.boardWriter}</td>
									<td>${b.recommend}</td>
									<td>${b.count}</td>
									<td>${b.uploadDate}</td>
								</tr>
							</c:forEach>
						</c:otherwise>
					</c:choose>
				</tbody>
			</table>
		</div>
	</div>
	
	
		<script>
		$(function(){
     		$("#boardList tbody>tr").click(function(){
     			//글번호 추출
     			var bno=$(this).children().first().text();
     			location.href="detail.bo?boardNo="+bno;
     		});
			});
		</script>
		
		<div id="pagingArea">
		<ul class="pagination">
			<c:choose>
				<c:when test="${pi.currentPage eq 1 }">
					<li class="page-item disabled"><a class="page-link" href="#">이전</a></li>
				</c:when>
				<c:otherwise>
					<li class="page-item"><a class="page-link"
						href="list.bo?currentPage=${pi.currentPage-1}&sort=${sort}&category=${category}&keyword=${keyword}">이전</a></li>
				</c:otherwise>
			</c:choose>
			<c:forEach begin="${pi.startPage }" end="${pi.endPage }" varStatus="p">
				<li class="page-item">
				<a class="page-link" href="list.bo?currentPage=${p.count}&sort=${sort}&category=${category}&keyword=${keyword}">${p.count}</a>
				</li>
			</c:forEach>
			<c:choose>
				<c:when test="${pi.currentPage eq pi.maxPage }">
					<li class="page-item disabled"><a class="page-link" href="#">다음</a></li>
				</c:when>
				<c:otherwise>
					<li class="page-item"><a class="page-link"
						href="list.bo?currentPage=${pi.currentPage+1}&sort=${sort}&category=${category}&keyword=${keyword}">다음</a></li>
				</c:otherwise>
			</c:choose>

		</ul>
	</div>
		<br clear="both">
	<form id="searchForm" action="search.bo" method="get" align="center">
		<div class="select">
			<select class="custom-select" name="condition">
				<option value="writer">아이디</option>
				<option value="title">제목</option>
				<option value="content">내용</option>
			</select>
		</div>
		<div class="text">
			<input type="text" class="form-control" name="keyword">
		</div>
		<button type="submit" class="searchBtn btn btn-secondary">검색</button>
	</form>
	<br> <br>
</body>
</html>