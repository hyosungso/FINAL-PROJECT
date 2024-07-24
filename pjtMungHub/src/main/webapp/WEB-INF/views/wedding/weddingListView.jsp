<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<style>
        .content {
            margin: 70px;
        }
        .card {
            margin: 20px;
        }
        img {
			width: 300px;
		}
</style>
<title>MUNGHUB 웨딩플래너 페이지입니다</title>
</head>
<body>
	<%@ include file="/WEB-INF/views/common/header.jsp"%>
<div class="content">
        <p>${loginUser.name }님의 강아지가 건강하고 행복한 모습으로 새 가족을 맞이할 수 있도록, MUNGHUB가 함께합니다.</p>
        <br>
        <select name="breed" id="breedList">
        	<option value="ALL">전체견종</option>
            <c:forEach var="b" items="${breedList}">
                <option value="${b.breedId}">${b.breedName}</option>
            </c:forEach>
        </select>
		<a href=""></a>
        <br><br>
        <c:choose>
        <c:when test="${loginUser.userId eq 'admin' }">
        <a href="admin.wd" class="btn btn-warning">서비스 신청한 강아지 조회하기</a>
        </c:when>
        <c:otherwise>
		<a href="insert.wd" class="btn btn-success">나의 강아지 등록하기</a>&ensp;
		<a href="regList.wd?userNo=${loginUser.userNo }" class="btn btn-warning">나의 신청내역 조회하기</a>
        </c:otherwise>
        </c:choose>
        <br><br>
        <c:choose>
        <c:when test="${empty weddingList }">
        <div class="row">
        <p class="text-center"> 
        아직 등록된 강아지가 없습니다 └(°ᴥ°)┓!<br>
        우리가 먼저 등록을 해볼까요 (ᐡ- ﻌ •ᐡ)♥?
        </p>
        </div>
        </c:when>
        </c:choose>
        <div class="row">
            <c:forEach items="${weddingList }" var="w">
                <div class="card" style="width:400px">
                    <img class="card-img-top" src="/pjtMungHub/${w.changeName }" alt="Card image" style="width:100%">
                    <div class="card-body text-center">
                        <h4 class="card-title">${w.petName}</h4>
                        <p class="card-text">${w.breed}</p>
                        <c:choose>
                            <c:when test="${w.gender == 'F'}">
                                <p>공주님 </p>
                            </c:when>
                            <c:otherwise>
                                <p>왕자님 </p>
                            </c:otherwise>
                        </c:choose>
                        <a href="info.wd?weddingNo=${w.weddingNo }" class="btn btn-primary">상세보기</a>
                    </div>
                </div>
        </c:forEach>
        </div>
    </div>
    <script>
    $("#breedList").change(function () {
		var breed = $(this).val();
		location.href="selectList.wd?breedId="+breed;
		
    });
    $(function () {
		$("#breedList").val("${breedId}").prop("selected",true);
    });
    </script>    
</body>
</html>