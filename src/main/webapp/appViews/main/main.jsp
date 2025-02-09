<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%@ taglib prefix="tiles" uri="http://tiles.apache.org/tags-tiles"  %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page session="false" %>


<html>
<head>
	<script src="https://code.jquery.com/jquery-1.12.4.min.js"></script>
	<!-- <script type="text/javascript" src="<c:url value='/js/jquery-1.12.4.min.js' />"></script> -->
	<link href="${pageContext.request.contextPath}/resources/css/page.css" rel="stylesheet">
	<script type="text/javascript">
		$(document).ready(function(){
			
			$("#currentPage").val("1");
			searchPgFunc(1);
			
	    });
		
		$(function() {
			
			$(".title").on("keyup",function(key){ 
				if(key.keyCode==13){
					searchPgFunc(1);
				}
			});
			
		});
		
		//List<vo>
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
		
		//조회
		function searchPgFunc(currentPage){
			console.log("currentPage.val : " + $("#currentPage").val());
			console.log("js currentPage: " + currentPage);
	    	var queryString = $("#search_form").serializeArray();
	    	$.ajax({
				url:"<c:url value='/main/searchPg.do'/>",
				type:'post',
				data:queryString,
				dataType : "json",
				success: function(data, status) {
					var boardList = data.boardList;
					var totalCnt = data.totalCnt;
					var paging = data.pagingVo;
					var html = '';
					var seq = '';
					boardList.forEach((row) => {
						
						seq = row.seq;
					    html += '<tr class="dtRow" onclick ="selectDetail(\''+seq+'\');">';
				    	//html += '<td onclick="event.cancelBubble=true;"><input type="checkbox" name="chkFlg" value="'+row.seq+'"></td>';
					    html += '<td>'+ seq +'</td>';
					    html += '<td>'+ row.title +'</td>';
					    html += '<td>'+ row.writer +'</td>';
					    html += '<td>'+ row.regdate +'</td>';
					    html += '<td>'+ row.cnt +'</td>';
					    html += '</tr>';
						
					});
					
					$("#boardList").empty();
					$("#boardList").append(html);
					
					$("#totalCnt").empty();
					$("#totalCnt").append("총" + totalCnt + "건");
					
					$("#pageList").empty();
					$("#pageList").append(paging.pageHtml);
					
					$("#beforePageBtn").val(paging.beforePage);
					$("#afterPageBtn").val(paging.afterPage);
					
					$("#beforePageBtn").show();
					$("#afterPageBtn").show();
					
				},
				error: function (data, status, e) {
					console.log(data); 
					console.log("실패");
				}
			});
	    }
		
		function pageChange(page){
			searchPgFunc(page);
		}
		
		function beforePageBtnClick(){
			if($("#beforePageBtn").val() != 0){
				searchPgFunc($("#beforePageBtn").val());
			}else{
				alert("첫 번째 페이지 입니다.");
			}
		}
		
		function afterPageBtnClick(){
			if($("#afterPageBtn").val() != 0){
				searchPgFunc($("#afterPageBtn").val());
			}else{
				alert("마지막 페이지 입니다.");
			}
		}
		
	</script>
</head>
<body>
	<!--
	화면이동 시<br>
	<button type="button" id="mainBtn" onclick="mainFunc();"> 화면 이동</button>
	-->
	<br>
	<form id="search_form" name="search_form" onsubmit="return false;">
		제목 <input type='text' id='title' class='title' name='title' value=''/>
		
		<input type='hidden' id='currentPage' name='currentPage' value='1'/>
		<input type='hidden' id='pageSize' name='pageSize' value='10'/>
		
		<!-- <button type="button" id="searchBtn" onclick="searchFunc();"> 검색</button> -->
		<button type="button" id="searchPgBtn" onclick="searchPgFunc(1);"> 검색</button>
	</form>
	
	<div id="totalCnt"></div>
	<div >
		<table>
			<colgroup>
				<col style="width: 15%;" />
                <col style="width: 50%;" />
                <col style="width: 15%;" />
                <col style="width: 17%;" />
                <col style="width: 10%;" />
			</colgroup>
			<thead>
				<tr>
					<th>번호</th>
					<th>제목</th>
					<th>작성자</th>
					<th>작성일</th>
					<th>조회수</th>
				</tr>
			</thead>
			<tbody id="boardList">
			</tbody>
		</table>
	</div>
	
	<div id="paging" class="paging">
		<button type="button" id="beforePageBtn" class="beforePageBtn" onclick="beforePageBtnClick()">이전</button>
		<ul id="pageList" class="pageList" ></ul>
	    <button type="button" id="afterPageBtn" onclick="afterPageBtnClick()">다음</button>
	</div>
	
	
</body>
</html>
