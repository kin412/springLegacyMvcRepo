<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<title>Insert title here</title>
	<script src="${pageContext.request.contextPath}/resources/js/jquery-1.12.4.min.js"></script>
	<script src="${pageContext.request.contextPath}/resources/js/common/com-function.js"></script>
	<script type="text/javascript">
		$(document).ready(function(){
			menuList();
	    });
		
		function menuList(){
			$.ajax({
				url:"<c:url value='/menu/menuList.do'/>",
				type:'post',
				//data:queryString,
				dataType : "json",
				success: function(data, status) {
					var menuList = data.menuList;
					var html = '';
					menuList.forEach((row) => {
						
						//number형을 자바에서 int로 받으면 null이 0이 된다.
						if(row.parent_id != 0){
							html+= "ㄴ"
						}
						
						html += '<button type="button" onclick="goMenu(\''+row.menu_url+'\')">'+row.name+'</button><br>';
						
					});
					
					//$("#sideBar2").empty();
					$(".SideBar").append(html);
					
				},
				error: function (data, status, e) {
					console.log(data); 
					console.log("e : " + e);
					console.log("실패");
				}
			});
		}
		
		//관리자 파일첨부 테스트
		function goAdminFileTest(){
			location.href = "<c:url value='/adminFileTest/adminFileTest.do'/>";
		}	
	
		//메인메뉴
		function goMain(){
			location.href = "<c:url value='/main/main.do'/>";
		}
		
		//ajax
		function goAjax(){
			location.href = "<c:url value='/ajax/ajaxMain.do'/>";
		}
		
		function goMenu(url){
			if(url != 0){
				//location.href = '<c:url value="'+url+'"/>'; //왜인지 안됨.
				location.href ="${pageContext.request.contextPath}"+url;
			}
		}
		
	</script>
</head>
<body>
	<div class="SideBar">Side menu<br>
		<!-- 권한 설정 예시 -->
		<!-- db에서 메뉴를 불러올 경우 그냥 로그인한 권한에서 가능한 메뉴만 가져오는게 깔끔 할 것 같아 기록으로만 남김. sec:authorize 태그
		<sec:authorize access="hasRole('ROLE_ADMIN')">
			<button type="button" onclick="goAdminFileTest()">관리자 첨부파일 테스트 페이지</button><br>
		</sec:authorize>
		<button type="button" onclick="goMain()">main</button><br>
		<button type="button" onclick="goAjax()">ajax</button>
		<br>--------<br>
		-->
	</div>
	<!-- 여기쓰면 body를 침범하는데? -->
	
</body>
</html>