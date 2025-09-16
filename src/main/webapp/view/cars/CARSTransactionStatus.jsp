<%@page import="org.apache.commons.text.StringEscapeUtils"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"  import="java.util.*,java.text.SimpleDateFormat"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
 
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Transaction Status</title>
<jsp:include page="../static/header.jsp"></jsp:include>
<spring:url value="/resources/css/cars/CARSTransactionStatus.css" var="carsTransactionStatus" />
<link href="${carsTransactionStatus}" rel="stylesheet" />
<spring:url value="/resources/css/cars/carscommon.css" var="carscommon1" />
<link href="${carscommon1}" rel="stylesheet" />



</head>
<body>
<%
List<Object[]> statuslist = (List<Object[]>)request.getAttribute("TransactionList");
String TransFlag = (String)request.getAttribute("TransFlag");
String carsInitiationId = (String)request.getAttribute("carsInitiationId");
%>

<div class="page card dashboard-card">
	<div class="mt-2 mr-5" align="right">
		<form action="#">
			<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
			<input type="hidden" name="TransFlag" value="<%=TransFlag %>" />
			<input type="hidden" name="carsInitiationId" value="<%=carsInitiationId %>" />
			<button type="submit" class="btn btn-sm btn-primary print-bg" formaction="CARSTransactionDownload.htm" formmethod="POST" formtarget="_blank" formnovalidate="formnovalidate"
			 >Print &emsp; <img alt="" src="view/images/trackingPrint.png"> </button>
		</form>
	</div>
	<section id="timeline">
		<% int count=1;
	       	 SimpleDateFormat month=new SimpleDateFormat("MMM");
			 SimpleDateFormat day=new SimpleDateFormat("dd");
			 SimpleDateFormat year=new SimpleDateFormat("yyyy");
			 SimpleDateFormat time=new SimpleDateFormat("HH:mm");
			 for(Object[] object:statuslist){
			 
		%>
	      <article>
		  	<div class="inner">
				<span class="date">
					<span class="day"><%=object[4]!=null?day.format(object[4]) :" - "%></span>
					<span class="month"><%=object[4]!=null?month.format(object[4]):" - " %></span>
					<span class="year"><%=object[4]!=null?year.format(object[4]):" - " %></span>
				</span>
				<h2 class="bg-color-<%=object[7].toString().replace("#","").trim() %>" ><%=object[6]!=null?StringEscapeUtils.escapeHtml4(object[6].toString()): " - " %> at <%=object[4]!=null?time.format(object[4]):" - " %></h2> 
				<p class="p-bg">
					<span class="remarks_title">Action By : </span>
					<%if(object[2]!=null) {%> <%=StringEscapeUtils.escapeHtml4(object[2].toString()) %><%} else{%><%=object[9]!=null?StringEscapeUtils.escapeHtml4(object[9].toString()): " - " %><%} %> , <%if(object[3]!=null) {%> <%=StringEscapeUtils.escapeHtml4(object[3].toString()) %><%} else{%>Expert<%} %><br>
					<%if(object[5]!= null) { %>
						<span class="remarks_title">Remarks : </span>
							<%=StringEscapeUtils.escapeHtml4(object[5].toString()) %>
					<%}else{ %> 
						<span class="remarks_title">No Remarks </span> 
					<%} %>
				</p>
			 </div>
		 </article>
		<%count++;}%> 		
	</section>	
	
</div>
</body>
</html>