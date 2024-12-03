
<%@page import="com.vts.pfms.master.model.Employee"%>
<%@page import="com.google.gson.GsonBuilder"%>
<%@page import="com.google.gson.Gson"%>
<%@page import="java.time.LocalDate"%>
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
.more-than-half-width {
    width: 65% !important;
}
.less-than-half-width {
    width: 35% !important;
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

.evo-calendar .calendar-events, #eventListToggler { 
  display: none; /* Hides the events panel */
}

.evo-calendar .calendar-inner { 
  width: 100%; /* Makes the calendar take the full width */
}


.slider {
    position: absolute;
    cursor: pointer;
    top: 0;
    left: 0;
    right: 0;
    bottom: 0;
    background-color: #edae6f;
    transition: 0.4s;
    border-radius: 34px;
}

.slider:before {
    position: absolute;
    content: attr(data-content); /* Use a data attribute for dynamic content */
    height: 26px;
    width: 26px;
    left: 4px;
    bottom: 4px;
    background-color: white;
    color: black;
    display: flex;
    align-items: center;
    justify-content: center;
    font-size: 14px;
    font-weight: bold;
    transition: 0.4s;
    border-radius: 50%;
}

input:checked + .slider {
    background-color: #74d751;
}

input:checked + .slider:before {
    transform: translateX(26px);
}
   
.toggle-switch {
	position: relative;
	display: inline-block;
	width: 60px;
	height: 34px;
	top: 5px;
}

.toggle-switch input {
	display: none;
}

/* .toggle-switch .label {
	position: relative;
	margin-left: 20px;
	font-weight: bold;
	font-size: 14px;
} */
</style>
    
</head>
<body>

<%

TimeSheet timeSheet = (TimeSheet)request.getAttribute("timeSheetData");
List<TimeSheetActivity> timeSheetActivityList = timeSheet!=null?timeSheet.getTimeSheetActivity():new ArrayList<TimeSheetActivity>();
List<TimeSheetTrans> transaction = timeSheet!=null?timeSheet.getTimeSheetTrans():new ArrayList<TimeSheetTrans>();

String activityDate = (String)request.getAttribute("activityDate");
String activityDateSql = (String)request.getAttribute("activityDateSql");

List<Object[]> todayScheduleList = (List<Object[]>)request.getAttribute("todayScheduleList");

List<Object[]> empAllTimeSheetList = (List<Object[]>)request.getAttribute("empAllTimeSheetList");

List<Object[]> allLabList = (List<Object[]>) request.getAttribute("allLabList");
List<Employee> allEmpList = (List<Employee>) request.getAttribute("allEmployeeList");
List<Object[]> designationlist = (List<Object[]>) request.getAttribute("designationlist");
String labcode = (String)session.getAttribute("labcode");

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

