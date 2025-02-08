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
		function searchFunc(){
			console.log("--searchFunc in")
	    	var queryString = $("#search_form").serializeArray();
	    	$.ajax({
				url:"<c:url value='/main/search.do'/>",
				type:'post',
				data:queryString,
				dataType : "json",
				success: function(data, status) {
					var html = '';
					var seq = '';
					data.forEach((row) => {
						
						/*seq = row.seq;
					    html += '<tr ondblclick ="selectDetail(\''+row.id+'\');">';
				    	html += '<td onclick="event.cancelBubble=true;"><input type="checkbox" name="chkFlg" value="'+row.id+'"></td>';
					    html += '<td>'+ row.no +'</td>';
					    html += '<td class="tll title">'+row.id+'</td>';
					    html += '<td>'+ row.name +'</td>';
					    html += '<td>'+ row.buseo_name +'</td>';
					    html += '<td>'+ row.acc_date +'</td>';
					    html += '<td>'+ row.reg_date +'</td>';
					    html += '</tr>';*/
					   	
					    html += row.seq + " || " + row.title + " || " + row.writer + " || " + row.regdate + " || " + row.cnt +"<br>"
						
					});
					
					$("#board").empty();
					$("#board").append(html);
					
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
	<br>
	<form id="search_form" name="search_form" >
		제목 <input type='text' id='title' name='title' value=''/>
		<br>
		<button type="button" id="searchBtn" onclick="searchFunc();"> 검색</button>
	</form>
	
	<div id="board">
		
	</div>
	
</body>
</html>
