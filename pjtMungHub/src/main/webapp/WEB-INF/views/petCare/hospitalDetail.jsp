<%@ page language="java" contentType="text/html; charset=UTF-8"
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
<title>동물병원 예약확인</title>
<script src="https://cdn.jsdelivr.net/npm/fullcalendar@6.1.14/index.global.min.js">
import { Calendar } from '@fullcalendar/core';
import dayGridPlugin from '@fullcalendar/daygrid';
import timeGridPlugin from '@fullcalendar/timegrid';
import listPlugin from '@fullcalendar/list';
</script> <!-- fullcalender -->

 <style>
        body {
            font-family: 'Arial', sans-serif;
            padding: 20px;
        }

        .container {
            background-color: #fff3e0;
            padding: 20px;
            border: 2px solid #ffa726;
            border-radius: 10px;
        }

        .h4, .h5 {
            color: #ef6c00;
            margin-bottom: 20px;
        }

        .sitter-info, .pet-info {
            background-color: #ffecb3;
            padding: 10px;
            border: 1px solid #ffa726;
            border-radius: 5px;
            margin-bottom: 20px;
        }

        .sitterFont {
            font-weight: bold;
            margin-top: 10px;
        }

        .popular-style {
            font-style: italic;
        }

        .str-btn, .petType-btn {
            background-color: #ffecb3;
            border: 1px solid #ffa726;
            color: #ef6c00;
            margin: 5px;
            padding: 20px 40px;
            border-radius: 5px;
            font-size: 1.2em;
            width: 100%;
        }

        .str-btn:hover, .petType-btn:hover {
            background-color: #ffb74d;
            color: #ffffff;
        }
        
        .str-btn.selected, .petType-btn.selected {
            background-color: #ffb74d;
            color: #ffffff;
        }

        .pet-info-all {
            background-color: #fff3e0;
            padding: 10px;
            border: 1px solid #ffa726;
            border-radius: 10px;
            flex: 1;
        }

        textarea {
            width: 100%;
            padding: 10px;
            border-radius: 5px;
            border: 1px solid #ffa726;
            resize: none;
        }

        .reservation-btn{
            background-color: blue;
            border: none;
            padding: 15px 0;
            color: #ffffff;
            border-radius: 5px;
            margin-top: 20px;
            width: 32%;
            font-size: 1.5em;
        }
        .update-btn {
            background-color: #ef6c00;
            border: none;
            padding: 15px 0;
            color: #ffffff;
            border-radius: 5px;
            margin-top: 20px;
            width: 32%;
            font-size: 1.5em;
        }
        .delete-btn {
            background-color: red;
            border: none;
            padding: 15px 0;
            color: #ffffff;
            border-radius: 5px;
            margin-top: 20px;
            width: 32%;
            font-size: 1.5em;
        }

        .reservation-btn:hover {
            background-color: #d84315;
        }

        #preview {
            margin-top: 10px;
            max-width: 100%;
            height: auto;
            border: 1px solid #ffa726;
            border-radius: 5px;
        }

        .calendar-time-container {
            display: flex;
            justify-content: space-between;
        }

        .calendar-container {
            flex: 1;
            margin-right: 20px;
        }
        
        #calendar {
            cursor: pointer;
        }
        
        .fc-daygrid-day:hover {
            cursor: pointer;
        }
        
        .fc-day-selected {
            background-color: #ffcc00 !important;
        }

        .time-container {
            flex: 1;
            display: flex;
            flex-direction: column;
            gap: 10px;
        }

        .info-container {
            display: flex;
            justify-content: space-between;
        }

        .info-container .sitter-info {
            flex: 1;
            margin-right: 20px;
        }

        .info-container .sitter-info:last-child {
            margin-right: 0;
        }

        .pet-type-container {
            display: flex;
            justify-content: space-between;
        }

        .three-section-container {
            display: flex;
            justify-content: space-between;
            gap: 20px;
        }

        .three-section-container > div {
            flex: 1;
        }

        .row {
            display: flex;
            flex-wrap: wrap;
        }

        .col-md-3 {
            flex: 0 0 25%;
            max-width: 25%;
        }
        
        #hosName,#hosPhone,#hosAddress {
        	font-color: gray;
        }
    </style>
