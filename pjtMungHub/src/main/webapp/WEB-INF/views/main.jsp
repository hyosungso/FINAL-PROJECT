<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Welcome to MungHub</title>
<style>
/* 이미지 그리드 스타일 */
		.image-grid {
            display: grid;
            grid-template-columns: repeat(3, 1fr);
            grid-gap: 20px;
            margin: 20px 0;
        }

        .image-grid div {
            position: relative;
            overflow: hidden;
        }

        .image-grid img {
            width: 100%;
            height: 100%;
            transition: transform 0.3s ease;
        }

        .image-grid div:hover img {
            transform: scale(1.1);
        }

        .overlay {
            position: absolute;
            bottom: 0;
            width: 100%;
            background-color: rgba(0, 0, 0, 0.7);
            color: white;
            padding: 10px 0;
            text-align: center;
            font-size: 1.2em;
            box-sizing: border-box;
            font-weight: bold;
            transform: translateY(100%);
            transition: transform 0.3s ease;
        }

        .image-grid div:hover .overlay {
            transform: translateY(0);
        }
</style>
</head>
<body>
	<%@include file="/WEB-INF/views/common/header.jsp"%>
	
	    <!-- 이미지 그리드 추가 -->
	<div class="image-grid">
		<div>
			<a href="map.do"> 
			<img src="${pageContext.request.contextPath}/resources/uploadFiles/common/css/D_101.jpg"
				alt="강아지유치원지도">
				<div class="overlay">강아지들이 신나게 뛰놀 유치원 찾아보기</div>
			</a>
		</div>
		<div>
			<a href="sitter.re"> 
			<img src="${pageContext.request.contextPath}/resources/uploadFiles/common/css/D_106.jpg"
				alt="단기돌봄예약">
				<div class="overlay">강아지를 잠깐 대신 돌봐줄 시터 알아보기</div>
			</a>
		</div>
		<div>
			<a href="houseList.re"> 
			<img src="${pageContext.request.contextPath}/resources/uploadFiles/common/css/D_102.jpg"
				alt="장기돌봄예약">
				<div class="overlay">강아지를 조금 오래 돌봐줄 시터 알아보기</div>
			</a>
		</div>
		<div>
			<a href="wedList.wd"> 
			<img src="${pageContext.request.contextPath}/resources/uploadFiles/common/css/D_103.jpg"
				alt="웨딩플래너">
				<div class="overlay">강아지에게 좋은 짝 찾아주기</div>
			</a>
		</div>
		<div>
			<a href="/pjtMungHub/list.bo"> 
			<img src="${pageContext.request.contextPath}/resources/uploadFiles/common/css/D_104.jpg"
				alt="게시판">
				<div class="overlay">다른 견주들과 소통할 공간</div>
			</a>
		</div>
		<div>
			<a href="/pjtMungHub/list.sp"> 
			<img src="${pageContext.request.contextPath}/resources/uploadFiles/common/css/D_105.jpg"
				alt="쇼핑몰">
				<div class="overlay">강아지에게 필요한 사료, 장난감 사러가기</div>
			</a>
		</div>
	</div>
	<%@include file="/WEB-INF/views/common/footer.jsp"%>
</body>
</html>