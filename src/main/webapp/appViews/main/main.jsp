<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%@ taglib prefix="tiles" uri="http://tiles.apache.org/tags-tiles"  %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page session="false" %>


<html>
<head>
	<script src="https://code.jquery.com/jquery-1.12.4.min.js"></script>
	<!-- <script type="text/javascript" src="<c:url value='/js/jquery-1.12.4.min.js' />"></script> -->
	
	<script type="text/javascript">
		$(document).ready(function(){
			
	    });
		
		$(function() {
			
		});
		
		//json
		function jsonChk(){
			console.log("--jsonChk in")
	    	var queryString = $("#conChk_form").serializeArray();
			$("#serializeArray").val("");
			$("#stringify").val("");
	    	$.ajax({
				url:"<c:url value='/jsonChk.do'/>",
				type:'post',
				data:queryString,
				dataType : "json",
				success: function(data, status) {
					var list1 = data.t1;
					var list2 = data.t2;
					var list3 = data.t3;
					console.log("List1 : " + list1);
					console.log("List2 : " + list2);
					console.log("List3 : " + list3);
					
				},
				error: function (data, status, e) {
					console.log(data); 
					console.log("실패");
				}
			});
	    }
		
		function mainFunc(){
			//location.href='/app/main/main.do';
			//location.href='main/main.do';
			location.href = "<c:url value='/main/main2.do'/>";
		}
		
	</script>
</head>
<body>
	화면이동 시<br>
	<button type="button" id="mainBtn" onclick="mainFunc();"> 화면 이동</button>
</body>
</html>
