<%@page import="com.fasterxml.jackson.databind.ObjectMapper"%>
<%@page import="java.util.Set"%>
<%@page import="com.vts.pfms.ccm.model.CCMAchievements"%>
<%@page import="java.util.HashMap"%>
<%@page import="java.util.LinkedHashMap"%>
<%@page import="com.vts.pfms.committee.model.CommitteeSchedule"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.util.stream.Collectors"%>
<%@page import="java.time.temporal.ChronoUnit"%>
<%@page import="com.vts.pfms.FormatConverter"%>
<%@page import="java.text.DecimalFormat"%>
<%@page import="java.time.LocalDate"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.Date"%>
<%@page import="java.util.Map"%>
<%@page import="com.vts.pfms.committee.model.Committee"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<jsp:include page="../static/header.jsp"></jsp:include>
<spring:url value="/resources/ckeditor/ckeditor.js" var="ckeditor" />
<spring:url value="/resources/ckeditor/contents.css" var="contentCss" />
<script src="${ckeditor}"></script>

<spring:url value="/resources/css/slides-style.css" var="SlidesStyleCSS" />
<link href="${SlidesStyleCSS}" rel="stylesheet" />


<style type="text/css">
label {
	font-weight: 800;
	font-size: 16px;
	color: #07689f;
}

.tab-pane p{
	text-align: justify;
	
}

.tabpanes1 {
	min-height: 651px;
    max-height: 651px;
    overflow: auto;
    scrollbar-width: thin;
    scrollbar-height: thin;
  	scrollbar-color: #216583 #f8f9fa;
}

.tabpanes2 {
	min-height: 699px;
    max-height: 699px;
    overflow: auto;
    scrollbar-width: thin;
    scrollbar-height: thin;
  	scrollbar-color: #216583 #f8f9fa;
}

.card-body {
    padding-bottom: 50px; /* Add some padding to make sure content doesn't overlap with the buttons */
}

/* Chrome, Edge, and Safari */
.tabpanes1::-webkit-scrollbar, .tabpanes2::-webkit-scrollbar {
  width: 12px;
}

.tabpanes1::-webkit-scrollbar-track, .tabpanes2::-webkit-scrollbar-track {
  background: #f8f9fa;
  border-radius: 5px;
}

.tabpanes1::-webkit-scrollbar-thum, .tabpanes2::-webkit-scrollbar-thum {
  background-color: #216583;
  border-radius: 5px;
  border: 2px solid #f8f9fa;
}


.card-body{
	padding: 0rem !important;
}

.navigation_btn{
	margin: 1%;
}

 .b{
	background-color: #ebecf1;	
}
.a{
	background-color: #d6e0f0;
}

.nav-links{
	text-align: left;
}

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

.previous{
	color: white !important;
}

.previous, .next{
	font-family: 'Montserrat', sans-serif;
    font-weight: 800 !important;
}

