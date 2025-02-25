<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring" %>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>


<!-- 스크립틀릿 예시 -->
<%
	String id = (String)request.getSession().getAttribute("id");
	String sessionId = (String)request.getSession().getId();
	String gp= request.getParameter("param");
	int i= 2;
	
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<title>Insert title here</title>
	<script src="${pageContext.request.contextPath}/resources/js/jquery-1.12.4.min.js"></script>
	<script src="${pageContext.request.contextPath}/resources/js/common/com-function.js"></script>
	<link href="${pageContext.request.contextPath}/resources/css/layerPopup.css" rel="stylesheet">
	<script type="text/javascript">
		$(document).ready(function(){
			//newWindowLocale();
	    });
		
		$(function() {
			
			$("#localeLang").on("change",function(e){ 
				changeLocale();
			});
			
		});
		
		function logoutBtnFunc(){
			var result = confirm("로그아웃 하시겠습니까?");

	        if(!result){
	        	return false;
	        }else{
	        	$("form").submit();
	        }
		}
		
		function scriptletTest(){
			alert('<%=sessionId %>');
		}
		
		function changeLocale(){
			
		}
		
		function changeLocale(){
			var localeLang = $("#localeLang option:selected").val();
			/*
				화면단 ajax에서 이렇게만 달랑 보내면 
				java단에서 paramName : en || pramValue : 
				이런식으로 paramName만 감. value가 없음.
			*/
			var sendData = {"localeLang":localeLang};
			console.log("localeLang : " + localeLang);
			$.ajax({
				url:"<c:url value='/locale/chageLang.do'/>",
				type:'post',
				//data:localeLang,
				//dataType : "json",
				data : sendData,
				success: function(data, status) {
					console.log("locale 전환 성공");
					//location.reload();
					//session변경 값을 새로고침없이 적용할수 있나?
					//다른 몇몇 홈페이지 locale의 경우도 새로고침이 어떻게 안되서 그냥 새창을 띄우는 듯?
					var url = "http://localhost:8080/app/main/main.do?"+localeLang;
					console.log("--url : " + url);
					window.open(url);
					
					//새창 연 이후 기존 창은 locale이 변하지 않았으므로 다시 기존 걸 선택하게 변경
					//하지만 세션값이 변경되었기 때문에 기존창도 새로고침시 언어가 변경되어있음
					//get방식인 화면에서 다른 파라미터가 있을때 문제 ex) seq=178
					if(localeLang=="ko"){
						$("#localeLang").val("en").prop("selected", true);
					}else{
						$("#localeLang").val("ko").prop("selected", true);
					}
					
				},
				error: function (data, status, e) {
					console.log(data); 
					console.log("실패");
				}
			}); 
		}
		
		//locale 변경 시 새창 열렸을 때 파라미터 체크해서 콤보박스 값 설정
		function newWindowLocale(){
			console.log(window.location.search);
			var localeParam = window.location.search;
			var lang = localeParam.substr(1);
			if(lang =='ko' || lang =='en' ){
				console.log("lang : " + lang);
				$("#localeLang").val(lang).prop("selected", true);
			}
			
		}
		
	</script>
</head>
<body>
	<div class="Header">
		Header<br>
		<div style="float:right">
			<button type="button" id="loginInfo" onclick="openPop(1)"><spring:message code="button.loginInfo"/></button>
			<form action="/app/logout" method="POST">
				<!-- <security:csrf disabled="true"/>가 없다면 로그아웃 처리시 csrf가 있어야함 -->
				<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
				<button type="button" onclick="logoutBtnFunc()"><spring:message code="button.logout"/></button>
			</form>
			<button type="button" onclick="scriptletTest()"><spring:message code="button.scriptletTest"/></button><br>
			<select id="localeLang" name="localeLang" size="1">
				<option value="ko">한국어</option>
				<option value="en">English</option>
			</select>
		</div>
	</div>
	
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
	        <h5>로그인 정보</h5>
	      	<h5>principal : </h5> <sec:authentication property="principal"/><br>
			<h5>memberVo : </h5> <sec:authentication property="principal.memberVo"/><br>
			<h5>사용자 이름 : </h5> <sec:authentication property="principal.memberVo.username"/><br>
			<h5>사용자 아이디 : </h5> <sec:authentication property="principal.memberVo.userid"/><br>
			<h5>소유 권한 : </h5> <sec:authentication property="principal.memberVo.authlist"/><br>
	      </div>
	      <!--팝업 버튼 영역-->
	      <div class="popup_btn" style="float: bottom; margin-top: 200px;">
	          <a href="javascript:closePop(1);">닫기</a>
	      </div>
	  </div>
	</div>
	
</body>
</html>