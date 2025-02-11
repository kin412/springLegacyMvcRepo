<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%@ taglib prefix="tiles" uri="http://tiles.apache.org/tags-tiles"  %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page session="false" %>


<html>
<head>
	<title><tiles:insertAttribute name="title" /></title>
	<meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">
	<script src="https://code.jquery.com/jquery-1.12.4.min.js"></script>
	<!-- <script type="text/javascript" src="<c:url value='/js/jquery-1.12.4.min.js' />"></script> -->
	<link href="${pageContext.request.contextPath}/resources/css/common.css" rel="stylesheet">
	
	<script type="text/javascript">
		$(document).ready(function(){
			
	    });
		
		$(function() {
			
		});
		
	</script>
</head>
<body>
	<div class='wrap'>
  		<tiles:insertAttribute name="header" />
		  <div class='content'>  	
  			<tiles:insertAttribute name="left"/>
	  		<div class="page_content">
	  			<tiles:insertAttribute name="body"/>
	  		</div>
  		</div>
  		<tiles:insertAttribute name="foot" />
  	</div>	
</body>
</html>
