<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!-- 현페이지의 데이터는 세션에 담지 않겠다. -->
<%@ page session="false" %>

<%@ taglib prefix="tiles" uri="http://tiles.apache.org/tags-tiles"  %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec" %>



<html>
<head>
	<!-- <script src="https://code.jquery.com/jquery-1.12.4.min.js"></script> -->
	<!-- <script type="text/javascript" src="<c:url value='/js/jquery-1.12.4.min.js' />"></script> -->
	<%-- <script src="${pageContext.request.contextPath}/resources/js/jquery-1.12.4.min.js"></script> --%>
	<script src="${pageContext.request.contextPath}/resources/js/jquery-3.3.1.min.js"></script>
	<script src="${pageContext.request.contextPath}/resources/js/common/com-function.js"></script>
	<link href="${pageContext.request.contextPath}/resources/css/page.css" rel="stylesheet">
	<script type="text/javascript">
		$(document).ready(function(){
			
			//searchPgFunc(${currentPage});
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
			console.log("--searchPgFunc")
			$("#currentPage").val(currentPage);
			
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
					    html += '<tr class="dtRow">';
				    	//html += '<td onclick="event.cancelBubble=true;"><input type="checkbox" name="chkFlg" value="'+row.seq+'"></td>';
					    html += '<td>'+ seq +'</td>';
					    html += '<td onclick ="selectDetail(\''+seq+'\');">'+ row.title +'</td>';
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
		
		//수정화면 페이지 전환형
		function selectDetail(seq){
			location.href = "<c:url value='/main/selectDetail.do?seq="+seq+"'/>";
		}
		
		//구글 smtp 메일 보내기
		function sendEmail(){
			$.ajax({
				url:"<c:url value='/sendMail/sendMail.do'/>",
				type:'get',
				//data:queryString,
				//dataType : "json",
				success: function(data, status) {
					alert("메일이 정상적으로 전송 되었습니다.");
					
				},
				error: function (data, status, e) {
					console.log(data); 
					console.log("실패");
				}
			});
		}
		
		//엑셀 업로드
		function excelUploadProcess(){
			var f = new FormData(document.getElementById('formExcel'));
			$.ajax({
				url: "<c:url value='/excel/uploadExcel.do'/>",
				data: f,
				processData: false,
				contentType: false,
				type: "POST",
				success: function(data){
					console.log(data);
					if(data == 1){
						alert("정상적으로 업로드 되었습니다.");
						searchPgFunc(1);
					}
					
				}
			});
		}
	    
		//엑셀 다운로드
		//보통근데 엑셀 다운은 비동기로 처리하지 않는듯? 너무크니까?
		function excelDownloadProcess(){
			/*
			document.formExcel.target = "hide_frame";
			document.formExcel.action = "<c:url value='/excel/downloadExcel.do'/>";
			document.formExcel.submit();
			*/
			
			$.ajax({
				url: "<c:url value='/excel/downloadExcel.do'/>",
				//data: f,
				processData: false,
				contentType: false,
				type: "POST",
				xhrFields: {
			        responseType: 'blob' // 응답을 Blob 객체로 받음. 이거 하려면 제이쿼리 버전이 3.3.1 이상이어야함
			    },
				success: function(data){
					console.log(data);
					
					alert("파일 다운로드를 시작합니다." );
					console.log("-----data------");
					console.log(data);
					var link = document.createElement('a');
			        link.href = window.URL.createObjectURL(data);
			        link.download = "mainList.xlsx"; // 다운로드시 저장되어 있는 파일이름으로 기본 다운로드 설정
	                link.click();
	                console.log("파일 다운로드 성공");
					
				}
			});
			
		}


		
	</script>
</head>
<body>
	<form id="search_form" name="search_form" onsubmit="return false;">
		제목 <input type='text' id='title' class='title' name='title' value=''/>
		
		<input type='hidden' id='currentPage' name='currentPage' value=1/>
		<input type='hidden' id='pageSize' name='pageSize' value='10'/>
		
		<!-- <button type="button" id="searchBtn" onclick="searchFunc();"> 검색</button> -->
		<button type="button" id="searchPgBtn" onclick="searchPgFunc(1);"> 검색</button>
	</form>
		<!-- security 예시 ROLE_ADMIN인 사용자만 보이게 -->
		<sec:authorize access="hasRole('ROLE_ADMIN')">
			<form id="formExcel" name="formExcel" method="post" enctype="multipart/form-data" onsubmit="return false">
				<input type="file" id="fileInput" name="fileInput">
				<button type="button" onclick="excelUploadProcess()">엑셀업로드</button>
				<button type="button" onclick="excelDownloadProcess()">엑셀다운로드</button>
			</form>
			
			<button type="button" onclick="sendEmail()">메일보내기</button>  *메일보내기는 설정파일에 계정 정보 입력 필요<br>
		</sec:authorize>
		<button type="button" id="insertBoardBtn" onclick="selectDetail(0);"> 새글 등록</button>
	<div id="totalCnt"></div>
	<div>
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
