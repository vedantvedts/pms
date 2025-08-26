
<%@page import="org.apache.commons.text.StringEscapeUtils"%>
<%@page import="com.vts.pfms.master.model.MilestoneActivityType"%>
<%@page import="java.util.Comparator"%>
<%@page import="java.util.Optional"%>
<%@page import="com.vts.pfms.timesheet.model.TimeSheetTrans"%>
<%@page import="java.util.HashMap"%>
<%@page import="java.util.Map"%>
<%@page import="java.util.stream.Collectors"%>
<%@page import="com.vts.pfms.FormatConverter"%>
<%@page import="java.util.ArrayList"%>
<%@page import="com.vts.pfms.timesheet.model.TimeSheetActivity"%>
<%@page import="com.vts.pfms.timesheet.model.TimeSheet"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>    
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<jsp:include page="../static/header.jsp"></jsp:include>

<%-- <spring:url value="/resources/css/projectdetails.css" var="projetdetailscss" />
<link href="${projetdetailscss}" rel="stylesheet" /> --%>

<style type="text/css">

label{
font-weight: bold;
  font-size: 15px !important;
}

.table .font{
	  font-family:'Muli', sans-serif !important;
	  font-style: normal;
	  font-size: 13px;
	  font-weight: 400 !important;
	 
}

.table button {
    background-color: Transparent !important;
    background-repeat:no-repeat;
    border: none;
    cursor:pointer;
    overflow: hidden;
    outline:none;
    text-align: left !important;
}
.table td{
	padding:5px !important;
}
 .resubmitted{
	color:green;
}

	.fa{
		font-size: 1.20rem;
	}
	
.datatable-dashv1-list table tbody tr td{
	padding: 8px 10px !important;
}

.table-project-n{
	color: #005086;
}

#table thead tr th{
	padding: 0px 0px !important;
}

#table tbody tr td{
	padding:2px 3px !important;
}


/* icon styles */

.cc-rockmenu {
	color:fff;
	padding:0px 5px;
	font-family: 'Lato',sans-serif;
}

.cc-rockmenu .rolling {
  display: inline-block;
  cursor:pointer;
  width: 34px;
  height: 30px;
  text-align:left;
  overflow: hidden;
  transition: all 0.3s ease-out;
  white-space: nowrap;
  
}
.cc-rockmenu .rolling:hover {
  width: 108px;
}
.cc-rockmenu .rolling .rolling_icon {
  float:left;
  z-index: 9;
  display: inline-block;
  width: 28px;
  height: 52px;
  box-sizing: border-box;
  margin: 0 5px 0 0;
}
.cc-rockmenu .rolling .rolling_icon:hover .rolling {
  width: 312px;
}

.cc-rockmenu .rolling i.fa {
    font-size: 20px;
    padding: 6px;
}
.cc-rockmenu .rolling span {
    display: block;
    font-weight: bold;
    padding: 2px 0;
    font-size: 14px;
    font-family: 'Muli',sans-serif;
}

.cc-rockmenu .rolling p {
	margin:0;
}

.width{
	width:270px !important;
}

.left {
	text-align: left;
}
.center{
	text-align: center;
}
.right{
	text-align: right;
}
.mandatory{
	color: red;
}
</style>
<style>
.card-body{
	padding: 0px !important;
}
.control-label{
	font-weight: bold !important;
}
#scrollclass::-webkit-scrollbar {
	width: 7px;
}

#scrollclass::-webkit-scrollbar-track {
	-webkit-box-shadow: inset 0 0 6px rgba(0, 0, 0, 0.3);
	border-radius: 5px;
}

#scrollclass::-webkit-scrollbar-thumb {
	border-radius: 5px; 
	/*   -webkit-box-shadow: inset 0 0 6px black;  */
	background-color: #fff;
} 

#scrollclass::-webkit-scrollbar-thumb:hover {
	-webkit-box-shadow: inset 0 0 6px black;
	transition: 0.5s;
}

#scrollclass::-webkit-scrollbar {
	width: 7px;
}

#scrollclass::-webkit-scrollbar-track {
	-webkit-box-shadow: inset 0 0 6px rgba(0, 0, 0, 0.3);
	border-radius: 5px;
}

#scrollclass::-webkit-scrollbar-thumb {
	border-radius: 5px;
	/*   -webkit-box-shadow: inset 0 0 6px black;  */
	background-color: #fff;
}

#scrollclass::-webkit-scrollbar-thumb:hover {
	-webkit-box-shadow: inset 0 0 6px black;
	transition: 0.5s;
}


#span{
background: blue;
}
#span1{
font-size: 10px;
margin-left:10px
}

#span2{
float:right;
font-size: 10px;
margin-right:10px
}

</style>
<style type="text/css">
.activitytable{
	border-collapse: collapse;
	width: 100%;
	border: 1px solid #216583;
}
.activitytable th, .activitytable td{
	border: 2px solid #216583;
	padding: 7px;
}

input {
	font-family: sans-serif;
	font-size: 18px;
}

#activityviewtable{
	border-collapse: collapse;
	width: 100%;
	border: 2px solid #216583;
	padding: 10px;
}

#activityviewtable th, #activityviewtable td{
	border: 2px solid #216583;
	padding: 7px;
}

