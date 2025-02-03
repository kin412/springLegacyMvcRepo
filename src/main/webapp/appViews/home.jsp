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
		
		//getParameterMap으로 모든 파라미터 읽기
		function getParameterMap(){
			console.log("--getParameterMap in")
	    	var queryString = $("#conChk_form").serializeArray();
			$("#serializeArray").val(queryString);
			$("#stringify").val(JSON.stringify(queryString));
	    	$.ajax({
				url:"<c:url value='/getParameterMap.do'/>",
				//url: "/app/getParameterMap",
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
		
		//json
		function jsonChk(){
			console.log("--jsonChk in")
	    	var queryString = $("#conChk_form").serializeArray();
			$("#serializeArray").val("");
			$("#stringify").val("");
	    	$.ajax({
				url:"<c:url value='/jsonChk.do'/>",
				//url: "/app/getParameterMap",
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
		
	</script>
</head>
<body>

<P>  The time on the server is ${serverTime}. </P>

<form id="conChk_form" name="conChk_form" >
	<input type='text' id='conChk_text1' name='conChk_text1' value='test'/>
	<input type='hidden' id='conChk_text2' name='conChk_text2' value='apple'/>
	<input type='hidden' id='conChk_text3' name='conChk_text3' value='banana'/>
	<input type='hidden' id='conChk_text4' name='conChk_text4' value='cookie'/>
	<button type="button" id="conChk_button1" onclick="getParameterMap();"> getParameterMap 확인</button>
	<button type="button" id="jsonChk_button" onclick="jsonChk();"> json 확인</button>
</form>
	<br>
	serializeArray <input type='text' id='serializeArray' name='serializeArray'/>
	<br>
	JSON.stringify <input type='text' id='stringify' name='stringify'/>
</body>
</html>
