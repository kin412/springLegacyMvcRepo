<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%@ taglib prefix="tiles" uri="http://tiles.apache.org/tags-tiles"  %>
<%@ taglib prefix="c" 	  uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn"    uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ page session="false" %>


<html>
<head>
	<!-- <script src="https://code.jquery.com/jquery-1.12.4.min.js"></script> -->
	<!-- <script type="text/javascript" src="<c:url value='/js/jquery-1.12.4.min.js' />"></script> -->
	<script src="${pageContext.request.contextPath}/resources/js/jquery-1.12.4.min.js"></script>
	<link href="${pageContext.request.contextPath}/resources/css/page.css" rel="stylesheet">
	<script type="text/javascript">	
	
		$(document).ready(function(){
			initPage();
	    });
		
		$(function() {
			
		});
		
		//등록, 수정 화면에 따른 화면 조절
		function initPage(){
			
			if(${detail.seq} == '0'){
				//등록
				$("#modiButtonSet").show();
				$("#basicButtonSet").hide();
				
				$("#modiSubmitBtn").empty();
				$("#modiSubmitBtn").append("글 등록");
				$("#modiCancelBtn").empty();
				$("#modiCancelBtn").append("등록 취소");
				
				$("#titleTd").empty();
				$("#titleTd").append('글 제목 : <input type="text" id="title">');
				$("#contentTd").empty();
				$("#contentTd").append('글 내용 : <input type="textarea" id="content">');
				
				$("#detailTr").remove();
				
				
			}else{
				//수정
				$("#modiButtonSet").hide();
			}
			
			
			
		}
		
		function modiFormBtnClick(){
			
			var title = $("#hiddenTitle").val();
			var content = $("#hiddenContent").val();
			
			$("#titleTd").empty();
			$("#titleTd").append('<input type="text" id="title" value="'+title+'">');
			$("#contentTd").empty();
			$("#contentTd").append('<input type="textarea" id="content" value="'+content+'">');
			
			$("#basicButtonSet").hide();
			$("#modiButtonSet").show();
		}
		
		function modiCancelBtnClick(){
			
			if(${detail.seq} == '0'){
				//등록취소
				location.href = "<c:url value='/main/main.do'/>";
			}else{
				//수정취소
				var title = $("#hiddenTitle").val();
				var content = $("#hiddenContent").val();
				
				$("#titleTd").empty();
				$("#titleTd").append(title);
				$("#contentTd").empty();
				$("#contentTd").append(content);
				
				$("#basicButtonSet").show();
				$("#modiButtonSet").hide();
			}
		}
		
		//등록&수정
		function modiSubmitBtnClick(){
			
			$("#hiddenTitle").val($("#title").val());
			$("#hiddenContent").val($("#content").val());
			
	    	var queryString = $("#modify_form").serializeArray();
	    	$.ajax({
				url:"<c:url value='/main/createAndUpdateDetail.do'/>",
				type:'post',
				data:queryString,
				dataType : "json",
				success: function(data, status) {
					var message = data.message;
					var seq = data.seq;
					
					alert(message);
					
					selectDetail(seq);
					
				},
				error: function (data, status, e) {
					console.log(data); 
					console.log("실패");
				}
			});
	    }
		
		function selectDetail(seq){
			location.href = "<c:url value='/main/selectDetail.do?seq="+seq+"'/>";
		}
		
		//글삭제
		function delBtnClick(){
			var queryString = $("#modify_form").serializeArray();
	    	$.ajax({
				url:"<c:url value='/main/deleteDetail.do'/>",
				type:'post',
				data:queryString,
				dataType : "json",
				success: function(data, status) {
					var message = data.message;
					
					alert(message);
					
					location.href = "<c:url value='/main/main.do'/>";
					
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
	<div>
		<table>
			<colgroup>
				<col style="width: 25%;" />
				<col style="width: 30%;" />
				<col style="width: 20%;" />
				<col style="width: 25%;" />
			</colgroup>
			
			<form id="modify_form" name="modify_form" onsubmit="return false;">
				<input type="hidden" id="hiddenSeq" name="seq" value=${detail.seq}>
				<input type="hidden" id="hiddenTitle" name="title" value=${detail.title}>
				<input type="hidden" id="hiddenContent" name="content" value=${detail.content}>
				
				<tbody id="detailList">
					<tr>
						<td id="titleTd" colspan='4'>${detail.title}</td>
					</tr>
					<tr id="detailTr">
						<td>${detail.seq} ||</td>
						<td>${detail.writer} ||</td>
						<td>${detail.regdate} ||</td>
						<td>${detail.cnt}</td>
					</tr>
					<tr>
						<td id="contentTd" colspan='4'>${detail.content}</td>
					</tr>
				</tbody>
			</form>
		</table>
	</div>
	
	<div id="basicButtonSet">
		<button type="button" id="modiFormBtn" class="modiFormBtn" onclick="modiFormBtnClick()">수정</button>
		<button type="button" id="delBtn" class="delBtn" onclick="delBtnClick()">삭제</button>
		<button type="button" id="listBtn" class="listBtn" onclick="window.history.back()">목록으로</button>
	</div>
	
	<div id="modiButtonSet">
		<button type="button" id="modiSubmitBtn" class="modiSubmitBtn" onclick="modiSubmitBtnClick()">수정완료</button>
		<button type="button" id="modiCancelBtn" class="modiCancelBtn" onclick="modiCancelBtnClick()">수정취소</button>
	</div>
	
</body>
</html>