.calendar-inner {
	padding: 40px 10px;
}
</style>

<style>
.div-container {
	position: relative;
	margin: 0.5rem;
    border: 3px solid #216583;
    border-radius: 5px;
    transition: all 0.5s;
}
.full-width {
    width: 100% !important;
}
.half-width {
    width: 48% !important;
}
.more-than-half-width {
    width: 51% !important;
}
.toggle-icon {
    position: absolute;
    top: 10px;
    right: 10px;
    cursor: pointer;
    font-size: 1.5rem;
    z-index: 10;
}

/* Ensure select picker adjusts width */
.select2-container {
    width: 100% !important; /* Force full width */
}

.timesheetform{
	max-height: 500px;
    min-height: 300px;
    overflow-y: auto;
    overflow-x: hidden;
}

/* Firefox */
.timesheetform {
  scrollbar-width: thin;
  scrollbar-color: #216583 #f8f9fa;
}

/* Chrome, Edge, and Safari */
.timesheetform::-webkit-scrollbar {
  width: 12px;
}

.timesheetform::-webkit-scrollbar-track {
  background: #f8f9fa;
  border-radius: 5px;
}

.timesheetform::-webkit-scrollbar-thumb {
  background-color: #007bff;
  border-radius: 5px;
  border: 2px solid #f8f9fa;
}

.custom-scrollbar::-webkit-scrollbar-thumb:hover {
  background-color: #0056b3;
}

</style>
    
</head>
<body>

<%

List<Object[]> empActivityAssignList = (List<Object[]>)request.getAttribute("empActivityAssignList");

TimeSheet timeSheet = (TimeSheet)request.getAttribute("timeSheetData");
List<TimeSheetActivity> timeSheetActivityList = timeSheet!=null?timeSheet.getTimeSheetActivity():new ArrayList<TimeSheetActivity>();
List<TimeSheetTrans> transaction = timeSheet!=null?timeSheet.getTimeSheetTrans():new ArrayList<TimeSheetTrans>();

String activityDate = (String)request.getAttribute("activityDate");
String activityDateSql = (String)request.getAttribute("activityDateSql");

List<Object[]> todayScheduleList = (List<Object[]>)request.getAttribute("todayScheduleList");

List<Object[]> empAllTimeSheetList = (List<Object[]>)request.getAttribute("empAllTimeSheetList");
List<MilestoneActivityType> milestoneActivityTypeList = (List<MilestoneActivityType>)request.getAttribute("milestoneActivityTypeList");
List<Object[]> projectList = (List<Object[]>)request.getAttribute("projectList");
//LocalDate now = LocalDate.now();

//DateTimeFormatter dateTimeFormatter = DateTimeFormatter.ofPattern("dd-MM-yyyy HH:mm:ss");
//LocalDateTime actualPunchInTime = LocalDateTime.of(now, LocalTime.parse("08:30:00"));
FormatConverter fc = new FormatConverter();

//String status = timeSheet.getTimeSheetStatus()!=null?timeSheet.getTimeSheetStatus():"INI";

