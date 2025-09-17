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
<spring:url value="/resources/css/projectModule/projectApprovalTracking.css" var="projectApprovalTracking" />
<link href="${projectApprovalTracking}" rel="stylesheet" />

<title>PROJECT STATUS LIST</title>

</head>
<body>
<%SimpleDateFormat sdf=new SimpleDateFormat("dd-MM-yyyy");
List<Object[]> ProjectStatusList=(List<Object[]>) request.getAttribute("ProjectStatusList");
List<Object[]> ProjectApprovalTracking=(List<Object[]>) request.getAttribute("ProjectApprovalTracking");
String InitiationId=(String) request.getAttribute("InitiationId");
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
				<div class="col-md-6 cs-col-6">
				</div>
				<div class="col-md-6">
					<form action="" method="POST" name="myfrm" id="myfrm" align="right" class="cs-form">
					    <button type="submit" class="btn btn-warning btn-sm prints" formaction="ExecutiveSummaryDownload.htm" formtarget="_blank"   >Print Executive Summary</button>&nbsp;&nbsp;
						<button type="submit" class="btn btn-warning btn-sm prints" formaction="ProjectProposalDownload.htm" formtarget="_blank"  >Print Project Proposal</button>&nbsp;&nbsp;
					    <input type="hidden" name="${_csrf.parameterName}"	value="${_csrf.token}" /> 
					    <input type="hidden" name="IntiationId"	value="<%=InitiationId%>" /> 
					</form>
				</div>
				
			</div>    
	      <section id="timeline">
	      
	       <% int count=1;
			 for(Object[] object:ProjectApprovalTracking){
			 SimpleDateFormat month=new SimpleDateFormat("MMM");
			 SimpleDateFormat day=new SimpleDateFormat("dd");
			 SimpleDateFormat year=new SimpleDateFormat("yyyy");
			 SimpleDateFormat time=new SimpleDateFormat("HH:mm");
			 %>
	      
			  <article>
			    <div class="inner">
			      <span class="date">
			        <span class="day"><%=object[5]!=null?day.format(object[1]):" - " %></span>
			        <span class="month"><%=object[5]!=null?month.format(object[1]):" - " %></span>
			        <span class="year"><%=object[5]!=null?year.format(object[1]) :" - "%></span>
			      </span>
			      <h2><%=object[7]!=null?StringEscapeUtils.escapeHtml4(object[7].toString()): " - " %> at <%=object[5]!=null?time.format(object[5]):" - " %></h2> 
				  <p>
				  <span class="remarks_title">Action By : </span>
				  				<%=object[2]!=null?StringEscapeUtils.escapeHtml4(object[2].toString()): " - " %>, <%=object[3]!=null?StringEscapeUtils.escapeHtml4(object[3].toString()): " - " %><br>
				  	<%if(object[6]!= null){%>
				  		<span class="remarks_title">Remarks : </span>
				  				<%=object[6]!=null?StringEscapeUtils.escapeHtml4(object[6].toString()): " - " %>
				  						<%}else{ %> <span class="remarks_title">No Remarks </span> <%} %>
				  </p>
			    </div>
			  </article>
			  
			<%count++;}
 					%> 
			  
		
		</section>
      
      
  
      
            <%-- <div class="main-timeline">

			 <% int count=1;
			 for(Object[] object:ProjectApprovalTracking){%>
 
 
                <div class="timeline">
                    <div class="timeline-icon"><i><%=count %></i></div>
                     
                    <span class="year"><%=object[3] %></span>
                    
                    <div class="timeline-content">
                        <h5 class="title">Remarks</h5>
                        <p class="description">
                            <%=object[2] %>
                        </p>
                    </div>
                </div>
               <%count++;}
 					%> 
        
            </div> --%>
            
            
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