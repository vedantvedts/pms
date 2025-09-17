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

<spring:url value="/resources/css/projectModule/techClosureTrans.css" var="techClosureTransCss"/>
<link rel="stylesheet" type="text/css" href="${techClosureTransCss}">

</head>
<body>
<%
List<Object[]> statuslist = (List<Object[]>)request.getAttribute("TransactionList");
String TransFlag = (String)request.getAttribute("TransFlag");
String closureId = (String)request.getAttribute("closureId");
%>

<div class="page card dashboard-card">
	<div class="mt-2 mr-5" align="right">
		<form action="#">
			<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
			<input type="hidden" name="TransFlag" value="<%=TransFlag %>" />
			<input type="hidden" name="closureId" value="<%=closureId %>" />
			<button type="submit" class="btn btn-sm btn-primary print-btn" formaction="ProjectClosureTransactionDownload.htm" formmethod="POST" formtarget="_blank" formnovalidate="formnovalidate"
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
					<span class="day"><%=object[4]!=null?day.format(object[4]):" - "  %></span>
					<span class="month"><%=object[4]!=null?month.format(object[4]):" - "  %></span>
					<span class="year"><%=object[4]!=null?year.format(object[4]):" - "  %></span>
				</span>
				<%
				   String bgColor = (String) object[7];
				   String bgClass = "BG" + bgColor.replace("#", "").toUpperCase();
				%>
				<h2 class="<%=bgClass%>"><%=object[6]!=null?StringEscapeUtils.escapeHtml4(object[6].toString()): " - " %> at <%=object[4]!=null?time.format(object[4]):" - " %></h2> 
				<p class="trans-bgcolor">
					<span class="remarks_title">Action By : </span>
					<%=object[2]!=null?StringEscapeUtils.escapeHtml4(object[2].toString()): " - " %>, <%=object[3]!=null?StringEscapeUtils.escapeHtml4(object[3].toString()): " - " %><br>
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