Map<String, String> statusMap = new HashMap<>();
statusMap.put("INI", "#95c8f4");
statusMap.put("FWD", "#0383F3");
statusMap.put("ABS", "#2B7A0B");
statusMap.put("RBS", "#fe4e4e");

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
			<div class="col-md-12">	
				<div class="card shadow-nohover">
					<div class="card-header">
						<h4 class="">Time Sheet</h4>
					</div>
					
					<div class="card-body d-flex justify-content-around">
						<div id="calendar" class="div-container more-than-half-width"></div>
						<div id="timesheet" class="div-container half-width">
							<div  style="font-size: 22px;font-weight: 600;color: white;text-align: center;background-color: #216583;height: 40px;">
								Time Sheet Details - (<%=activityDate!=null?StringEscapeUtils.escapeHtml4(activityDate):"-" %>)
							</div>
							
							<!-- Time Sheet Details View -->
							<div class="timesheetform" id="timesheetdetailsdiv">
								<!-- <div class="row">
							    	<div class="col-md-10" align="left">
							        	
							    	</div>
			                            	
	                   				<div class="col-md-2 mt-1" style="margin-bottom: 5px">
										<button class="share-button" style="border: none;font-size:13px;" onclick="AllowEdit()" id="" value="EDIT" >
							  				<span><i class="fa fa-pencil text-white" aria-hidden="true" style=""></i></span>
							  				<input type="submit"  class="edit-btn" name="sub" value="EDIT">
										</button>
									</div>       			  	
				                </div>
				                            				
				                <hr> -->
				                
				                <div class="row mt-3">
				                	<div class="col-md-2 right">
				                		<label style="margin-top:0px; margin-left:0px;font-weight: 800; margin-bottom:0px;	font-size: 20px; color:#07689f;">
 											<b style="font-family: 'Lato',sans-serif;font-size: large;">Punch In &emsp;: </b>
 										</label>
				                	</div>
				                	<div class="col-md-3 left">
				                		<%if(timeSheet!=null && timeSheet.getPunchInTime()!=null) {%><%=fc.sdtfTordtf(StringEscapeUtils.escapeHtml4(timeSheet.getPunchInTime())) %><%} %>
				                	</div>
				                </div>   
				                
				                <div class="row mt-3 ml-2 mr-2">
				                	<div class="col-md-12">
				                		<table id="activityviewtable" style="width:100%;" >
											<thead class="center">
												<tr>
													<th width="5%">SN</th>
													<th width="20%">Activity No</th>
													<th width="20%">Project</th>
													<th width="25%">Activity</th>
													<th width="10%">Duration</th>
													<th width="20%">Remarks</th>
												</tr>
											</thead>
											<tbody>
												<%if(timeSheetActivityList!=null && timeSheetActivityList.size()>0) {
													int count = 0;
													for(TimeSheetActivity act : timeSheetActivityList) {
														
														Object[] activity = empActivityAssignList!=null && empActivityAssignList.size()>0?empActivityAssignList.stream()
																 			.filter(e -> act.getActivityId() == Long.parseLong(e[10].toString()))
																 	        .findFirst()
																 	        .orElse(null)
																 	    	: null;
												%>
													<tr>
														<td class="center"><%=++count %></td>
														<td>
															<%if(act.getActivityId()==Long.parseLong("0")) {%>
																NIL
															<%} else {%>
																<%=activity!=null&&activity[9]!=null?StringEscapeUtils.escapeHtml4(activity[9].toString()):"-" %>			
															<%} %>
														</td>
														<td>
															<%
																String project = projectList!=null?projectList.stream()
															            .filter(e -> Long.parseLong(e[0].toString()) == act.getProjectId())
															            .map(e ->  e[4]+" ("+e[17]+")")
															            .findFirst().orElse("General"): "-";
																out.println(project);
															%>
														</td>
														<td>
															<%if(act.getActivityType().equalsIgnoreCase("N")) {
																String activityName = milestoneActivityTypeList.stream()
															            .filter(e -> e.getActivityTypeId() == act.getActivityTypeId())
															            .map(MilestoneActivityType::getActivityType)
															            .findFirst().orElse(null);
																out.println(activityName);
															%>
																<%-- <%if(act.getActivityNameType().equalsIgnoreCase("A")) {
																	String activityName = milestoneActivityTypeList.stream()
																            .filter(e -> e.getActivityTypeId() == act.getActivityNameId())
																            .map(MilestoneActivityType::getActivityType)
																            .findFirst().orElse(null);
																	out.println(activityName);
																}else if(act.getActivityNameType().equalsIgnoreCase("G")){
																	out.println("General");
																}else if(act.getActivityNameType().equalsIgnoreCase("P")){
																	String activityName = projectList!=null?projectList.stream()
																            .filter(e -> Long.parseLong(e[0].toString()) == act.getActivityNameId())
																            .map(e ->  e[4]+" ("+e[17]+")")
																            .findFirst().orElse(null): null;
																	out.println(activityName);
																}
																%> --%>
																
															<%} else{%>
																<%=activity!=null&&activity[5]!=null?StringEscapeUtils.escapeHtml4(activity[5].toString()):"-" %>	
															<%} %>
														</td>
														<td class="center">
															<%if(act.getActivityDuration()!=null) {%><%=StringEscapeUtils.escapeHtml4(act.getActivityDuration())%><%} %>
														</td>
														<td>
															<%if(act.getRemarks()!=null && !act.getRemarks().isEmpty()) {%><%=StringEscapeUtils.escapeHtml4(act.getRemarks())%><%} else{%>-<%} %>
														</td>
													</tr>
												<%} }else {%>
													<tr>
														<td colspan="6" class="center">No Data Available</td>
													</tr>
												<%} %>	
												<tr>
													<td class="right" colspan="3" style="font-weight: bold;">Work Duration</td>
													<td colspan="1" class="center">
														<%if(timeSheet!=null && timeSheet.getTotalDuration()!=null) {%><%=StringEscapeUtils.escapeHtml4(timeSheet.getTotalDuration()) %><%} else{%>00:00<%} %>
													</td>
													<td colspan="1"></td>
												</tr>
												<% String latestRemarks = transaction!=null && transaction.size()>0? transaction.stream()
																		  .filter(e -> "ABS".equals(e.getTimeSheetStatusCode()) || "RBS".equals(e.getTimeSheetStatusCode()))
																		  .sorted(Comparator.comparing(TimeSheetTrans::getActionDate).reversed())
						            									  .map(TimeSheetTrans::getRemarks)
						            									  .findFirst()
						            									  .orElse(""): "";
						        				%>
						        				<%if(!latestRemarks.isEmpty()) {%>
												<tr>
													<td class="right" colspan="1" style="font-weight: bold;">Remarks</td>
													<td colspan="4">
						        						<%=latestRemarks!=null?StringEscapeUtils.escapeHtml4(latestRemarks):"-" %>
													</td>
												</tr>
												<%} %>
											</tbody>
										</table>
				                	</div>
				                </div>
						        <div class="row mt-3">
						        	<div class="col-md-12 center">
						        		<%if(timeSheet!=null && timeSheet.getTimeSheetStatus()!=null && (timeSheet.getTimeSheetStatus().equalsIgnoreCase("INI") || timeSheet.getTimeSheetStatus().equalsIgnoreCase("RBS"))) {%>
						        		<form action="#">
						        			<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
						        			<input type="hidden" name="timeSheetId" value="<%=timeSheet.getTimeSheetId()%>">
						        			<input type="hidden" name="activityDate" value="<%=activityDate%>">
							        		
							        		<button type="button" class="btn btn-sm edit" onclick="AllowEdit('Y')" formnovalidate="formnovalidate" >
								  				EDIT &nbsp;<i class="fa fa-pencil " aria-hidden="true" style="font-size: 17px;"></i>
											</button>
											<button type="submit" class="btn-sm btn submit" formaction="TimeSheetDetailsForward.htm" name="action" value="A" onclick="return confirm('Are you sure to Forward?')">
												Forward &nbsp;<i class="fa fa-forward" aria-hidden="true" style="font-size: 15px;"></i>
											</button>
						        		</form>
										<%} %>
						        	</div> 
						        </div>    
							</div>
							
							<!-- Time Sheet Details Add / Edit -->
							<div class="shadow mt-2 timesheetform" id="timesheetformdiv">
								<form action="TimeSheetDetailsSubmit.htm" method="post">
									<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
									<div class="form-group">
										<div class="row ml-2">
											<div class="col-md-2">
												<label class="form-label">Punch In <span class="mandatory">*</span></label>
											</div>
											<div class="col-md-3 left" style="">
												<input type="text" class="form-control punch" name="punchInTime" id="punchInTime" <%if(timeSheet!=null && timeSheet.getPunchInTime()!=null) {%>value="<%=fc.sdtfTordtf(StringEscapeUtils.escapeHtml4(timeSheet.getPunchInTime())) %>"<%} %> readonly style="background: #fff;">
											</div>
											<div class="col-md-7"></div>
										</div>	
									</div>
									<div class="form-group" id="activitytablediv">
										<div class="row ml-2 mr-2">
											<div class="col-md-12">
												<table id="activitytable" class="activitytable" >
													<thead class="center">
														<tr>
															<th width="20%">Activity No</th>
															<th width="20%">Project</th>
															<th width="25%">Activity</th>
															<th width="10%">Duration</th>
															<th width="25%">Remarks</th>
														</tr>
													</thead>
													<tbody id="activityTableBody">
														<%if(timeSheetActivityList!=null && timeSheetActivityList.size()>0) {
															int count = 0;
														  	for(TimeSheetActivity act : timeSheetActivityList) {
														  		++count;
														%>
															<tr class="tr_clone_activity">
																<td>
																	<input type="hidden" name="projectIdhidden" id="projectId-input-<%=count %>">
																	<select class="form-control selectdee" id="activityId-<%=count %>" name="activityId" onchange="changeActivity('<%=count %>')" data-live-search="true" >
																		<option selected="selected" value="0" <%if(act.getActivityId()==Long.parseLong("0")) {%>selected<%} %> >--Select--</option>
																		<option value="N" <%if(act.getActivityType().equalsIgnoreCase("N")) {%>selected<%} %> >Add New</option>
																		<%
																		    if(empActivityAssignList!=null && empActivityAssignList.size()>0){
																		    for(Object[] activity : empActivityAssignList){
																			%>
																			<option value="<%=activity[10]%>" 
																			data-activity="<%=activity[5]%>" 
																			data-projectid="<%=activity[14]%>" 
																			data-actionno="<%=activity[9]%>"
																			<%if(act.getActivityId()==Long.parseLong(activity[10].toString())) {%>selected<%} %>
																			>
																			<%=activity[9]!=null?StringEscapeUtils.escapeHtml4(activity[9].toString()):"-"%>
																			</option>
																		<%} }%>
																	</select>
																</td>
																<td>
																	<span id="activityName-project-<%=count %>"></span>
																	<select class="form-control selectdee" name="projectId" id="projectId-select-<%=count %>">
																		<option value="0" <%if(act.getProjectId()==0) {%>selected<%} %> >General</option>
											               				 <%
											                				for(Object[] pro: projectList ){
											                					String projectshortName=(pro[17]!=null)?" ("+pro[17].toString()+") ":"";
											                			 %>
																			<option value="<%=pro[0]%>" <%if(act.getProjectId()==Long.parseLong(pro[0].toString())) {%>selected<%} %>  ><%=pro[4]!=null?StringEscapeUtils.escapeHtml4(pro[4].toString()):"-"%> <%=projectshortName!=null?StringEscapeUtils.escapeHtml4(projectshortName):"-" %></option>
																		<%} %>
																	</select>
																</td>
																<td>
																	<span id="activityName-<%=count %>"></span>
																	<select class="form-control selectdee" name="activityName" id="activityName-select-<%=count %>">
																		<option value="" disabled="disabled" selected="selected">--Select--</option>
																		<%if(milestoneActivityTypeList!=null && milestoneActivityTypeList.size()>0) {
																			for(MilestoneActivityType mil : milestoneActivityTypeList) {
																		%>
																			<option value="<%=mil.getActivityTypeId()%>" <%if(act.getActivityTypeId()==mil.getActivityTypeId()) {%>selected<%} %> ><%=mil.getActivityType() %></option>
																		<%} }%>
																	</select>
																	<!-- <input type="text" class="form-control" name="activityName" id="activityName-select-1" placeholder="Enter maximum 255 characters" maxlength="255"> -->
																</td>
																
																<td class="center">
																	<input type="text" class="form-control duration center" name="duration" id="duration" <%if(act.getActivityDuration()!=null) {%>value="<%=StringEscapeUtils.escapeHtml4(act.getActivityDuration()) %>"<%} %> maxlength="5" onchange="calculateTotalDuration()">
																</td>
																<td>
																	<input type="text" class="form-control" name="remarks" <%if(act.getRemarks()!=null) {%>value="<%=StringEscapeUtils.escapeHtml4(act.getRemarks()) %>"<%} %> placeholder="Enter maximum 255 characters" maxlength="255">
																</td>
															</tr>
														<%} }else {%>
															<tr class="tr_clone_activity">
																<td>
																	<input type="hidden" name="projectIdhidden" id="projectId-input-1">
																	<select class="form-control selectdee" id="activityId-1" name="activityId" onchange="changeActivity('1')" data-live-search="true" >
																		<option selected="selected" value="0">--Select--</option>
																		<option value="N">Add New</option>
																		<%
																		    if(empActivityAssignList!=null && empActivityAssignList.size()>0){
																		    for(Object[] activity : empActivityAssignList){
																		    	String activity5 = activity[5].toString().replaceAll("'", "\\\\'")
																								        			     .replaceAll("\"", "\\\\\"")
																								        			     .replaceAll("\n", "")
																								        			     .replaceAll("\r", "");
																			%>
																			<option value="<%=activity[10]%>" 
																			data-activity="<%=activity5%>" 
																			data-projectid="<%=activity[14]%>" 
																			data-actionno="<%=activity[9]%>"
																			>
																			<%=activity[9]!=null?StringEscapeUtils.escapeHtml4(activity[9].toString()):"-"%>
																			</option>
																		<%} }%>
																	</select>
																</td>
																<td>
																	<span id="activityName-project-1"></span>
																	<select class="form-control selectdee" name="projectId" id="projectId-select-1">
																		<option value="0" >General</option>
											               				 <%
											                				for(Object[] pro: projectList ){
											                					String projectshortName=(pro[17]!=null)?" ("+pro[17].toString()+") ":"";
											                			 %>
																			<option value="<%=pro[0]%>" ><%=pro[4]!=null?StringEscapeUtils.escapeHtml4(pro[4].toString()):" - "%> <%=projectshortName!=null?StringEscapeUtils.escapeHtml4(projectshortName):" - " %></option>
																		<%} %>
																	</select>
																</td>
																<td>
																	<span id="activityName-1"></span>
																	<select class="form-control selectdee" name="activityName" id="activityName-select-1">
																		<option value="" disabled="disabled" selected="selected">--Select--</option>
																		<%if(milestoneActivityTypeList!=null && milestoneActivityTypeList.size()>0) {
																			for(MilestoneActivityType mil : milestoneActivityTypeList) {
																		%>
																			<option value="<%=mil.getActivityTypeId()%>"><%=mil.getActivityType()!=null?StringEscapeUtils.escapeHtml4(mil.getActivityType()):"-" %></option>
																		<%} }%>
																	</select>
																	<!-- <input type="text" class="form-control" name="activityName" id="activityName-select-1" placeholder="Enter maximum 255 characters" maxlength="255"> -->
																</td>
																<td class="center">
																	<input type="text" class="form-control duration center" name="duration" id="duration" maxlength="5" onchange="calculateTotalDuration()">
																</td>
																<td>
																	<input type="text" class="form-control" name="remarks" placeholder="Enter maximum 255 characters" maxlength="255">
																</td>
															</tr>
														<%} %>
															<tr>
																<td class="right" colspan="3" style="font-weight: bold;">Work Duration</td>
																<td colspan="1">
																	<input type="text" class="form-control totalduration center" name="totalduration" id="totalduration" value="<%if(timeSheet!=null && timeSheet.getTotalDuration()!=null) {%><%=StringEscapeUtils.escapeHtml4(timeSheet.getTotalDuration()) %><%} else{%>01:00<%} %>" maxlength="5" readonly>
																</td>
																<td colspan="1"></td>
															</tr>
													</tbody>
												</table>
											</div>
										</div>
									</div>
									<div class="form-group">
										<div class="row ml-2 mr-2 mt-2">
											<div class="col-md-4">
												<span class="text-primary" id="addnewaction" style="cursor: pointer;">
													<i class="fa fa-plus" aria-hidden="true" style="font-size: 16px;"></i> 
													Add New Activity Row 
												</span>
											</div>
											<div class="col-md-4 center">
												<%if(timeSheet!=null){ %>
								    				<input type="hidden" name="timeSheetId" value="<%=timeSheet.getTimeSheetId()%>">
													<button type="submit" class="btn btn-sm btn-warning edit" name="Action" value="Edit" onclick="return confirm('Are you sure to update?')" >UPDATE</button>
													<button type="button" class="btn btn-sm" style="border: none;font-size:13px;margin-left: 1%;padding: 7px 10px 7px 10px;" onclick="AllowEdit('N')"
														formnovalidate="formnovalidate" data-toggle="tooltip" data-placement="top" title="Close">
														<i class="fa fa-times fa-lg" aria-hidden="true" style="color: red;"></i>
													</button>
												<%}else{ %>
													<button type="submit" class="btn btn-sm btn-success submit" name="Action" value="Add" onclick="return confirm('Are you sure to submit?')" >SUBMIT</button>
												<%} %>
											</div>
											<div class="col-md-4">
											</div>
										</div>
									</div>
									<input type="hidden" class="activityDate" name="activityDate" id="activityDate">
								</form>
								
								<form action="TimeSheetList.htm" method="post" id="calenderdateform">
									<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
									<input type="hidden" class="activityDate" name="activityDate" id="activityDate">
								</form>
							</div>
							
						</div>
						
					</div>
					<div class="text-center mt-3">
			            <button class="btn btn-primary" onclick="toggleDiv('calendar')">Toggle Calendar</button>
			            <button class="btn btn-secondary" onclick="toggleDiv('timesheet')">Toggle Time Sheet</button>
        			</div>	
				</div>
			</div>
		</div>
	</div>

