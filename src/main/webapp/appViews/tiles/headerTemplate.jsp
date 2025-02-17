<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<!-- 스크립틀릿 예시 -->
<%
	String id = (String)request.getSession().getAttribute("id");
	String sessionId = (String)request.getSession().getId();
	String gp= request.getParameter("param");
	int i= 2;
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<title>Insert title here</title>
	<script src="https://code.jquery.com/jquery-1.12.4.min.js"></script>
	<script type="text/javascript">
		$(document).ready(function(){
	    	
	    });
		
		$(function() {
			
		});
		
		function logoutBtnFunc(){
			var result = confirm("로그아웃 하시겠습니까?");

	        if(!result){
	        	return false;
	        }else{
	        	$("form").submit();
	        }
		}
		
		function scriptletTest(){
			alert('<%=sessionId %>');
		}
		
	</script>
</head>
<body>
	<div class="Header">
		Header<br>
		<div style="float:right">
			<form action="/app/logout" method="POST">
				<!-- <security:csrf disabled="true"/>가 없다면 로그아웃 처리시 csrf가 있어야함 -->
				<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
				<button type="button" onclick="logoutBtnFunc()">로그아웃</button>
			</form>
			<button type="button" onclick="scriptletTest()">스크립틀릿 테스트</button>
		</div>
	</div>
</body>
</html>