.next {
  padding: 4px 16px;
  font-weight: 800;
  background-color: #394989;
  border-color: #394989;
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
.select2-selection__rendered{
	text-align: left !important;
}

.agendaItemBtn > p {
	margin-bottom : 0;
}

.panel-bottom {
    bottom: 10px;
    right: 10px;
    text-align: right;
}

.ccmSideBar {
	min-height: 670px;
    max-height: 670px;
    overflow-y: auto;
    overflow-x: hidden;
    scrollbar-width: thin;
  	scrollbar-color: #4B70F5 #f8f9fa;
}

.ccmSideBarButton {
	margin-right: 0.25rem;
	margin-left: 0.25rem;
	margin-top: 0.25rem;
	width: 97%;
	border-radius: 0.75rem;
	text-align: left;
}

.panel-buttons {
	margin: 1%;
}

.btn-print {
	background-color: purple;
	border: none;
	color: white;
	font-weight: bold;
	text-decoration: none;
}

/* Custom colspan */
.col-custom-1-5 {
    width: calc(12.5%); /* This gives 1.5 out of 12 columns */
    flex: 0 0 calc(12.5%);
    max-width: calc(12.5%);
}

@media (max-width: 768px) {
    .col-custom-1-5 {
        width: 100%;
        flex: 0 0 100%;
        max-width: 100%;
    }
}

.col-custom-10-5 {
    width: calc(86.5%); 
    flex: 0 0 calc(86.5%);
    max-width: calc(86.5%);
    margin-left: 0.4rem;
}

@media (max-width: 768px) {
    .col-custom-10-5 {
        width: 100%;
        flex: 0 0 100%;
        max-width: 100%;
    }
}


.subtables {
	width: 100%;
	border-collapse: collapse;
	border: 1px solid black;
	/* margin-top: 10px; */
}


.custom-input {
	border-left: 0;
    border-top: 0;
    border-right: 0;
    width: 70%;
}

.modal-dialog-jump {
  animation: jumpIn 1.5s ease;
}

@keyframes jumpIn {
  0% {
    transform: scale(0.1);
    opacity: 0;
  }
  70% {
    transform: scale(1);
  }
  100% {
    transform: scale(1);
    opacity: 1;
  }
}

/* Modal specific styles */
.modal-fixed-bottom-right {
    position: fixed;
    right: 25px;
    bottom: 30px;
    width: 300px;
    z-index: 1050; /* Ensure it's above other elements */
}

.modal-content {
    background-color: #f8f9fa;
    padding: 20px;
    border-radius: 5px;
}

    
.open-modal-button {
   right: 10px;
   background-color: #4B70F5;
   color: #fff;
   padding: 5px;
   border: none;
   border-radius: 20px;
   font-weight:bold;
   cursor: pointer;
   z-index: 1001; /* Make sure the button is above the modal */
}
</style>


</head>
<body>

	<%
		String labcode = (String)session.getAttribute("labcode");
		String clusterid = (String)session.getAttribute("clusterid");
		
		String committeeId = (String)request.getAttribute("committeeId");
		String committeeIdDMC = (String)request.getAttribute("committeeIdDMC");
		String tabName = (String)request.getAttribute("tabName");
		String filesize = (String) request.getAttribute("filesize");
		
    	List<Object[]> clusterLabList = (List<Object[]>) request.getAttribute("clusterLabList");
    	Object[] clusterLabDetails = clusterLabList!=null && clusterLabList.size()>0 ?clusterLabList.stream().filter(e -> e[3].toString().equalsIgnoreCase("Y")).collect(Collectors.toList()).get(0) :null;
		String clusterLab = clusterLabDetails!=null && !clusterLabDetails[2].toString().equalsIgnoreCase(labcode)?"N":"Y";
		
		List<Object[]> clusterLabListFilter = new ArrayList<>();
		
		int tabCount = 0;
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
 					<div class="col-md-2">
 						<h3 class="text-dark" style="font-weight: bold;">CCM Presentation</h3>
 					</div>
 					<div class="col-md-8"></div>
 					<div class="col-md-2 right">
	 					
 					</div>
 					
 				</div>
       		</div>
       		
       		<div class="card-body">
       			<div class="row ml-2">
       				<div class="col-custom-1-5 p-0 mt-2 mb-2">
       					<div class="card" style="border-color: #007bff;">
     						<div class="card-header center" style="background-color: transparent;border-color: #007bff;">
     							<h5 class="" style="font-weight: bold;color: #8b550c;">List of Topics</h5>
     						</div>
   							<div class="card-body ccmSideBar">
								<div class="row">
  									<div class="col-md-12">
  										<form action="CCMPresentation.htm" method="GET">
											<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
											<input type="hidden" name="committeeId" value="<%=committeeId%>">
     										<button type="submit" class="btn btn-outline-primary fw-bold ccmSideBarButton" name="tabName" value="ATR" data-toggle="tooltip" data-placement="top" title="Action Taken Report">
     											<i class="fa fa-caret-right" aria-hidden="true"></i>&nbsp; <%=++tabCount %>. ATR
     										</button>
     										<button type="submit" class="btn btn-outline-primary fw-bold ccmSideBarButton" name="tabName" value="DMC" data-toggle="tooltip" data-placement="top" title="DMC">
     											<i class="fa fa-caret-right" aria-hidden="true"></i>&nbsp; <%=++tabCount %>. DMC
     										</button>
     										<button type="submit" class="btn btn-outline-primary fw-bold ccmSideBarButton" name="tabName" value="EB Calendar" data-toggle="tooltip" data-placement="top" title="EB Calendar">
     											<i class="fa fa-caret-right" aria-hidden="true"></i>&nbsp; <%=++tabCount %>. EB Calendar 
     										</button>
     										<button type="submit" class="btn btn-outline-primary fw-bold ccmSideBarButton" name="tabName" value="PMRC Calendar" data-toggle="tooltip" data-placement="top" title="PMRC Calendar">
     											<i class="fa fa-caret-right" aria-hidden="true"></i>&nbsp; <%=++tabCount %>. PMRC Calendar 
     										</button>
     										<button type="submit" class="btn btn-outline-primary fw-bold ccmSideBarButton" name="tabName" value="ASP Status" data-toggle="tooltip" data-placement="top" title="ASP Status">
     											<i class="fa fa-caret-right" aria-hidden="true"></i>&nbsp; <%=++tabCount %>. ASP Status 
     										</button>
     										<button type="submit" class="btn btn-outline-primary fw-bold ccmSideBarButton" name="tabName" value="Project Closure" data-toggle="tooltip" data-placement="top" title="Project Closure">
     											<i class="fa fa-caret-right" aria-hidden="true"></i>&nbsp; <%=++tabCount %>. Project Closure
     										</button>
     										<button type="submit" class="btn btn-outline-primary fw-bold ccmSideBarButton" name="tabName" value="Cash Out Go Status" data-toggle="tooltip" data-placement="top" title="Cash Out Go Status">
     											<i class="fa fa-caret-right" aria-hidden="true"></i>&nbsp; <%=++tabCount %>. Cash Out Go Status
     										</button>
     										<button type="submit" class="btn btn-outline-primary fw-bold ccmSideBarButton" name="tabName" value="Test & Trials" data-toggle="tooltip" data-placement="top" title="Test & Trials">
     											<i class="fa fa-caret-right" aria-hidden="true"></i>&nbsp; <%=++tabCount %>. Test & Trials
     										</button>
     										<button type="submit" class="btn btn-outline-primary fw-bold ccmSideBarButton" name="tabName" value="Achievements" data-toggle="tooltip" data-placement="top" title="Achievements">
     											<i class="fa fa-caret-right" aria-hidden="true"></i>&nbsp; <%=++tabCount %>. Achievements
     										</button>
	     								</form>		
  									</div>
   								</div>
   								
   							</div>
       					</div>
       				</div>
       				<div class="col-custom-10-5">
       					
						<!-- This is for Tab Panes -->
 						<div class="card mr-2 mb-2 mt-2" style="border-color: #007bff;">
 							<div class="tab-content text-center" style="">
 								<div class="tab-pane active" id="meetingschedule" role="tabpanel">
 								
 									<!-- ----------------------------------------------- ATR --------------------------------------------------- -->	
									<%if(tabName!=null && tabName.equalsIgnoreCase("ATR")) {
										
									    List<Object[]> ccmActions = (List<Object[]>) request.getAttribute("ccmActions");
									    
									    if(clusterLab.equalsIgnoreCase("N")){
									    	ccmActions = ccmActions.stream().filter(e -> e[19].toString().equalsIgnoreCase(labcode)).collect(Collectors.toList());
									    }
										
										List<String> latestScheduleMinutesIds = (List<String>) request.getAttribute("latestScheduleMinutesIds");
										
										Map<String, List<Object[]>> ccmActionsToListMap = ccmActions!=null && ccmActions.size()>0?ccmActions.stream()
																						  .filter(e -> latestScheduleMinutesIds.contains(e[18].toString()))
																						  .collect(Collectors.groupingBy(array -> array[0] + "", LinkedHashMap::new, Collectors.toList())) : new HashMap<>();
										
										Map<String, List<Object[]>> prevccmActionsToListMap = ccmActions!=null && ccmActions.size()>0?ccmActions.stream()
																							 .filter(e -> !e[9].toString().equalsIgnoreCase("C") && !latestScheduleMinutesIds.contains(e[18].toString()))
																							 .collect(Collectors.groupingBy(array -> array[0] + "", LinkedHashMap::new, Collectors.toList())) : new HashMap<>();
										
										Committee committee = (Committee) request.getAttribute("committeeData");
										CommitteeSchedule ccmSchedule = (CommitteeSchedule) request.getAttribute("ccmSchedule");
										String seqDate = ccmSchedule!=null?ccmSchedule.getScheduleDate().toString().substring(2, 7):"";
										
										Map<Integer,String> mapCCM = (Map<Integer,String>)request.getAttribute("mapCCM");
									
										DecimalFormat df = new DecimalFormat("####################.##");
										FormatConverter fc = new FormatConverter();
										SimpleDateFormat sdf = fc.getRegularDateFormat();
										SimpleDateFormat sdf1 = fc.getSqlDateFormat();
									    SimpleDateFormat inputFormat = new SimpleDateFormat("ddMMMyyyy");
									    SimpleDateFormat outputFormat = new SimpleDateFormat("yyyy-MM-dd");	
										String todayDate = outputFormat.format(new Date()).toString();		
									%>
 										<div class="container-fluid mt-3 tabpanes1">
 											<%-- <div class="card">
 												<div class="card-header" style="background-color: #007bff;color: white;">
 													<h4 class="atrHeading">
 														Action Taken Report of CCM(<%=seqDate %>)
 													</h4>
 													<h4 class="prevatrHeading" style="display: none;">
 														Pending Points from Prev CCM
 													</h4>
 												</div>
 											</div> --%>
	 										<table class="table table-bordered table-hover table-striped table-condensed " id="atrTable">
												<thead style="background-color: #4B70F5; color: #ffff !important;">
													<tr style="background-color: #4C3BCF;border-radius: 1rem;">
														<th colspan="6" style="border-radius: 1rem;"> <h5>Action Taken Report of CCM(<%=seqDate %>)</h5></th>
													</tr>
													<tr>
														<th style="width: 15px !important; text-align: center;">SN</th>
														<th style="width:30px;">ID</th>
														<th style="width: 280px;">Action Point</th>
														<th style="width: 205px;">Action by</th>
														<th style="width: 95px;"><!-- ADC <br> -->PDC</th>
														<th style="width: 200px;">Status</th>
														<!-- <th style="width: 80px;">Action</th> -->
														<!-- <th style="width: 20px;">Info</th> -->
													</tr>
												</thead>
	
												<tbody>
													<% if (ccmActionsToListMap!=null && ccmActionsToListMap.size() > 0) {
															int slno = 0;String key="";
															for (Map.Entry<String, List<Object[]>> map : ccmActionsToListMap.entrySet()) {
					                   							
					                   							List<Object[]> values = map.getValue();
					                   							int i=0;
					                   							for (Object[] obj : values) {
													%>
														<tr>
															<td style="text-align: center;"><%=++slno%></td>
															<td style="text-align: center;">
															
																<%if(obj[17]!=null && Long.parseLong(obj[17].toString())>0){ %>
																	<button type="button" class="btn btn-sm btn-primary" style="border-radius: 50px;font-weight: bold;background-color: #402E7A;" onclick="ActionDetails( <%=obj[17] %>);" data-toggle="tooltip" data-placement="top" title="Action Details" >
																		<%if(committee.getCommitteeShortName().trim().equalsIgnoreCase("CCM")){ %>
																		<%for (Map.Entry<Integer, String> entry : mapCCM.entrySet()) {
																			Date date = inputFormat.parse(obj[1].toString().split("/")[2]);
																			 String formattedDate = outputFormat.format(date);
																			 if(entry.getValue().equalsIgnoreCase(formattedDate)){
																				 key=entry.getKey().toString();
																			 } }}%>
																		
																		<%=committee.getCommitteeShortName().trim().toUpperCase()+"-"+key+"-("+seqDate+")/"+obj[1].toString().split("/")[3] %>
																	</button>
																	<input type="hidden" id="thisYearNo" value="<%=key%>">
																<%}%> 
															<!--  -->
															</td>
															<%if(i==0) {%>
													    		<td rowspan="<%=values.size() %>" style="text-align: justify;vertical-align: top;"><%=obj[2] %></td>
			           										<%} %>
															<td style="text-align: justify;"><%=obj[11]+", "+obj[12]%></td>
															<td style="text-align: center;">
																<%	String actionstatus = obj[9].toString();
																	int progress = obj[15]!=null ? Integer.parseInt(obj[15].toString()) : 0;
																	LocalDate pdcorg = LocalDate.parse(obj[3].toString());
																	LocalDate lastdate = obj[13]!=null ? LocalDate.parse(obj[13].toString()): null;
																	LocalDate today = LocalDate.now();
																	LocalDate endPdc = LocalDate.parse(obj[4].toString());
																%> 
												 				<%-- <% if(lastdate!=null && actionstatus.equalsIgnoreCase("C") ){%>
																		<%if(actionstatus.equals("C") && (pdcorg.isAfter(lastdate) || pdcorg.equals(lastdate))){%>
																		<span class="completed"><%= sdf.format(sdf1.parse(obj[13].toString()))%> </span>
																		<%}else if(actionstatus.equals("C") && pdcorg.isBefore(lastdate)){ %>	
																		<span class="completeddelay"><%= sdf.format(sdf1.parse(obj[13].toString()))%> </span>
																		<%} %>	
																	<%}else{ %>
																			-									
																	<%} %>
																<br> --%>
																<span <%if(endPdc.isAfter(today) || endPdc.isEqual(today)) {%>style="color:black;font-weight: bold;" <%} else{%> style="color:maroon ;font-weight:bolder;" <%} %>>
																<%= sdf.format(sdf1.parse(obj[4].toString()))%> 
																</span> 
																<%if(!pdcorg.equals(endPdc)) { %>
																<br> 
																<span <%if(pdcorg.isAfter(today) || pdcorg.isEqual(today)) {%>style="color:black;font-weight: bold;" <%} else{%> style="color:maroon ;font-weight:bolder;" <%} %>>
																<%= sdf.format(sdf1.parse(obj[3].toString()))%> 
																</span>	
																<%} %>
															</td>
															<!-- <td style="text-align: center;">
																<input type="text" class="custom-input" name="actionStatus" placeholder="Enter Status">
																&nbsp;&nbsp;
																<button type="submit" class="btn btn-sm edit" name="action" value="A" data-toggle="tooltip" data-placement="top" title="Update" onclick="return confirm('Are you sure to update?')" style="border-radius: 0.75rem;">
																	Update
																</button>
															</td> -->
															<td style="text-align: justify;">
																<% if (obj[16] != null) { %><%=obj[16]%> <% } else{%>-<%} %>
															</td>
										
														</tr>
													<% ++i;}} } else{%>
														<tr>
															<td colspan="6" style="text-align: center;">No Data Available</td>
														</tr>
													<%} %>
												</tbody>
											</table>
											
	 										<table class="table table-bordered table-hover table-striped table-condensed " id="prevatrTable" >
												<thead style="background-color: #4B70F5; color: #ffff !important;">
													<tr style="background-color: #4C3BCF;border-radius: 1rem;">
														<th colspan="6" style="border-radius: 1rem;"> <h5>Pending Points from Prev CCM</h5></th>
													</tr>
													<tr >
														<th style="width: 15px !important; text-align: center;">SN</th>
														<th style="width:30px;">ID</th>
														<th style="width: 280px;">Action Point</th>
														<th style="width: 205px;">Action by</th>
														<th style="width: 95px;"><!-- ADC <br> -->PDC</th>
														<th style="width: 200px;">Status</th>
														<!-- <th style="width: 80px;">Action</th> -->
														<!-- <th style="width: 20px;">Info</th> -->
													</tr>
												</thead>
	
												<tbody>
													<% if (prevccmActionsToListMap!=null && prevccmActionsToListMap.size() > 0) {
															int slno = 0;String key="";
															for (Map.Entry<String, List<Object[]>> map : prevccmActionsToListMap.entrySet()) {
					                   							
					                   							List<Object[]> values = map.getValue();
					                   							int i=0;
					                   							for (Object[] obj : values) {
													%>
														<tr>
															<td style="text-align: center;"><%=++slno%></td>
															<td style="text-align: center;">
															
																<%if(obj[17]!=null && Long.parseLong(obj[17].toString())>0){ %>
																	<button type="button" class="btn btn-sm btn-primary" style="border-radius: 50px;font-weight: bold;background-color: #402E7A;" onclick="ActionDetails( <%=obj[17] %>);" data-toggle="tooltip" data-placement="top" title="Action Details" >
																		<%if(committee.getCommitteeShortName().trim().equalsIgnoreCase("CCM")){ %>
																		<%for (Map.Entry<Integer, String> entry : mapCCM.entrySet()) {
																			Date date = inputFormat.parse(obj[1].toString().split("/")[2]);
																			 String formattedDate = outputFormat.format(date);
																			 if(entry.getValue().equalsIgnoreCase(formattedDate)){
																				 key=entry.getKey().toString();
																			 } }}%>
																		
																		<%=committee.getCommitteeShortName().trim().toUpperCase()+"-"+key+"-("+seqDate+")/"+obj[1].toString().split("/")[3] %>
																	</button>
																<%}%> 
															<!--  -->
															</td>
															<%if(i==0) {%>
													    		<td rowspan="<%=values.size() %>" style="text-align: justify;vertical-align: top;"><%=obj[2] %></td>
			           										<%} %>
															<td style="text-align: justify;"><%=obj[11]+", "+obj[12]%></td>
															<td style="text-align: center;">
																<%	String actionstatus = obj[9].toString();
																	int progress = obj[15]!=null ? Integer.parseInt(obj[15].toString()) : 0;
																	LocalDate pdcorg = LocalDate.parse(obj[3].toString());
																	LocalDate lastdate = obj[13]!=null ? LocalDate.parse(obj[13].toString()): null;
																	LocalDate today = LocalDate.now();
																	LocalDate endPdc = LocalDate.parse(obj[4].toString());
																%> 
												 				<%-- <% if(lastdate!=null && actionstatus.equalsIgnoreCase("C") ){%>
																		<%if(actionstatus.equals("C") && (pdcorg.isAfter(lastdate) || pdcorg.equals(lastdate))){%>
																		<span class="completed"><%= sdf.format(sdf1.parse(obj[13].toString()))%> </span>
																		<%}else if(actionstatus.equals("C") && pdcorg.isBefore(lastdate)){ %>	
																		<span class="completeddelay"><%= sdf.format(sdf1.parse(obj[13].toString()))%> </span>
																		<%} %>	
																	<%}else{ %>
																			-									
																	<%} %>
																<br> --%>
																<span <%if(endPdc.isAfter(today) || endPdc.isEqual(today)) {%>style="color:black;font-weight: bold;" <%} else{%> style="color:maroon ;font-weight:bolder;" <%} %>>
																<%= sdf.format(sdf1.parse(obj[4].toString()))%> 
																</span>  
																<%if(!pdcorg.equals(endPdc)) { %>
																<br> 
																<span <%if(pdcorg.isAfter(today) || pdcorg.isEqual(today)) {%>style="color:black;font-weight: bold;" <%} else{%> style="color:maroon ;font-weight:bolder;" <%} %>>
																<%= sdf.format(sdf1.parse(obj[3].toString()))%> 
																</span>	
																<%} %>
															</td>
															<!-- <td style="text-align: center;">
																<input type="text" class="custom-input" name="actionStatus" placeholder="Enter Status">
																&nbsp;&nbsp;
																<button type="submit" class="btn btn-sm edit" name="action" value="A" data-toggle="tooltip" data-placement="top" title="Update" onclick="return confirm('Are you sure to update?')" style="border-radius: 0.75rem;">
																	Update
																</button>
															</td> -->
															<td style="text-align: justify;">
																<% if (obj[16] != null) { %><%=obj[16]%> <% } else{%>-<%} %>
															</td>
										
														</tr>
													<% i++; }} } else {%>
														<tr>
															<td colspan="6" style="text-align: center;">No Data Available</td>
														</tr>
													<%} %>
												</tbody>
											</table>
											
										</div>	
										<div class="center mt-2 mb-2">
											<button type="button" class="btn btn-sm btn-outline-secondary fw-bold atr-btn" style="border-radius: 0.75rem;">
												ATR of <%=seqDate %> 
											</button>
											<button type="button" class="btn btn-sm btn-outline-info fw-bold pending-point-btn" style="border-radius: 0.75rem;">
												Pending Points 
											</button>
										</div>
									<!-- ----------------------------------------------- ATR End --------------------------------------------------- -->	
									
									<!-- ----------------------------------------------- DMC --------------------------------------------------- -->	
									<%} else if(tabName!=null && tabName.equalsIgnoreCase("DMC")) {
										
										String committeeMainId = (String)request.getAttribute("committeeMainId");
										List<Object[]> dmcActions = (List<Object[]>) request.getAttribute("dmcActions");
										
										if(clusterLab.equalsIgnoreCase("N")){
											dmcActions = dmcActions.stream().filter(e -> e[19].toString().equalsIgnoreCase(labcode)).collect(Collectors.toList());
									    }
										
										List<String> latestScheduleMinutesIds = (List<String>) request.getAttribute("latestScheduleMinutesIds");
										
										//Map<String, List<Object[]>> dmcActionsToListMap = dmcActions!=null && dmcActions.size()>0? dmcActions.stream()
										//												.filter(e -> latestScheduleMinutesIds.contains(e[18].toString()))
										//												.collect(Collectors.groupingBy(array -> array[0] + "", LinkedHashMap::new, Collectors.toList())) : new HashMap<>();
										//
										Map<String, List<Object[]>> prevdmcActionsToListMap = dmcActions!=null && dmcActions.size()>0?dmcActions.stream()
																							  .filter(e -> !e[9].toString().equalsIgnoreCase("C"))
																							  .collect(Collectors.groupingBy(array -> array[0] + "", LinkedHashMap::new, Collectors.toList())) : new HashMap<>();
										Committee committee = (Committee) request.getAttribute("committeeData");
										CommitteeSchedule dmcSchedule = (CommitteeSchedule) request.getAttribute("dmcSchedule");
										String seqDate = dmcSchedule!=null?dmcSchedule.getScheduleDate().toString().substring(2, 7):"";
										
										Map<Integer,String> mapDMC = (Map<Integer,String>)request.getAttribute("mapDMC");
									
										DecimalFormat df = new DecimalFormat("####################.##");
										FormatConverter fc = new FormatConverter();
										SimpleDateFormat sdf = fc.getRegularDateFormat();
										SimpleDateFormat sdf1 = fc.getSqlDateFormat();
									    SimpleDateFormat inputFormat = new SimpleDateFormat("ddMMMyyyy");
									    SimpleDateFormat outputFormat = new SimpleDateFormat("yyyy-MM-dd");	
										String todayDate = outputFormat.format(new Date()).toString();	
									%>
										<div class="container-fluid mt-3 tabpanes1">
											<table class="table table-bordered table-hover table-striped table-condensed " >
												<thead style="background-color: #4B70F5; color: #ffff !important;">
													<tr style="background-color: #4C3BCF;border-radius: 1rem;">
														<th colspan="6" style="border-radius: 1rem;"> <h5>DMC Approval</h5></th>
													</tr>
													<tr >
														<th style="width: 15px !important; text-align: center;">SN</th>
														<th style="width:30px;">ID</th>
														<th style="width: 280px;">Action Point</th>
														<th style="width: 205px;">Action by</th>
														<th style="width: 95px;"><!-- ADC <br> -->PDC</th>
														<th style="width: 200px;">Status</th>
														<!-- <th style="width: 80px;">Action</th> -->
														<!-- <th style="width: 20px;">Info</th> -->
													</tr>
												</thead>
												<tbody>
													<% if (prevdmcActionsToListMap!=null && prevdmcActionsToListMap.size() > 0) {
															int slno = 0;String key="";
															for (Map.Entry<String, List<Object[]>> map : prevdmcActionsToListMap.entrySet()) {
					                   							
					                   							List<Object[]> values = map.getValue();
					                   							int i=0;
					                   							for (Object[] obj : values) {
													%>
														<tr>
															<td style="text-align: center;"><%=++slno%></td>
															<td style="text-align: center;">
															
																<%if(obj[17]!=null && Long.parseLong(obj[17].toString())>0){ %>
																	<button type="button" class="btn btn-sm btn-primary" style="border-radius: 50px;font-weight: bold;background-color: #402E7A;" onclick="ActionDetails( <%=obj[17] %>);" data-toggle="tooltip" data-placement="top" title="Action Details" >
																		<%if(committee.getCommitteeShortName().trim().equalsIgnoreCase("DMC")){ %>
																		<%for (Map.Entry<Integer, String> entry : mapDMC.entrySet()) {
																			Date date = inputFormat.parse(obj[1].toString().split("/")[2]);
																			 String formattedDate = outputFormat.format(date);
																			 if(entry.getValue().equalsIgnoreCase(formattedDate)){
																				 key=entry.getKey().toString();
																			 } }}%>
																		
																		<%=committee.getCommitteeShortName().trim().toUpperCase()+"-"+key+"-("+seqDate+")/"+obj[1].toString().split("/")[3] %>
																	</button>
																<%}%> 
															<!--  -->
															</td>
															<%if(i==0) {%>
													    		<td rowspan="<%=values.size() %>" style="text-align: justify;vertical-align: top;"><%=obj[2] %></td>
			           										<%} %>
															<td style="text-align: justify;"><%=obj[11]+", "+obj[12]%></td>
															<td style="text-align: center;">
																<%	String actionstatus = obj[9].toString();
																	int progress = obj[15]!=null ? Integer.parseInt(obj[15].toString()) : 0;
																	LocalDate pdcorg = LocalDate.parse(obj[3].toString());
																	LocalDate lastdate = obj[13]!=null ? LocalDate.parse(obj[13].toString()): null;
																	LocalDate today = LocalDate.now();
																	LocalDate endPdc = LocalDate.parse(obj[4].toString());
																%> 
												 				<%-- <% if(lastdate!=null && actionstatus.equalsIgnoreCase("C") ){%>
																		<%if(actionstatus.equals("C") && (pdcorg.isAfter(lastdate) || pdcorg.equals(lastdate))){%>
																		<span class="completed"><%= sdf.format(sdf1.parse(obj[13].toString()))%> </span>
																		<%}else if(actionstatus.equals("C") && pdcorg.isBefore(lastdate)){ %>	
																		<span class="completeddelay"><%= sdf.format(sdf1.parse(obj[13].toString()))%> </span>
																		<%} %>	
																	<%}else{ %>
																			-									
																	<%} %>
																<br> --%>
																<span <%if(endPdc.isAfter(today) || endPdc.isEqual(today)) {%>style="color:black;font-weight: bold;" <%} else{%> style="color:maroon ;font-weight:bolder;" <%} %>>
																<%= sdf.format(sdf1.parse(obj[4].toString()))%> 
																</span>  
																<%if(!pdcorg.equals(endPdc)) { %>
																<br> 
																<span <%if(pdcorg.isAfter(today) || pdcorg.isEqual(today)) {%>style="color:black;font-weight: bold;" <%} else{%> style="color:maroon ;font-weight:bolder;" <%} %>>
																<%= sdf.format(sdf1.parse(obj[3].toString()))%> 
																</span>	
																<%} %>
															</td>
															<!-- <td style="text-align: center;">
																<input type="text" class="custom-input" name="actionStatus" placeholder="Enter Status">
																&nbsp;&nbsp;
																<button type="submit" class="btn btn-sm edit" name="action" value="A" data-toggle="tooltip" data-placement="top" title="Update" onclick="return confirm('Are you sure to update?')" style="border-radius: 0.75rem;">
																	Update
																</button>
															</td> -->
															<td style="text-align: justify;">
																<% if (obj[16] != null) { %><%=obj[16]%> <% } else{%>-<%} %>
															</td>
										
														</tr>
													<% i++; }} } else {%>
														<tr>
															<td colspan="6" style="text-align: center;">No Data Available</td>
														</tr>
													<%} %>
												</tbody>
											</table>	
										</div>	
										<div class="center mt-2 mb-2">
											<form action="#" id="dmcScheduleForm">
												<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"  />
												<input type="hidden" name="committeeMainId" value="<%=committeeMainId %>">
												<input type="hidden" name="committeeIdDMC" value="<%=committeeIdDMC %>">
												<input type="hidden" name="committeeId" value="<%=committeeIdDMC %>">
												<div class="row">
													<div class="col-md-4">
													</div>
													<div class="col-md-4 center">
														<%if(dmcSchedule!=null) {%> 
															<button type="submit" class="btn btn-sm fw-bold fs-custom btn-outline-info btn-minutes" value="Minutes" formaction="CommitteeScheduleMinutes.htm" >
																Minutes
															</button>
															<input type="hidden" name="committeescheduleid" value="<%=dmcSchedule.getScheduleId()%>">
															<input type="hidden" name="dmcFlag" value="Y">
														<%} %> 
													</div>
													
													
													<div class="col-md-4 right">
														<button type="submit" class="btn btn-sm submit" name="action" value="Add" id="dmcScheduleBtn" formaction="DCMScheduleDetailsSubmit.htm" style="display: none;"></button>
														<button type="button" class="open-modal-button mr-2" id="modalBtn" data-toggle="tooltip" title="Schedule New DMC">
															<img class="fa faa-pulse animated faa-medium" alt="" src="view/images/requirements.png" style="width:21px" >
														</button>
													</div>
													
												</div>
												
											</form>
											
										</div>	
									<!-- ----------------------------------------------- DMC End --------------------------------------------------- -->
									
									<!-- ----------------------------------------------- EB Calendar --------------------------------------------------- -->	
									<%} else if(tabName!=null && tabName.equalsIgnoreCase("EB Calendar")) { %>
										<div class="container-fluid mt-3 tabpanes2">
											<table class="table table-bordered table-hover table-striped table-condensed " style="width: 100%;" >
												<thead style="background-color: #4B70F5; color: #ffff !important;border-radius: 1rem;">
													<tr style="background-color: #4C3BCF;border-radius: 1rem;">
														<th colspan="6" style="border-radius: 1rem;"> <h5>EB Calendar</h5></th>
													</tr>
												</thead>
											</table>
										</div>
													
									<!-- ----------------------------------------------- EB Calendar End --------------------------------------------------- -->	
									
									<!-- ----------------------------------------------- PMRC Calendar --------------------------------------------------- -->	
									<%} else if(tabName!=null && tabName.equalsIgnoreCase("PMRC Calendar")) { %>
										<div class="container-fluid mt-3 tabpanes2">
											<table class="table table-bordered table-hover table-striped table-condensed " style="width: 100%;" >
												<thead style="background-color: #4B70F5; color: #ffff !important;border-radius: 1rem;">
													<tr style="background-color: #4C3BCF;border-radius: 1rem;">
														<th colspan="6" style="border-radius: 1rem;"> <h5>PMRC Calendar</h5></th>
													</tr>
												</thead>
											</table>
										</div>
													
									<!-- ----------------------------------------------- PMRC Calendar End --------------------------------------------------- -->	
									
									<!-- ----------------------------------------------- ASP Status --------------------------------------------------- -->	
									<%} else if(tabName!=null && tabName.equalsIgnoreCase("ASP Status")) { %>
										<div class="container-fluid mt-3 tabpanes2">
											<table class="table table-bordered table-hover table-striped table-condensed " style="width: 100%;" >
												<thead style="background-color: #4B70F5; color: #ffff !important;border-radius: 1rem;">
													<tr style="background-color: #4C3BCF;border-radius: 1rem;">
														<th colspan="6" style="border-radius: 1rem;"> <h5>ASP Status</h5></th>
													</tr>
												</thead>
											</table>
										</div>
													
									<!-- ----------------------------------------------- ASP Status End --------------------------------------------------- -->	
									
									<!-- ----------------------------------------------- Project Closure --------------------------------------------------- -->	
									<%} else if(tabName!=null && tabName.equalsIgnoreCase("Project Closure")) { %>
										<div class="container-fluid mt-3 tabpanes2">
											<table class="table table-bordered table-hover table-striped table-condensed " style="width: 100%;" >
												<thead style="background-color: #4B70F5; color: #ffff !important;border-radius: 1rem;">
													<tr style="background-color: #4C3BCF;border-radius: 1rem;">
														<th colspan="6" style="border-radius: 1rem;"> <h5>Project Closure</h5></th>
													</tr>
												</thead>
											</table>
										</div>
													
									<!-- ----------------------------------------------- Project Closure End --------------------------------------------------- -->	
									
									<!-- ----------------------------------------------- Cash Out Go Status --------------------------------------------------- -->	
									<%} else if(tabName!=null && tabName.equalsIgnoreCase("Cash Out Go Status")) { %>
										<div class="container-fluid mt-3 tabpanes2">
											<table class="table table-bordered table-hover table-striped table-condensed " style="width: 100%;" >
												<thead style="background-color: #4B70F5; color: #ffff !important;border-radius: 1rem;">
													<tr style="background-color: #4C3BCF;border-radius: 1rem;">
														<th colspan="6" style="border-radius: 1rem;"> <h5>Cash Out Go Status</h5></th>
													</tr>
												</thead>
											</table>
										</div>
													
									<!-- ----------------------------------------------- Cash Out Go Status End --------------------------------------------------- -->	
									
									<!-- ----------------------------------------------- Test & Trials --------------------------------------------------- -->	
									<%} else if(tabName!=null && tabName.equalsIgnoreCase("Test & Trials")) { %>
										<div class="container-fluid mt-3 tabpanes2">
											<table class="table table-bordered table-hover table-striped table-condensed " style="width: 100%;" >
												<thead style="background-color: #4B70F5; color: #ffff !important;border-radius: 1rem;">
													<tr style="background-color: #4C3BCF;border-radius: 1rem;">
														<th colspan="6" style="border-radius: 1rem;"> <h5>Test & Trials</h5></th>
													</tr>
												</thead>
											</table>
										</div>
													
									<!-- ----------------------------------------------- Test & Trials End --------------------------------------------------- -->	
									
									<!-- ----------------------------------------------- Achievements --------------------------------------------------- -->		
									<%} else if(tabName!=null && tabName.equalsIgnoreCase("Achievements")) {
											List<CCMAchievements> ccmAchievementsList = (List<CCMAchievements>) request.getAttribute("ccmAchievementsList");
											String scheduleId = (String) request.getAttribute("scheduleId");
											
											if(clusterLabList!=null && clusterLabList.size()>0) {

												Set<String> achmntLabCodes = ccmAchievementsList.stream().map(CCMAchievements::getLabCode).collect(Collectors.toSet());

												// Filter the clusterLabList to exclude records already in ccmAchievementsList
												clusterLabListFilter = clusterLabList.stream().filter(e -> !achmntLabCodes.contains(e[2].toString())).collect(Collectors.toList());
											}
											
											if(clusterLab.equalsIgnoreCase("N")){
												ccmAchievementsList = ccmAchievementsList.stream().filter(e -> e.getLabCode().equalsIgnoreCase(labcode)).collect(Collectors.toList());
											}

									%>
										<div class="container-fluid mt-3 tabpanes1">
											<table class="table table-bordered table-hover table-striped table-condensed " style="width: 100%;" >
												<thead style="background-color: #4B70F5; color: #ffff !important;border-radius: 1rem;">
													<tr style="background-color: #4C3BCF;border-radius: 1rem;">
														<th colspan="6" style="border-radius: 1rem;"> <h5>Achievements</h5></th>
													</tr>
													<tr >
														<th style="width: 5%;">SN</th>
														<th style="width: 15%;">Lab</th>
														<th style="width: 70%;">Achievement</th>
														<th style="width: 10%;">Action</th>
													</tr>
												</thead>
												<tbody>
													<%if(ccmAchievementsList!=null && ccmAchievementsList.size()>0) {
														int slno=0;
														for(CCMAchievements achmnts : ccmAchievementsList) {
													%>
														<tr>
															<td class="center"><%=++slno %></td>
															<td><%=achmnts.getLabCode() %></td>
															<td><%=achmnts.getAchievement() %></td>
															<td class="center">
																<form action="#">
																	<input type="hidden" name="action" value="Edit">
																	<textarea class="achievement" name="achievement" id="achievement_<%=slno %>" style="display: none;"><%=achmnts.getAchievement() %></textarea>
																	<button type="button" class="btn btn-lg" formmethod="post" formaction="CCMAchievementSubmit.htm" onclick="openAchievementsModalEdit('<%=slno %>','<%=achmnts.getAchievementId() %>','<%=achmnts.getLabCode() %>')" data-toggle="tooltip" data-placement="top" title="Edit Achievement">
																		<i class="fa fa-pencil-square-o" aria-hidden="true"></i>
																	</button>
																	<button type="submit" class="btn btn-lg" name="achievementId" value="<%=achmnts.getAchievementId() %>" formmethod="get" formaction="CCMAchievementDelete.htm" onclick="return confirm('Are you sure To Delete this Achievement?')" data-toggle="tooltip" data-placement="top" title="Delete Achievement"> 
																		<i class="fa fa-trash" aria-hidden="true"></i>
																	</button>
																</form>
															</td>
														</tr>
													<%}} else{%>
														<tr>
															<td colspan="6" style="text-align: center;">No Data Available</td>
														</tr>
													<%} %>
												</tbody>
											</table>
										</div>
										<div class="center mt-2 mb-2">
											
												<div class="row">
													<div class="col-md-4">
													</div>
													<div class="col-md-4 center">
														<button type="button" class="btn btn-sm fw-bold add" data-toggle="tooltip" data-target="modal" title="Add Achievement" onclick="openAchievementsModal()"
														<%if(clusterLab.equalsIgnoreCase("N") && ccmAchievementsList.size()>0) {%>disabled<%} %> >
															ADD ACHIEVEMENT
														</button>
													</div>
													
													<div class="col-md-4 right">
														
													</div>
													
												</div>
											
											
										</div>	
										
										<div class="modal fade bd-example-modal-lg" id="ckEditorModal" tabindex="-1" role="dialog" aria-labelledby="ckEditorModal" aria-hidden="true" style="margin-top: 5%;">
											<div class="modal-dialog modal-lg" role="document" style="max-width: 900px;">
												<div class="modal-content">
													<div class="modal-header bg-primary text-light">
											        	<h5 class="modal-title">Achievement</h5>
												        <button type="button" class="close" style="text-shadow: none!important" data-dismiss="modal" aria-label="Close">
												          <span aria-hidden="true" style="color:red;">&times;</span>
												        </button>
											      	</div>
									     			<div class="modal-body">
									     				<form action="CCMAchievementSubmit.htm" method="post" id="achmntForm">
									     					<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"  />
									     					<input type="hidden" name="scheduleId" value="<%=scheduleId%>">
									     					<input type="hidden" name="committeeId" value="<%=committeeId%>">
									     					<input type="hidden" name="achievementId" id="achievementId">
									     					
									     					<%if(clusterLab.equalsIgnoreCase("N")) {%>
									     						<input type="hidden" id="labCode" name="labCode" value="<%=labcode%>">
									     					<%} else {%>
									     						<div class="row">
									     							<div class="col-md-1">
									     								<label class="mt-2">Lab: </label>
									     							</div>
									     							<div class="col-md-3 mb-2 labCodeSelectDiv">
																		<select class="form-control selectdee" id="labCode" name="labCode" required style="width: 200px;">
																			<option value="0">---Select---</option>
																			<%if(clusterLabListFilter!=null && clusterLabListFilter.size()>0) {
																				for(Object[] obj : clusterLabListFilter) {
																			%>
																				<option value="<%=obj[2]%>" ><%=obj[2] %></option>
																			<%} }%>
																		</select>
									     							</div>
									     							<div class="col-md-3 mt-2 labCodeSpanDiv left" style="display: none;">
									     								<span id="showLabCode"></span>
									     							</div>
									     							<div class="col-md-8"></div>
									     						</div>
										     					
									     					<%} %>
									     					
									     					<textarea class="achievement" name="achievement" id="achievement" style="display: none;"></textarea>
											         		
											         		<div id="Editor" class="center"></div>
											         		
											         		<div class="center mt-2">
											         			<button type="submit" name="action" value="Add" class="btn btn-sm submit btn-achmnts" onclick="submitAchmnts()">Submit</button>
											         		</div>
										         		</form>
										         	</div>
									    		</div>
									  		</div>
										</div>
									<!-- ----------------------------------------------- Achievements End--------------------------------------------------- -->	
										
									<%} else {%>
										<div class="container-fluid mt-3 tabpanes2">
										</div>			
 									<%} %>
 								</div>
 							</div>
 						</div>
       				</div>
       			</div>
       		</div>		
       		
		</div>
	</div>		
	
	<!-- -------------------------------------------------------------- action modal ----------------------------------------------------- -->

	<div class=" modal bd-example-modal-lg" tabindex="-1" role="dialog" id="action_modal">
		<div class="modal-dialog modal-lg modal-dialog-jump" role="document" style="max-width: 950px;">
			<div class="modal-content">
				<div class="modal-header" style="background-color: #FFE0AD; ">
					<div class="row w-100"  >
						<div class="col-md-12" >
							<h5 class="modal-title" id="modal_action_no" style="font-weight:700; color: #A30808;">
								
							</h5>
						</div>
					</div>
					
					 <button type="button" class="close" data-dismiss="modal" aria-label="Close">
						<span aria-hidden="true">&times;</span>
					</button>
				</div>
				<div class="modal-body" align="center">
					<form action="#" method="post" autocomplete="off"  >
						<table style="width: 100%;">
							<tr>
								<td style="width:20%;padding: 5px;border :0;font-weight: bold;"> Action Item :</td>
								<td class="tabledata" style="width:80%;padding: 5px;word-wrap:break-word;border :0;" colspan="3" id="modal_action_item"></td>
							</tr>
							<tr>
								<td style="padding: 5px;border :0;font-weight: bold;" >Assign Date :</td>
								<td style="padding: 5px;border :0;" id="modal_action_date"></td>
								<td style="padding: 5px;border :0;font-weight: bold;" >PDC :</td>
								<td style="padding: 5px;border :0;" id="modal_action_PDC"></td>
							</tr>
							<tr>
								<td style="padding: 5px;border :0;font-weight: bold;" >Assignor :</td>
								<td style="padding: 5px;border :0;" class="tabledata" id="modal_action_assignor"></td>
								<td style="padding: 5px;border :0;font-weight: bold;" >Assignee :</td>
								<td style="padding: 5px;border :0;" class="tabledata" id="modal_action_assignee"></td>
							</tr>
							<tr>
								<td style="padding: 5px;border :0;font-weight: bold;" >Final Progress :</td>
								<td style="padding: 5px;border :0;" id="modal_action_progress"></td>
								<td style="padding: 5px;border :0;font-weight: bold;" > Type :</td>
								<td style="padding: 5px;font-weight: bold;color:#A30808 ;border :0;" id="modal_action_type"></td>
							</tr>
							
						</table>
					</form>
					<hr>
					<form method="post" action="SubSubmit.htm" enctype="multipart/form-data" id="subsubmitform">
						<table class="table table-bordered table-hover table-striped table-condensed " id="" style="width: 100%">
							<thead> 
								<tr style="background-color: #055C9D; color: white;">
									<th style="text-align: center;width:5% !important;">SN</th>
									<th style="text-align: center;width:15% !important;">Progress Date</th>
									<th style="text-align: center;width:15% !important;"> Progress</th>
									<th style="width:60% !important;">Remarks</th>
									<th style="text-align: center;width:5% !important;">Download</th>
								</tr>
							</thead>
							<tbody id="modal_progress_table_body">
								
							</tbody>
						</table>
						
						<hr> 
						<table class="table table-bordered table-hover table-striped table-condensed " id="myTable20" style="margin-top: 15px;">
							<thead>  
								<tr  style="background-color: #055C9D; color: white;">
									<th>As On Date</th>
									<th>Remarks</th>
									<th>Progress %</th>
									<th>Attachment</th>
								</tr>							
								<tr id="Memberrow0">									
									<td width="10%"><input  class="form-control "  data-date-format="dd/mm/yyyy" name="AsOnDate" id="DateCompletion" required="required" readonly="readonly" ></td>
									<td width="20%"><input type="text" name="Remarks" class="form-control item_name" maxlength="500"  required="required" /></td>      
									<td width="10%"><input type="number" name="Progress" class="form-control item_name" max="100"  min="0"  required="required" /></td>								
					         		<td  width="25%"><input type="file" name="FileAttach" id="FileAttach"  class="form-control wrap" aria-describedby="inputGroup-sizing-sm" maxlength="255" onchange="Filevalidation('FileAttach');"  /></td>										
								</tr>
							</thead>
						</table>
						
						<div align="center">
							<input type="submit"  class="btn  btn-sm submit" id="myBtn" onclick="return formsubmit('subsubmitform');" value="SUBMIT"/>
							<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"  />
				     		<input type="hidden" name="ActionMainId" id="ActionMainId"  /> 
				     		<input type="hidden" name="ActionAssignId" id="ActionAssignId" /> 
				     		<input type="hidden" name="committeeId" value="<%=committeeId %>" /> 
				     		<input type="hidden" name="tabName" value="<%=tabName %>" /> 
				     		<input type="hidden" name="ccmActionFlag" value="Y" /> 
						</div>	
					</form>
				</div>
				
			</div>
		</div>
	</div>

	<!-- -------------------------------------------------------------- action modal end ----------------------------------------------------- -->
	
	<!-- Modal Structure -->
	<div id="fixedModal" class="modal-fixed-bottom-right" style="display: none;">
	    <div class="modal-content">
	        <div class="modal-header" style="">
	            <h5 class="modal-title" style="">Schedule New DMC</h5>
	            <button type="button" class="close" id="closeModalBtn" aria-label="Close">
	                <span aria-hidden="true">&times;</span>
	            </button>
	        </div>
	        <div class="modal-body">
	            <input type="text" form="dmcScheduleForm" class="form-control" name="meetingDate" id="meetingDate" style="" readonly>
	        </div>
	        <div class="center">
	        	<button type="button" form="dmcScheduleForm" class="btn btn-sm fw-bold submit" onclick="validateDMCSchedule('<%=committeeIdDMC%>','<%=(String)request.getAttribute("committeeMainId")%>')">
					Submit
				</button>
        	</div>
	    </div>
	</div>
	
	
<script type="text/javascript">
	$(document).ready(function(){
	
		const tab = document.querySelector('button[name="tabName"][value="<%=tabName%>"]');
		
		if(tab) {
			tab.style.backgroundColor = 'green';
			tab.style.color = 'white';
			tab.style.borderColor = 'green';
		}
		
		$('[data-toggle="tooltip"]').tooltip();
		
		$('.atr-btn').trigger('click');
	});

	function ActionDetails(InAssignId)
	{
		$("#modal_progress_table").DataTable().destroy();
		
		$.ajax({		
			type : "GET",
			url : "ActionAssignDataAjax.htm",
			data : {
				ActionAssignid : InAssignId
			},
			datatype : 'json',
			success : function(result) {
				var result = JSON.parse(result);
				
				$('#modal_action_item').html(result[1]);
				$('#modal_action_no').html(result[2]);
				$('#modal_action_date').html(moment(new Date(result[5]) ).format('DD-MM-YYYY'));
				$('#modal_action_PDC').html(moment(new Date(result[6]) ).format('DD-MM-YYYY'));
				$('#modal_action_assignor').html(result[8]);
				$('#modal_action_assignee').html(result[9]);
				
				$('#ActionAssignId').val(result[0]);
				$('#ActionMainId').val(result[3]);
				
				var InActionType = result[10];
				var ActionType = 'Action';
				
				if(InActionType==='A')
				{
					ActionType = 'Action';
				}
				else if(InActionType==='I')
				{
					ActionType = 'Issue';
				}
				else if(InActionType==='D')
				{
					ActionType = 'Decision';
				}
				else if(InActionType==='R')
				{
					ActionType = 'Recommendation';
				}
				else if(InActionType==='C')
				{
					ActionType = 'Comment';
				}
				else if(InActionType==='K')
				{
					ActionType = 'Risk';
				}
				
				$('#modal_action_type').html(ActionType);
				
				var InProgress = '0'
				if(result[4]!=null){
					InProgress=result[4]+'';
				}
				
				if(InProgress.trim() === '0')
				{
					var progressBar ='<div class="progress" style="background-color:#cdd0cb !important;height: 1.5rem !important;">'; 
					progressBar += 		'<div class="progress-bar" role="progressbar" style=" width: 100%; background-color:#cdd0cb !important;color:black;font-weight: bold;  "  >';
					progressBar +=		'Not Started'
					progressBar +=		'</div>'; 
					progressBar += '</div>'; 
				}
				else
				{
					var progressBar ='<div class="progress" style="background-color:#cdd0cb !important;height:1.5rem !important; ">'; 
					progressBar += 		'<div class="progress-bar progress-bar-striped" role="progressbar" style=" width: '+InProgress+'%;  " aria-valuemin="0" aria-valuemax="100" >';
					progressBar +=		InProgress
					progressBar +=		'</div>'; 
					progressBar += '</div>'; 
				}
				$('#modal_action_progress').html(progressBar);
			}
		});
		$.ajax({		
			type : "GET",
			url : "ActionSubListAjax.htm",
			data : {
				ActionAssignid : InAssignId
			},
			datatype : 'json',
			success :  function(result) {
				var result = JSON.parse(result);
				
				
				var htmlStr='';
				if(result.length> 0){
					for(var v=0;v<result.length;v++)
						{
						htmlStr += '<tr>';
						htmlStr += '<td class="tabledata" style="text-align: center;" >'+ (v+1) + '</td>';
						htmlStr += '<td class="tabledata" style="text-align: center;" >'+ moment(new Date(result[v][3]) ).format('DD-MM-YYYY') + '</td>';
						htmlStr += '<td class="tabledata" style="text-align: center;" >'+ result[v][2] + ' %</td>';
						htmlStr += '<td class="tabledata" >'+ result[v][4] + '</td>';
						if(result[v][5]=== null)
						{
						htmlStr += '<td class="tabledata" style="text-align: center;">-</td>';
						}
						else
						{
						htmlStr += '<td class="tabledata" style="text-align: center;"><button type="submit" class="btn btn-sm" name="ActionSubId" value="'+ result[v][5] + '" target="blank" formaction="ActionDataAttachDownload.htm" ><i class="fa fa-download"></i></button></td>';
						}
						htmlStr += '</tr>';
					}
				}
				else
				{
					htmlStr += '<tr>';
					htmlStr += '<td colspan="5" style="text-align: center;"> Progress Not Updated </td>';
					htmlStr += '</tr>';
				}
				setModalDataTable();
				$('#modal_progress_table_body').html(htmlStr);
				
				
				$('#action_modal').modal('toggle');
			}
		});
	}
	
	setModalDataTable();
	
	function setModalDataTable()
	{
		$("#modal_progress_table").DataTable({
			"lengthMenu": [ 5, 10,25, 50, 75, 100 ],
			"pagingType": "simple",
			"pageLength": 5
		});
	}
	
	$('#DateCompletion').daterangepicker({
		"singleDatePicker" : true,
		"linkedCalendars" : false,
		"showCustomRangeLabel" : true,
		/* "minDate" :new Date(), */
		"startDate" : new Date(),

		"cancelClass" : "btn-default",
		showDropdowns : true,
		locale : {
			format : 'DD-MM-YYYY'
		}
	});
	
	var fsizeindi=0;
	  function Filevalidation (fileid) 
	    {
	        const fi = $('#'+fileid )[0].files[0].size;							 	
	        const file = Math.round((fi / 1024/1024));
	        if (file >= <%=filesize%>) 
	        {
	        	fsizeindi++;
	        	alert("File too Big, please select a file less than <%=filesize%> mb");
	        	document.getElementById("myBtn").disabled = true;
	        }else{
	        	fsizeindi=0;
	        	document.getElementById("myBtn").disabled = false;
	        }
	    }
	function formsubmit(formid)
	{
		if(fsizeindi>0)
		{
			alert("File too Big, please select a file less than 50mb");
			event.preventDefault();
			return false;
			
		}else
		{
			return confirm('Are You Sure To Submit?');
		}
	}
	
	
	// ATR Buttons handle
	// ATR Buttons handle
	$('.atr-btn').on('click', function () {
	
	    /* $('.atrHeading').show();
	    $('.prevatrHeading').hide(); */
	    
	    $('#prevatrTable').hide();
	    $('#atrTable').show();
	
	    // Toggle active class on the ATR button
	    $('.atr-btn').removeClass('btn-outline-secondary').addClass('btn-secondary');
	    
	    // Reset Pending Points button
	    $('.pending-point-btn').removeClass('btn-info').addClass('btn-outline-info');
	    
	});
	
	$('.pending-point-btn').on('click', function () {
		
		/* $('.atrHeading').hide();
	    $('.prevatrHeading').show(); */
	    
	    $('#atrTable').hide();
	    $('#prevatrTable').show();
	
	    // Toggle active class on the Pending Points button
	    $('.pending-point-btn').removeClass('btn-outline-info').addClass('btn-info');
	    
	    // Reset ATR button
	    $('.atr-btn').removeClass('btn-secondary').addClass('btn-outline-secondary');
	    
	});

	$('#meetingDate').daterangepicker({
	    "singleDatePicker": true,
	    "linkedCalendars": false,
	    "showCustomRangeLabel": true,
	    "startDate": new Date(),
	    "cancelClass": "btn-default",
	    "showDropdowns": true,
	    "drops": "up", // This will make the dropdown open above the input field
	    "locale": {
	        format: 'DD-MM-YYYY'
	    }
	});

	// Validate DMC Schedule
	function validateDMCSchedule(committeeId, committeeMainId) {
		if( committeeId==="0" && committeeMainId==="0"){
			if(confirm('DMC Committee not created yet \n Do you want to create New Committee?')){
				window.open('CommitteeList.htm', '_blank');
			}else{
				event.preventDefault();
			}
		}else if(committeeMainId=="0" && committeeId!="0"){
			if(confirm('DMC Committee not constituted yet \n Do you want to constitute Committee?')){
				window.open('CommitteeList.htm', '_blank');
			}else{
				event.preventDefault();
			}
		}else{
			if(confirm('Are you Sure to Add New Schedule?')){
				$('#dmcScheduleBtn').trigger('click');
			}else {
				event.preventDefault();
			}
		}
	}

	
	/* ---------------------CK Editor Config --------------------------------------------------------------------------------------------------- */

	var editor_config = {
			toolbar : [
					{
						name : 'clipboard',
						items : [ 'Undo', 'Redo' ]
					},
					{
						name : 'basicstyles',
						items : [ 'Bold', 'Italic', 'Underline', 'Strike',
								  'Subscript', 'Superscript' ]
					},

					{
						name : 'paragraph',
						items : [ 'NumberedList', 'BulletedList', '-',
								'Outdent', 'Indent']
					},

					{
						name : 'styles',
						items : [ 'Format', 'Font', 'FontSize' ]
					},
					{
						name : 'colors',
						items : [ 'TextColor', 'BGColor', 'CopyFormatting' ]
					},
					{
						name : 'align',
						items : [ 'JustifyLeft', 'JustifyCenter',
								'JustifyRight', 'JustifyBlock' ]
					}, {
						name : 'document',
						items : [ 'Source' ]
					} ],

			removeButtons : 'Underline,Strike,Subscript,Superscript,Anchor,Styles,Specialchar',

			customConfig : '',

			disallowedContent : 'img{width,height,float}',
			extraAllowedContent : 'img[width,height,align]',

			height : 200,

			contentsCss : [ CKEDITOR.basePath + 'mystyles.css' ],

			bodyClass : 'document-editor',

			format_tags : 'p;h1;h2;h3;pre',

			removeDialogTabs : 'image:advanced;link:advanced',

			stylesSet : [

			{
				name : 'Marker',
				element : 'span',
				attributes : {
					'class' : 'marker'
				}
			}, {
				name : 'Cited Work',
				element : 'cite'
			}, {
				name : 'Inline Quotation',
				element : 'q'
			},

			{
				name : 'Special Container',
				element : 'div',
				styles : {
					padding : '5px 10px',
					background : '#eee',
					border : '1px solid #ccc'
				}
			}, {
				name : 'Compact table',
				element : 'table',
				attributes : {
					cellpadding : '6',
					cellspacing : '0',
					border : '1',
					bordercolor : '#ccc'
				},
				styles : {
					'border-collapse' : 'collapse'
				}
			}, {
				name : 'Borderless Table',
				element : 'table',
				styles : {
					'border-style' : 'hidden',
					'background-color' : '#E6E6FA'
				}
			}, {
				name : 'Square Bulleted List',
				element : 'ul',
				styles : {
					'list-style-type' : 'square'
				}
			}, {
				filebrowserUploadUrl : '/path/to/upload-handler'
			}, ]
		};
	
	CKEDITOR.replace('Editor', editor_config);
	/* ---------------------CK Editor Config End --------------------------------------------------------------------------------------------------- */
	
	
	/* --------------------- Open Achievements Modal --------------------------------------------------------------------------------------------------- */
	
	function openAchievementsModal() {
		$('#ckEditorModal').modal('show');
		$('.btn-achmnts').val('Add');
		$('#achievementId').val('0');
		
		$('.labCodeSelectDiv').show();
		$('.labCodeSpanDiv').hide();
		
		CKEDITOR.instances['Editor'].setData('Enter Achievement Details');
	}
	
	function submitAchmnts(){
		var data = CKEDITOR.instances['Editor'].getData();
					
		$('#achievement').val(data);
		var $labCode = $('#labCode').val();
		
		if($labCode!="0") {
			if(window.confirm('Are you Sure to Submit?')) {
				$('#achmntForm').submit()
			}else{
				event.preventDefault();
			}
		}else{
			alert('Please Select Lab Name');
			event.preventDefault();
		}
		
	}
	
	function openAchievementsModalEdit(slno, achievementId, labCode) {
		
		$('#ckEditorModal').modal('show');
		$('#achievementId').val(achievementId);
		$('.btn-achmnts').val('Edit');
		$('.labCodeSelectDiv').hide();
		$('.labCodeSpanDiv').show();
		$('#showLabCode').html(labCode);
		
		var html = $('#achievement_'+slno).val();
		CKEDITOR.instances['Editor'].setData(html);
	}
	/* --------------------- Open Achievements Modal End --------------------------------------------------------------------------------------------------- */

	</script>	
	
	<script type="text/javascript">
		// Show modal on button click
		document.getElementById('modalBtn').addEventListener('click', function() {
		    document.getElementById('fixedModal').style.display = 'block';
		});
	
		// Close modal on close button click
		document.getElementById('closeModalBtn').addEventListener('click', function() {
		    document.getElementById('fixedModal').style.display = 'none';
		});
	
		document.addEventListener('DOMContentLoaded', function() {
			document.getElementById('fixedModal').style.display = 'block';
	    });
		
		$( document ).ready(function() {
	 	   setTimeout(() => { 
	 		  document.getElementById('fixedModal').style.display = 'none';
			}, 5000);
	 	});
	</script>
</body>
</html>