</head>
<body>
    <%@include file="/WEB-INF/views/common/header.jsp" %>
    <input type="hidden" id="formattedDate" value="<%=formattedDate %>">
    <input type="hidden" id="hosReNo" name="hosReNo" value="${hosRe.hosReNo }">
    
    <div class="container">
            <h4 class="h4">예약내역 확인란</h4>
            <div class="info-container mb-3">
                <div class="sitter-info">
                    <h5 class="h5">보호자의 정보</h5>
                    <label for="petOwnerName">성명:</label>
                    <input type="text" id="petOwnerName" name="petOwnerName" value="${hosRe.petOwnerName }" class="form-control" readonly>
                    <label for="ownerPhone">연락처:</label>
                    <input type="text" id="ownerPhone" name="ownerPhone" value="${hosRe.ownerPhone }" class="form-control" readonly>
                    <label for="reDate">예약날짜:</label>
                    <input type="text" id="reDate" name="reDate" value="${hosRe.reDate }" class="form-control" readonly>
                	<label for="reTime">예약시간:</label>
                    <input type="text" id="reTime" name="reTime" value="${hosRe.reTime }" class="form-control" readonly>
                </div>
                
                <div class="sitter-info">
                    <h5 class="h5">예약하신 병원정보</h5>
                    <label for="hosName">병원 이름:</label>
                    <input type="text" id="hosName" name="hosName" value="${hosRe.hosName }" class="form-control" readonly>
                    <label for="hosPhone">연락처:</label>
                    <input type="text" id="hosPhone" name="hosPhone" value="${hosRe.hosPhone }" class="form-control" readonly>
                    <label for="hosAddress">주소:</label>
                    <input type="text" id="hosAddress" name="hosAddress" value="${hosRe.hosAddress }" class="form-control" readonly>
                </div>
            </div>
           
            <div class="three-section-container mb-3">
                <div class="sitter-info">
                    <h5 class="h5">반려동물 정보</h5>
                    <label for="diseaseName">예상되는 병명:</label>
                    <input type="text" id="diseaseName" name="diseaseName" value="${hosRe.diseaseName }" class="form-control" readonly>
                  
                    <label for="petName">이름:</label>
                    <input type="text" id="petName" name="petName" value="${hosRe.petName }" class="form-control" readonly>
                    <label for="petKind">견종:</label>
                    <input type="text" id="petKind" name="petKind" value="${hosRe.petKind }" class="form-control" readonly>
                    <label for="petTypeNo">반려견 크기:</label>
                    <input type="text" id="petTypeNo" name="petTypeNo" value="${hosRe.petTypeNo }" class="form-control" readonly>
                    
                    <label for="petBirthDay">생년월일:</label>
                    <input type="text" id="petBirthDay" name="petBirthDay" value="${hosRe.petBirthDay }" class="form-control" readonly>
                    <label for="petGender">성별:</label>
                    <input type="text" id="petGender" name="petGender" value="${hosRe.petGender }" class="form-control" readonly>
                    <label for="neutralization">중성화 여부:</label>
                    <input type="text" id="neutralization" name="neutralization" value="${hosRe.neutralization }" class="form-control" readonly>
                    <label for="specialNotes">특이사항:</label>
                    <textarea id="specialNotes" name="specialNotes" rows="3" style="resize:none;" class="form-control" readonly>${hosRe.specialNotes }</textarea>
                </div>
                
                <div class="pet-info-all">
                	<label for="upfile" style="font-size:16px; font-weight:bold;">첨부하신 사진파일</label>
                	<div>
                		<img src="/pjtMungHub/${hosRe.changeName }" width="100%" alt="펫 상처부위 이미지">
                	</div>
                </div>
            </div>
            <button type="button" class="update-btn" id="upDateBtn">예약사항 변경하기</button>
            <button type="button" class="reservation-btn" id="doneBtn">예약 확정</button>
            <button type="button" class="delete-btn" id="deleteBtn">예약 삭제하기</button>
    </div>	
	<br><br>
	
	<script>
		$(function(){
			$('#upDateBtn').click(function(){
				var hosReNo = $('#hosReNo').val();
				location.href="hospitalUpdate.re?hosReNo="+hosReNo;
			});
			$('#doneBtn').click(function(){
				location.href="hospitalDone.re";
			});
			$('#deleteBtn').click(function(){
				var hosReNo = $('#hosReNo').val();
				location.href="hospitalDelete.re?hosReNo="+hosReNo;
			});
		});
		
	</script>
</body>
</html>