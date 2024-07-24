<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style>
 .footer {
            background-color: #40A578;
            padding: 20px 0;
            margin-top: 20px;
        }

        .footer .footer-grid {
            display: flex;
            justify-content: space-around;
            align-items: center;
        }

        .footer .footer-grid div {
            text-align: center;
            width: 150px;
        }

        .footer .footer-grid img {
            width: 100%;
            height: 150px;
            object-fit: cover;
            margin-bottom: 10px;
        }

        .footer .footer-grid p {
            margin: 0;
            font-size: 0.9em;
            color: white;
        }
</style>
</head>
<body>
	<footer class="footer">
		<div class="container">
			<div class="footer-grid">
				<div>
					<img src="${pageContext.request.contextPath}/resources/uploadFiles/common/css/shy.png" alt="유상혁">
					<p>회원/채팅 담당</p>
					<p>유상혁</p>
				</div>
				<div>
					<img src="${pageContext.request.contextPath}/resources/uploadFiles/common/css/hss.png" alt="소효성">
					<p>쇼핑몰 담당</p>
					<p>소효성</p>
				</div>
				<div>
					<img src="${pageContext.request.contextPath}/resources/uploadFiles/common/css/jsh.jpg" alt="황지수">
					<p>지도/웨딩플래너 담당</p>
					<p>황지수(팀장)</p>
				</div>
				<div>
					<img src="${pageContext.request.contextPath}/resources/uploadFiles/common/css/chk.png" alt="김창현">
					<p>돌봄,동물병원 담당</p>
					<p>김창현</p>
				</div>
				<div>
					<img src="${pageContext.request.contextPath}/resources/uploadFiles/common/css/kmk.jpg" alt="김광민">
					<p>견주 게시판 담당</p>
					<p>김광민</p>
				</div>
			</div>
		</div>
	</footer>
</body>
</html>