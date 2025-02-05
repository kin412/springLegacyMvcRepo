<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page session="false" %>


<html>
<head>
	<title>Home</title>
	<script src="https://code.jquery.com/jquery-1.12.4.min.js"></script>
	<!-- <script type="text/javascript" src="<c:url value='/js/jquery-1.12.4.min.js' />"></script> -->
	<script type="text/javascript">
		$(document).ready(function(){
	    	console.log("--ready--");
	    });
		
		$(function() {
			
		});
		
		function loginFunc(){
			//location.href='/app/main/main.do';
			//location.href='main/main.do';
			location.href = "<c:url value='/main/main.do'/>";
		}
		
	</script>
</head>
<body>

	임시 로그인<br>
	<button type="button" id="loginBtn" onclick="loginFunc();"> 임시 로그인</button>

</body>
</html>
