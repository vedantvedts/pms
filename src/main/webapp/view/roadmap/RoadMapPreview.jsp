<%@page import="org.apache.commons.text.StringEscapeUtils"%>
<%@page import="java.util.Arrays"%>
<%@page import="com.vts.pfms.FormatConverter"%>
<%@page import="java.util.stream.Collectors"%>
<%@page import="com.vts.pfms.roadmap.model.RoadMapAnnualTargets"%>
<%@page import="java.util.List"%>
<%@page import="com.vts.pfms.roadmap.model.RoadMap"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<jsp:include page="../static/header.jsp"></jsp:include>
<style type="text/css">
body { 
   font-family : "Lato", Arial, sans-serif !important;
   overflow-x: hidden;
}

input,select,table,div,label,span {
font-family : "Lato", Arial, sans-serif !important;
}
.text-center{
	text-align: left !imporatant;
}

.scrollclass::-webkit-scrollbar {
    width:7px;
}
.scrollclass::-webkit-scrollbar-track {
    -webkit-box-shadow:inset 0 0 6px rgba(0,0,0,0.3); 
    border-radius:5px;
}
.scrollclass::-webkit-scrollbar-thumb {
    border-radius:5px;
  /*   -webkit-box-shadow: inset 0 0 6px black;  */
	background-color: gray;
}
.scrollclass::-webkit-scrollbar-thumb:hover {
	-webkit-box-shadow: inset 0 0 6px black;
 	transition: 0.5s;
}

#roadmaptable{
	width : 98%;
	/* border : 1px solid black; */
	margin-top : 1.5rem;
	margin-left : 0.8rem;
	font-size: 15px;
}
#roadmaptable td, #roadmaptable th{
	border : 1px solid black;
	text-align: left;
	padding : 5px;
	vertical-align: top;
}
</style>
</head>
<body>
<%
RoadMap roadMap = (RoadMap)request.getAttribute("roadMapDetails");
Long roadMapId = roadMap.getRoadMapId();
List<RoadMapAnnualTargets> roadMapAnnualTargetDetails = null;
if(roadMap!=null) {
	roadMapAnnualTargetDetails = roadMap.getRoadMapAnnualTargets().stream().filter(e-> e.getIsActive()==1).collect(Collectors.toList());
}
List<Object[]> roadMapApprovalEmpData = (List<Object[]>)request.getAttribute("roadMapApprovalEmpData");
List<Object[]> roadMapRemarksHistory = (List<Object[]>)request.getAttribute("roadMapRemarksHistory");

List<String> roadmapforward = Arrays.asList("RIN","RRD","RRA","RRV");
String isApproval = (String)request.getAttribute("isApproval");
String aspFlag = (String)request.getAttribute("aspFlag");

