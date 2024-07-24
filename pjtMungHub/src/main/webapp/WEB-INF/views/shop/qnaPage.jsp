<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style>
    .qa-section {
      display: flex;
      flex-direction: column;
      justify-content: space-between;
      border: 1px solid #dee2e6;
      border-radius: 10px;
      padding: 20px;
      background: #f8f9fa;
      margin-bottom: 20px;
    }
    .question, .answer {
      flex: 1;
      padding: 20px;
      border-radius: 10px;
      margin: 10px 0;
    }
    
     small{
      color: gray;
    }
    
    .question {
      background: #e9ecef;
      text-align: left;
    }
    .answer {
      background: #e2e3ff;
      text-align: right;
    }
  </style>
</head>
<body>
	<%@include file="../common/header.jsp" %>
	
  <div class="container">
    <h1 class="my-4">상품 Q&A [${q.categoryName }]</h1>

    <div class="qa-section">
      <div class="question">
        <h5>${q.userName }님의 질문</h5>
        <small>${q.createDate }</small>
        <p>${q.content }</p>
      </div>

      <div class="answer">
        <h5>답변</h5>
        <small>${a.createDate }</small>
        <c:choose>
        <c:when test="${empty a }">
        <p>답변 대기중입니다. 신속하게 확인하고 성실히 응답하겠습니다.</p>
        </c:when>
        <c:otherwise>
        <p>${a.content }</p>
        </c:otherwise>
        </c:choose>
      </div>
    </div>
  </div>

</body>
</html>