Gson gson = new GsonBuilder().setDateFormat("yyyy-MM-dd").create();
String jsonempAllTimeSheetList = gson.toJson(empAllTimeSheetList);
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

	<div class="container-fluid">
		<div class="row">
			<div class="col-md-12">	
				<div class="card shadow-nohover">
					<div class="card-header">
						<h4 class="">Time Sheet</h4>
					</div>
					
					<div class="card-body d-flex justify-content-around">
						<div id="calendar" class="div-container less-than-half-width"></div>
						<div id="timesheet" class="div-container more-than-half-width">
							<div  style="font-size: 22px;font-weight: 600;color: white;text-align: center;background-color: #216583;height: 40px;">
								Time Sheet Details - (<%=activityDate %>)
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
				                
				                <%-- <div class="row mt-3">
				                	<div class="col-md-2 right">
				                		<label style="margin-top:0px; margin-left:0px;font-weight: 800; margin-bottom:0px;	font-size: 20px; color:#07689f;">
 											<b style="font-family: 'Lato',sans-serif;font-size: large;">Punch In &emsp;: </b>
 										</label>
				                	</div>
				                	<div class="col-md-3 left">
				                		<%if(timeSheet!=null && timeSheet.getPunchInTime()!=null) {%><%=fc.sdtfTordtf(timeSheet.getPunchInTime()) %><%} %>
				                	</div>
				                </div> --%>   
				                
				                <div class="row mt-3 ml-2 mr-2">
				                	<div class="col-md-12">
				                		<table id="activityviewtable" style="width:100%;" >
											<thead class="center">
												<tr>
													<th width="5%">SN</th>
													<th width="15%">Activity Type</th>
													<th width="10%">Assigner Lab</th>
													<th width="20%">Assigner</th>
													<th width="10%">PDC</th>
													<th width="7%">FN / AN</th>
													<th width="33%">Work Done</th>
												</tr>
											</thead>
											<tbody>
												<%if(timeSheetActivityList!=null && timeSheetActivityList.size()>0) {
													int count = 0;
													for(TimeSheetActivity act : timeSheetActivityList) {
														Employee emp = allEmpList!=null && allEmpList.size()>0?allEmpList.stream()
																		.filter(e -> e.getLabCode().equalsIgnoreCase(act.getAssignerLabCode()) && e.getEmpId()==act.getAssignedBy()).findFirst().orElse(null): null;
														Object[] desig = designationlist!=null && designationlist.size()>0 ?designationlist.stream()
																				.filter(e -> emp.getDesigId() == Long.parseLong(e[0].toString()) ).findFirst().orElse(null):null;
												%>
													<tr>
														<td class="center"><%=++count %></td>
														<td>
															<%if(act.getActivityTypeDesc()!=null && !act.getActivityTypeDesc().isEmpty()) {%><%=act.getActivityTypeDesc()%><%} else{%>-<%} %>
														</td>
														<td class="center">
															<%if(act.getAssignerLabCode()!=null) {%><%=act.getAssignerLabCode() %><%} %>
														</td>
														<td>
															<%=emp!=null?((emp.getTitle()!=null?emp.getTitle():(emp.getSalutation()!=null?emp.getSalutation():"")) + " " + (emp.getEmpName()) + ", " + (desig!=null && desig[2]!=null?desig[2]:"")):"-"%>
														</td>
														<td class="center">
															<%=act.getActionPDC()!=null?fc.sdfTordf(act.getActionPDC()):"-" %>
														</td>
														<td class="center">
															<%=act.getFnorAn()!=null?(act.getFnorAn().equalsIgnoreCase("A")?"AN":"FN"):"-" %>
														</td>
														<td>
															<%if(act.getWorkDone()!=null && !act.getWorkDone().isEmpty()) {%><%=act.getWorkDone()%><%} else{%>-<%} %>
														</td>
													</tr>
												<%} }else {%>
													<tr>
														<td colspan="6" class="center">No Data Available</td>
													</tr>
												<%} %>	
											</tbody>
										</table>
				                	</div>
				                </div>
						        <div class="row mt-3">
						        	<div class="col-md-12 center">
						        		<%-- <%if(timeSheet!=null && timeSheet.getTimeSheetStatus()!=null && (timeSheet.getTimeSheetStatus().equalsIgnoreCase("INI") || timeSheet.getTimeSheetStatus().equalsIgnoreCase("RBS"))) {%>
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
										<%} %> --%>
						        		<%if(timeSheet!=null) {%>
						        		<form action="#">
						        			<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
						        			<input type="hidden" name="timeSheetId" value="<%=timeSheet.getTimeSheetId()%>">
						        			<input type="hidden" name="activityDate" value="<%=activityDate%>">
							        		<%
							        			LocalDate now = LocalDate.now();
							        			LocalDate activityFromDate = LocalDate.parse(timeSheet.getActivityFromDate());
							        			LocalDate afterFiveDays = activityFromDate.plusDays(5);
							        		%>
							        		<%if(now.isBefore(afterFiveDays) || now.isEqual(afterFiveDays)) {%>
								        		<button type="button" class="btn btn-sm edit" onclick="AllowEdit('Y')" formnovalidate="formnovalidate" >
									  				EDIT &nbsp;<i class="fa fa-pencil " aria-hidden="true" style="font-size: 17px;"></i>
												</button>
											<%} %>
						        		</form>
										<%} %>
						        	</div> 
						        </div>    
							</div>
							
							<!-- Time Sheet Details Add / Edit -->
							<div class="shadow mt-2 timesheetform" id="timesheetformdiv">
								<form action="TimeSheetDetailsSubmit.htm" method="post">
									<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
									<%-- <div class="form-group">
										<div class="row ml-2">
											<div class="col-md-2">
												<label class="form-label">Date <span class="mandatory">*</span></label>
											</div>
											<div class="col-md-3 left" style="">
												<input type="text" class="form-control punch" name="punchInTime" id="punchInTime" <%if(timeSheet!=null && timeSheet.getPunchInTime()!=null) {%>value="<%=fc.sdtfTordtf(timeSheet.getPunchInTime()) %>"<%} %> readonly style="background: #fff;">
											</div>
											<div class="col-md-7"></div>
										</div>	
									</div> --%>
									<div class="form-group" id="activitytablediv">
										<div class="row ml-2 mr-2">
											<div class="col-md-12">
												<table id="activitytable" class="activitytable" >
													<thead class="center">
														<tr>
															<th width="15%">Activity Type</th>
															<th width="15%">Assigner Lab</th>
															<th width="20%">Assigner</th>
															<th width="10%">PDC</th>
															<th width="7%">FN / AN</th>
															<th width="33%">Work Done</th>
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
																	<input type="text" class="form-control" name="activityTypeDesc" <%if(act.getActivityTypeDesc()!=null) {%>value="<%=act.getActivityTypeDesc()%>"<%} %> placeholder="Enter maximum 50 characters" maxlength="50">
																</td>
																<td>
																	<select class="form-control selectitem assignerLabCode" name="assignerLabCode" id="assignerLabCode_edit_<%=count %>" data-live-search="true" data-container="body" onchange="labEmployeesList('edit_<%=count %>')">
																		<option value="0">Lab Name</option>
																			<% for (Object[] obj : allLabList) {%>
																			    <option value="<%=obj[3]%>" <%if(act.getAssignerLabCode().equalsIgnoreCase(obj[3].toString())){ %>selected<%} %> ><%=obj[3]%></option>
																		    <%} %>
																		<option value="@EXP" <%if(act.getAssignerLabCode().equalsIgnoreCase("@EXP")){ %>selected<%} %>>Expert</option>
																	</select>
																</td>
																<td>
																	<select class="form-control selectitem assignedBy" name="assignedBy" id="assignedBy_edit_<%=count %>" data-live-search="true" data-container="body">
																	</select>
																</td>
																<td>
																	<input type="text" class="form-control actionPDC" name="actionPDC" id="actionPDC_edit_<%=count %>" <%if(act.getActionPDC()!=null) {%> value="<%=fc.sdfTordf(act.getActionPDC())%>" <%} %> >
																</td>
																<td class="center">
																	<input type="hidden" class="fnoranval" name="fnoran" id="fnoranval_edit_<%=count %>" value="<%=act.getFnorAn()%>">
																	<label class="toggle-switch">
							                                            <input type="checkbox" class="fnoran" id="fnoran_edit_<%=count %>" <%if(act.getFnorAn()!=null && act.getFnorAn().equalsIgnoreCase("A")) {%>checked<%} %> >
							                                            <span class="slider"></span>
							                                            <!-- <span class="label" id="versionToggleLabel">FN</span> -->
							                                        </label>
																</td>
																<td>
																	<input type="text" class="form-control" name="workDone" <%if(act.getWorkDone()!=null) {%>value="<%=act.getWorkDone()%>"<%} %> placeholder="Enter maximum 200 characters" maxlength="200">
																</td>
															</tr>
														<%} }else {%>
															<%-- <%for(int i=1;i<=5;i++) {%> --%>
																<tr class="tr_clone_activity">
																	<td class="center">
																		<input type="text" class="form-control" name="activityTypeDesc" maxlength="50" >
																	</td>
																	<td>
																		<select class="form-control selectitem assignerLabCode" name="assignerLabCode" id="assignerLabCode_1" data-live-search="true" data-container="body" onchange="labEmployeesList('1')">
																			<option value="0">Lab Name</option>
																				<% for (Object[] obj : allLabList) {%>
																				    <option value="<%=obj[3]%>" <%if(obj[3].toString().equalsIgnoreCase(labcode)) {%>selected<%} %> ><%=obj[3]%></option>
																			    <%} %>
																			<option value="@EXP">Expert</option>
																		</select>
																	</td>
																	<td>
																		<select class="form-control selectitem assignedBy" name="assignedBy" id="assignedBy_1" data-live-search="true" data-container="body">
																			<option value="0">Choose...</option>
																	        <%-- <% for(Object[] emp : labEmpList){ %>
																	        	<option value="<%=emp[0] %>"><%=emp[1] %>, <%=emp[3] %></option>
																	        <%} %> --%>	
																		</select>
																	</td>
																	<td>
																		<input type="text" class="form-control actionPDC" name="actionPDC" id="actionPDC_1" >
																	</td>
																	<td class="center">
																		<input type="hidden" class="fnoranval" name="fnoran" id="fnoranval_1">
																		<label class="toggle-switch">
								                                            <input type="checkbox" class="fnoran" id="fnoran_1">
								                                            <span class="slider"></span>
								                                            <!-- <span class="label" id="versionToggleLabel">FN</span> -->
								                                        </label>
																	</td>
																	<td>
																		<input type="text" class="form-control" name="workDone" placeholder="Enter maximum 200 characters" maxlength="200" >
																	</td>
																</tr>
															<%-- <%} %>	 --%>
														<%} %>	
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
									<div class="form-group">
										<div class="row ml-2 mr-2 mt-2">
											<div class="col-md-12">
												<b>Note:</b> <br>
												1. Unfilled rows will be ignored. <br>
												2. E.g: Activity type - Technical, Managerial, Administrative, etc.
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
	    targetDiv.removeClass('full-width').addClass(divId === 'calendar' ? 'less-than-half-width' : 'more-than-half-width');
	    otherDiv.removeClass('hidden').addClass(divId === 'calendar' ? 'more-than-half-width' : 'less-than-half-width').show();
	} else if (otherDiv.hasClass('full-width')) {
	    // If the other div is in full width, reset both to original sizes
	    otherDiv.removeClass('full-width').addClass(divId === 'calendar' ? 'more-than-half-width' : 'less-than-half-width');
	    targetDiv.addClass('full-width').removeClass(divId === 'calendar' ? 'less-than-half-width' : 'more-than-half-width').show();
	} else {
	    // Set the target div to full width and hide the other
	    targetDiv.addClass('full-width').removeClass(divId === 'calendar' ? 'less-than-half-width' : 'more-than-half-width');
	    otherDiv.hide();
	}
	

 }
