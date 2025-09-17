<%@page import="org.apache.commons.text.StringEscapeUtils"%>
<%@page import="java.util.regex.Matcher"%>
<%@page import="java.util.regex.Pattern"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"  import="java.util.*,java.text.SimpleDateFormat"%>
 <%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>History</title>
<jsp:include page="../static/header.jsp"></jsp:include>
<spring:url value="/resources/css/projectModule/initiationFlowTrack.css" var="initiationFlowTrack" />
<link href="${initiationFlowTrack}" rel="stylesheet" />

</head>
<body>
<%
List<Object[]> EnoteTransactionList = (List<Object[]>)request.getAttribute("EnoteTransactionList");
%>

<div class="page card dashboard-card">
	<section id="timeline">
		<% int count=1;
	       	 SimpleDateFormat month=new SimpleDateFormat("MMM");
			 SimpleDateFormat day=new SimpleDateFormat("dd");
			 SimpleDateFormat year=new SimpleDateFormat("yyyy");
			 SimpleDateFormat time=new SimpleDateFormat("HH:mm");
			 if(EnoteTransactionList!=null && EnoteTransactionList.size()>0){
			 for(Object[] object:EnoteTransactionList){
			 
		%>
	      <article>
		  	<div class="inner">
				<span class="date">
					<span class="day"><%=day.format(object[4]) %></span>
					<span class="month"><%=month.format(object[4]) %></span>
					<span class="year"><%=year.format(object[4]) %></span>
				</span>
				<%
				String extractedWord=null;
				String originalString = object[6].toString();
				Pattern pattern = Pattern.compile("^\\w+"); // Define a pattern to match the first word
				Matcher matcher = pattern.matcher(originalString);
				if (matcher.find()) {
				    extractedWord = matcher.group(); // Get the matched word
				    System.out.println(extractedWord); // This will display "Recommended"
				}
				%>
			    <%
				   String colorCode = (String) object[7];
				   String className = "C" + colorCode.replace("#", "").toUpperCase();
				%>
				<h2 class="<%=className%>"><%=extractedWord!=null?StringEscapeUtils.escapeHtml4(extractedWord): " - "%> at <%=time.format(object[4]) %></h2> 
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
		<%count++;}}%> 		
	</section>	
</div>
</body>
</html>