<script>
function toggleDiv(divId) {
	const calendarDiv = $('#calendar');
	const meetingsDiv = $('#timesheet');
	const targetDiv = $('#' + divId);
	const otherDiv = divId === 'calendar' ? meetingsDiv : calendarDiv;
	
	if (targetDiv.hasClass('full-width')) {
	    // Reset to original sizes
	    targetDiv.removeClass('full-width').addClass(divId === 'calendar' ? 'more-than-half-width' : 'half-width');
	    otherDiv.removeClass('hidden').addClass(divId === 'calendar' ? 'half-width' : 'more-than-half-width').show();
	} else if (otherDiv.hasClass('full-width')) {
	    // If the other div is in full width, reset both to original sizes
	    otherDiv.removeClass('full-width').addClass(divId === 'calendar' ? 'half-width' : 'more-than-half-width');
	    targetDiv.addClass('full-width').removeClass(divId === 'calendar' ? 'more-than-half-width' : 'half-width').show();
	} else {
	    // Set the target div to full width and hide the other
	    targetDiv.addClass('full-width').removeClass(divId === 'calendar' ? 'more-than-half-width' : 'half-width');
	    otherDiv.hide();
	}
	

 }
</script>
    
<script type="text/javascript">
	var myEvents = [
		<%if(empAllTimeSheetList!=null && empAllTimeSheetList.size()>0) {
		for(Object[] obj :empAllTimeSheetList) {
		%>
	    {
	        id: "required-id-1",
	        name: "Time Sheet",
	        time: "",
	        ComCode: "Time Sheet",
	        date: "<%=obj[3] %>",
	        url: "#",
	        type: "event",
	        <%-- color: '<%=obj[10]!=null?(obj[10].toString().equalsIgnoreCase("INI")?"#4DACFF":(obj[10].toString().equalsIgnoreCase("FWD")?"#0383F3":"#2B7A0B")):"#4DACFF"%>' --%>
	    	color: "<%=statusMap.get(obj[10]!=null?obj[10].toString():"#95c8f4")%>"
	    },
	    <%} }%>
	    
		<%	
		if(todayScheduleList!=null && todayScheduleList.size()>0) {
		for(Object[] obj :todayScheduleList) {
			if(!obj[6].toString().equalsIgnoreCase("E")){
		%>
	    {
	        id: "required-id-1",
	        name: "Today Meetings",
	        scheduleid: "<%=obj[2] %>",
	        time: "<%=obj[4] %>",
	        ComCode: "<%=obj[7] %>",
	        date: "<%=obj[3] %>",
	        url: "CommitteeScheduleView.htm",
	        type: "event",
	        color: "NA"
	    },
	    <%} } }%>
		<%	
		if(empActivityAssignList!=null && empActivityAssignList.size()>0) {
		for(Object[] obj :empActivityAssignList) {
			String[] seqNo = obj[9]!=null?obj[9].toString().split("/"):null;
		%>
	    {
	        id: "required-id-1",
	        name: "Today PDC",
	        <%-- Assigner: "<%=obj[1]%>,<%=obj[2]%>",
	        ActionLinkId : "<%=obj[8]%>",
	        ActionMainId : "<%=obj[0]%>",
	        ActionNo : "<%=obj[9]%>",
	       	ActionAssignid : "<%=obj[10]%>",
	        ProjectId : "<%=obj[14]%>", --%>
	        time: "",
	        ComCode: "<%=seqNo!=null && seqNo.length>0?seqNo[seqNo.length-3]+"/"+seqNo[seqNo.length-2]+"/"+seqNo[seqNo.length-1]:"-" %>",
	        <%-- ComCode: "<%=obj[9]%>", --%>
	        date: "<%=obj[4] %>",
	        url: "AssigneeList.htm",
	        type: "event",
	        color: "NA"
	    },
	    <%} }%>
	    
	]
	
	$("#calendar").evoCalendar({
	    theme: 'Royal Navy',
	    calendarEvents: myEvents,
	});

	$(document).ready(function() {
	
		var activityDate = '<%=activityDate%>';
	    
    	setPunchInDateTime(activityDate);
    	
    	if(activityDate!=null && activityDate!=''){
    		
    		// Function to convert date from dd-mm-yyyy to yyyy-mm-dd
            function convertDateToIsoFormat(dateStr) {
                var parts = dateStr.split('-');
                return parts[2] + '-' + parts[1] + '-' + parts[0];
            }

            // Convert custom date to yyyy-mm-dd format
            var isoDate = convertDateToIsoFormat(activityDate);

            // Set the calendar date
            $('#calendar').evoCalendar('selectDate', isoDate);
    	}
    	
	 	// Function to convert date format from mm/dd/yyyy to dd-mm-yyyy
        function convertDateFormat(dateStr) {
            var parts = dateStr.split('/');
            return parts[1] + '-' + parts[0] + '-' + parts[2];
        }

        // Event listener for date click
        $('#calendar').on('selectDate', function(event, newDate) {
            var formattedDate = convertDateFormat(newDate);
            
            setPunchInDateTime(formattedDate);
            
            $('#calenderdateform').submit();
            
        });
        
	});
