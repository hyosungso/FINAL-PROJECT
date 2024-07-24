<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style>
	#pet-photo-area,.pet-info{
		float:left;
		border-right:5px;
	}
	.pet-info>label{
		margin-top:10px;
	}
	#pet-photo-area{
		margin-left:10px;
		margin-top:20px;
	}
</style>
</head>
<body>
	<form action="enrollPet.me" method="post" enctype="multipart/form-data">
		<div id="pet-photo-area" hidden="true">
			<img id="pet-photo" width="200" height="auto">
		</div>
		<div class="pet-info">
				<label for="breed">품종</label>
				<select name="breed">
					<c:forEach items="${breed}" var="b">
						<option value="${b.breedId}">${b.breedName}</option>
					</c:forEach>
				</select><br>
				<input type="hidden" id="ownerNo" name="ownerNo" value="${loginUser.userNo}">
				<label for="petName">이름 : </label>
				<input type="text" id="petName" name="petName"><br>
				<label for="">나이 :  </label> <span id="pet-age"> 살</span><br>
				<input type="range" id="petAge" name="petAge" min="0" step="1" max="18"><br>
				<label for="">성별 : </label>
				<input type="radio" name="petGender" value="M">
				<label for="M">왕자님</label>
				<input type="radio" name="petGender" value="F">
				<label for="F">공주님</label><br>
				<label for="weight">몸무게 : </label>
				<input type="number" id="weight" name="weight" step="0.1"> kg<br>
				<label for="photo">반려견 사진 자랑(1장만!)</label>
				<input type="file" id="upFile" name="upFile" onchange="loadImage(this);" required>
				
				<button type="submit">반려견 등록</button>
		</div>
	</form>
	<script>
		function loadImage(inputFile){
			var trg=$("#pet-photo-area");
			console.log(trg);
			if(inputFile.files.length==1){
				var reader = new FileReader();
				reader.readAsDataURL(inputFile.files[0]);
				reader.onload=function(e){
					trg.children().attr("src",e.target.result);
					trg.attr("hidden",false);
				}
			}else{
				trg.children().attr("src",null);
			}
		}
		$("#petAge").on("change",function(){
			var age=$("#petAge").val();
			age+=" 살";
			$("#pet-age").text(age);
		})
	</script>
</body>
</html>