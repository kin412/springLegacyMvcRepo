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
			/* $("#conChk_button1").on('click', function(){
			    alert("999");
			  }); */
			/* $("#conChk_button1").click(function(e) {
				alert("234");
			}); */
			
		});
		
		function btnTest(){
			console.log("--btnTest in")
	    	var queryString = $("#conChk_form").serializeArray();
	    	$.ajax({
				url:"<c:url value='/homeTest'/>",
				//url: "/app/homeTest",
				type:'post',
				data:queryString,
				dataType : "html",
				success: function(data, status) {
					var list = data;
					console.log("List : " + list);
					
				},
				error: function (data, status, e) {
					console.log(data); 
					console.log("실패");
				}
			});
	    }
		
	</script>
</head>
<body>

<P>  The time on the server is ${serverTime}. </P>

<form id="conChk_form" name="conChk_form" >
	<input type='text' id='conChk_text1' name='conChk_text1' value='test'/>
	<button type="button" id="conChk_button1" onclick="btnTest();"> 컨트롤러 반응 확인 버튼</button>
</form>
</body>
</html>
