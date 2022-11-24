<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
 <%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>


<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Action Tree</title>
<jsp:include page="../static/dependancy.jsp"></jsp:include>
<spring:url value="/resources/plugins/HTree/HTree.css" var="HTreecss" />
<link href="${HTreecss}" rel="stylesheet" />
<spring:url value="/resources/plugins/HTree/HTree.js" var="HTreejs" />
<script src="${HTreejs}"></script>

</head>
<body>
<%
List<Object[]> actionslist = (List<Object[]>)request.getAttribute("actionslist");
%>

<%=actionslist.size()%>
<div class="body genealogy-body genealogy-scroll">
    <div class="genealogy-tree">
        <ul>
        
        	<%for(Object[] action : actionslist){ %>
	            <li>
	                <a href="javascript:void(0);">
	                    <div class="member-view-box" align="center">
	                        <div class="member-image" align="center" >
	                            <div>
	                            	
	                            </div>
	                            <div class="member-details" align="center">
	                                <h5></h5>
	                            </div>
	                        </div>
	                    </div>
	                </a>
	          <%} %>
	                <ul class="active">
	                	
	                
	                </ul>
	            </li>
        </ul>
    </div>
</div>
    
</body>
</html>