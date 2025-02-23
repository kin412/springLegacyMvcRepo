<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<title>Insert title here</title>
	<script src="${pageContext.request.contextPath}/resources/js/jquery-1.12.4.min.js"></script>
	<script src="${pageContext.request.contextPath}/resources/js/common/com-function.js"></script>
	<script type="text/javascript">
	
		//관리자 파일첨부 테스트
		function goAdminFileTest(){
			location.href = "<c:url value='/adminFileTest/adminFileTest.do'/>";
		}	
	
		//메인메뉴
		function goMain(){
			location.href = "<c:url value='/main/main.do'/>";
		}
		
		//ajax
		function goAjax(){
			location.href = "<c:url value='/ajax/ajaxMain.do'/>";
		}
	</script>
</head>
<body>
	<div class="SideBar">Side menu
		<!-- security 예시 ROLE_ADMIN인 사용자만 보이게 -->
		<sec:authorize access="hasRole('ROLE_ADMIN')">
			<button type="button" onclick="goAdminFileTest()">관리자 첨부파일 테스트 페이지</button><br>
		</sec:authorize>
		<button type="button" onclick="goMain()">main</button><br>
		<button type="button" onclick="goAjax()">ajax</button>
	</div>
	
</body>
</html>