<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
</body>
<meta charset="UTF-8">
<title>Insert title here</title>
<style>
        .content {
            margin: 20px auto;
            max-width: 800px;
            background: #f8f9fa;
            padding: 20px;
            border-radius: 8px;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
        }
        .innerOuter {
            padding: 20px;
            background: white;
            border-radius: 8px;
        }
        h2 {
            margin-bottom: 20px;
            color: #343a40;
        }
        label {
            font-weight: bold;
        }
        .btn {
            min-width: 120px;
        }
    </style>
</head>
<body>
	<%@include file="../common/header.jsp"%>
	<div class="content">
		<br>
		<br>
		<div class="innerOuter">
			<h2>수정하기</h2>

			<form id="updateForm" method="post" action="update.bo">
				<input type="hidden" name="boardNo" value="${b.boardNo }">
				<table align="center">
					<tr>
						<th><label for="title">글제목</label></th>
						<td><input type="text" id="title" class="form-control"
							value="${b.boardTitle}" name="boardTitle" required></td>
					</tr>
					<tr>
                        <th><label for="upfile">첨부파일</label></th>
                        <td><input type="file" id="upfile" class="form-control-file border" name="upfile" multiple></td>
                    </tr>
					<tr>
						<th><label for="content">내용</label></th>
						<td><textarea id="content" class="form-control" rows="10" style="resize: none;" name="boardContent" required>${b.boardContent }</textarea></td>
					</tr>
				</table>
				<br>
				
				<div>
					<button type="submit" class="btn btn-primary">등록하기</button>
					<button type="button" class="btn btn-danger" onclick="javascript:history.go(-1);">이전으로</button>
				</div>
			</form>
		</div>


	</div>
</body>
</html>