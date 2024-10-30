<%@page import="java.util.stream.Collectors"%>
<%@page import="java.util.Arrays"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<jsp:include page="../static/header.jsp"></jsp:include>

<style type="text/css">

label {
	font-weight: 800;
	font-size: 16px;
	color: #07689f;
}

.center {
	text-align: center !important;
}

.right {
	text-align: right !important;
}

.left {
	text-align: left !important;
}

.fw-bold {
	font-weight: bold;
}

.tabpanes1 {
	min-height: 690px;
    max-height: 690px;
    overflow-y: auto; /* Vertical scrollbar */
  	overflow-x: hidden; /* Optional if no horizontal scroll */
    scrollbar-width: thin;
    scrollbar-height: thin;
  	scrollbar-color: #007bff #f8f9fa;
}

/* Chrome, Edge, and Safari */
.tabpanes1::-webkit-scrollbar{
  width: 12px;
}

.tabpanes1::-webkit-scrollbar-track{
  background: #f8f9fa;
  border-radius: 5px;
}

.tabpanes1::-webkit-scrollbar-thum{
  background-color: #007bff;
  border-radius: 5px;
  border: 2px solid #f8f9fa;
}

 .trackingTable {
	width: 100%;
	border-collapse: collapse;
	border: 1px solid #ced4da;
	padding: 1rem;
	overflow-y: auto; 
	overflow-x: auto; 
	font-family: 'Muli' !important;
}

.trackingTable thead {
	position: sticky;
	top: 0; /* Keeps the header at the top */
	z-index: 10; /* Ensure the header stays on top of the body */
	background-color: white; /* For visibility */
}

.trackingTable tbody{
	font-size: 1rem !important;
}

.trackingTable th {
	text-align: center;
	font-size: 1.2rem !important;
	border: 1px solid #ced4da;
	padding: 10px;
}

.trackingTable td {
	border: 1px solid #ced4da;
	padding: 0.2rem;
}

.link-button {
	margin-right: 0.25rem;
	margin-left: 0.25rem;
	/* margin-top: 0.5rem; */
	width: 97%;
	border-radius: 0.75rem;
	border: 3px solid #007bff; 
}

</style>

<style type="text/css">
/* Tracking Line */
.tracking-container {
  /* position: relative; */
  width: 90%;
  height: 3rem;
  display: flex;
  justify-content: space-between;
  align-items: center;
  margin-bottom: 2rem;
  margin-left: 3%;
  margin-top: 1.5%;

}

.tracking-line {
  /* position: absolute; */
  top: 50%;
  left: 0;
  width: 15%;
  height: 6px;
  background-color: #ced4da;
  z-index: 0;
}

.tracking-line.active {
  background-color: #28a745;
}

.track-btn {
  /* position: relative; */
  z-index: 1;
  background-color: #ced4da;
  border: 2px solid #ced4da;
  border-radius: 2rem;
  width: 2.5rem;
  height: 2.2rem;
  display: flex;
  justify-content: center;
  align-items: center;
  font-size: 1rem;
  cursor: pointer;
}

.track-btn.active {
  background-color: #28a745;
  border: 2px solid #28a745;
  color: #fff;
}

.minus {
  font-size: 1rem;
  color: #007bff;
  margin: 0 0.5rem;
}

/* @media (max-width: 768px) {
  .tracking-container {
    flex-direction: column;
    height: auto;
  }
  .tracking-line {
    width: 2px;
    height: 100%;
  }
}  */

/* Tracking Header */
.tracking-header-container {
  position: relative;
  width: 98%;
  height: 3rem;
  display: flex;
  justify-content: space-between;
  align-items: center;
  /* margin-bottom: 2rem; */
  margin-left: 1%;
  margin-right: 1%; 
}
</style>

<style type="text/css">
.custom-tooltip {
    position: absolute;
    background-color: #fff7e3;
    color: black;
    padding: 5px;
    border-radius: 3px;
    z-index: 9999;
    box-shadow: 0px 0px 9px black;
}

 .message-blue:after {
    content: '';
    position: absolute;
    width: 0;
    height: 0;
    border-top: 15px solid black;
    border-left: 15px solid transparent;
    top: 0;
    left: -15px;
} 

 .blueBottom:after {
    content: '';
    position: absolute;
    width: 0;
    height: 0;
    border-top: 15px solid black;
    border-left: 15px solid transparent;
    bottom: 0;
    left: -15px;
    
    transform: rotate(90deg);
    
}

