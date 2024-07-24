<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"
    import="java.util.Date, java.text.SimpleDateFormat"%>
<%
	Date today = new Date();
	SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
	String formattedDate = sdf.format(today);
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>집 첫화면</title>

<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script> <!-- 주소 api -->
<script src="https://cdn.jsdelivr.net/npm/fullcalendar@6.1.14/index.global.min.js"></script> <!-- fullcalender -->


<style>
	@font-face {
        font-family: 'MangoDdobak-B';
        src: url('https://fastly.jsdelivr.net/gh/projectnoonnu/2405-3@1.1/MangoDdobak-B.woff2') format('woff2');
        font-weight: 700;
        font-style: normal;
	}
	body {
	    font-family: Arial, sans-serif;
	    margin: 0;
	    padding: 0;
	    background-color: #f5f5f5;
	}
	
	h2 {
		font-family: 'MangoDdobak-B', sans-serif;
	}
	
	.search-bar {
	    display: flex;
	    align-items: center;
	    margin: 1% 3% 3% 5%;
	}
	
	.search-bar input {
	    border: 1px solid #cccccc;
	    border-radius: 20px;
	    padding: 5px 10px;
	    margin-right: 10px;
	}
	
	.search-bar button {
	    cursor: pointer;
	}
	
	/* 달력 */
    #calendar {
    	max-width : 600px;
       	margin : 0 auto;
    }
    .fc-daygrid-day:hover {
        cursor: pointer;
    }
    .fc-daygrid-day.fc-day-selected {
        background-color: skyblue !important;
    }
	
	.titlePaging {
		display: flex;
		margin: 2% 0% 0% 15%;
	}
	#pagingArea {
		margin-left: 5%;
	}
	.partner {
		margin-bottom: 10%;
	}
	
	.house-container {
		font-family: 'MangoDdobak-B', sans-serif;
	    display: flex; /* flexbox를 사용하여 요소들을 배치 */
	    flex-direction: column; /* 요소들을 세로로 배치 */
	    align-items: center; /* 요소들을 중앙 정렬 */
	    margin: 20px;
	}
	
	.house-item {
	  	border: 3px solid #cccccc;
	    border-radius: 20px;
	    padding: 20px; 
	    margin: 10px; 
	    width: 80%; 
	    display: flex;
	    flex-direction: column;
	}
	.house-header {
		display: flex;
		/*justify-content: space-between; /* 요소들을 양쪽 끝에 배치 */
		/*align-items: center;*/
	}
	
	.house-title {
	    font-size: 30px; 
	    font-weight: bold; 
	    cursor: pointer;
	}
	.house-buttons {
		margin-left: 5%;
		display: flex;
		gap: 10px; /*버튼 사이간격조절*/
	}
	.house-buttons button {
		/*padding: 5px 10px;*/
		border: 2px solid #ccc;
		background-color #f8f8f8;
		font-size: 12px;
		font-weight: bold;
	}		
	.house-details {
	    margin: 10px 0;
	    cursor: pointer;
	}
	.house-imges {
		display: flex;
		justify-content: space-around; /* 요소들을 균등하게 배치 */
		margin: 10px 0;
	}
	.house-images img {
	    width: 30%;
	    margin: 5px;
	    cursor: pointer;
	}
	
	
