<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<title>Document</title>
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
<script
	src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
<style>
.content {
	background-color: rgb(247, 245, 245);
	width: 80%;
	margin: auto;
}

.innerOuter {
	border: 1px solid lightgray;
	width: 80%;
	margin: auto;
	padding: 5% 10%;
	background-color: white;
}

#boardList {
	text-align: center;
}

#boardList>tbody>tr:hover {
	cursor: pointer;
}

#pagingArea {
	width: fit-content;
	margin: auto;
}

#searchForm {
	width: 40%;
	margin: auto;
}

#searchForm>* {
	float: left;
	margin: 5px;
}

.select {
	width: 20%;
}

.text {
	width: 53%;
}

.searchBtn {
	width: 20%;
}

#category-area {
	list-style-type: none;
	margin: 0;
	padding: 0;
	overflow: hidden;
	background-color: #F4D3D3;
}

#category-area li {
	float: left;
}

#category-area li a {
	display: block;
	color: #492F10;
	margin: auto;
	text-align: center;
	padding: 14px 16px;
	text-decoration: none;
}

#category {
	display: block;
	color: #492F10;
	margin: auto;
}

button[name=category]:hover {
	background-color: lightblue;
	click-color: pink;
}

button[name=category] {
	margin: 10px;
}

input[name=sortBy] {
	margin: 10px;
}

.ctSelected {
	background-color: blue;
	color: white;
}
</style>
</head>
<body>


	<%@include file="../common/header.jsp"%>

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


			<c:if test="${not empty loginUser}">
				<a class="btn btn-secondary"
					style="float: right; background-color: yellow; color: black;"
					href="insert.bo">글쓰기</a>
			</c:if>

			<table id="boardList" class="table table-hover" align="center">
				<thead>
					<tr>
						<th>글번호</th>
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
								<td colspan='6'>조회된 게시글이 없습니다.</td>
							</tr>
						</c:when>
						<c:otherwise>
							<c:forEach items="${list}" var="b">
								<tr>
									<td>${b.boardNo}</td>
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
	
     	//글을 클릭했을때 해당 글을 상세보기 할 수 있는 함수 작성 
     	$(function(){
     		$("#boardList tbody>tr").click(function(){
     			//글번호 추출
     			var bno=$(this).children().first().text();
     			location.href="detail.bo?boardNo="+bno;
     		});
     	//카테고리 버튼을 클릭했을때 해당 카테고리 글들을 클래스에 추가
     		$("button[name=category]").each(function(){
     			if($(this).val()==${category}){
     				$(this).addClass("ctSelected");
     				
     			}
     		});
     	//radio버튼 클릭했을때 체크되어있는 sort 정렬
	     	$("input[name=sortBy]").each(function(){
				if($(this).val()=="${sort}"){
					$(this).attr("checked",true);
				}
			});
	     	$("button[name=category]").click(function(){
				var category=$(this).val();
				var sortBy=$("input[name=sortBy]:checked").val();
				location.href="list.bo?currentPage=1&category="+category+"&sort="+sortBy;
				});
	     	
	     	$("input[name=sortBy]").click(function(){
	     		var sortBy=$(this).val();
				var category=$(".ctSelected").val();
				location.href="list.bo?currentPage=1&category="+category+"&sort="+sortBy;
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
						href="list.bo?currentPage=${pi.currentPage-1}&sort=${sort}&category=${category}">이전</a></li>
				</c:otherwise>
			</c:choose>
			<c:forEach begin="${pi.startPage }" end="${pi.endPage }" varStatus="p">
				<li class="page-item">
				<a class="page-link" href="list.bo?currentPage=${p.count}&sort=${sort}&category=${category}">${p.count}</a>
				</li>
			</c:forEach>
			<c:choose>
				<c:when test="${pi.currentPage eq pi.maxPage }">
					<li class="page-item disabled"><a class="page-link" href="#">다음</a></li>
				</c:when>
				<c:otherwise>
					<li class="page-item"><a class="page-link"
						href="list.bo?currentPage=${pi.currentPage+1}&sort=${sort}&category=${category}">다음</a></li>
				</c:otherwise>
			</c:choose>

		</ul>
	</div>

	<br clear="both">
	
	<br> <br>
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