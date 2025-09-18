<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<!DOCTYPE html>

<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>PMS | 404</title>
   <spring:url value="/resources/css/header/error.css" var="error" />     
	<link href="${error}" rel="stylesheet" />
</head>
<body>
    <div class="background-bubbles">
        <div class="bubble bubble-1"></div>
        <div class="bubble bubble-2 darkblue"></div>
        <div class="bubble bubble-3"></div>
        <div class="bubble bubble-4 blue"></div>
        <div class="bubble bubble-5 "></div>
        <div class="bubble bubble-6 blue"></div>
        <div class="bubble bubble-7 "></div>
        <div class="bubble bubble-8"></div>
        <div class="bubble bubble-9 blue"></div>
        <div class="bubble bubble-10 darkblue"></div>
    </div>

    <h1>404</h1>
    <h2>Page not found</h2>
    <p>Oops! The page you are looking for does not exist.</p>
    <a href="MainDashBoard.htm">Back to Home</a>
</body>
</html>