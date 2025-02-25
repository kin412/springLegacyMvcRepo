<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec" %>
<%@ taglib prefix="c" 	  uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<title>Insert title here</title>
	<!-- <script src="https://code.jquery.com/jquery-1.12.4.min.js"></script> -->
	<script src="${pageContext.request.contextPath}/resources/js/jquery-1.12.4.min.js"></script>
	<script type="text/javascript">	
		function backToWindow(){
			window.history.back();
		}
	</script>
</head>
<body>
	오류가 발생했습니다.<br>
	관리자에 문의하세요.<br>
	<button type="button" onclick="backToWindow()">돌아가기</button>
	
</body>
</html>