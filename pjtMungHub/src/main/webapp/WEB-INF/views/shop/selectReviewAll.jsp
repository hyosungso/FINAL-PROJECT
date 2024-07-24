<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style type="text/css">

.progress {
	width: 80%;
	float: right;
}

.score {
	width: 20%;
	display: block;
	float: left;
}
.star-rating {
      display: flex;
    }

    .star {
      appearance: none;
      padding: 1px;
    }

    .star::after {
      content: '☆';
      color: #F2D106;
      font-size: 30px;
    }

    .star:hover::after,
    .star:has(~ .star:hover)::after,
    .star:checked::after,
    .star:has(~ .star:checked)::after {
      content: '★';
    }

    .star:hover ~ .star::after {
      content: '☆';
    }
.review-star {width:100px; }
.review-star,.review-star span {display:inline-block; height:24px; overflow:hidden; background:url(/pjtMungHub/resources/uploadFiles/shopFile/productFile/common/star.png)no-repeat; }
.review-star span{background-position:left bottom; line-height:0; vertical-align:top; }
</style>
</head>
<body>

	<%@include file="../common/header.jsp" %>
					
				<script>
				function selectReplyList(num){
					$.ajax({
						url : "/pjtMungHub/reviewReplyList.sp",
						data : { reviewNo : num},
						success : function(result){
							var str="";
							if(result!=null){
								for (var i=0; i<result.length; i++) {
									str+="<div class='reviewReply row'>"
										+"<div class='col-10'>"
										+"<div><small style='color:gray'>"+result[i].userName+" "+result[i].createDate+"</small></div>"
										+"<div>"+result[i].replyContent+"</div>"
										+"</div>";
										if(result[i].userNo=="${loginUser.userNo}"){
											
										str+="<div class='col-1'>"
										+"<button style='background-color:transparent;border:0px;'"
										+"onclick='deleteReply("+result[i].replyNo+","+result[i].reviewNo+")'>"
										+"<i class='bi bi-x-lg'></i></button>";
										}
										str+="</div>"
										+"</div>";
									}
								$("#reviewReply"+num).html(str);
								
							}
						},
						error : function(){
							console.log("통신오류");	
						}
						
					});
				}</script>
				<c:if test="${not empty loginUser }">
				<script>
				
				
				
				
				function deleteReply(replyNo,reviewNo){
					$.ajax({
						url : "/pjtMungHub/deleteReply.sp",
						type : "post",
						data : {replyNo : replyNo},
						success : function(result){
							selectReplyList(reviewNo);
						},error : function(){
							console.log("통신오류");
						}
						
					});
				}
				
				
				function insertReply(num){
					
					var replyContent = $("#replyContent"+num).val();
					$.ajax({
						url : "/pjtMungHub/insertReviewReply.sp",
						type : "post",
						data : { reviewNo : num,
								 userNo : ${loginUser.userNo},
								 replyContent : replyContent },
						success : function(result){
							$("#replyContent"+num).val("");
							selectReplyList(num);
							buttonChange();
							
						},error : function(){
							console.log("통신오류");
						}
					
						
					});
					
				}
				
				function like(num){
					$.ajax({
						url : "/pjtMungHub/reviewLike.sp",
						type : "post",
						data : {userNo : ${loginUser.userNo},
								reviewNo : num},
						success : function(result){
							console.log(result);
							$("#likeCount"+num).text(result);
							$("#likeCountB"+num).text(result);
							selectReview();
							
							},error : function(){
							console.log("통신오류");
						}
					});
				}
				
				function likeModal(num){
					$.ajax({
						url : "/pjtMungHub/reviewLike.sp",
						type : "post",
						data : {userNo : ${loginUser.userNo},
								reviewNo : num},
						success : function(result){
							console.log(result);
							$("#likeCountT"+num).text(result);
							$("#likeCount"+num).text(result);
							$("#likeCountB"+num).text(result);
							$("#likeCountTmodal"+num).text(result);
							
							},error : function(){
							console.log("통신오류");
						}
					});
				}
				
				
				
				</script>
			</c:if>
			
			<c:if test="${empty loginUser }">
			<script>
			function like(num){
				alert("로그인 이후에 이용해주세요.");
			}
			function insertReply(num){
				alert("로그인 이후에 이용해주세요.")
			}
			</script>
			
			</c:if>
	<div class="container py-5">
		<h2>구매후기</h2>
		<div align="right" id="reviewBtnDiv">
		<button type="button" class="btn btn-primary" 
		<c:if test="${not empty loginUser }"> data-bs-toggle="modal" data-bs-target="#reviewModal"</c:if>
		id="reviewButton">리뷰작성</button>
		</div>
		
		<c:if test="${empty loginUser }">
			<script>
			$(function(){
				$("#reviewButton").click(function(){
					alert("로그인 이후에 이용해 주세요.");
				});
			});
			
			</script>
		
		</c:if>
		
		
		<c:if test="${not empty loginUser }">
		
		<div class="modal fade" id="reviewModal" data-bs-backdrop="static" data-bs-keyboard="false" tabindex="-1" aria-labelledby="staticBackdropLabel" aria-hidden="true">
		  <div class="modal-dialog">
		    <div class="modal-content">
		      <div class="modal-header">
		        <h1 class="modal-title fs-5" id="staticBackdropLabel">리뷰 쓰기</h1>
		        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
		      </div>
		      <div class="modal-body">
		          <div class="mb-3">
	            <label for="review_writer" class="col-form-label">작성자:</label>
	            <p>${loginUser.name }</p>
	          </div>
	          <div class="mb-3">
	          <div class="star-rating">
			    <input type="radio" class="star" name="rate" value="1">
			    <input type="radio" class="star" name="rate" value="2">
			    <input type="radio" class="star" name="rate" value="3">
			    <input type="radio" class="star" name="rate" value="4">
			    <input type="radio" class="star" name="rate" value="5" checked>
			  </div>
	       
          	</div>
	          <div class="mb-3">
	            <label for="content" class="col-form-label">후기내용 :</label>
	            <textarea class="form-control" id="content"></textarea>
	            <label for="fileFlag" class="col-form-label">파일 첨부여부</label>
	            <input type="checkbox" id="fileFlag">
          </div>
				<script>
				
				$(function(){
					$("#file-insert").hide();
					
					$("#fileFlag").click(function(){
						
						if($("#fileFlag").is(":checked")){
							$("#file-insert").show();
						}else{
							$("#file-insert").hide();
						}
					});
					
				
					buttonChange();
					
				});
				
				function buttonChange(){
					$.ajax({
						url: "/pjtMungHub/selectReivew.sp",
						data: {productNo : ${p.productNo},
							   userNo : ${loginUser.userNo}},
						success:function(result){
							if(result!=null && result!=""){
							var	str="";
							var btnDiv="";
							str+="<button type='button' class='btn btn-secondary'"
							+"data-bs-toggle='modal' data-bs-target='#reviewModal'"
							+"id='reviewButton'>리뷰수정</button>";
							
							btnDiv+="<button type='button'" 
							+"class='btn btn-secondary'" 
							+"data-bs-dismiss='modal'>취소</button>"
							+"<button type='button' class='btn btn-warning' onclick='reviewUpdate("+result.reviewNo+")'>수정하기</button>"
							$("#reviewBtnDiv").html(str);
							$("#reviewOption").html(btnDiv);
							}
							
						},error:function(){
							console.log("통신오류");
						}
					
						
					});
				}
					
				
				</script>          
           <div class="mb-3" id="file-insert">
          <ul class="nav nav-tabs nav-fill">
			  <li class="nav-item">
			    <button class="nav-link active" aria-current="page" id="insertPhoto">사진</button>
			  </li>
			  <li class="nav-item">
			    <button class="nav-link" aria-current="page" id="insertVideo">동영상</button>
			  </li>
			  </ul>
		  
		  	<div id="file">
		  		<img onclick='photo()' src="/pjtMungHub/resources/uploadFiles/common/css/MUNGHUB_logo.png" width="100%" id='loadedFile'>
				<input type='file' accept='image/*' id="uploadFile" onchange='loadFile(this)'>		  	
		  		<input type='hidden' value='image' id='type'>
		  	</div>
		  	</div>
		      </div>
		      <div class="modal-footer" id="reviewOption">
		        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">취소</button>
		        <button type="button" class="btn btn-primary" id="review-write">작성하기</button>
		      </div>
		    </div>
		  </div>
		</div>
		
		
		<script>
		function photo(){
			$("#uploadFile").click();
		}
		
		function loadFile(inputFile){
			if(inputFile.files.length==1){
				var reader = new FileReader();
				
				reader.readAsDataURL(inputFile.files[0]);
				
				reader.onload =function(e){
						$("#loadedFile").attr("src",e.target.result);
						$("#loadedFile").removeAttr("poster");
					}
				}else{
					$("#loadedFile").attr("src",null);
			}
		}	
		
		$(function(){
			var str="";
			$("#insertVideo").click(function(){
				$("#insertVideo").attr("class","nav-link active");
				$("#insertPhoto").attr("class","nav-link");
				str+="<video src='...' poster='/pjtMungHub/resources/uploadFiles/common/css/MUNGHUB_logo.png' width='100%' id='loadedFile' controls></video>";
				str+="<input type='file' accept='video/*' id='uploadFile' onchange='loadFile(this)'>";
				str+="<input type='hidden' value='video' id='type'>"
				$("#file").html(str);
				str="";
			});
			
			$("#insertPhoto").click(function(){
				$("#insertPhoto").attr("class","nav-link active");
				$("#insertVideo").attr("class","nav-link");
				str+="<img onclick='photo()' src='/pjtMungHub/resources/uploadFiles/common/css/MUNGHUB_logo.png' width='100%' id='loadedFile'>";
				str+="<input type='file' accept='image/*' id='uploadFile' onchange='loadFile(this)'>";
				str+="<input type='hidden' value='picture' id='type'>"
				$("#file").html(str);
				str="";
			
			
			});
			
			$("#review-write").click(function(){
				if($("#content").val()!=""){
					
				

				    var requestData = {userNo : ${loginUser.userNo},
							productNo : ${p.productNo},
							reviewContent : $("#content").val(),
							score : $("input[name='rate']:checked").val(),
							type : $("#type").val()}

				    var formData = new FormData();
				    formData.append("uploadFile", $("#uploadFile")[0].files[0]);
				    formData.append("review", new Blob([JSON.stringify(requestData)], {type: "application/json"}));
				
				
				$.ajax({
					url : "/pjtMungHub/insertReview.sp",
					type : "post",
					contentType: false, // 필수 : x-www-form-urlencoded로 파싱되는 것을 방지
				    processData: false,  // 필수: contentType을 false로 줬을 때 QueryString 자동 설정됨. 해제
					data : formData,
					success : function(result){
						$('#reviewModal').modal('hide');
						alertify
						  .alert("작성이 완료되었습니다.", function(){
						    alertify.success('마일리지가 적립되었습니다. 150P+');
						    selectReview();
						  });
					},error : function(){
						console.log("통신 오류");
					}
					
					
				});
			}else{
				alert("리뷰 내용을 작성해주세요.");
			}
			});
	
		});
		
		function reviewUpdate(num){
			
		if($("#content").val()!=""){
			
		
		    var requestData = {userNo : ${loginUser.userNo},
					productNo : ${p.productNo},
					reviewContent : $("#content").val(),
					score : $("input[name='rate']:checked").val(),
					type : $("#type").val(),
					reviewNo : num}

		    var formData = new FormData();
		    formData.append("uploadFile", $("#uploadFile")[0].files[0]);
		    formData.append("review", new Blob([JSON.stringify(requestData)], {type: "application/json"}));
		
		
		$.ajax({
			url : "/pjtMungHub/updateReview.sp",
			type : "post",
			contentType: false, // 필수 : x-www-form-urlencoded로 파싱되는 것을 방지
		    processData: false,  // 필수: contentType을 false로 줬을 때 QueryString 자동 설정됨. 해제
			data : formData,
			success : function(result){
				$('#reviewModal').modal('hide');
				alertify
				  .alert("수정이 완료되었습니다.", function(){
				    selectReview();
				  });
			},error : function(){
				console.log("통신 오류");
			}
			
			
				});
		}else{
			alert("리뷰내용을 작성해주세요.");
		}
			}
		
				
		</script>
		
		</c:if>
		

		<div class="py-5" align="center">
			<div class="row row-cols-2 align-items-center mt-3 ml-3 mr-3">
				<div class="col-sm-5">
					<h2>
						<fmt:formatNumber type="number" maxFractionDigits="1"
							value="${p.reviewTScore}" />
					</h2>
					<div class="star-wrap">
					<div class="review-star" align="left">
					<span style="width: ${p.reviewTScore*20}%"></span>
					</div>
					</div>
					
					 <span>총 <fmt:formatNumber type="number"
							maxFractionDigits="0" value="${p.reviewCount }" />건
					</span><br> <span style="color: gray">만족도 ${percent[0].percent}%</span>
				</div>
				<div class="col-sm-5">
				<c:forEach begin="0" end="4" varStatus="index">
				
					<div class="score">${5-index.index }점</div>
					<div class="progress my-1">
					<c:forEach begin="0" end="4" varStatus="i">
					<c:if test="${5-index.index eq percent[i.index].score }">
						<div class="progress-bar bg-warning" role="progressbar"
							style="width: ${percent[i.index].percent }%" aria-valuenow="75" aria-valuemin="0"
							aria-valuemax="100"></div>
					</c:if>
					</c:forEach>
					</div>
					<br>
				</c:forEach>
				</div>
			</div>
		</div>
		<h4>
			전체후기 <span id="totalReviewCount"><fmt:formatNumber type="number"
					maxFractionDigits="0" value="${p.reviewCount }" />건</span>
		</h4>

		<hr>
		
		<script type="text/javascript">
		
		
		   //날짜 포맷 변환 함수
        function formatDate(datetime) {
            //문자열 날짜 데이터를 날짜객체로 변환
            const dateObj = new Date(datetime);
            // 그냥은 못 가져오니까 Date 객체에 담는다 
           //그러면 string 으로 받을수 있다
 
            //날짜객체를 통해 각 날짜 정보 얻기
            let year = dateObj.getFullYear();
            //1월이 0으로 설정되어있음.
            let month = dateObj.getMonth() + 1;
            let day = dateObj.getDate();
            (month < 10) ? month = '0' + month: month;
            (day < 10) ? day = '0' + day: day;
            return year + "-" + month + "-" + day;
        }

		
		
		$(function(){
			selectReview();
		});
		
		function selectReview(){
			var str="";
			$.ajax({
				url: "/pjtMungHub/reviewList.sp",
				data : {productNo : ${p.productNo},
						justifying : $("input[name='orderBy']:checked").val(),
						star : 0,
						amount : 10
						},
					
			success : function(result){
					
					var modal="";
					for (var i = 0; i < result.length; i++) {
					var img="";
						for (var k = 0; k < result[i].atList.length; k++) {
						if(result[i].atList[k].type=='video'){
						img+="<video src='"+result[i].atList[k].filePath+result[i].atList[k].changeName+"' style='max-height: 300px;' controls/>";
						}else{
							
				 		img+="<img src='"+result[i].atList[k].filePath+result[i].atList[k].changeName+"' class='img-fluid' style='max-height: 300px;'>";
						}
				 			
						}
					str+="<div class='col-10 mb-4' >"
	                +"<div class='card'>"
	                +"<div class='media-container p-3'>"
	                +img
	                +"</div>"
	                +"<div class='card-body'>"
	                +"<h5 class='card-title'>"+result[i].userName+"</h5>"
	                +"<div class='wrap-star'>"
				    +"<div class='review-star'>"
				    +"<span style ='width: "+(result[i].score*20)+"%'></span>"
				    +"</div>"
					+"</div>"
	                +"<h6 class='card-subtitle mb-2 text-muted'>"+formatDate(result[i].createDate)+"</h6>"
	                +"<p class='card-text'>"+result[i].reviewContent+"</p>"
	                +"<div class='btn-div' align='right'>"
	                +"<span class='mx-3' id='likeCountT"+result[i].reviewNo+"'>"+result[i].likeCount+"</span>"
	                +"<button class='btn btn-primary' onclick='like("+result[i].reviewNo+")'><i class='bi bi-hand-thumbs-up'></i></button>"
	                +"<button class='btn btn-secondary' data-bs-toggle='modal' data-bs-target='#reviewDetailModal"+result[i].reviewNo+"' onclick='selectReplyList("+result[i].reviewNo+")'>댓글보기</button>"
	                +"</div>"
	                +"</div>"
	                +"</div>"
		            +"</div>"
					+"</div>";
					
					modal+="<div class='modal fade' id='reviewDetailModal"+result[i].reviewNo+"'" 
					+"data-bs-backdrop='static' data-bs-keyboard='false'"
					+"tabindex='-1' aria-labelledby='staticBackdropLabel' aria-hidden='true'>"
					+"<div class='modal-dialog'>"
					+"<div class='modal-content'>"
					+"<div class='modal-header'>"
					+"<h1 class='modal-title fs-5' id='staticBackdropLabel'>리뷰 보기</h1>"
					+"<button type='button' class='btn-close' data-bs-dismiss='modal' aria-label='Close'></button>"
					+"</div>"
					+"<div class='modal-body'>"
					+"<div class='media-container'>"
					+img      
					+"</div>"
					+"<div class='wrap-star'>"
					+"<div class='review-star'>"
					+"<span style ='width: "+(result[i].score*20)+"%'></span>"
					+"</div>"
					+"</div>"
					+"<div class='row align-items-center justify-content-center'>"
					+"<div class='col-sm-10'>"
					+"<small class='text-muted'>"+result[i].userName+"</small>"
					+"<small class='text-muted'>"+formatDate(result[i].createDate)+"</small>"
					+"<p>"+result[i].reviewContent+"</p>"
					+"</div>"
					+"<div class='col-sm-1' id='likeCountTmodal"+result[i].reviewNo+"' align='center'>"
					+result[i].likeCount
					+"</div>"
					+"<button class='btn btn-primary col-sm-1' style='max-height:40px' onclick='likeModal("+result[i].reviewNo+")'><i class='bi bi-hand-thumbs-up'></i></button>"
					+"</div>"
					+"<div class='row align-items-center justify-content-center py-2'>"
					+"<hr>"
					+"<textarea class='col-sm-9 mx-2' id='replyContent"+result[i].reviewNo+"' rows='5' cols='5' style='resize:none'></textarea>"
				    +"<button class='btn btn-secondary col-sm-2' style='max-height:40px;' onclick='insertReply("+result[i].reviewNo+")'><p style='font-size:0.8em; margin-bottom:0;'>댓글작성</p></button>"
					+"</div>"
					+"<hr>"
					+"<div id='reviewReply"+result[i].reviewNo+"' class='pb-3'>"
					+"</div>"
					+"</div>"
					+"</div>"
					+"</div>"
					+"</div>";
					}
					if(str!=""){
						
					}else{
						str+="<h1 align='center' class='py-5'>리뷰가 없습니다.</h1>"
					}
					$("#review_area").html(str+modal);
					
					$.ajax({
						url : "/pjtMungHub/selectReviewCount.sp",
						data : {productNo : ${p.productNo}},
						success : function(result){
							
						$("#totalReviewCount").text(result);
						},error : function(){
							console.log("통신오류");
						}
						
					});
				},
				error: function(){
					console.log("통신오류");
				}
			});
				
			
		};
			
		
		
		</script>
	<div class="container mt-5">
	<div align="right">
	<label for="topRate">추천순</label><input type="radio" id="topRate" name="orderBy" value="topRate" checked onclick="selectReview()">
	<label for="latest">최신순</label><input type="radio" id="latest" name="orderBy" value="latest" onclick="selectReview()">
	</div>
	<div class='row justify-content-center mt-3' id='review_area'>
	</div>
	</div>
