<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<c:set var="contextPath" value="${pageContext.request.contextPath}"/>    
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Access Denied</title>
<jsp:include page="../static/dependancy.jsp"></jsp:include>
<style type="text/css">
p{
	text-align: justify !important;
  	text-justify: inter-word;
  	word-wrap: break-word;
  	word-break: normal ;
	font-family: 'Montserrat' sans-serif;
	font-size: 17px;
}
</style>
</head>
<body>
	<div class="container">
		<div class="d-flex justify-content-center">
			<img alt="Licence Expired" src="view/images/licenseexpired.png" style="width: 35rem;">
		</div>
		<div class="d-flex justify-content-center">
			<div>
				<h1>License is Expired..!</h1>
			</div>
		</div>
		<div class="d-flex justify-content-center ml-10 mt-3">
			<div>
				<p>Hi there, your license period is over.</p>
			</div>
		</div>
		<div class="d-flex justify-content-center ml-10" style="margin-top: -1%;">
			<div>
				<p>Please Contact Team Vedant Tech Solutions.</p>
			</div>
		</div>
		<div class="d-flex justify-content-center ml-10 mt-2">
			<div>
				<form action="${contextPath}/login" autocomplete="off" method="post" >
					<button type="submit" class="btn btn-sm submit" >Return to Login</button>
					<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
				</form>
			</div>
		</div>
	</div>
	
</body>
</html>