</style>
</head>
<body>
	<%@include file="/WEB-INF/views/common/header.jsp" %>
	
	<input type="hidden" id="hiddenAddress" name="address">
	<input type="hidden" id="hiddenStartDate" name="startDate">
	<input type="hidden" id="hiddenEndDate" name="endDate">
	<input type="hidden" id="hiddenDaysNight" name="daysNight">
	<input type="hidden" id="firstCurrentPage" value="${currentPage }">
	
    <header>
        <div class="search-bar">
        
        <!-- 주소 api 모달창으로 -->
		<input type="hidden" id="addrBtn" class="btn btn-primary" data-bs-toggle="modal" data-bs-target="#staticBackdrop1">
		<input type="text" id="inputAddress" style="width:400px;" readonly placeholder="주소를 입력해주세요." required>
		<div class="modal fade" id="staticBackdrop1" data-bs-backdrop="static" data-bs-keyboard="false" tabindex="-1" aria-labelledby="staticBackdropLabel" aria-hidden="true">
		  <div class="modal-dialog">
		    <div class="modal-content">
		      <div class="modal-header">
		        <h1 class="modal-title fs-5" id="staticBackdropLabel">주소입력창</h1>
		        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
		      </div>
		      <div class="modal-body">
		        <input type="text" id="sample6_postcode" placeholder="우편번호">
				<input type="button" onclick="sample6_execDaumPostcode()" value="우편번호 찾기"><br>
				<input type="text" id="sample6_address" placeholder="주소" style="width:400px;"><br>
				<input type="text" id="sample6_detailAddress" placeholder="상세주소" style="width:300px;">
				<input type="text" id="sample6_extraAddress" placeholder="참고항목">
		      </div>
		      <div class="modal-footer">
		        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">닫기</button>
		        <button type="button" class="btn btn-primary" id="resetBtn">초기화</button>
		        <button type="button" class="btn btn-primary" id="inputBtn">입력완료</button>
		      </div>
		    </div>
		  </div>
		</div>
		
		<button type="button" id="addrBtn" class="btn btn-primary" data-bs-toggle="modal" data-bs-target="#staticBackdrop3">
                다양한 필터 기능선택
        </button>
        
		<input type="button" class="btn btn-secondary" id="searchBtn" value="검색" style="margin-left:3%;">
            
            <div class="modal fade" id="staticBackdrop3" data-bs-backdrop="static" data-bs-keyboard="false" tabindex="-1" aria-labelledby="staticBackdropLabel" aria-hidden="true">
                <div class="modal-dialog">
                    <div class="modal-content">
                        <div class="modal-header">
                            <h1 class="modal-title fs-5" id="staticBackdropLabel">날짜 및 돌봄기간</h1>
                            <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                        </div>
                        <div class="modal-body">
                            <h5>날짜를 지정해주세요.</h5>
                            <div class="date-container">
                                <div id="calendar">
                                 <!-- FullCanlendar API -->
                                </div>
                            </div>
                            
                            <br><br>
                            
                            <h5>돌봄 기간을 선택해주세요.(5박이상은 관리자에게 문의해주세요.)</h5>
                            <input type="radio" class="btn-check" name="daysNight" id="day1" autocomplete="off" value="1" checked>
                            <label class="btn btn-secondary" for="day1">1박2일</label>
                            <input type="radio" class="btn-check" name="daysNight" id="day2" autocomplete="off" value="2">
                            <label class="btn btn-secondary" for="day2">2박3일</label>
                            <input type="radio" class="btn-check" name="daysNight" id="day3" autocomplete="off" value="3">
                            <label class="btn btn-secondary" for="day3">3박4일</label>
                            <input type="radio" class="btn-check" name="daysNight" id="day4" autocomplete="off" value="4">
                            <label class="btn btn-secondary" for="day4">4박5일</label>
                            
                            <br><br>
                            
                            <div class="radio-btn-group">
                                <h5>돌보미의 반려동물 보유</h5>
                                <div class="form-check form-switch">
                                    <input class="form-check-input" type="checkbox" id="pet">
                                    <label class="form-check-label" for="flexSwitchCheckDefault">반려동물 보유</label>
                                </div>
                                <h5>돌보미의 산책가능 여부</h5>
                                <div class="form-check form-switch">
                                    <input class="form-check-input" type="checkbox" id="walk">
                                    <label class="form-check-label" for="flexSwitchCheckDefault">산책가능여부</label>
                                </div>
                                <h5>반려동물의 크기를 선택해주세요.</h5>
                                <input type="radio" class="btn-check" name="petType" id="petType1" autocomplete="off" value="1" checked>
                                <label class="btn btn-secondary" for="petType1">소형견(7kg미만)</label>
                                <input type="radio" class="btn-check" name="petType" id="petType2" autocomplete="off" value="2">
                                <label class="btn btn-secondary" for="petType2">중형견(7~15kg)</label>
                                <input type="radio" class="btn-check" name="petType" id="petType3" autocomplete="off" value="3">
                                <label class="btn btn-secondary" for="petType3">대형견(15kg이상)</label>
                            </div>
                            
                            <br><br>
                        </div>
                        <div class="modal-footer">
                            <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">닫기</button>
                            <button type="button" class="btn btn-primary" id="resetBtn3">초기화</button>
                            <button type="button" class="btn btn-primary" id="inputBtn3">입력완료</button>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </header>
    
    <div class="titlePaging">
    	<h2> < 우리집 같은 보금자리 > </h2>
		<div id="pagingArea">
	
       	</div>
	</div>
    
   	
    <section class="partner">
        <div class="house-container" id="house-container">
        
        
        </div>
    </section>
    
    <script>
    var inputDate = ""; //달력에 입력된 날짜
	var daysNight = ""; //돌봄기간(ex:1박2일)
	var endDate = ""; // inputDate + daysNight 계산된 값
	var pet = ""; //집주인의 펫보유 여부
	var walk = "";  //산책가능여부
	var petType = ""; //가능한 펫 크기
		