</script>
    
<script type="text/javascript">

	function setPunchInDateTime(date) {
		
		$('#punchInTime').daterangepicker({
            singleDatePicker: true,
            showDropdowns: true,
            timePicker: true,
            timePicker24Hour: true,
            timePickerIncrement: 1,
            autoUpdateInput: true,
            <%if(timeSheet==null) {%>
            startDate: date+' 08:30:00',
            <%}%>
            minDate: date+' 00:00:00', 
            maxDate: date+' 23:59:00', 
            locale: {
                format: 'DD-MM-YYYY HH:mm:ss'
            }
        });
		
		$('.activityDate').val(date);
	}
	
    $(document).ready(function() {
		
      //Initialize timepickers for Duration
    	$('.duration').daterangepicker({
    	    timePicker : true,
    	    singleDatePicker:true,
    	    timePicker24Hour : true,
    	    timePickerIncrement : 1,
    	    timePickerSeconds : false,
    	    <%if(timeSheet==null) {%>
    	    startDate: '01:00',
    	    endDate : '12:00',
    	    <%}%>
    	    maxDate : '12:00',
    	    locale : {
    	        format : 'HH:mm'
    	    }
    	}).on('show.daterangepicker', function(ev, picker) {
    	    picker.container.find(".calendar-table").hide();
    	});	

      	<%if(timeSheet==null){%>
    		changeActivity('1');
    	<%}%>
    	
    	<%if(timeSheetActivityList!=null && timeSheetActivityList.size()>0) {
    		int count = 0;
    	  	for(TimeSheetActivity act : timeSheetActivityList) {
    	%>
    			changeActivity('<%=++count %>');
    	<%} }%>
    	
    	calculateTotalDuration();
    	
    });
    
    function calculateTotalDuration(){
    	let totalMinutes = 0;
        
        $('.duration').each(function() {
            const time = $(this).val();
            if (time) {
                const [hours, minutes] = time.split(':').map(Number);
                totalMinutes += hours * 60 + minutes;
            }
        });
       
        const totalHours = Math.floor(totalMinutes / 60);
        const remainingMinutes = totalMinutes % 60;
        const totalDuration = (totalHours < 10 ? '0' : '') + totalHours + ':' + (remainingMinutes < 10 ? '0' : '') + remainingMinutes;
        $('#totalduration').val(totalDuration);
    }