#TooltipStyle {
	margin: 0.3rem;
}
 
#TooltipStyle td {
	font-size: 1rem;
	border-collapse: collapse;
    border-color: white; 
    font-family: 'Muli' !important;
    font-weight: 900;
}

</style>
</head>
<body>
<%
List<Object[]> intiationList = (List<Object[]>)request.getAttribute("initiationList");

%>

<% String ses=(String)request.getParameter("result");
 	String ses1=(String)request.getParameter("resultfail");
	if(ses1!=null){
	%>
	<div align="center">
		<div class="alert alert-danger" role="alert">
	    <%=ses1 %>
	    </div>
	</div>
	<%}if(ses!=null){ %>
	<div align="center">
		<div class="alert alert-success" role="alert" >
	    	<%=ses %>
		</div>
	</div>
<%} %>

	<div class="container-fluid mb-3">
		<div class="card shadow-nohover">
 			<div class="card-header" style="background-color: transparent;height: 3rem;">
 				<div class="row">
 					<div class="col-md-3">
 						<h3 class="text-dark" style="font-weight: bold;">CARS Report</h3>
 					</div>
 					<div class="col-md-7"></div>
 					<div class="col-md-2 right">
 						<a class="btn btn-sm btn-outline-success" href="CARSReportPresentation.htm" target="_blank" title="CARS Presentation">
								<img alt="" src="view/images/presentation.png" style="width:19px !important">
						</a>
	 					<!-- <form action="#" method="post">
							<input type="hidden" name="ccmScheduleId" value="81">
							<input type="hidden" name="committeeId" value="12">
							<input type="hidden" name="_csrf" value="2be07c98-e96d-4306-8db3-b4f4fa6555ae">
				        									
    						
						</form> -->
 					</div>
 				</div>
 			</div>
 			<div class="card-body">
 				<div class="table-responsive tabpanes1"> 
					<table class=" trackingTable">
						<thead>  
							<tr>
								<th style="width: 15%;">CARS No</th>
								<th style="width: 85%;">
									<div class="tracking-header-container">
										<div>&emsp;Initiation</div>
										<div>&emsp;RSQR Approval</div>
										<div>&emsp;&emsp;SoC Details</div>
										<div>&emsp;&emsp;SoC Approval</div>
										<div>&emsp;&emsp;MoM Upload</div>
										<div>&emsp;&emsp;DP&C Approval</div>
										<div>Contract Signature</div>
										<div>Milestone Payment</div>
									</div>
								</th>
							</tr>
						</thead>
						<tbody>
							<%if(intiationList!=null && intiationList.size()>0) {
								for(Object[] obj : intiationList) {
									List<String> transactionCodes = Arrays.asList(obj[15].toString().split(","));
									int actualMilestoneCount = Integer.parseInt(obj[17].toString());
									int approvedMilestoneCount = transactionCodes.stream().filter(e -> e.equalsIgnoreCase("MAD")).collect(Collectors.toList()).size();
									int count = 1;
									
									String projectName = obj[4].toString().replaceAll("'", "\\\\'")
													        			  .replaceAll("\"", "\\\\\"")
													        			  .replaceAll("\n", "")
													        			  .replaceAll("\r", "");
									
									String amount = String.format("%.2f", Double.parseDouble(obj[20]!=null?obj[20].toString():obj[13].toString())/100000);
									int milestoneProgress = actualMilestoneCount!=0? (int)(((double)approvedMilestoneCount / actualMilestoneCount) * 100):0;
									
							%>
								<tr>
									<td id="AppendProjectDetails" onmouseout="HideProjectDetails()" class="AppendProjectDetails center">
										<form action="#">
                                        	<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
                                       	  	<button type="submit" class="btn btn-outline-primary link-button" formaction=CARSTransStatus.htm value="<%=obj[0] %>" name="carsInitiationId"  data-toggle="tooltip" data-placement="top" formtarget="_blank"
                                       	  	 onmouseover="ShowProjectDetails('<%=obj[2] %>','<%=projectName %>','<%=obj[18] %>','<%=obj[33]!=null?obj[33]:(obj[8]!=null?obj[8]:"-") %>','<%=amount %>')">
							    				<%=obj[2] %>
							    			</button>
                                     	</form>
									</td>
									<td colspan="8">
						             	<div class="tracking-container">
						                  
						             		<!-- Initiation Button -->
											<button type="button" class="track-btn active" data-toggle="tooltip" title="Initiation">
												<i class="fa fa-check" aria-hidden="true"></i>
											</button>
						                  
						                  
											<div class="tracking-line <%if(transactionCodes.contains("AGD") || transactionCodes.contains("APD")) { ++count;%>active<%} %>"
						                   		<%if(count<=1) {%> style="background: linear-gradient(to right, #28a745 25%, #ced4da 25%);" <%} %> >
						                    </div>
						                  
						                    <!-- Approval Button -->
						                    <button type="button" class="track-btn <%if(transactionCodes.contains("AGD") || transactionCodes.contains("APD")) {%>active<%} %>" data-toggle="tooltip" title="RSQR Approval">
						                  		<%if(transactionCodes.contains("AGD") || transactionCodes.contains("APD")) {%>
						                    		<i class="fa fa-check" aria-hidden="true"></i>
						                    	<%} %>
						                  	</button>
						                  
						                  
						                  	<div class="tracking-line <%if(transactionCodes.contains("SIN")) { ++count;%>active<%} %>"
										  		<%if(count>1 && count<=2) {%> style="background: linear-gradient(to right, #28a745 25%, #ced4da 25%);" <%} %> >
						                  	</div>
						                  
						                  	<!-- SoC Button -->
						                  	<button type="button" class="track-btn <%if(transactionCodes.contains("SIN")) {%>active<%} %>" data-toggle="tooltip" title="SoC Details">
						                  		<%if(transactionCodes.contains("SIN")) {%>
						                    		<i class="fa fa-check" aria-hidden="true"></i>
						                    	<%} %>
						                  	</button>
						                  
						                  
						                  	<div class="tracking-line <%if(transactionCodes.contains("SFG") || transactionCodes.contains("SFP")) { ++count;%>active<%} %>"
										  		<%if(count>2 && count<=3) {%> style="background: linear-gradient(to right, #28a745 25%, #ced4da 25%);" <%} %> >
						                  	</div>
						                  
						                  	<!-- SoC Approval Button -->
						                  	<button type="button" class="track-btn <%if(transactionCodes.contains("SFG") || transactionCodes.contains("SFP")) {%>active<%} %>" data-toggle="tooltip" title="SoC Approval">
						                  		<%if(transactionCodes.contains("SFG") || transactionCodes.contains("SFP")) {%>
						                    		<i class="fa fa-check" aria-hidden="true"></i>
						                    	<%} %>
						                  	</button>
						                  
						                  
						                  	<div class="tracking-line <%if(obj[16]!=null) { ++count;%>active<%} %>"
										  		<%if(count>3 && count<=4) {%> style="background: linear-gradient(to right, #28a745 25%, #ced4da 25%);" <%} %> >
						                  	</div>
						                  
						                  	<!-- MoM Upload Button -->
						                  	<button type="button" class="track-btn <%if(obj[16]!=null) {%>active<%}%>" data-toggle="tooltip" title="MoM Upload">
						                  		<%if(obj[16]!=null) {%>
						                    		<i class="fa fa-check" aria-hidden="true"></i>
						                    	<%} %>
						                  	</button>
						                  
						                  
						                  	<div class="tracking-line <%if(obj[14]!=null && obj[14].toString().equalsIgnoreCase("A")) { ++count;%>active<%} %>"
										  		<%if(count>4 && count<=5) {%> style="background: linear-gradient(to right, #28a745 25%, #ced4da 25%);" <%} %> >
						                  	</div>
						                  
						                  	<!-- DP&C SoC Approval Button -->
						                  	<button type="button" class="track-btn <%if(obj[14]!=null && obj[14].toString().equalsIgnoreCase("A")) {%>active<%}%>" data-toggle="tooltip" title="DP&C Approval">
						                  		<%if(obj[14]!=null && obj[14].toString().equalsIgnoreCase("A")) {%>
						                    		<i class="fa fa-check" aria-hidden="true"></i>
						                    	<%} %>
						                  	</button>
						                  
						                  
						                  	<div class="tracking-line <%if(transactionCodes.contains("CAD")) { ++count;%>active<%} %>"
										  		<%if(count>5 && count<=6) {%> style="background: linear-gradient(to right, #28a745 25%, #ced4da 25%);" <%} %> >
						                  	</div>
						                  
						                  	<!-- Contract Signature Button -->
						                  	<button type="button" class="track-btn <%if(transactionCodes.contains("CAD")) {%>active<%} %>" data-toggle="tooltip" title="Contract Signature">
							                  	<%if(transactionCodes.contains("CAD")) {%>
							                    	<i class="fa fa-check" aria-hidden="true"></i>
							                    <%} %>
						                  	</button>
						                  
						                  
						                  	<div class="tracking-line <%if(actualMilestoneCount>0 && actualMilestoneCount==approvedMilestoneCount) { ++count;%>active<%} %>"
										  		<%if(count>6 && count<=7) {%> style="background: linear-gradient(to right, #28a745 <%=milestoneProgress %>%, #ced4da 25%);" <%} %> >
						                  	</div>
						                  
						                  	<!-- Milestone Payment Button -->
						                  	<button type="button" class="track-btn <%if(actualMilestoneCount>0 && actualMilestoneCount==approvedMilestoneCount) {%>active<%} %>" data-toggle="tooltip" title="Milestone Payment">
							                  	<%if(actualMilestoneCount>0 && actualMilestoneCount==approvedMilestoneCount) {%>
							                    	<i class="fa fa-check" aria-hidden="true"></i>
							                    <%} %>
						                  	</button>
						                </div>
             				 		</td>
								</tr>
							<%} }%>
						</tbody>
					</table>	
				</div>	
 			</div>
 		</div>
 	</div>

