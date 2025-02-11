<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<title>Insert title here</title>
	<script type="text/javascript">
		function logoutBtnClick(){
				location.href = "/app/login/custumLogout.do";
			}
	</script>
</head>
<body>

	관리자 메인페이지 
	<button type="button" style="float: right;" onclick="logoutBtnClick()">로그아웃</button>
</body>
</html>