FormatConverter fc = new FormatConverter();
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

	<div class="container-fluid">
		<div class="row">
			<!-- <div class="col-md-2"></div> -->
			<div class="col-md-12">
				<div class="card shadow-nohover">
	  				<div class="card-header" style=" background-color: #055C9D;margin-top: ">
	                    <h3 class="text-white">Road Map Preview
	                    	<a class="btn btn-info btn-sm mr-4 shadow-nohover back"
	                    	<%if(isApproval!=null && isApproval.equalsIgnoreCase("Y")) {%>
               					href="RoadMapApprovals.htm" 
               				<%} else if(isApproval!=null && isApproval.equalsIgnoreCase("N")) {%>
               					href="RoadMapApprovals.htm?val=app" 
               				<%} else if(aspFlag!=null && aspFlag.equalsIgnoreCase("Y")) {%>
               					href="RoadMapASPList.htm" 
               				<%} else{%>
               					href="RoadMapList.htm" 
               				<%} %>
	                    	 
	                    	 style="color: white!important; float: right;margin-top: -5.5px;">BACK</a>
	                    </h3>
	        		</div>
	        		<div class="card-body">
						<form action="#" method="post">
							<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
							<div class="row">
								<div class="col-md-2"></div>
								<div class="col-md-8">
									<%if(roadMap!=null) {%>
									<div class="card">
										<div class="mt-2" align="center">
               								<h5 style="font-weight: bold;margin-top: 1.5rem;">Road Map Details
               									&emsp;<button type="submit" class="btn btn-sm"
               									 formaction="RoadMapPreviewDownload.htm" name="roadMapId" value="<%=roadMapId%>" formtarget="blank" formmethod="post" data-toggle="tooltip" data-placement="top" title="Download" formnovalidate="formnovalidate">
								  	 				<i class="fa fa-lg fa-download" aria-hidden="true"></i>
												</button>
											</h5>
               							</div>
										<table id="roadmaptable">
											<tr>
												<th style="width: 20%;">Title</th>
												<td style="width: 78%;">
													<%if(roadMap.getProjectTitle()!=null) {%>
														<%=StringEscapeUtils.escapeHtml4(roadMap.getProjectTitle()) %>
													<%} else{%>-<%} %>
												</td>
											</tr>
											<tr>
												<th>Duration (in months)</th>
												<td>
													<%if(roadMap.getDuration()!=0) {%>
														<%=roadMap.getDuration() %>
													<%} else{%>0<%} %>
												</td>
											</tr>
											<tr>
												<th>Start & End Date</th>
												<td>
													<%if(roadMap.getStartDate()!=null) {%>
														<%=fc.SqlToRegularDate(roadMap.getStartDate()) %>
													<%} %>
													&emsp;-&emsp;
													<%if(roadMap.getEndDate()!=null) {%>
														<%=fc.SqlToRegularDate(roadMap.getEndDate()) %>
													<%} %>
												</td>
											</tr>
											<tr>
												<th>Aim & Objectives</th>
												<td>
													<%if(roadMap.getAimObjectives()!=null) {%>
														<%=StringEscapeUtils.escapeHtml4(roadMap.getAimObjectives()) %>
													<%} else{%>-<%} %>
												</td>
											</tr>
											<tr>
												<th>Scope</th>
												<td>
													<%if(roadMap.getScope()!=null) {%>
														<%=StringEscapeUtils.escapeHtml4(roadMap.getScope()) %>
													<%} else{%>-<%} %>
												</td>
											</tr>
											<tr>
												<th>Reference</th>
												<td>
													<%if(roadMap.getReference()!=null) {%>
														<%=StringEscapeUtils.escapeHtml4(roadMap.getReference()) %>
													<%} else{%>-<%} %>
												</td>
											</tr>
											<tr>
												<th colspan="2">Annual Targets:</th>
											</tr>
											<tr>
												<th>Year</th>
												<th>Target</th>
											</tr>
											<%if(roadMapAnnualTargetDetails!=null) { 
														int OrigAnnualYear=0,TempAnnualYear=0;
													 	for(RoadMapAnnualTargets target :roadMapAnnualTargetDetails) {
													 		
													 		OrigAnnualYear=Integer.parseInt(target.getAnnualYear());
													 		List<String> targetssList =  roadMapAnnualTargetDetails.stream()
													 						      .filter(e-> e.getAnnualYear().equalsIgnoreCase(target.getAnnualYear()))
													 						      .map(e -> e.getAnnualTargets().getAnnualTarget())
													 						      .collect(Collectors.toList());
													 		
													%>
													<%if(OrigAnnualYear!=TempAnnualYear){ %>
											<tr>
												<td>
													<%=OrigAnnualYear %>
												</td>
												
												<td>
													<%int count=1; for(String targets : targetssList) {%>
														<%if(count==1) {%>
															<%=targets %>
														<%} else{%>
															<%=", "+targets %>
														<%} %>
													<%count++;} %>
												</td>
            									
											</tr>
											<%} %>
											<%TempAnnualYear=OrigAnnualYear;} } %>
										</table>
										
										<!-- Signatures and timestamps -->
										<div style="width: 96%;text-align: right;margin-right: 10px;line-height: 10px;margin-top: 30px;">
              								<div style="font-size: 15px;"> Signature of Initiator</div>
			               					<%for(Object[] apprInfo : roadMapApprovalEmpData){ %>
			   			   					<%if(apprInfo[8].toString().equalsIgnoreCase("RFW")){ %>
				   								<label style="text-transform: capitalize;margin-top: 15px !important;"><%=apprInfo[2]!=null?StringEscapeUtils.escapeHtml4(apprInfo[2].toString()): " - "%></label>,<!-- <br> -->
				   								<label style="text-transform: capitalize;"><%=apprInfo[3]!=null?StringEscapeUtils.escapeHtml4(apprInfo[3].toString()): " - "%></label><br>
				   								<label style="font-size: 12px; ">[Forwarded On:&nbsp; <%= apprInfo[4]!=null? (fc.SqlToRegularDate(apprInfo[4].toString().substring(0, 10))  +" "+StringEscapeUtils.escapeHtml4(apprInfo[4].toString()).substring(11,19)):" - "  %>]</label>
			   			    				<%break;}} %>  
				            			 </div>
							            
							            <%for(Object[] apprInfo : roadMapApprovalEmpData) {%>
							            	<div style="width: 96%;text-align: left;margin-left: 10px;line-height: 10px;margin-top: 10px;">
							            			 		
							            		<%if(apprInfo[8].toString().equalsIgnoreCase("RAD")){ %>
							            			<div style="font-size: 15px;"> Signature of Director</div>
							   						<label style="text-transform: capitalize;margin-top: 15px !important;"><%=apprInfo[2]%></label>,<!-- <br> -->
							   						<label style="text-transform: capitalize;"><%=apprInfo[3]%></label><br>
							   						<label style="font-size: 12px; ">[Recommended On:&nbsp; <%=apprInfo[4]!=null? (fc.SqlToRegularDate(apprInfo[4].toString().substring(0, 10))  +" "+StringEscapeUtils.escapeHtml4(apprInfo[4].toString()).substring(11,19)):" - " %>]</label>
								   				<%} %>
							            	</div>	
							            <%} %>
								   						
								   											 
										<!-- Remarks -->
               		   					<div class="row mt-2">
											<%if(roadMapRemarksHistory.size()>0){ %>
												<div class="col-md-8" align="left" style="margin: 10px 0px 5px 25px; padding:0px;border: 1px solid black;border-radius: 5px;">
													<%if(roadMapRemarksHistory.size()>0){ %>
														<table style="margin: 3px;padding: 0px">
															<tr>
																<td style="border:none;padding: 0px">
																<h6 style="text-decoration: underline;">Remarks :</h6> 
																</td>											
															</tr>
															<%for(Object[] obj : roadMapRemarksHistory){%>
															<tr>
																<td style="border:none;width: 80%;overflow-wrap: anywhere;padding: 0px">
																	<%if(obj[3]!=null) {%> <%=StringEscapeUtils.escapeHtml4(obj[3].toString())%> <%} else{%><%=obj[5]!=null?StringEscapeUtils.escapeHtml4(obj[5].toString()): " - " %> <%} %> &nbsp; :
																	<span style="border:none; color: blue;"><%=obj[1]!=null?StringEscapeUtils.escapeHtml4(obj[1].toString()): " - " %></span>
																</td>
															</tr>
															<%} %>
														</table>
													<%} %>
												</div>
											<%} %>
		   								</div>
					   								
										<div class="row mt-2 mb-4">
											<div class="col-md-12" align="center">
												<%if(roadmapforward!=null && roadmapforward.contains(roadMap.getRoadMapStatusCode())) {%>
													<div class="ml-2" align="left">
						   								<b >Remarks :</b><br>
						   								<textarea rows="3" cols="65" name="remarks" id="remarksarea" maxlength="1000"></textarea>
					         						</div>
													<button type="submit" class="btn btn-sm submit" name="Action" formaction="RoadMapApprovalSubmit.htm" value="A" onclick="return confirm('Are you Sure to Submit ?');">Forward</button>
												<%} %>
												<%if(isApproval!=null && isApproval.equalsIgnoreCase("Y")) {%>
													<div class="ml-2" align="left">
						   								<b >Remarks :</b><br>
						   								<textarea rows="3" cols="65" name="remarks" id="remarksarea" maxlength="1000"></textarea>
					         						</div>
													<button type="submit" class="btn btn-sm btn-success" id="finalSubmission" formaction="RoadMapApprovalSubmit.htm" name="Action" value="A" onclick="return confirm('Are You Sure To Recommend?');" style="font-weight: 600;">
							    						Recommend	
						      						</button>
						      						
						      						<button type="submit" class="btn btn-sm btn-danger" id="finalSubmission" formaction="RoadMapApprovalSubmit.htm" name="Action" value="R" onclick="return validateTextBox();" style="font-weight: 600;background-color: #ff2d00;">
							 							Return
													</button>
												<%} %>
											</div>
                   						</div>
                   						<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
                   						<input type="hidden" name="roadMapId" value="<%=roadMapId%>">
									</div>
									<%} %>
								</div>
								<div class="col-md-2"></div>
							</div>
						</form>
					</div>
	        	</div>
	        </div>
		</div>
	</div>
<!-- Remarks Handling -->
<script type="text/javascript">
function validateTextBox() {
    if (document.getElementById("remarksarea").value.trim() != "") {
    	return confirm('Are You Sure To Return?');
    	
    } else {
        alert("Please enter Remarks to Return");
        return false;
    }
}
function disapprove() {
    if (document.getElementById("remarksarea").value.trim() != "") {
    	return confirm('Are You Sure To Disappove?');
    	
    } else {
        alert("Please enter Remarks to Disapprove");
        return false;
    }
}
</script>
</body>
</html>