<script type="text/javascript">

var tooltip ='';
function ShowProjectDetails(carsNo, initiationTitle, fundsFrom, duration, amount)
{
	var mouseX = event.clientX; 
    var mouseY = event.clientY;
    var maxY = screen.height;
    
	var Text='';
			
	Text += '<div class="custom-tooltip message-blue blueBottom" id="hoverDiv">';
	Text += '<table id="TooltipStyle">';
	Text += '<tr>';
	Text += '<td class="center" colspan="2" style="background-color: #4B70F5;color: #ffff;">' + carsNo + '</td>';
	Text += '</tr>';
	Text += '<tr>';
	Text += '<td class="left" style="">Title</td>';
	Text += '<td class="left" style="">:&emsp;' + initiationTitle + '</td>';
	Text += '</tr>';
	Text += '<tr>';
	Text += '<td class="left" style="">Funds from</td>';
	Text += '<td class="left" style="">:&emsp;' + fundsFrom + '</td>';
	Text += '<tr>';
	Text += '<tr>';
	Text += '<td class="left" style="">Duration</td>';
	Text += '<td class="left" style="">:&emsp;' + duration + ' (In Months)</td>';
	Text += '<tr>';
	Text += '<tr>';
	Text += '<td class="left" style="">Cost</td>';
	Text += '<td class="left" style="">:&emsp;' + amount + ' (In Lakhs)</td>';
	Text += '<tr>';
	Text += '</table>';
	Text += '</div>';
		
	tooltip=$(Text).appendTo('#AppendProjectDetails');
	$('#hoverDiv').removeClass('blueBottom');
	
	if(mouseY >maxY-350){
       	mouseY-=$('#hoverDiv').height();
       	$('#hoverDiv').removeClass('message-blue');
       	$('#hoverDiv').addClass('blueBottom');
       }
		
	tooltip.css({
		position: 'fixed',
		left: mouseX+100,
		top: mouseY-10,
	});

	$(event.target).data('tooltip', tooltip);
}

function HideProjectDetails()
{
	 if (tooltip) {
     tooltip.remove(); 
     $(".custom-tooltip").remove();
     }
}

</script> 								
</body>
</html>