//===================== 하우스 리스트 (페이지 첫 로드시)===================
		
		var firstCurrentPage = $('#firstCurrentPage').val();	
		function firstList(){
			$.ajax({
				url : "firstHouseList.re",
				data :{
					firstCurrentPage : firstCurrentPage
				},
				success : function(result){
					var list = result.houseList; //map에서 꺼내쓰는 방법
					var pi = result.pi;
					var houseList = "";
					for (var i = 0; i < list.length; i++) {
						houseList += "<div class='house-item'>" 
	            	 			+ "<div class='house-header'>"
								+ "<div class='house-title' data-house-no='" + list[i].houseNo + "'>" + list[i].introductionSummary + "</div>" 
								+ "<div class='house-buttons'>"
	                            + "<button class='btn btn-secondary'>산책: " + list[i].houseWalkNo + "</button>"
	                            + "<button class='btn btn-secondary'>반려견: " + list[i].housePetNo + "</button>"
	                            + "<button class='btn btn-secondary'>돌봄가능크기: " + list[i].petTypeNo + "</button>"
	                            + "</div>"
								+ "</div>" 
								+ "<div class='house-details' data-house-no='" + list[i].houseNo + "'>" 
								+ "집 주소 자세하게: " + list[i].houseAddress + "</div>" 
								+ "<div class='house-details' data-house-no='" + list[i].houseNo + "'>" 
								+ "인근병원주소: " + list[i].nearbyHospital + "</div>" 
								+ "<div class='house-images'>" 
								+ "<img src='" + list[i].filePath + list[i].originName01 + "' alt='Image 1' data-house-no='" + list[i].houseNo + "'>" 
								+ "<img src='" + list[i].filePath + list[i].originName02 + "' alt='Image 2' data-house-no='" + list[i].houseNo + "'>" 
								+ "<img src='" + list[i].filePath + list[i].originName03 + "' alt='Image 3' data-house-no='" + list[i].houseNo + "'>" 
								+ "</div>" 
								+ "</div>";
					}
					
					var pagination = "<ul class='pagination'>";
		            // 이전버튼
		            if (pi.currentPage == 1) {
		                pagination += "<li class='page-item disabled'><a class='page-link' href='#'>◀</a></li>";
		            } else {
		                pagination += "<li class='page-item'><a class='page-link' href='#' onclick='goToPage2(" + (pi.currentPage - 1) + ")'>◀</a></li>";
		            }
		            // 페이징번호 반복문
		            for (var p = pi.startPage; p <= pi.endPage; p++) {
		                pagination += "<li class='page-item'><a class='page-link' href='#' onclick='goToPage2(" + p + ")'>" + p + "</a></li>";
		            }
		            // 다음버튼
		            if (pi.currentPage == pi.maxPage) {
		                pagination += "<li class='page-item disabled'><a class='page-link' href='#'>▶</a></li>";
		            } else {
		                pagination += "<li class='page-item'><a class='page-link' href='#' onclick='goToPage2(" + (pi.currentPage + 1) + ")'>▶</a></li>";
		            }
					
					$('#pagingArea').html(pagination);
					$('#house-container').html(houseList);
					console.log('하우스 리스트 불러오기 성공!!');
				},
				error : function(){
					console.log('통신실패ㅠㅠ');
				}
			});
		};
		
		//page 넘버마다 onclick 이벤트를 사용하여 비동기로 페이징이동 (페이지 처음화면용)
		function goToPage2(page) {
			
		    $.ajax({
		        url: "firstHouseList.re",
		        data: {
		        	firstCurrentPage : page
		        },
		        success: function(result) {
		            var list = result.houseList;
		            var pi = result.pi;

		            var houseList = "";
		            for (var i = 0; i < list.length; i++) {
		            	houseList += "<div class='house-item'>" 
            	 			+ "<div class='house-header'>"
							+ "<div class='house-title' data-house-no='" + list[i].houseNo + "'>" + list[i].introductionSummary + "</div>" 
							+ "<div class='house-buttons'>"
                            + "<button class='btn btn-secondary'>산책: " + list[i].houseWalkNo + "</button>"
                            + "<button class='btn btn-secondary'>반려견: " + list[i].housePetNo + "</button>"
                            + "<button class='btn btn-secondary'>돌봄가능크기: " + list[i].petTypeNo + "</button>"
                            + "</div>"
							+ "</div>" 
							+ "<div class='house-details' data-house-no='" + list[i].houseNo + "'>" 
							+ "집 주소 자세하게: " + list[i].houseAddress + "</div>" 
							+ "<div class='house-details' data-house-no='" + list[i].houseNo + "'>" 
							+ "인근병원주소: " + list[i].nearbyHospital + "</div>" 
							+ "<div class='house-images'>" 
							+ "<img src='" + list[i].filePath + list[i].originName01 + "' alt='Image 1' data-house-no='" + list[i].houseNo + "'>" 
							+ "<img src='" + list[i].filePath + list[i].originName02 + "' alt='Image 2' data-house-no='" + list[i].houseNo + "'>" 
							+ "<img src='" + list[i].filePath + list[i].originName03 + "' alt='Image 3' data-house-no='" + list[i].houseNo + "'>" 
							+ "</div>" 
							+ "</div>";
		            }

		            var pagination = "<ul class='pagination'>";

		            // 이전버튼
		            if (pi.currentPage == 1) {
		                pagination += "<li class='page-item disabled'><a class='page-link' href='#'>◀</a></li>";
		            } else {
		                pagination += "<li class='page-item'><a class='page-link' href='#' onclick='goToPage2(" + (pi.currentPage - 1) + ")'>◀</a></li>";
		            }
		            // 페이징번호 반복문
		            for (var p = pi.startPage; p <= pi.endPage; p++) {
		                pagination += "<li class='page-item'><a class='page-link' href='#' onclick='goToPage2(" + p + ")'>" + p + "</a></li>";
		            }
		            // 다음버튼
		            if (pi.currentPage == pi.maxPage) {
		                pagination += "<li class='page-item disabled'><a class='page-link' href='#'>▶</a></li>";
		            } else {
		                pagination += "<li class='page-item'><a class='page-link' href='#' onclick='goToPage2(" + (pi.currentPage + 1) + ")'>▶</a></li>";
		            }
		            pagination += "</ul>";

		            $('#pagingArea').html(pagination);
		            $('#house-container').html(houseList);
		            console.log('하우스 리스트 불러오기 성공!!');
		        },
		        error: function() {
		            console.log('통신실패ㅠㅠ');
		        }
		    });
		}
		
		//============ 집 디테일로 이동 ===================
		$(function(){
			firstList();
			houseList();
			goToPage();
			
			$(document).on('click','.house-item .house-images img,.house-title,.house-details',function(){
				var houseNo = $(this).data('house-no');
				location.href="detailHouse.re?houseNo="+houseNo;
			});
		});
		
		//============== FullCaleandar API ===================
	    $(function() {
	        var calendarEl = document.getElementById('calendar');
	        var calendar;
	        
	        $('#staticBackdrop3').on('shown.bs.modal', function() {
	        	var preToday = new Date();
	            var today = new Date(preToday.getTime() - (preToday.getTimezoneOffset() * 60000)).toISOString().split('T')[0];
	            console.log(today);
	            
	            calendar = new FullCalendar.Calendar(calendarEl, {
	                initialView: 'dayGridMonth',
	                locale: 'ko',
	                validRange: {
	                    start: today,
	                    end: null
	                },
	                headerToolbar: {
	                    left: '',
	                    center: 'title',
	                    right: 'prev,next'
	                },
	                dateClick: function(info) {
	                    inputDate = info.dateStr; // 선택된 날짜

	                    // 모든 날짜에 스타일 제거
	                    document.querySelectorAll('.fc-daygrid-day').forEach(function(dayEl) {
	                        dayEl.classList.remove('fc-day-selected');
	                    });

	                    // 선택된 날짜에 스타일 추가
	                    var selectedDayEl = document.querySelector('[data-date="' + inputDate + '"]');
	                    if (selectedDayEl) {
	                        selectedDayEl.classList.add('fc-day-selected');
	                    }
	                }
	            });
	            
	            calendar.render();

	            // 페이지 로드시 오늘 날짜 선택
	            function selectToday() {
	                var today = new Date().toISOString().split('T')[0];
	                var todayElement = document.querySelector('[data-date="' + today + '"]');
	                if (todayElement) {
	                    todayElement.classList.add('fc-day-selected');
	                    calendar.trigger('dateClick', { date: new Date(), dateStr: today });
	                }
	            }
	            setTimeout(selectToday, 500);
	        });

	        $('#staticBackdrop3').on('hidden.bs.modal', function() {
	            if (calendar) {
	                calendar.destroy();
	            }
	        });
	    });
	   
	  //================== 하우스리스트 (필터링) =======================
		function houseList(){
			//모당창 확인버튼
			$('#inputBtn3').click(function(){
				daysNight = $('input[name="daysNight"]:checked').val(); //몇박몇일
				petType = $('input[name="petType"]:checked').val();
				
				//DB 자료와 일치하기 위해 변환과정
				if($('#pet').is(':checked')==true){
					pet = '1';
				}else{
					pet = '2';
				}
				
				if($('#walk').is(':checked')==true){
					walk = '1';
				}else{
					walk = '2';
				}
				
				if(inputDate && daysNight && petType ){
	    			$("#staticBackdrop3").modal('hide'); //값을 보낸 후 모달창 닫아주기
				}else{
					alert('모든 요소를 입력해주세요.');
				}
			});
			
			// 최종 검색버튼 (주소 + 필터링)
			$('#searchBtn').click(function(){
				
				var address = $("#inputAddress").val(); //주소
				var endDatePlus = parseInt(daysNight);
				//java.util.Date 로 받았기 때문에, controller에서 sql.Date로 변환예정
				endDate = new Date(inputDate);
				endDate.setDate(endDate.getDate() + endDatePlus);
				
				$.ajax({
					url : "selectHouseList.re",
					data : {
						address : address,
						startDate : inputDate,
						endJavaDate : endDate,
						stayNo : daysNight,
						pet : pet,
						walk : walk,
						petTypeNo : petType
					},
					success : function(result){
						
						var list = result.houseList; //map에서 꺼내쓰는 방법
						var pi = result.pi;
						// Hidden input fields 설정
			            $('#hiddenAddress').val(address);
			            $('#hiddenStartDate').val(inputDate);
			            $('#hiddenEndDate').val(endDate);
			            $('#hiddenDaysNight').val(daysNight);
			            
						var houseList = "";
						for (var i = 0; i < list.length; i++) {
							houseList += "<div class='house-item'>" 
	            	 			+ "<div class='house-header'>"
								+ "<div class='house-title' data-house-no='" + list[i].houseNo + "'>" + list[i].introductionSummary + "</div>" 
								+ "<div class='house-buttons'>"
	                            + "<button class='btn btn-secondary'>산책: " + list[i].houseWalkNo + "</button>"
	                            + "<button class='btn btn-secondary'>반려견: " + list[i].housePetNo + "</button>"
	                            + "<button class='btn btn-secondary'>돌봄가능크기: " + list[i].petTypeNo + "</button>"
	                            + "</div>"
								+ "</div>" 
								+ "<div class='house-details' data-house-no='" + list[i].houseNo + "'>" 
								+ "집 주소 자세하게: " + list[i].houseAddress + "</div>" 
								+ "<div class='house-details' data-house-no='" + list[i].houseNo + "'>" 
								+ "인근병원주소: " + list[i].nearbyHospital + "</div>" 
								+ "<div class='house-images'>" 
								+ "<img src='" + list[i].filePath + list[i].originName01 + "' alt='Image 1' data-house-no='" + list[i].houseNo + "'>" 
								+ "<img src='" + list[i].filePath + list[i].originName02 + "' alt='Image 2' data-house-no='" + list[i].houseNo + "'>" 
								+ "<img src='" + list[i].filePath + list[i].originName03 + "' alt='Image 3' data-house-no='" + list[i].houseNo + "'>" 
								+ "</div>" 
								+ "</div>";
						}
						
						var pagination = "<ul class='pagination'>";
			            // 이전버튼
			            if (pi.currentPage == 1) {
			                pagination += "<li class='page-item disabled'><a class='page-link' href='#'>◀</a></li>";
			            } else {
			                pagination += "<li class='page-item'><a class='page-link' href='#' onclick='goToPage(" + (pi.currentPage - 1) + ")'>◀</a></li>";
			            }
			            // 페이징번호 반복문
			            for (var p = pi.startPage; p <= pi.endPage; p++) {
			                pagination += "<li class='page-item'><a class='page-link' href='#' onclick='goToPage(" + p + ")'>" + p + "</a></li>";
			            }
			            // 다음버튼
			            if (pi.currentPage == pi.maxPage) {
			                pagination += "<li class='page-item disabled'><a class='page-link' href='#'>▶</a></li>";
			            } else {
			                pagination += "<li class='page-item'><a class='page-link' href='#' onclick='goToPage(" + (pi.currentPage + 1) + ")'>▶</a></li>";
			            }
						
						$('#pagingArea').html(pagination);
						$('#house-container').html(houseList);
						console.log('하우스 리스트 불러오기 성공!!');
					},
					erorr : function(){
						console.log('통신실패ㅠㅠ');
					}
				});
			});
		};
		
		//page 넘버마다 onclick 이벤트를 사용하여 비동기로 페이징이동 (필터링용)
		function goToPage(page) {
		    var address = $('#hiddenAddress').val();
		    var startDate = $('#hiddenStartDate').val();
		    var endDate = $('#hiddenEndDate').val();
		    var daysNight = $('#hiddenDaysNight').val();
		    
		    console.log(page);

		    $.ajax({
		        url: "selectHouseList.re",
		        data: {
		        	currentPage : page,
		        	address : address,
					startDate : inputDate,
					endJavaDate : endDate,
					stayNo : daysNight,
					pet : pet,
					walk : walk,
					petTypeNo : petType
		        },
		        success: function(result) {
		            var list = result.houseList;
		            var pi = result.pi;
		            
		            console.log(pi);

		            var houseList = "";
		            for (var i = 0; i < list.length; i++) {
		            	houseList += "<div class='house-item'>" 
            	 			+ "<div class='house-header'>"
							+ "<div class='house-title' data-house-no='" + list[i].houseNo + "'>" + list[i].introductionSummary + "</div>" 
							+ "<div class='house-buttons'>"
                            + "<button class='btn btn-secondary'>산책: " + list[i].houseWalkNo + "</button>"
                            + "<button class='btn btn-secondary'>반려견: " + list[i].housePetNo + "</button>"
                            + "<button class='btn btn-secondary'>돌봄가능크기: " + list[i].petTypeNo + "</button>"
                            + "</div>"
							+ "</div>" 
							+ "<div class='house-details' data-house-no='" + list[i].houseNo + "'>" 
							+ "집 주소 자세하게: " + list[i].houseAddress + "</div>" 
							+ "<div class='house-details' data-house-no='" + list[i].houseNo + "'>" 
							+ "인근병원주소: " + list[i].nearbyHospital + "</div>" 
							+ "<div class='house-images'>" 
							+ "<img src='" + list[i].filePath + list[i].originName01 + "' alt='Image 1' data-house-no='" + list[i].houseNo + "'>" 
							+ "<img src='" + list[i].filePath + list[i].originName02 + "' alt='Image 2' data-house-no='" + list[i].houseNo + "'>" 
							+ "<img src='" + list[i].filePath + list[i].originName03 + "' alt='Image 3' data-house-no='" + list[i].houseNo + "'>" 
							+ "</div>" 
							+ "</div>";
		            }

		            var pagination = "<ul class='pagination'>";

		            // 이전버튼
		            if (pi.currentPage == 1) {
		                pagination += "<li class='page-item disabled'><a class='page-link' href='#'>◀</a></li>";
		            } else {
		                pagination += "<li class='page-item'><a class='page-link' href='#' onclick='goToPage(" + (pi.currentPage - 1) + ")'>◀</a></li>";
		            }
		            // 페이징번호 반복문
		            for (var p = pi.startPage; p <= pi.endPage; p++) {
		                pagination += "<li class='page-item'><a class='page-link' href='#' onclick='goToPage(" + p + ")'>" + p + "</a></li>";
		            }
		            // 다음버튼
		            if (pi.currentPage == pi.maxPage) {
		                pagination += "<li class='page-item disabled'><a class='page-link' href='#'>▶</a></li>";
		            } else {
		                pagination += "<li class='page-item'><a class='page-link' href='#' onclick='goToPage(" + (pi.currentPage + 1) + ")'>▶</a></li>";
		            }
		            pagination += "</ul>";

		            $('#pagingArea').html(pagination);
		            $('#house-container').html(houseList);
		            console.log('하우스 리스트 불러오기 성공!!');
		        },
		        error: function() {
		            console.log('통신실패ㅠㅠ');
		        }
		    });
		}
		
		//==================== 주소 api ===============================
    	$(function(){
    		$('#inputAddress').on('click',function(){
    			$('#addrBtn').click();
    		});
    	});
		
		function sample6_execDaumPostcode() {
	        new daum.Postcode({
	            oncomplete: function(data) {
	            	
	                var addr = ''; // 주소 변수
	                var extraAddr = ''; // 참고항목 변수
	
	                if (data.userSelectedType === 'R') { // 사용자가 도로명 주소를 선택했을 경우
	                    addr = data.roadAddress;
	                } else { // 사용자가 지번 주소를 선택했을 경우(J)
	                    addr = data.jibunAddress;
	                }
	
	                if(data.userSelectedType === 'R'){
	                    if(data.bname !== '' && /[동|로|가]$/g.test(data.bname)){
	                        extraAddr += data.bname;
	                    }
	                    // 건물명이 있고, 공동주택일 경우 추가한다.
	                    if(data.buildingName !== '' && data.apartment === 'Y'){
	                        extraAddr += (extraAddr !== '' ? ', ' + data.buildingName : data.buildingName);
	                    }
	                    // 표시할 참고항목이 있을 경우, 괄호까지 추가한 최종 문자열을 만든다.
	                    if(extraAddr !== ''){
	                        extraAddr = ' (' + extraAddr + ')';
	                    }
	                    // 조합된 참고항목을 해당 필드에 넣는다.
	                    document.getElementById("sample6_extraAddress").value = extraAddr;
	                
	                } else {
	                    document.getElementById("sample6_extraAddress").value = '';
	                }
	                document.getElementById('sample6_postcode').value = data.zonecode;
	                document.getElementById("sample6_address").value = addr; 
	                document.getElementById("sample6_detailAddress").focus();
	                
	               $('#inputBtn').click(function(){
	            	   var fullAddress = addr+'  '+document.getElementById("sample6_detailAddress").value;
	            	   $('#inputAddress').val(fullAddress);
	            	 //값을 보낸 후 모달창 닫아주기
						$("#staticBackdrop1").modal('hide'); 
	               });
	            }
	        }).open();
		}
		//주소 입력창 초기화 버튼  		
		$("#resetBtn").click(function(){ 
			$("#sample6_postcode").val('');
			$("#sample6_address").val('');
			$("#sample6_detailAddress").val('');
			$("#sample6_extraAddress").val('');
		});
    </script>

</body>
</html>