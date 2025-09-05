<%@page import="org.apache.commons.text.StringEscapeUtils"%>
<%@page import="com.ibm.icu.text.DecimalFormat"%>
<%@page import="com.vts.pfms.NFormatConvertion"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="java.util.*,com.vts.*,java.text.SimpleDateFormat"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<jsp:include page="../static/header.jsp"></jsp:include>
<%-- <jsp:include page="../static/sidebar.jsp"></jsp:include> --%>
<title>PROJECT STATUS LIST</title>
<style type="text/css">
/* #wrapper{
	background-color: white !important;
} */


  html, body {
    margin: 0;
    padding: 0;
    font-family: Helvetica, sans-serif;
  }
  body {
    background: #25303B;
  }
  section#timeline {
    width: 80%;
    margin: 20px auto;
    position: relative;
  }
  section#timeline:before {
    content: '';
    display: block;
    position: absolute;
    left: 50%;
    top: 0;
    margin: 0 0 0 -1px;
    width: 2px;
    height: 100%;
    background:black;
  }
  section#timeline article {
    width: 100%;
    margin: 0 0 20px 0;
    position: relative;
  }
  section#timeline article:after {
    content: '';
    display: block;
    clear: both;
  }
  section#timeline article div.inner {
    width: 40%;
    float: left;
    margin: 5px 0 0 0;
    border-radius: 6px;
  }
  section#timeline article div.inner span.date {
    display: block;
    width: 70px;
    height: 65px;
    padding: 5px 0;
    position: absolute;
    top: 0;
    left: 50%;
    margin: 0 0 0 -32px;
    border-radius: 100%;
    font-size: 12px;
    font-weight: 900;
    text-transform: uppercase;
    background: #25303B;
    color: rgba(255,255,255,0.5);
    border: 2px solid rgba(255,255,255,0.2);
    box-shadow: 0 0 0 7px #25303B;
  }
  section#timeline article div.inner span.date span {
    display: block;
    text-align: center;
  }
  section#timeline article div.inner span.date span.day {
    font-size: 12px;
  }
  section#timeline article div.inner span.date span.month {
    font-size: 13px;
  }
  section#timeline article div.inner span.date span.year {
    font-size: 9px;
  }
  section#timeline article div.inner h2 {
    padding: 10px;
    margin: 0;
    color: #fff;
    font-size: 14px;
    text-transform: uppercase;
    letter-spacing: 0px;
    border-radius: 6px 6px 0 0;
    position: relative;
    font-family: 'Muli',sans-serif;
  }
  section#timeline article div.inner h2:after {
    content: '';
    position: absolute;
    top: 20px;
    right: -5px;
      width: 10px; 
      height: 10px;
    -webkit-transform: rotate(-45deg);
  }
  section#timeline article div.inner p {
    padding: 15px;
    margin: 0;
    font-size: 14px;
    background: #fff;
    color: #656565;
    border-radius: 0 0 6px 6px;
    font-family: 'Lato',sans-serif;
  }
  section#timeline article:nth-child(2n+2) div.inner {
    float: right;
  }
  section#timeline article:nth-child(2n+2) div.inner h2:after {
    left: -5px;
  }
  section#timeline article:nth-child(1) div.inner h2 {
    background: #e74c3c;
  }
  section#timeline article:nth-child(1) div.inner h2:after {
    background: #e74c3c;
  }
  section#timeline article:nth-child(2) div.inner h2 {
    background: #2ecc71;
  }
  section#timeline article:nth-child(2) div.inner h2:after {
    background: #2ecc71;
  }
  section#timeline article:nth-child(3) div.inner h2 {
    background: #e67e22;
  }
  section#timeline article:nth-child(3) div.inner h2:after {
    background: #e67e22;
  }
  section#timeline article:nth-child(4) div.inner h2 {
    background: #1abc9c;
  }
  section#timeline article:nth-child(4) div.inner h2:after {
    background: #1abc9c;
  }
  section#timeline article:nth-child(5) div.inner h2 {
    background: #9b59b6;
  }
  section#timeline article:nth-child(5) div.inner h2:after {
    background: #9b59b6;
  }

/* timeline customization */

.remarks_title{
	font-size: 12px;
	font-weight: 800;
	color:black;
}
h2{
background:#b39999 ;
}

</style>
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
				<div class="col-md-6" style="margin-bottom: 10px;margin-top: -25px">
					<!-- <h5> Project Title : </h5> -->
				</div>
				<div class="col-md-6">
					<form action="" method="POST" name="myfrm" id="myfrm" align="right" style="margin-bottom: 10px;margin-top: -25px">
					    <button type="submit" class="btn btn-warning btn-sm prints" formaction="ExecutiveSummaryDownload.htm" formtarget="_blank"   >Print Executive Summary</button>&nbsp;&nbsp;
						<button type="submit" class="btn btn-warning btn-sm prints" formaction="ProjectProposalDownload.htm" formtarget="_blank"  >Print Project Proposal</button>&nbsp;&nbsp;
					    <input type="hidden" name="${_csrf.parameterName}"	value="${_csrf.token}" /> 
					    <input type="hidden" name="IntiationId"	value="<%=InitiationId%>" /> 
					</form>
				</div>
				
			</div>
        		<%-- <form action="" method="POST" name="myfrm" id="myfrm" align="right" style="margin-bottom: 10px;margin-top: -25px">
				    <button type="submit" class="btn btn-warning btn-sm prints" formaction="PfmsPrint.htm" formtarget="_blank"   >Print Executive Summary</button>&nbsp;&nbsp;
					<button type="submit" class="btn btn-warning btn-sm prints" formaction="PfmsPrint2.htm" formtarget="_blank"  >Print Project Proposal</button>&nbsp;&nbsp;
				    <input type="hidden" name="${_csrf.parameterName}"	value="${_csrf.token}" /> 
				    <input type="hidden" name="IntiationId"	value="<%=InitiationId%>" /> 
				</form> --%>        
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