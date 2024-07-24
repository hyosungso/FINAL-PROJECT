<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style>
        body {
            font-family: Arial, sans-serif;
            margin: 20px;
        }
        .container {
            max-width: 600px;
            margin: 0 auto;
        }
        .form-group {
            margin-bottom: 15px;
        }
        .form-group label {
            display: block;
            margin-bottom: 5px;
        }
        .form-group input, .form-group textarea {
            width: 100%;
            padding: 8px;
            box-sizing: border-box;
        }
        .form-group input[type="file"] {
            padding: 3px;
        }
        button {
            padding: 10px 20px;
            background-color: #007BFF;
            color: white;
            border: none;
            cursor: pointer;
        }
        button:hover {
            background-color: #0056b3;
        }
    </style>
</head>
<body>
<%@include file="../common/header.jsp" %>
<div class="container">
    <h1>상품 상세 정보 입력</h1>
    <form method="post" action="/pjtMungHub/insertDetailInfo.sp" enctype="multipart/form-data">
        <input type="hidden" name="productNo" value="${productNo }">
        
        <div class="form-group">
            <label for="originContry">제조국/원산지</label>
            <input type="text" id="originContry" name="originContry" required>
        </div>
        <div class="form-group">
            <label for="manufacturer">제조사/수입자</label>
            <input type="text" id="manufacturer" name="manufacturer" required>
        </div>
        <div class="form-group">
            <label for="customer-service">소비자 상담 전화번호</label>
            <input type="text" id="phone" name="phone" required>
        </div>
        <div class="form-group">
            <label for="expiration-date">폐기일</label>
            <input type="text" id="expireDate" name="expireDate" required>
        </div>
        <div class="form-group">
            <label for="recommended-age">권장연령</label>
            <input type="text" id="recommendedAge" name="recommendedAge" required>
        </div>
        <div class="form-group">
            <label for="weight">중량</label>
            <input type="text" id="weight" name="weight" required>
        </div>
        <div class="form-group">
            <label for="ingredient">재료</label>
            <textarea id="ingredient" name="ingredient" required></textarea>
        </div>
        <div class="form-group">
            <label for="component">구성성분</label>
            <textarea id="component" name="component" required></textarea>
        </div>
        <div class="form-group">
            <label for="upfile">상품 사진 업로드</label>
            <input type="file" id="upfile" name="upfile" multiple required>
        </div>
        <button type="submit">제출</button>
    </form>
</div>

</body>
</html>