</div>
	<div align="center">
		<nav>
		  <ul class="pagination justify-content-center">
		  <c:choose>
		  <c:when test="${pi.currentPage eq 1 }">
		  </c:when>
		  <c:otherwise>
		   <li class="page-item"><a class="page-link" href="/pjtMungHub/reviewListAll.sp/${p.productNo }?currentPage=${pi.currentPage-1}">Previous</a></li>
		  </c:otherwise>
		  </c:choose>
		  <c:forEach begin="${pi.startPage }" end="${pi.endPage }" var="page">
		  <c:choose>
		  <c:when test="${pi.currentPage eq page }">
		  <li class="page-item disabled"><a class="page-link" href="/pjtMungHub/reviewListAll.sp/${p.productNo }?${page}">${page}</a></li>
		  </c:when>
		  <c:otherwise>
		    <li class="page-item"><a class="page-link" href="/pjtMungHub/reviewListAll.sp/${p.productNo }?${page}">${page}</a></li>
		  </c:otherwise>
		  </c:choose>
		  </c:forEach>
		  <c:choose>
		  <c:when test="${pi.currentPage eq pi.maxPage }">
		  </c:when>
		  <c:otherwise>
		    <li class="page-item"><a class="page-link" href="/pjtMungHub/reviewListAll.sp/${p.productNo }?currentPage=${pi.currentPage+1}">Next</a></li>
		  </c:otherwise>
		  </c:choose>
		  </ul>
		</nav>
	</div>
	
</body>
</html>