</script>
    
<script type="text/javascript">

	var empAllTimeSheetList = JSON.parse('<%= jsonempAllTimeSheetList %>');
	
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
	    
		<%-- <%	
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
	    <%} } }%> --%>
		<%-- <%	
		if(empActivityAssignList!=null && empActivityAssignList.size()>0) {
		for(Object[] obj :empActivityAssignList) {
			String[] seqNo = obj[9]!=null?obj[9].toString().split("/"):null;
		%>
	    {
	        id: "required-id-1",
	        name: "Today PDC",
	        Assigner: "<%=obj[1]%>,<%=obj[2]%>",
	        ActionLinkId : "<%=obj[8]%>",
	        ActionMainId : "<%=obj[0]%>",
	        ActionNo : "<%=obj[9]%>",
	       	ActionAssignid : "<%=obj[10]%>",
	        ProjectId : "<%=obj[14]%>",
	        time: "",
	        ComCode: "<%=seqNo!=null && seqNo.length>0?seqNo[seqNo.length-3]+"/"+seqNo[seqNo.length-2]+"/"+seqNo[seqNo.length-1]:"-" %>",
	        ComCode: "<%=obj[9]%>",
	        date: "<%=obj[4] %>",
	        url: "AssigneeList.htm",
	        type: "event",
	        color: "NA"
	    },
	    <%} }%> --%>
	    
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

        const today = new Date();
        const maxDate = today.toISOString().split('T')[0];
        const minDate = new Date(today);
        minDate.setDate(minDate.getDate() - 10);
        const formattedMinDate = minDate.toISOString().split('T')[0];
        const restrictionDate = new Date('2024-11-30');

        // Event listener for date click
        $('#calendar').on('selectDate', function(event, newDate) {
            var formattedDate = convertDateFormat(newDate);
            
            setPunchInDateTime(formattedDate);
            
            const selectedDate = new Date(newDate);

            const selectedDateParts = newDate.split('/'); // Format: mm/dd/yyyy
            const formattedSelectedDate =
                selectedDateParts[2] + '-' + // Year
                selectedDateParts[0].padStart(2, '0') + '-' + // Month
                selectedDateParts[1].padStart(2, '0'); // Day
                
            const isDateExisting = empAllTimeSheetList.some(row => {
                return row[3] === formattedSelectedDate;
            });

            if (isDateExisting) {
                $('#calenderdateform').submit();
            } else if (selectedDate < restrictionDate) {
                alert('Please select a date on or after 01-12-2024.');
                $('#calendar').evoCalendar('clearSelectedDate');
            } else if (selectedDate < minDate) {
                alert('Please select a date on or after 01-12-2024.');
                $('#calendar').evoCalendar('clearSelectedDate');
            } else if (selectedDate > today) {
                alert('Future date selection is not allowed.');
                $('#calendar').evoCalendar('clearSelectedDate');
            } else {
                $('#calenderdateform').submit();
            }
            
        });
        
     	// Simulate the click on the event list toggler to expand the calendar
        const eventListToggler = document.getElementById('eventListToggler');
        if (eventListToggler) {
          eventListToggler.click(); // Simulate the click
          eventListToggler.style.display = 'none'; // Hide the toggler
        }
	});
