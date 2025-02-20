<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fn"    uri="http://java.sun.com/jsp/jstl/functions" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<title>Insert title here</title>
	<%-- <script src="${pageContext.request.contextPath}/resources/js/jquery-1.12.4.min.js"></script> --%>
	<script src="https://code.jquery.com/jquery-3.3.1.min.js"
		integrity="sha256-FgpCb/KJQlLNfOu91ta32o/NMZxltwRo8QtmkMRdAu8=" crossorigin="anonymous"></script>

	<script src="${pageContext.request.contextPath}/resources/js/common/com-function.js"></script>
	<script type="text/javascript">
		$(document).ready(function(){
			fileList();
	    });
		
		$(function() {
			
			
		});
		
		function fileList(){
			$.ajax({
				url:"<c:url value='/adminFileTest/adminFileList.do'/>",
				type:'post',
				//data:queryString,
				dataType : "json",
				success: function(data, status) {
					
					var html = '';
					
					if(data.length == 0){
						html += "첨부된 파일이 없습니다.";
					}else{
						html +="첨부된 파일 리스트 <br>"
						data.forEach((row) => {
						    html += "<input type='checkbox' name='cb'>	"+ row.seq + " || ";
						    html += '<a onclick="fileDown(\''+row.real_file_name+'\',\''+row.code_file_name+'\')">';
						    html += row.real_file_name + '</a> || ';
						    html += row.code_file_name + " || " + row.regdate + "<br>";
						});
						
					}
					
					$("#fileList").empty();
					$("#fileList").append(html);
					
				},
				error: function (data, status, e) {
					console.log(data); 
					console.log("실패");
				}
			});
		}
		
		function fileUpload(){
			//FormData는 가상의 <form> 태그와 같다. 
			//ajax를 이용하는 파일 업로드는 FormData를 이용해 필요한 파라미터를 담아 전송한다. 
			var formData = new FormData();
			//<input>태그 그 자체를 가져온다. 
			var inputFile = $("input[name='uploadFiles']");
			//.files로 files에 배열 객체를 참조할 수 있다. 
			var files = inputFile[0].files; 
			
			console.log(formData);
			console.log("-------------");
			console.log(inputFile[0]);
			console.log("-------------");
			console.log(files);
			
			//add file data to format
			for(var i=0; i<files.length; i++){
				formData.append("uploadFile", files[i]);
			}
			
			//위는 수동으로 만들어주는 것 이렇게 한큐에 보낼수도 있다.
			//var formData2 = new FormData($('#uploadForm')[0]);
			
			//ajax를 통해 서버의 url로 요청을 보낸다. 그때 formData 객체 자체를 전달함 
			//processData와 contentType은 반드시 false로 지정해야 됨.
			$.ajax({
				url : "<c:url value='/adminFileTest/uploadFile.do'/>",
				processData : false,
				contentType : false,
				enctype: 'multipart/form-data',
				data : formData,
				type : 'POST',
				success : function(result){
					alert("업로드가 정상적으로 처리되었습니다.");
					fileList();
				}
			}); 
			
		}
		
		//다운로드는 ajax와 form인경우 두가지가 다르다
		//1. ajax
		function fileDown(realFileName, codeFileName){
			console.log("--realFileName : " + realFileName);
			console.log("--codeFileName : " + codeFileName);
			
			//querystring 
			//방법 1. form serializeArray()
			//방법 2. 직접 작성 = key1=value&key2=value2&
			var queryString = "real_file_name="+realFileName+"&code_file_name="+codeFileName;
			
			console.log("--queryString : " + queryString);
			$.ajax({
				url:"<c:url value='/adminFileTest/fileDown2.do'/>",
				type:'GET',
				data:queryString,
				xhrFields: {
			        responseType: 'blob' // 응답을 Blob 객체로 받음. 이거 하려면 제이쿼리 버전이 3.3.1 이상이어야함
			    },
				//processData : false,
				//contentType : false,
				//dataType : "json",
				success: function(data) {
					alert("파일 다운로드를 시작합니다." );
					console.log("-----data------");
					console.log(data);
					var link = document.createElement('a');
			        link.href = window.URL.createObjectURL(data);
			        link.download = realFileName; // 다운로드시 저장되어 있는 파일이름으로 기본 다운로드 설정
	                link.click();
	                console.log("파일 다운로드 성공");
					
					//$("#fileList").append(html);
					
				},
				error: function (data, status, e) {
					console.log(data); 
					console.log("실패");
					console.log("--e : "+ e);
				}
			});
			
		}
		
	</script>
</head>
<body>

	관리자 파일첨부 테스트 페이지<br><br>
	<div>
		<div id="fileList">
			
			<!-- 
			<c:choose>
				<c:when test="${fn:length(adminFileTestList) == 0 } ">
					첨부된 파일이 없습니다.
				</c:when>
				<c:otherwise>
					첨부된 파일 리스트
				</c:otherwise>
			</c:choose><br>
			-->
			
		</div>
		
		<br>
		<br>
		
		<!-- 파일 업로드에서는 enctype(인코딩타입)을 multipart/form-data로 반드시 설정 -->
		<!-- 파일업로드 1개 시
		<form action="upload_ok" method="post" enctype="multipart/form-data">
			파일 선택 : <input type="file" name="file">
			<input type="submit" value="전송">
		</form>
		-->
		
		<!-- 파일 두개이상 붙히는거 -->
		<form id="uploadForm" name="uploadForm" method="post" enctype="multipart/form-data">
			파일 선택 : <input type="file" multiple="multiple" name="uploadFiles"> 
			<button type="button" onclick ="fileUpload()">업로드</button>
		</form>
		
		<!-- 다운로드는 ajax와 form인경우 두가지가 다르다  2. a태그 -->
		<!-- a태그 get요청 이미지 다운로드 -->
		<a href="${pageContext.request.contextPath}/adminFileTest/fileDown.do?fileName=ac4aca6e-94ea-46db-84ee-c1c4c5e00a7d_키디언_테스트이미지.jpg">
		a태그 get요청 테스트키디언 다운로드</a>
		
	</div>
	
</body>
</html>