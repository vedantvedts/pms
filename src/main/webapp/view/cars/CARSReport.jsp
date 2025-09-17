<%@page import="org.apache.commons.text.StringEscapeUtils"%>
<%@page import="java.util.stream.Collectors"%>
<%@page import="java.util.Arrays"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<jsp:include page="../static/header.jsp"></jsp:include>

<spring:url value="/resources/css/cars/CARSReport.css" var="carsReport" />
<link href="${carsReport}" rel="stylesheet" />
</head>
<body>
<%
List<Object[]> intiationList = (List<Object[]>)request.getAttribute("initiationList");

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

	<div class="container-fluid mb-3">
		<div class="card shadow-nohover">
 			<div class="card-header card-header-bg" >
 				<div class="row">
 					<div class="col-md-3">
 						<h3 class="text-dark fw-bold" >CARS Report</h3>
 					</div>
 					<div class="col-md-7"></div>
 					<div class="col-md-2 right">
 						<a class="btn btn-sm btn-outline-success" href="CARSReportPresentation.htm" target="_blank" title="CARS Presentation">
								<img alt="" src="view/images/presentation.png"  class="w-19">
						</a>
 					</div>
 				</div>
 			</div>
 			<div class="card-body">
 				<div class="table-responsive tabpanes1"> 
					<table class=" trackingTable">
						<thead>  
							<tr>
								<th class="w-15">CARS No</th>
								<th class="w-85">
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
							    				<%=obj[2]!=null?StringEscapeUtils.escapeHtml4(obj[2].toString()): " - " %>
							    			</button>
                                     	</form>
									</td>
									<td colspan="8">
						             	<div class="tracking-container">
						                  
						             		<!-- Initiation Button -->
											<button type="button" class="track-btn active" data-toggle="tooltip" title="Initiation">
												<i class="fa fa-check" aria-hidden="true"></i>
											</button>
						                  
						                  
											<div class="tracking-line <%if(transactionCodes.contains("AGD") || transactionCodes.contains("APD")) { ++count;%>active <%} %> <%if(count<=1) {%>  track-bg  <%} %>" >
						                    </div>
						                  
						                    <!-- Approval Button -->
						                    <button type="button" class="track-btn <%if(transactionCodes.contains("AGD") || transactionCodes.contains("APD")) {%>active <%} %>" data-toggle="tooltip" title="RSQR Approval">
						                  		<%if(transactionCodes.contains("AGD") || transactionCodes.contains("APD")) {%>
						                    		<i class="fa fa-check" aria-hidden="true"></i>
						                    	<%} %>
						                  	</button>
						                  
						                  
						                  	<div class="tracking-line <%if(transactionCodes.contains("SIN")) { ++count;%>active <%} %> <%if(count>1 && count<=2) { %> track-bg  <% } %>" >
						                  	</div>
						                  
						                  	<!-- SoC Button -->
						                  	<button type="button" class="track-btn <%if(transactionCodes.contains("SIN")) {%>active <%} %>" data-toggle="tooltip" title="SoC Details">
						                  		<%if(transactionCodes.contains("SIN")) {%>
						                    		<i class="fa fa-check" aria-hidden="true"></i>
						                    	<%} %>
						                  	</button>
						                  
						                  
						                  	<div class="tracking-line <%if(transactionCodes.contains("SFG") || transactionCodes.contains("SFP")) { ++count;%>active <%} %> <%if(count>2 && count<=3) {%>  track-bg  <%} %>" >
						                  	</div>
						                  
						                  	<!-- SoC Approval Button -->
						                  	<button type="button" class="track-btn <%if(transactionCodes.contains("SFG") || transactionCodes.contains("SFP")) {%>active <%} %>" data-toggle="tooltip" title="SoC Approval">
						                  		<%if(transactionCodes.contains("SFG") || transactionCodes.contains("SFP")) {%>
						                    		<i class="fa fa-check" aria-hidden="true"></i>
						                    	<%} %>
						                  	</button>
						                  
						                  
						                  	<div class="tracking-line <%if(obj[16]!=null) { ++count;%>active <%} %> <%if(count>3 && count<=4) {%> track-bg  <%} %>" >
						                  	</div>
						                  
						                  	<!-- MoM Upload Button -->
						                  	<button type="button" class="track-btn <%if(obj[16]!=null) {%>active <%}%>" data-toggle="tooltip" title="MoM Upload">
						                  		<%if(obj[16]!=null) {%>
						                    		<i class="fa fa-check" aria-hidden="true"></i>
						                    	<%} %>
						                  	</button>
						                  
						                  
						                  	<div class="tracking-line <%if(obj[14]!=null && obj[14].toString().equalsIgnoreCase("A")) { ++count;%>active <%} %> <%if(count>4 && count<=5) {%>  track-bg  <%} %>" >
						                  	</div>
						                  
						                  	<!-- DP&C SoC Approval Button -->
						                  	<button type="button" class="track-btn <%if(obj[14]!=null && obj[14].toString().equalsIgnoreCase("A")) {%>active <%}%>" data-toggle="tooltip" title="DP&C Approval">
						                  		<%if(obj[14]!=null && obj[14].toString().equalsIgnoreCase("A")) {%>
						                    		<i class="fa fa-check" aria-hidden="true"></i>
						                    	<%} %>
						                  	</button>
						                  
						                  
						                  	<div class="tracking-line <%if(transactionCodes.contains("CAD")) { ++count;%>active <%} %> <%if(count>5 && count<=6) {%> track-bg  <%} %> ">
						                  	</div>
						                  
						                  	<!-- Contract Signature Button -->
						                  	<button type="button" class="track-btn <%if(transactionCodes.contains("CAD")) {%>active <%} %>" data-toggle="tooltip" title="Contract Signature">
							                  	<%if(transactionCodes.contains("CAD")) {%>
							                    	<i class="fa fa-check" aria-hidden="true"></i>
							                    <%} %>
						                  	</button>
						                  
						                  
						                  	<div class="tracking-line <%if(actualMilestoneCount>0 && actualMilestoneCount==approvedMilestoneCount) { ++count;%>active <%} %> <%if(count>6 && count<=7) {%> progress-bar  <%} %>" <%if(count>6 && count<=7) {%> data-progress="<%= milestoneProgress %>"<%} %> >
						                  	</div>
						                  
						                  	<!-- Milestone Payment Button -->
						                  	<button type="button" class="track-btn <%if(actualMilestoneCount>0 && actualMilestoneCount==approvedMilestoneCount) {%>active <%} %>" data-toggle="tooltip" title="Milestone Payment">
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

document.querySelectorAll('.progress-bar').forEach(el => {
	  const p = el.dataset.progress;
	  el.style.setProperty('--progress', p + '%');
	});

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
	Text += '<td class="center cars-no" colspan="2">' + carsNo + '</td>';
	Text += '</tr>';
	Text += '<tr>';
	Text += '<td class="left" >Title</td>';
	Text += '<td class="left" >:&emsp;' + initiationTitle + '</td>';
	Text += '</tr>';
	Text += '<tr>';
	Text += '<td class="left" >Funds from</td>';
	Text += '<td class="left" >:&emsp;' + fundsFrom + '</td>';
	Text += '<tr>';
	Text += '<tr>';
	Text += '<td class="left" >Duration</td>';
	Text += '<td class="left" >:&emsp;' + duration + ' (In Months)</td>';
	Text += '<tr>';
	Text += '<tr>';
	Text += '<td class="left" >Cost</td>';
	Text += '<td class="left" >:&emsp;' + amount + ' (In Lakhs)</td>';
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