</script>
    
<script type="text/javascript">

	function setPunchInDateTime(date) {
		
		$('#punchInTime').daterangepicker({
            singleDatePicker: true,
            showDropdowns: true,
            timePicker: false,
            timePicker24Hour: false,
            timePickerIncrement: 1,
            autoUpdateInput: true,
            locale: {
                format: 'DD-MM-YYYY'
            }
        });
		
		$('.activityDate').val(date);
	}
	
</script>					

<script type="text/javascript">

	<%if(timeSheetActivityList!=null && timeSheetActivityList.size()>0) {
	int  count=1;
	for(TimeSheetActivity act : timeSheetActivityList){  %>
		EditlabEmployeesList('<%=count%>','<%=act.getAssignedBy()%>');
		datePickerInitializer('edit_<%=count%>');
		setFNorAnEdit('<%=count%>', '<%=act.getFnorAn()%>');
	<% count++;  } } else {%>
		
		// Initialize Date Picker
		datePickerInitializer(1);
		
		// Set FN / AN 
		setFNorAn(1);
		
		// Set Current Lab Emp List
		labEmployeesList(1);
	<%} %>
	
	// Initialize Select Picker
	$('.selectitem').select2();
	
	var cloneCount = 1; 
	
	$('#addnewaction').click(function(){
		$('.selectitem').select2("destroy");
		var $tr = $('.tr_clone_activity').last();
		var $clone = $tr.clone();
		$tr.after($clone);
		
		++cloneCount;
		
		$clone.find(".selectitem.assignerLabCode").attr("id", 'assignerLabCode_' + cloneCount).attr("onchange", 'labEmployeesList(\'' + cloneCount + '\')');
		$clone.find(".selectitem.assignedBy").attr("id", 'assignedBy_' + cloneCount);
		$clone.find(".actionPDC").attr("id", 'actionPDC_' + cloneCount);
		$clone.find(".fnoran").attr("id", 'fnoran_' + cloneCount);
		$clone.find(".fnoranval").attr("id", 'fnoranval_' + cloneCount);
		
		// Reset the checkbox state and slider content
	    var $checkbox = $clone.find(".fnoran");
	    $checkbox.prop('checked', false); // Uncheck the cloned checkbox
	    $checkbox.siblings('.slider').attr('data-content', 'FN'); // Reset slider content to "FN"
	    
		$('.selectitem').select2();
	    $clone.find('.selectitem').select2('val', '');
	    $clone.find("input").val("");
	    
	    labEmployeesList(cloneCount);
	    datePickerInitializer(cloneCount);
	    setFNorAn(cloneCount);
	    
	});
	
	// 
	function labEmployeesList($AddrowId){
		
		var $assignerLabCode = $('#assignerLabCode_'+$AddrowId).val();
		if($assignerLabCode !="" && $assignerLabCode !="null" && $assignerLabCode !=null){
		$.ajax({		
				type : "GET",
				url : "CommitteeAgendaPresenterList.htm",
				data : {
					PresLabCode : $assignerLabCode,
				},
				datatype : 'json',
				success : function(result) {
	
					var result = JSON.parse(result);	
					var values = Object.keys(result).map(function(e) {return result[e]});
							
					var s = '';
					s += '<option value="0" >Choose...</option>';
					for (i = 0; i < values.length; i++) {									
						s += '<option value="'+values[i][0]+'">'+values[i][1] + " (" +values[i][3]+")" + '</option>';
					} 
							 
					$('#assignedBy_'+$AddrowId).html(s);
				}
			});
		}
	}
	
	// 
	function EditlabEmployeesList($AddrowId, empId){
		
		var $assignerLabCode = $('#assignerLabCode_edit_'+$AddrowId).val();
		
		if($assignerLabCode !="" && $assignerLabCode !="null" && $assignerLabCode !=null){
			$.ajax({		
				type : "GET",
				url : "CommitteeAgendaPresenterList.htm",
				data : {
					PresLabCode : $assignerLabCode,
					
					   },
				datatype : 'json',
				success : function(result) {
	
				var result = JSON.parse(result);	
				var values = Object.keys(result).map(function(e) {return result[e]});
				
				var s = '';
				s += '<option value="0">Choose...</option>';
				for (i = 0; i < values.length; i++) {									
					s += '<option value="'+values[i][0]+'">'+values[i][1] + " (" +values[i][3]+")"+ '</option>';
				} 
							 
				$('#assignedBy_edit_'+$AddrowId).html(s);
				$('#assignedBy_edit_'+$AddrowId).val(empId).trigger('change');
				
				}
			});
		}
	}
	
	// Datepicker initializer
	function datePickerInitializer(rowId) {
		$('#actionPDC_'+rowId).daterangepicker({
			singleDatePicker: true,
		    linkedCalendars: false,
		    showCustomRangeLabel: true,
		    cancelClass: "btn-default",
		    showDropdowns: true,
            locale: {
                format: 'DD-MM-YYYY'
            }
        });
	}
	
	// Set FN / AN dynamically
	function setFNorAn(rowId) {
	    // Initialize with "FN" for the slider
	    $('#fnoran_' + rowId).siblings('.slider').attr('data-content', 'FN');
	    $('#fnoranval_' + rowId).val('F');
	    // Listen to changes on the checkbox
	    $('#fnoran_' + rowId).change(function () {
	        if ($(this).is(':checked')) {
	            $('#fnoranval_' + rowId).val('A');
	            $(this).siblings('.slider').attr('data-content', 'AN'); // Set "AN" when checked
	        } else {
	            $('#fnoranval_' + rowId).val('F');
	            $(this).siblings('.slider').attr('data-content', 'FN'); // Set "FN" when unchecked
	        }
	    });
	}
	
	function setFNorAnEdit(rowId, fnoran) {
		console.log('rowId: ', rowId);
		console.log('fnoran: ', fnoran);
	    if(fnoran=='A') {
	    	$('#fnoran_edit_' + rowId).siblings('.slider').attr('data-content', 'AN');
	    }else {
	    	$('#fnoran_edit_' + rowId).siblings('.slider').attr('data-content', 'FN');
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