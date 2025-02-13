<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>


<html>
<head>
	<title>Home</title>
	<script src="https://code.jquery.com/jquery-1.12.4.min.js"></script>
	<script type="text/javascript">
		$(document).ready(function(){
	    	console.log("--ready--");
	    });
		
		$(function() {
			
		});
		
	</script>
</head>
<body>

	로그인<br>
	
	<table>
		<tbody>
			<form action="/app/login" method="post">
				<!-- <security:csrf disabled="true"/>가 없다면 로그인 처리시 csrf가 있어야함 -->
				<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
				<tr>
					<td>ID</td>
					<td><input type="text" name="id"></td>
					<td rowspan='2'>
						<button type="submit">로그인</button>
					</td>
				</tr>
				<tr>
					<td>PW</td>
					<td><input type="password" name="pw"></td>
					<td>
						
					</td>
				</tr>
				<tr>
					<td colspan='3'>
					</td>
				</tr>
			</form>
		</tbody>
	</table>
</body>
</html>
