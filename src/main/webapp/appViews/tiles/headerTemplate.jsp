<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>
	<div class="Header">
		Header<br>
		<div style="float:right">
			<form action="/app/logout" method="POST">
				<!-- <security:csrf disabled="true"/>가 없다면 로그아웃 처리시 csrf가 있어야함 -->
				<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
				<button type="submit">로그아웃</button>
			</form>
		</div>
	</div>
</body>
</html>