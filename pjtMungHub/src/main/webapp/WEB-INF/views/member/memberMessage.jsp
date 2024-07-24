<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>  
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style>
	thead th{
		width:100px;
		height:60px;
	}
	thead .list-cont{
		width:300px;
	}
	.msg-list tbody>tr:hover{
		background-color:lightgray;
	}
</style>
</head>
<body>
	<%@include file="/WEB-INF/views/common/header.jsp" %>
	<div class="totalArea">
	<div class="mypage-left">
		<%@include file="/WEB-INF/views/member/memberSideBar.jsp" %>
	</div>
	<div class="mypage-main">
		<div class="msg-main">
			<div class="msg-content" hidden="true">
				<h3>메시지 내용</h3>
				<input type="hidden" id="readMessageNo">
				<label for="">작성자 : </label> <input type="text" id="readSender" readonly>
				<label for="msgDate">작성일자 : </label> <input type="date" id="readMessageDate" readonly>	<br>
				<label for="messageContent">내용 : </label><br>
				<textarea rows="12" cols="60" id="readMessageContent" style="resize:none;" readonly></textarea>
			</div>
			<div class="sendMsg-button" align="right">
				<button type="button" data-bs-toggle="modal" data-bs-target="#msgModal">메시지 작성</button>
			</div>
			<div class="list-area">
				<h4>받은 메시지 목록</h4>
				<span class="">${pi.currentPage} 페이지</span>
				<br><br>
				<c:if test="${not empty msgList}">
					<table class="msg-list">
						<thead>
							<tr>
								<th class="list-writer">작성자</th>
								<th class="list-date">작성일</th>
								<th class="list-cont">내용</th>
								<th class="list-del">관리</th>
							</tr>
						</thead>
						<tbody>
							<c:forEach items="${msgList}" var="msg">
								<tr>
									<td hidden="true"><input type="hidden" name="messageNo" value="${msg.messageNo}"></td>
									<td>${msg.sender}</td>
									<td class="msgDate">${msg.messageDate}</td>
									<c:if test="${fn:length(msg.messageContent) gt 15}">
										<td hidden="true">${msg.messageContent}</td>
										<td class="msgCont">${fn:substring(msg.messageContent,0,15)}...</td>
									</c:if>
									<c:if test="${fn:length(msg.messageContent) le 15 }">
										<td class="msgCont">${msg.messageContent}</td>
									</c:if>
									<td><button onclick="deleteMsg(${msg.messageNo});">삭제</button></td>
								</tr>
							</c:forEach>
						</tbody>
					</table>
					<nav aria-label="Page navigation example" style="text-align: center;">
				        <ul class="pagination justify-content-center">
				        	<c:if test="${pi.currentPage gt 5}">
					            <li class="page-item">
					                <button aria-label="Previous" onclick="prev();">
					                    <span aria-hidden="true">&laquo;</span>
					                    <span class="sr-only" >Previous</span>
					                </button>
					            </li>
				        	</c:if>
				        <c:forEach var="i" begin="${pi.startPage}" end="${pi.endPage}">
				           	<li class="page-item">
				           		<button class="page-link">${i}</button>
				         	</li>
				        </c:forEach>
							<c:if test="${pi.currentPage lt pi.maxPage}">
				           		<li class="page-item">
					                <button aria-label="Next" onclick="next();">
					                    <span aria-hidden="true">&raquo;</span>
					                    <span class="sr-only">Next</span>
					                </button>
					            </li>
				            </c:if>
				        </ul>
				    </nav>
				</c:if>
				<c:if test="${empty msgList}">
					확인할 메시지가 없습니다.
				</c:if>
			</div>
		</div>
	</div>
	</div>
	<script>
		$(".msg-list tbody").on("click",".msgCont",function(){
			var msgNo=$(this).siblings().eq(0).children().val();
			var msgSender=$(this).siblings().eq(1).text();
			var msgDate=$(this).siblings().eq(2).text();
			var msgCont=$(this).siblings().eq(3).text();
			$.ajax({
				url:"checkMsg.me",
				data:{
					messageNo:msgNo
				},
				success:function(result){
					if(result>0){						
						console.log("확인");
					}
				},
				error:function(){
					console.log("오류");
				}
			})
			$("#readMessageNo").text(msgNo);
			$("#readSender").val(msgSender);
			$("#readMessageDate").val(msgDate);
			$("#readMessageContent").text(msgCont);
			if($(".msg-content").attr("hidden")){
				$(".msg-content").attr("hidden",false);
			}else{
				$(".msg-content").attr("hidden",true);				
			}
		})			

		function deleteMsg(messageNo){
			var msgNo=messageNo;
			location.href='deleteMsg.bo?messageNo='+msgNo;
		}
		
		$(".page-link").on("click",function(){
			var pageNo=$(this).text();
			
		})

	</script>
	<div class="modal fade" id="msgModal">
		<div class="modal-dialog">
			<div class="modal-content">
				<!-- Modal Header -->
				<div class="modal-header" align="right">
					<h4 class="modal-title" align="center">메시지 전송</h4><br>
					<button type="button"  class="close" data-bs-dismiss="modal">&times;</button>
				</div>		
				<form action="sendMsg.me" method="post">
				<!-- Modal body -->
					<div class="modal-body">
						<div class="msg-main">
							<label for="receiver" >수신인 : </label>
							<input type="text" name="receiver" required> <button onclick="searchUser(); return false;">검색</button>
							<input type="hidden" name="sender" value="${loginUser.userNo}"><br>
							<label for="messageContent">내용 : </label><br>
							<textarea id="messageContent" name="messageContent" cols="40" rows="15" style="resize:none;" placeholder="내용을 작성해 주세요" required></textarea>
						</div>	
					</div>
					<!-- Modal footer -->
					<div class="modal-footer">
						<button type="submit" class="btn btn-danger">전송하기</button>
						<button type="button" class="btn btn-secondary" data-bs-dismiss="modal">취소</button>
					</div>
				</form>
			</div>
		</div>
	</div>
	<script>
		function searchUser(){
			var receiver=$("input[name=receiver]").val();
			$.ajax({
				url:"",
				data:{
					userId:receiver
				},
				success:function(){
					alert("메시지 전송 가능한 아이디입니다.");
				},
				error:function(){
					console.log("통신오류");
				}
			})
		}
	</script>
</body>
</html>