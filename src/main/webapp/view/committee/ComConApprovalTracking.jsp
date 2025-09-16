<%@page import="org.apache.commons.text.StringEscapeUtils"%>
<%@page import="com.ibm.icu.text.DecimalFormat"%>
<%@page import="com.vts.pfms.NFormatConvertion"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="java.util.*,com.vts.*,java.text.SimpleDateFormat"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<jsp:include page="../static/header.jsp"></jsp:include>
<spring:url value="/resources/css/committeeModule/ComConApprovalTracking.css" var="ComConApprovalTracking" />
<link href="${ComConApprovalTracking}" rel="stylesheet" />
<title>PROJECT STATUS LIST</title>
</head>
<body>
<%SimpleDateFormat sdf=new SimpleDateFormat("dd-MM-yyyy");


List<Object[]> historydata=(List<Object[]>)request.getAttribute("historydata");


Object[] projectdata=(Object[])request.getAttribute("projectdata"); 
Object[] divisiondata=(Object[])request.getAttribute("divisiondata"); 
Object[] initiationdata=(Object[])request.getAttribute("initiationdata");

Object[] committeedata=(Object[])request.getAttribute("committeedata");
String initiationid=committeedata[4].toString();
String divisionid=committeedata[3].toString();
String projectid=committeedata[2].toString();
String committeeid=committeedata[1].toString();
String committeemainid=committeedata[0].toString();





DecimalFormat df=new DecimalFormat("0.00");
NFormatConvertion nfc=new NFormatConvertion();
%>



<% 
    String ses = (String) request.getParameter("result");
    String ses1 = (String) request.getParameter("resultfail");
    if (ses1 != null) { %>
    <div align="center">
        <div class="alert alert-danger" role="alert">
            <%=StringEscapeUtils.escapeHtml4(ses1) %>
        </div>
    </div>
<% }if (ses != null) { %>
    <div align="center">
        <div class="alert alert-success" role="alert">
            <%=StringEscapeUtils.escapeHtml4(ses) %>
        </div>
    </div>
<% } %>

<br>	
<div class="container-fluid">		
	<div class="row">
		<div class="col-md-12">		
			<div class="row">
				<div class="col-md-9 card-header headerDiv">
					<h3 class="h3color">
						<%if(Long.parseLong(projectid)>0){ %> Project : <%=projectdata[4]!=null?StringEscapeUtils.escapeHtml4(projectdata[4].toString()): " - " %><%}else if (Long.parseLong(divisionid)>0){ %>  Division : <%=divisiondata[1]!=null?StringEscapeUtils.escapeHtml4(divisiondata[1].toString()): " - " %> <%}else if(Long.parseLong(initiationid)>0){ %>Initiated Project : <%=initiationdata[1]!=null?StringEscapeUtils.escapeHtml4(initiationdata[1].toString()): " - "%> <%} %>
					</h3>			
				</div>
				<div class="col-md-6">
					
				</div>
				
				
			</div>
				
        	
	      <section id="timeline">
	      
	       <% int count=1;
			 for(Object[] object:historydata){
			 SimpleDateFormat month=new SimpleDateFormat("MMM");
			 SimpleDateFormat day=new SimpleDateFormat("dd");
			 SimpleDateFormat year=new SimpleDateFormat("yyyy");
			 SimpleDateFormat time=new SimpleDateFormat("HH:mm");
			 %>
	      
			  <article>
			    <div class="inner">
			      <span class="date">
			        <span class="day"><%=object[6]!=null?day.format(object[6]):" - " %></span>
			        <span class="month"><%=object[6]!=null?month.format(object[6]):" - " %></span>
			        <span class="year"><%=object[6]!=null?year.format(object[6]):" - " %></span>
			      </span>
			      <h2><%=object[7]!=null?StringEscapeUtils.escapeHtml4(object[7].toString()): " - " %> at <%=object[6]!=null?time.format(object[6]):" - " %></h2> 
				  <p>
				  <span class="remarks_title">Action By : </span>
				  				<%=object[8]!=null?StringEscapeUtils.escapeHtml4(object[8].toString()): " - " %>, <%=object[9]!=null?StringEscapeUtils.escapeHtml4(object[9].toString()): " - " %><br>
				  	<%if(object[3]!= null && object[3].toString().trim().length()>0){%>
				  		<span class="remarks_title">Remarks : </span>
				  				<%=StringEscapeUtils.escapeHtml4(object[3].toString()) %>
					<%}else{ %> 
						<span class="remarks_title">No Remarks </span> 
					<%} %>
				  </p>
			    </div>
			  </article>
			  
			<%count++;}
 					%> 
			  
		
		</section>
      
        </div>         
	</div> 
</div>	
	
	
	
	
<script type="text/javascript">

$(function () {
	  $('[data-toggle="tooltip"]').tooltip()
	})


function Prints(myfrm){
	
	 var fields = $("input[name='btSelectItem']").serializeArray();

	 
	  if (fields.length === 0){
		  myalert();
	 event.preventDefault();
	return false;
	}
	 
		  return true;
	 
	}






</script>
</body>
</html>