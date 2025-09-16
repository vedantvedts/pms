<%@page import="org.apache.commons.text.StringEscapeUtils"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"  import="java.util.*,java.text.SimpleDateFormat"%>
 <%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Road Map Status</title>
<jsp:include page="../static/header.jsp"></jsp:include>
<spring:url value="/resources/css/roadMapModule/roadMapTransStatus.css" var="roadMapTransStatus" />
<link href="${roadMapTransStatus}" rel="stylesheet" />

</head>
<body>
<%
List<Object[]> statuslist = (List<Object[]>)request.getAttribute("transactionList");
String roadMapId = (String)request.getAttribute("roadMapId");
%>

	 <div class="page card dashboard-card">
		 <div class="mt-2 mr-5" align="right">
			<form action="#">
				<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
				<input type="hidden" name="roadMapId" value="<%=roadMapId %>" />
				<button type="submit" class="btn btn-sm btn-primary custom-print" formaction="RoadMapTransactionDownload.htm" formmethod="POST" formtarget="_blank" formnovalidate="formnovalidate"
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
						<span class="day"><%=day.format(object[4]) %></span>
						<span class="month"><%=month.format(object[4]) %></span>
						<span class="year"><%=year.format(object[4]) %></span>
					</span>
					    <%
						   String colorCode = (String) object[7];
						   String className = "C" + colorCode.replace("#", "").toUpperCase();
						%>
					<h2 class="<%=className%>"><%=object[6] %> at <%=time.format(object[4]) %></h2> 
					<p class="custom-p">
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