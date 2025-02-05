<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page session="false" %>
<html>
<head>
	<title>Home</title>
</head>
<body>
<h1>
	Hello world!  
	Hello world!  !!!!!!!!!!!!!!!!!!!!!!
</h1>
<!-- <jsp:include page="/appViews/include/header.jsp"/> -->
<!-- <jsp:include page="../../appViews/include/header.jsp"/> -->
<%-- <%@ include file="../../appViews/include/header.jsp" %> --%>

	<!-- 
		http://localhost:8080/app/WEB-INF/views/home.jsp
		/app/WEB-INF/views/home.jsp
		/app
	 -->

	<br>
	${pageContext.request.requestURL}
	<br>
	${pageContext.request.requestURI}
	<br>
	${pageContext.request.contextPath}
	<br>

<P>  The time on the server is ${serverTime}. </P>

</body>
</html>
