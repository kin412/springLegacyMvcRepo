<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec" %>
    
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
	    	
	    });
		
		$(function() {
			
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
		
	</script>
</head>
<body>
	<div class="Header">
		Header<br>
		<div style="float:right">
			<button type="button" onclick="openPop(1)">로그인정보</button>
			<form action="/app/logout" method="POST">
				<!-- <security:csrf disabled="true"/>가 없다면 로그아웃 처리시 csrf가 있어야함 -->
				<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
				<button type="button" onclick="logoutBtnFunc()">로그아웃</button>
			</form>
			<button type="button" onclick="scriptletTest()">스크립틀릿 테스트</button>
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