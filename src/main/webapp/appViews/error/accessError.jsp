<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec" %>
<%@ taglib prefix="c" 	  uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<title>Insert title here</title>
	<script src="https://code.jquery.com/jquery-1.12.4.min.js"></script>
	<script type="text/javascript">	
		function backToLogin(){
			location.href = "<c:url value='/login/login.do'/>";
		}
	</script>
</head>
<body>
	권한이 없는 접근입니다.
	<br>
	메시지 내용 : ${SPRING_SECURITY_403_EXCEPTION.getMessage()}
	<br>
	<button type="button" onclick="backToLogin()">돌아가기</button>
	
</body>
</html>