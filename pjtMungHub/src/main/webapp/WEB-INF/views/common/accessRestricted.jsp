<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>접근이 제한되었습니다▼･。･▼</title>
	<script>
		alert("${message}. 제한 해제까지 ${daysUntil}일 ${hoursUntil}시간 ${minutesUntil}분 남았습니다.");
		location.href='${pageContext.request.contextPath}/';
	</script>
</head>
<body>

</body>
</html>