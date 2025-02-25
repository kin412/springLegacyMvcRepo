<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>


<html>
<head>
	<title>Home</title>
	<script src="${pageContext.request.contextPath}/resources/js/jquery-1.12.4.min.js"></script>
	<script src="${pageContext.request.contextPath}/resources/js/jquery.validate.min.js"></script>
	<script src="${pageContext.request.contextPath}/resources/js/common/com-function.js"></script>
	<link href="${pageContext.request.contextPath}/resources/css/layerPopup.css" rel="stylesheet">
	<script type="text/javascript">
		$(document).ready(function(){
	    	console.log("--login ready--");
	    	$('#id').focus();
	    });
		
		$(function() {
			//이 형태는 이안에서만 동작함
			$('#findPwBtn').click(function () {
				 alert("#findPwBtn.click");
			});
			
			//id 변경 시 중복확인 fg 초기화 - change 시 해당 element에서 포커스가 벗어나야 실행
			$("#userid").change(function(){  
				console.log("userid : " + $("#userid").val());
				console.log("idCheckFg : "+$("#idCheckFg").val());
				$("#idCheckFg").val("1");
			});
			
			// 유효성 검증 비밀번호 조건
			$.validator.addMethod("regex", function(value, element, regex){
			  var regExp = new RegExp(regex);
			  return regExp.test(value);
			});
			
			//id에서 tab시 비밀번호로 이동
			$('#id').keydown(function(e){
				console.log("2");
			        if ( e.keyCode === 9 && !e.shiftKey ) {
			        	console.log("3");
			            $('#submitBtn').focus();
			        }
			});
			
			//유효성 검증
			$("#memberShip_form").validate({
				focusCleanup: true,  // true이면 잘못된 필드에 포커스가 가면 에러를 지움
				focusInvalid: false, // 유효성 검사후 포커스를 무효필드에 둠 꺼놓음
				onclick: false,      // 클릭시 발생됨 꺼놓음
				onkeyup: false,      // 키보드 키가 올라가면 발생됨 꺼놓음
				rules:{
					"userid": {
						required:true,
						minlength : 4
					},
					"userpw": {
						required:true,
						//최소 8 자 및 최대 20 자, 하나 이상의 대문자 or 하나의 소문자 + 하나의 숫자 + 하나의 특수 문자 정규식
						regex:/^(?=.*[a-zA-Z])(?=.*\d)(?=.*[@$!%*?&#.~_-])[A-Za-z\d@$!%*?&#.~_-]{8,20}$/
					},
					"username": {
						required:true,
						minlength : 1
					}
				},
				messages:{
					"userid": {
						required:"id를 입력하세요.",
						minlength: '최소 4자 이상 입력하세요.'
					},
					"userpw": {
						required:"비밀번호를 입력하세요.",
						regex:"비밀번호는 영문 숫자 특수기호 조합 8자리 이상 이어야 합니다."
					},		
					"username": {
						required:"이름을 입력하세요.",
						minlength : '이름을 입력하세요.'
					}
				},
				errorPlacement: function(label, element) {
					label.addClass("invalid-feedback");
					label.insertAfter(element);
				},
				submitHandler: function(form) {
					//$('#loading_dim').addClass('on');
					
					if($("#idCheckFg").val() == '0'){
						if (!confirm("회원가입 하시겠습니까?")) {
							//$('#loading_dim').removeClass('on');
							return false;
						}
						joinMemberShip();
					}else if($("#idCheckFg").val() == '1'){
						alert("ID 중복 확인을 해야합니다.");
						//$("#idCheckBtn").focus();
					}else{
						alert("중복되는 ID는 사용할 수 없습니다.");
						$("#userid").focus();
					}
				}
			});
			
			
		});
		
		function findId(){
			alert("function findId");
		}
		
		function idCheck(){
			var userId = $("#userid").val();
			
			if(userId.length < 4){
				alert("아이디를 4자 이상 입력하세요.");
				return;
			}
			console.log("userId : " + userId);
			
	    	$.ajax({
				url:"<c:url value='/login/idCheck.do'/>",
				type:'get',
				data: {'userid' : userId},
				dataType : "text",
				success: function(data, status) {
					
					console.log("data : " + data);
					
					if(data == 0){
						alert('사용 가능한 ID입니다.');
						$("#idCheckFg").val("0");
					}else{
						alert('중복된 ID입니다.');
						$("#idCheckFg").val("3");
					}
					
					console.log("idCheckFg : " + $("#idCheckFg").val());
					
				},
				error: function (data, status, e) {
					console.log(data); 
					console.log("실패");
				}
			});
			
		}
		
		//회원가입
		function joinMemberShip(){
			var queryString = $("#memberShip_form").serializeArray();
	    	$.ajax({
				url:"<c:url value='/login/joinMemberShip.do'/>",
				type:'post',
				data:queryString,
				dataType : "json",
				success: function(data, status) {
					var message = data.message;
					var result = data.result;
					var auth_result = data.auth_result;
					
					alert(message);
					console.log("result : " + result);
					console.log("auth_result : " + auth_result);
					closePop(1);
					
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

	로그인<br>
	
	<table>
		<tbody>
			<form action="/app/login" method="post">
				<!-- <security:csrf disabled="true"/>가 없다면 로그인 처리시 csrf가 있어야함 -->
				<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
				<tr>
					<td>ID</td>
					<td><input type="text" id="id" name="id"></td>
					<td rowspan='2'>
						<button type="submit" id="submitBtn">로그인</button>
					</td>
				</tr>
				<tr>
					<td>PW</td>
					<td><input type="password" id="pw" name="pw"></td>
					<td>
						
					</td>
				</tr>
				<tr>
					<td>
						<button type="button" onclick="findId()">id 찾기</button>
					</td>
					<td colspan='2'>
						<button type="button" id="findPwBtn">비밀번호 찾기</button>
						<button type="button" onclick="openPop(1)">회원가입</button>
					</td>
				</tr>
			</form>
		</tbody>
	</table>
	
	<!-- 레이어 팝업 -->
	<div class="popup_layer" id="popup_layer1" style="display: none;">
	  <div class="popup_box">
	      <div style="height: 10px; width: 375px; float: top;">
	        <a href="javascript:closePop(1);">
	        	팝업 닫기
	        	<!-- 
	        	<img src="/static/img/ic_close.svg" class="m_header-banner-close" width="30px" height="30px">
	        	-->
	        </a>
	      </div>
	      <!--팝업 컨텐츠 영역-->
	      <div class="popup_cont">
	          <h5>회원가입</h5>
	          	<form id="memberShip_form" name="memberShip_form">
		          	<table>
						<tbody>
							<tr>
								<td>ID*</td>
								<td><input type="text" id="userid" name="userid"></td>
								<td>
									<input type="hidden" id="idCheckFg" value="1">
									<button type="button" id="idCheckBtn" onclick="idCheck()">중복확인</button>
								</td>
							</tr>
							<tr>
								<td>PW*</td>
								<td colspan="2"><input type="password" id="userpw" name="userpw"></td>
							</tr>
							<tr>
								<td>이름*</td>
								<td colspan="2"><input type="text" id="username" name="username"></td>
							</tr>
							<tr>
								<td colspan='3'>
									<button type="button" onclick="$('#memberShip_form').submit();">회원가입</button>
									<button type="button" onclick="closePop(1)">취소</button>
								</td>
							</tr>
						</tbody>
					</table>
				</form>
	      </div>
	      <!--팝업 버튼 영역-->
	      <div class="popup_btn" style="float: bottom; margin-top: 200px;">
	          <a href="javascript:closePop(1);">닫기</a>
	      </div>
	  </div>
	</div>
	
</body>
</html>