</script>					

<script type="text/javascript">
	$('#addnewaction').click(function(){
		
		var newId = $('.tr_clone_activity').length+1;
		
		var newRow = '';
		newRow+='<tr class="tr_clone_activity">';
		newRow+='<td><input type="hidden" name="projectIdhidden" id="projectId-input-'+newId+'"><select class="form-control selectdee" id="activityId-'+newId+'" name="activityId" onchange="changeActivity('+newId+')"  data-live-search="true" data-container="body"  >';
		newRow+='<option selected="selected" value="0">--Select--</option> <option value="N">Add New</option>';
		<%
        if(empActivityAssignList!=null && empActivityAssignList.size()>0){
        for(Object[] activity : empActivityAssignList){
        	 String activity5 = activity[5].toString().replaceAll("'", "\\\\'")
								        			  .replaceAll("\"", "\\\\\"")
								        			  .replaceAll("\n", "")
								        			  .replaceAll("\r", "");
        	 
        %>
		newRow+='<option value="<%=activity[10]%>" data-activity="<%=activity5%>" data-projectid="<%=activity[14]%>" data-actionno="<%=activity[9]%>"><%=activity[9]!=null?StringEscapeUtils.escapeHtml4(activity[9].toString()):"-"%></option>';
		<%} }%>
		newRow+='</select></td>';
		newRow+='<td><span id="activityName-project-'+newId+'"></span><select class="form-control selectdee" name="projectId" id="projectId-select-'+newId+'"><option value="0" >General</option>';
   				 <%
    				for(Object[] pro: projectList ){
    					String projectshortName=(pro[17]!=null)?" ("+pro[17].toString()+") ":"";
    			 %>
    			 newRow+='<option value="<%=pro[0]%>" ><%=pro[4]!=null?StringEscapeUtils.escapeHtml4(pro[4].toString()):" - "%> <%=projectshortName!=null?StringEscapeUtils.escapeHtml4(projectshortName):" - " %></option>';
				<%} %>
		newRow+='</select></td>';
		newRow+='<td><span id="activityName-'+newId+'"></span>';
		newRow+='<select class="form-control selectdee" name="activityName" id="activityName-select-'+newId+'"><option value="" disabled="disabled" selected="selected">--Select--</option>';
			<%if(milestoneActivityTypeList!=null && milestoneActivityTypeList.size()>0) {
				for(MilestoneActivityType mil : milestoneActivityTypeList) {
			%>
			newRow+='<option value="<%=mil.getActivityTypeId()%>"><%=mil.getActivityType() %></option>';
			<%} }%>
		newRow+='</select>';
		newRow+='</td>';
		newRow+='<td class="center"><input type="text" class="form-control duration center" name="duration" id="duration" maxlength="5" onchange="calculateTotalDuration()"></td>';
		newRow+='<td><input type="text" class="form-control" name="remarks" placeholder="Enter maximum 255 characters" maxlength="255"></td>';
		newRow+='</tr>';
		
		 $('#activityTableBody tr:last').before(newRow);
		
		$('#activityId-'+newId+'').select2();
		$('#projectId-select-'+newId+'').select2();
		$('#activityName-select-'+newId+'').select2();
		
		// Initialize new start time picker
	    $('#activityTableBody').find('.duration').last().daterangepicker({
	    	timePicker : true,
    	    singleDatePicker:true,
    	    timePicker24Hour : true,
    	    timePickerIncrement : 1,
    	    timePickerSeconds : false,
    	    startDate: '01:00',
    	    endDate : '12:00',
    	    maxDate : '12:00',
    	    locale : {
    	        format : 'HH:mm'
    	    }
	    }).on('show.daterangepicker', function(ev, picker) {
	        picker.container.find(".calendar-table").hide();
	    });
		
	    changeActivity(newId);
	    
	    calculateTotalDuration();
	});
	
	function escapeHtml(text) {
	    var map = {
	        '&': '&amp;',
	        '<': '&lt;',
	        '>': '&gt;',
	        '"': '&quot;',
	        "'": '&#039;',
	        '/': '&#x2F;',
	        '`': '&#x60;',
	        '=': '&#x3D;'
	    };
	    return text.replace(/[&<>"'`=\/]/g, function(m) { return map[m]; });
	}
</script>

<script type="text/javascript">
/* 	function changeActivity(selectid)
	{
		var activityId = $('#activityId-'+selectid).val();
		if(activityId=='N'){
			$('#activityName-select-'+selectid).show();
			$('#activityName-'+selectid).hide();
		}else if(activityId=='0'){
			$('#activityName-select-'+selectid).hide();
			$('#activityName-'+selectid).hide();
		}else{
			$('#activityName-select-'+selectid).hide();
			$('#activityName-'+selectid).show();
			$('#activityName-'+selectid).html($('#activityId-'+selectid+' option:selected').attr('data-activity'));
		}
	} */
	
	function changeActivity(selectid) {
		
	    var activityId = $('#activityId-' + selectid).val();
	    var activitySelect2 = $('#activityName-select-' + selectid).next('.select2-container');
	    var projectSelect2= $('#projectId-select-' + selectid).next('.select2-container');

	    if (activityId == 'N') {
	    	activitySelect2.show();
	    	projectSelect2.show();
	        $('#activityName-' + selectid).hide();
	        $('#activityName-project-' + selectid).hide();
	    } else if (activityId == '0') {
	    	activitySelect2.hide();
	    	projectSelect2.hide();
	        $('#activityName-' + selectid).hide();
	        $('#activityName-project-' + selectid).hide();
	    } else {
	    	activitySelect2.hide();
	    	projectSelect2.hide();
	        $('#activityName-' + selectid).show();
	        $('#activityName-project-' + selectid).show();
	        var selectedDataActivity = $('#activityId-' + selectid + ' option:selected').attr('data-activity');
	        var selectedDataProjectId = $('#activityId-' + selectid + ' option:selected').attr('data-projectid');
	        var selectedDataActionNo = $('#activityId-' + selectid + ' option:selected').attr('data-actionno');
	        var actionNo = selectedDataActionNo!=null?selectedDataActionNo.split("/"):null;
	        $('#activityName-' + selectid).html(selectedDataActivity);
	        $('#projectId-input-' + selectid).val(selectedDataProjectId);
	        $('#activityName-project-' + selectid).html(selectedDataProjectId==0?'General':(actionNo!=null?actionNo[1]:'-'));
	    }
	}
	
</script>

<script type="text/javascript">
	$(document).ready(function() {
		<%if(timeSheet!=null) {%>
			$('#timesheetformdiv').hide();
			$('#timesheetdetailsdiv').show();
		<%} else{%>
			$('#timesheetformdiv').show();
			$('#timesheetdetailsdiv').hide();
		<%} %>
		
	});

	function AllowEdit(allow){
		if(allow=='Y') {
			$('#timesheetformdiv').show();
			$('#timesheetdetailsdiv').hide();
		}else{
			$('#timesheetformdiv').hide();
			$('#timesheetdetailsdiv').show();
		}
		
	}
</script>				
</body>
</html>