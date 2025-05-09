<%@page import="com.google.gson.GsonBuilder"%>
<%@page import="com.google.gson.Gson"%>
<%@page import="com.vts.pfms.timesheet.model.TimesheetKeywords"%>
<%@page import="com.vts.pfms.master.model.Employee"%>
<%@page import="java.util.HashMap"%>
<%@page import="java.util.LinkedHashMap"%>
<%@page import="java.util.stream.Collectors"%>
<%@page import="com.vts.pfms.master.model.MilestoneActivityType"%>
<%@page import="java.util.Date"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.ArrayList"%>
<%@page import="com.vts.pfms.timesheet.model.TimeSheetActivity"%>
<%@page import="com.vts.pfms.timesheet.model.TimeSheet"%>
<%@page import="com.vts.pfms.FormatConverter"%>
<%@page import="java.time.DayOfWeek"%>
<%@page import="java.time.temporal.TemporalAdjusters"%>
<%@page import="java.time.LocalDate"%>
<%@page import="java.util.Map"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>  
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<jsp:include page="../static/header.jsp"></jsp:include>

<!-- Pdfmake  -->
	<spring:url value="/resources/pdfmake/pdfmake.min.js" var="pdfmake" />
	<script src="${pdfmake}"></script>
	<spring:url value="/resources/pdfmake/vfs_fonts.js" var="pdfmakefont" />
	<script src="${pdfmakefont}"></script>
	<spring:url value="/resources/pdfmake/htmltopdf.js" var="htmltopdf" />
	<script src="${htmltopdf}"></script>
	
<style type="text/css">
label{
font-weight: bold;
  font-size: 15px !important;
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
.activitytable{
	border-collapse: collapse;
	width: 100%;
	border: 1px solid #0000002b; 
	margin-top: 1.2rem;
	overflow-y: auto; 
	overflow-x: auto;  
}
.activitytable th, .activitytable td{
	border: 1px solid #0000002b; 
	padding: 20px;
}
.activitytable th{

	vertical-align: middle;
}
.activitytable thead {
	text-align: center;
	background-color: #2883c0;
	color: white;
	position: sticky;
	top: 0; /* Keeps the header at the top */
	z-index: 10; /* Ensure the header stays on top of the body */
	/* background-color: white; */ /* For visibility */
}


#activityviewtable{
	border-collapse: collapse;
	width: 100%;
	border: 1px solid #0000002b; 
	padding: 10px;
}

#activityviewtable th, #activityviewtable td{
	border: 1px solid #0000002b; 
	padding: 7px;
}
#activityviewtable thead {
	text-align: center;
	background-color: #60707a;
	color: white;
}

.highlight-week {
	background-color: #2883c0 !important;
	color: white;
}

.table-wrapper {
    max-height: 800px; /* Set the max height for the table wrapper */
    overflow-y: auto; /* Enable vertical scrolling */
    overflow-x: hidden; /* Enable vertical scrolling */
}

.select2-container {
    text-align: left !important;
    width: 100% !important;
}
</style>

<style type="text/css">

/* General Calendar Styles */
.calendar-container {
    display: flex;
    align-items: center;
    justify-content: space-between;
    padding: 10px;
    background: linear-gradient(145deg, #ffffff, #f0f0f0);
    border-radius: 8px;
    box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
    border: 1px solid #ddd;
    gap: 10px;
    overflow-x: auto;
}

/* Navigation Buttons */
.nav-btn {
    background-color: transparent;
    border: none;
    color: #007bff;
    font-size: 16px;
    cursor: pointer;
    transition: transform 0.3s ease, color 0.3s ease;
}

.nav-btn:hover {
    color: #0056b3;
    transform: scale(1.2);
}

.fa {
    font-size: 20px;
}

/* Month Display */
.month-display {
    font-size: 16px;
    font-weight: bold;
    color: #fff;
    padding: 3px 5px;
    background-color: #7e7e7e;
    border-radius: 5px;
    border: 1px solid #ddd;
    box-shadow: 0 1px 2px rgba(0, 0, 0, 0.1);
    text-transform: uppercase;
    text-align: center;
    min-width: 50px;
    /* transform: rotate(270deg); */
}

/* Year Container */
.year-container {
    display: flex;
    align-items: center;
    gap: 5px;
}

#current-year {
    font-size: 18px;
    font-weight: bold;
    color: #333;
}

/* Days Container */
.days-container {
    display: flex;
    flex-wrap: nowrap;
    gap: 10px;
    justify-content: flex-start;
    overflow: hidden;
    width: 100%; /* Ensure it adjusts according to the width of the calendar */
}

.day {
    display: flex;
    flex-direction: column;
    align-items: center;
    justify-content: center;
    width: 42px;
    height: 42px;
    text-align: center;
    border: 1px solid #ddd;
    border-radius: 8px;
    background-color: #fdfdfd;
    font-size: 14px;
    cursor: pointer;
    transition: background-color 0.3s ease, transform 0.2s ease;
}
.day-name {
    font-size: 10px;
    color: #0f0f0f8a;
    font-weight: 400;
}

.day-number {
    font-size: 14px;
    font-weight: bold; 
}

.day:hover {
    background-color: #007bff;
    transform: scale(1.1);
}

.day:hover .day-name,
.day:hover .day-number {
    color: #fff !important; /* Change to desired hover color */
}

.day.active {
    background-color: #28a745;
    font-weight: bold;
}

.day.active .day-name,
.day.active .day-number {
    color: #fff !important; /* Ensure active state color is applied */
}


/* Responsive Design */
@media (max-width: 768px) {
    .day {
        width: 35px;
        height: 35px;
        line-height: 35px;
        font-size: 12px;
    }
}

@media (max-width: 480px) {
    .day {
        width: 30px;
        height: 30px;
        line-height: 30px;
        font-size: 10px;
    }
}

.highlighted-date {
    background-color: #007bff; /* Yellow background for highlighting */
    font-weight: bold;
}

.day.highlighted-date .day-name,
.day.highlighted-date .day-number {
    color: #fff !important; /* Ensure active state color is applied */
}

.spinner {
    position: fixed;
    top: 40%;
    left: 50%;
    transform: translate(-50%, -50%);
    z-index: 9999; /* Ensures it is above other elements */
    text-align: center;
    display: none; /* Initially hidden */
}

.spinner img {
    width: 200px;
    height: 200px;
}

</style> 
</head>
<body>

<%
List<Object[]> employeeList = (List<Object[]>)request.getAttribute("roleWiseEmployeeList");
Map<String, Map<LocalDate, TimeSheet>> timeSheetData = (Map<String, Map<LocalDate, TimeSheet>>)request.getAttribute("timesheetDataForOfficer");
List<MilestoneActivityType> milestoneActivityTypeList = (List<MilestoneActivityType>) request.getAttribute("milestoneActivityTypeList");

List<Employee> allEmpList = (List<Employee>) request.getAttribute("allEmployeeList");
List<Object[]> designationlist = (List<Object[]>) request.getAttribute("designationlist");
List<Object[]> projectList = (List<Object[]>)request.getAttribute("projectList");
List<TimesheetKeywords> keywordsList = (List<TimesheetKeywords>) request.getAttribute("keywordsList");

String activityWeekDate = (String)request.getAttribute("activityWeekDate");
String activityWeekDateSql = (String)request.getAttribute("activityWeekDateSql");

LocalDate localdate = LocalDate.parse(activityWeekDateSql);
// Get the start of the week (Sunday)
LocalDate startOfWeek = localdate.with(TemporalAdjusters.previousOrSame(DayOfWeek.SUNDAY));

// Get the end of the week (Saturday)
LocalDate endOfWeek = localdate.with(TemporalAdjusters.nextOrSame(DayOfWeek.SATURDAY));


String empId = (String)request.getAttribute("empId");
String empIdW = (String)request.getAttribute("empIdW");

String activityDate = (String)request.getAttribute("activityDate");
String activityDateSql = (String)request.getAttribute("activityDateSql");

List<Object[]> employeeNewTimeSheetList = (List<Object[]>)request.getAttribute("employeeNewTimeSheetList");
Map<String, List<Object[]>> timeSheetToListMap = employeeNewTimeSheetList!=null && employeeNewTimeSheetList.size()>0?employeeNewTimeSheetList.stream()
		  										  .collect(Collectors.groupingBy(array -> array[0] + "", LinkedHashMap::new, Collectors.toList())) : new HashMap<>();
List<Object[]> empAllTimeSheetList = (List<Object[]>)request.getAttribute("empAllTimeSheetList");
Gson gson = new GsonBuilder().setDateFormat("yyyy-MM-dd").create();
String jsonempAllTimeSheetList = gson.toJson(empAllTimeSheetList);

String viewFlag = (String)request.getAttribute("viewFlag");
viewFlag = viewFlag == null? "W":viewFlag;

FormatConverter fc = new FormatConverter();
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
		<!-- <div id="spinner" class="spinner">
    		<img id="img-spinner" src="view/images/spinner1.gif" alt="Loading" />
		</div> -->
	
		<!-- <div class="row" id="main" style="display: none;"> -->
		<div class="row">
			<div class="col-md-12">	
				<div class="card shadow-nohover">
					<div class="card-header">
						<div class="row">
							<div class="col-md-6">
								<h4 class="">Work Register View</h4>
							</div>
							<div class="col-md-6">
								
							</div>
						</div>
					</div>
					
					<div class="row" style="margin: 0.5rem;">
						<div class="col-12">
		         			<ul class="nav nav-pills" id="pills-tab" role="tablist" style="background-color: #E1E5E8;padding:0px;">
				  				<li class="nav-item" style="width: 50%;"  >
				    				<div class="nav-link active" style="text-align: center;" id="pills-tab-1" data-toggle="pill" data-target="#tab-1" role="tab" aria-controls="tab-1" aria-selected="true">
					   					<span>Weekly View</span> 
				    				</div>
				  				</li>
				  				<li class="nav-item"  style="width: 50%;">
				    				<div class="nav-link" style="text-align: center;" id="pills-tab-2" data-toggle="pill" data-target="#tab-2" role="tab" aria-controls="tab-2" aria-selected="false">
				    	 				<span>Monthly View</span> 
				    				</div>
				  				</li>
							</ul>
			   			</div>
					</div>
					<div class="card-body">
						<div class="tab-content" id="pills-tabContent">
       			
            				<div class="tab-pane fade show active" id="tab-1" role="tabpanel" aria-labelledby="pills-tab-1">
            					<div class="row mb-3">
									<div class="col-md-6">
									</div>
									<div class="col-md-6">
										<form action="TimeSheetView.htm" method="get">
											<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
											<input type="hidden" name="viewFlag" value="W">
											<table style="width: 100%;padding: 3px;">
												<tr>
													<td width="10%" class="right">
														<label class="form-label mt-2">Employee: </label>
													</td>
													<td width="29%">
														<select class="form-control selectdee" name="empIdW" onchange="this.form.submit()" >
															<option selected disabled>---Select---</option>
															<%if(employeeList!=null && employeeList.size()>0) {
																for(Object[] obj : employeeList) {%>
																	<option value="<%=obj[0]%>" <%if(empIdW.equalsIgnoreCase(obj[0]+"")) {%>selected<%} %> >
																		<%=(obj[1]!=null?obj[1]:(obj[2]!=null?obj[2]:""))+""+obj[5]+", "+obj[6] %>
																	</option>
															<%} }%>
														</select>
													</td>
													<td width="5%" class="right">
														<label class="form-label mt-2">Date: </label>
													</td>
													<td width="12%">
														<input type="text" class="form-control " name="activityWeekDate" id="activityWeekDate" value="<%=activityWeekDate%>" onchange="this.form.submit()">
													</td>
													<td width="10%" class="right">
														<label class="form-label mt-2">Start Date: </label>
													</td>
													<td width="12%">
														<input type="text" class="form-control " id="activityWeekStartDate" value="<%=fc.SqlToRegularDate(startOfWeek.toString()) %>" readonly>
													</td>
													<td width="10%" class="right">
														<label class="form-label mt-2">End Date: </label>
													</td>
													<td width="12%">
														<input type="text" class="form-control " id="activityWeekEndDate" value="<%=fc.SqlToRegularDate(endOfWeek.toString()) %>" readonly>
													</td>
												</tr>
											</table>
											
											<%-- <div class="row right" style="margin-top: -0.5rem;">
												<div class="col-md-1"></div>
												<div class="col-md-1">
													<label class="form-label mt-2">Date: </label>
												</div>
												<div class="col-md-2">
													<input type="text" class="form-control " name="activityWeekDate" id="activityWeekDate" value="<%=activityWeekDate%>" onchange="this.form.submit()">
												</div>
												<div class="col-md-2">
													<label class="form-label mt-2">Start Date: </label>
												</div>
												<div class="col-md-2">
													<input type="text" class="form-control " id="activityWeekStartDate" value="<%=fc.SqlToRegularDate(startOfWeek.toString()) %>" readonly>
												</div>
												<div class="col-md-2">
													<label class="form-label mt-2">End Date: </label>
												</div>
												<div class="col-md-2">
													<input type="text" class="form-control " id="activityWeekEndDate" value="<%=fc.SqlToRegularDate(endOfWeek.toString()) %>" readonly>
												</div>
											</div> --%>
											
										</form>
									</div>
								</div>
								<div class="table-wrapper table-responsive">
									<!-- <input type="text" id="searchBar" class="search-bar form-control" placeholder="Search..." style="float: right;width: auto;" />
       								<br> -->
									<table class="table activitytable" id="dataTable"> 
			                        	<thead style="">
			                            	<tr>
			                            		<th>Expand</th>
			                            		<th>SN</th>
			                            		<th>Employee</th>
												<th>Sunday <br> <span class="datecolor"><%=fc.SqlToRegularDate(startOfWeek.toString()) %></span></th>
												<th>Monday <br> <span class="datecolor"><%=fc.SqlToRegularDate(startOfWeek.plusDays(1).toString()) %></span></th>
												<th>Tuesday <br> <span class="datecolor"><%=fc.SqlToRegularDate(startOfWeek.plusDays(2).toString()) %></span></th>
												<th>Wednesday <br> <span class="datecolor"><%=fc.SqlToRegularDate(startOfWeek.plusDays(3).toString()) %></span></th>
												<th>Thursday <br> <span class="datecolor"><%=fc.SqlToRegularDate(startOfWeek.plusDays(4).toString()) %></span></th>
												<th>Friday <br> <span class="datecolor"><%=fc.SqlToRegularDate(startOfWeek.plusDays(5).toString()) %></span></th>
												<th>Saturday <br> <span class="datecolor"><%=fc.SqlToRegularDate(endOfWeek.toString()) %></span></th>
											</tr>
										</thead>
										<tbody>
											<%
											int  count=1;
											if(employeeList!=null && employeeList.size()>0) {
												
												// Filter with selected employee
												Object[] obj =  employeeList.stream().filter(e -> empIdW.equalsIgnoreCase(e[0].toString()) ).findFirst().orElse(null);
												
												//for(Object[] obj : employeeList) {
													Map<LocalDate, TimeSheet> employeeTimesheet = timeSheetData.get(obj[0].toString());
											%>
												<tr>
													<td class="center">
														<span class="clickable" data-toggle="collapse" id="row<%=count %>" data-target=".row<%=count %>"><button class="btn btn-sm btn-success" id="btn<%=count %>"  onclick="ChangeButton('<%=count %>')"><i class="fa fa-plus"  id="fa<%=count%>"></i> </button></span>
													</td>
													<td class="center"><%=count %></td>
													<td><%=(obj[1]!=null?obj[1]:(obj[2]!=null?obj[2]:""))+""+obj[5]+", "+obj[6] %></td>
													<%for (LocalDate date = startOfWeek; !date.isAfter(endOfWeek); date = date.plusDays(1)) { 
														TimeSheet timeSheet = employeeTimesheet.get(date);
													%>
														<td class="center">
															<%if(timeSheet!=null) {
															%>
																<div class="row">
																	<div class="col-md-4 right">
																		<%if(timeSheet!=null && timeSheet.getTimeSheetStatus().equalsIgnoreCase("ABS")){%>
																			<span style="margin-left: 100%;">
																				<i class="fa fa-check" aria-hidden="true" style="color: green;font-size: 20px;"></i>
																			</span>
																		<%} %>
																	</div>
																	<div class="col-md-7 left ml-2">
																		<span style="color: green">Submitted</span>
																	</div>
																</div>
															<%} else{%>
																<div class="row">
																	<div class="col-md-4 right">
																		<span style="margin-left: 100%;">
																			<i class="fa fa-times" aria-hidden="true" style="color: red;font-size: 20px;"></i>
																		</span>
																	</div>
																	<div class="col-md-7 left ml-2">
																		<span style="color: red">Not Submitted</span>
																	</div>
																</div>
															<%} %>
														</td>
													<%} %>
												</tr>
												
												<!-- Sub-Level for Time Sheet Activity -->
												<%-- <tr class="collapse row<%=count %>"  id="rowcollapse<%=count%>" style="font-weight: bold;">
													<td></td>
													<td colspan="8">Details</td>
												</tr> --%>
												<tr class="collapse row<%=count %>" id="rowcollapse<%=count%>" >
													<td></td>
													<td colspan="10">
														
														<table id="activityviewtable" style="width:100%;" >
															<thead class="center">
																<tr>
																	<th width="3%">SN</th>
																	<th width="8%">Activity Type</th>
																	<th width="10%">Activity Type</th>
																	<th width="10%">Project</th>
																	<th width="20%">Assigner</th>
																	<th width="10%">Keywords</th>
																	<th width="30%">Work Done</th>
																	<th width="10%">Work Done on </th>
																</tr>
															</thead>
															<tbody>
																<%
																int activitycount=0;
																for (LocalDate date = startOfWeek; !date.isAfter(endOfWeek); date = date.plusDays(1)) { 
																	TimeSheet timeSheet = employeeTimesheet.get(date);
																	List<TimeSheetActivity> timeSheetActivityList = timeSheet!=null?timeSheet.getTimeSheetActivity():new ArrayList<TimeSheetActivity>();
																%>
																<%if(timeSheetActivityList!=null && timeSheetActivityList.size()>0 ) { ++activitycount;%>
																	<tr>
																		<td colspan="8">
																			<span style="font-weight: bold;font-size: 16px;color: <%if(timeSheet.getTimeSheetStatus().equalsIgnoreCase("ABS")) {%>green<%}else if(timeSheet.getTimeSheetStatus().equalsIgnoreCase("RBS")){%>red<%}%> ">
																			<%=fc.SqlToRegularDate(date.toString()) %>
																			</span>
																		</td>
																	</tr>
																<%} %>
																<%if(timeSheetActivityList!=null && timeSheetActivityList.size()>0) {
																	int slno = 0;
																	for(TimeSheetActivity act : timeSheetActivityList) {
																		Employee emp = allEmpList!=null && allEmpList.size()>0?allEmpList.stream()
																						.filter(e -> e.getEmpId().equals(act.getAssignedBy())).findFirst().orElse(null): null;
																		Object[] desig = designationlist!=null && designationlist.size()>0 ?designationlist.stream()
																				 		 .filter(e -> (emp!=null? emp.getDesigId():0L) == Long.parseLong(e[0].toString()) ).findFirst().orElse(null):null;
																%>
																		<tr>
																			<td class="center"><%=++slno %></td>
																			<td class="center"><%=act.getActivitySeqNo() %></td>
																			<td>
																				<%
																					String activityName = milestoneActivityTypeList.stream().filter(e -> act.getActivityTypeId().equals(e.getActivityTypeId())).map(MilestoneActivityType::getActivityType).findFirst().orElse(null);
																					out.println(activityName);
																				%>
																			</td>
																			<td class="center">
																				<%
																					String project = projectList!=null?projectList.stream()
																				            .filter(e -> Long.parseLong(e[0].toString()) == act.getProjectId())
																				            .map(e ->  e[4]+" ("+e[17]+")")
																				            .findFirst().orElse("General"): "-";
																					out.println(project);
																				%>
																			</td>
																			<td>
																				<%=emp!=null?((emp.getTitle()!=null?emp.getTitle():(emp.getSalutation()!=null?emp.getSalutation():"")) + " " + (emp.getEmpName()) + ", " + (desig!=null && desig[2]!=null?desig[2]:"")):"Not Available"%>
																			</td>
																			<td class="center">
																				<%
																					String keyword = keywordsList!=null?keywordsList.stream()
																				            .filter(e -> e.getKeywordId().equals(act.getKeywordId()))
																				            .map(e ->  e.getKeyword())
																				            .findFirst().orElse("-"): "-";
																					out.println(keyword);
																				%>
																			</td>
																			<td>
																				<%if(act.getWorkDone()!=null && !act.getWorkDone().isEmpty()) {%><%=act.getWorkDone()%><%} else{%>-<%} %>
																			</td>
																			<td class="center">
																				<%=act.getWorkDoneon()!=null?(act.getWorkDoneon().equalsIgnoreCase("A")?"AN":(act.getWorkDoneon().equalsIgnoreCase("F")?"FN":"Full day")):"-" %>
																			</td>
																		</tr>
																	<%} %>
																<%} %>	
																
																<%} %>
																<%if(activitycount==0) {%>
																	<tr>
																		<td class="center" colspan="8">No Data Available</td> 
																	</tr>
																<%} %>
															</tbody>
														</table>
														
													</td>
												</tr>
											<%count++; } else{%>
												<tr>
													<td class="center" colspan="10">No Data Available</td>
												</tr>
											<%} %>
										</tbody>
									</table>
								</div>
							</div>
							<div class="tab-pane fade" id="tab-2" role="tabpanel" aria-labelledby="pills-tab-2">
								<div class="calendar-container">
								    <div class="year-container">
								        <button class="nav-btn" id="prev-year">
								            <i class="fa fa-chevron-left"></i>
								        </button>
								        <span id="current-year"></span>
								        <button class="nav-btn" id="next-year">
								            <i class="fa fa-chevron-right"></i>
								        </button>
								    </div>
								    <button class="nav-btn" id="prev-month">
								        <i class="fa fa-chevron-left"></i>
								    </button>
									<div id="current-month" class="month-display"></div>
									<div id="days-container" class="days-container"></div>
								    <button class="nav-btn" id="next-month">
								        <i class="fa fa-chevron-right"></i>
								    </button>
								</div>
								
								<div class="form-group">
				  					<div class="row mb-3 mt-2">
										<div class="col-md-6">
											<%Object[] emp = employeeList!=null && employeeList.size()>0?employeeList.stream()
															.filter(e -> empId.equalsIgnoreCase(e[0]+"")).findFirst().orElse(null):null; %>
											<b class="ml-2">Report</b> of <b><%=emp!=null?((emp[1]!=null?emp[1]:(emp[2]!=null?emp[2]:""))+""+emp[5]+", "+emp[6]):"-" %></b>
											<%-- from <b><%=fc.sdfTordf(fromDate) %></b> to <b><%=fc.sdfTordf(toDate) %></b> --%>
										</div>
										<div class="col-md-6">
											<form action="TimeSheetView.htm" method="get">
												<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
												<input type="hidden" name="viewFlag" value="M">
												<div class="row right" style="margin-top: -0.5rem;">
													<div class="col-md-3"></div>
													<div class="col-md-2">
														<label class="form-label mt-2">Employee: </label>
													</div>
													<div class="col-md-5 right">
														<select class="form-control selectdee" name="empId" onchange="this.form.submit()" >
															<option selected disabled>---Select---</option>
															<%if(employeeList!=null && employeeList.size()>0) {
																for(Object[] obj : employeeList) {%>
																	<option value="<%=obj[0]%>" <%if(empId.equalsIgnoreCase(obj[0]+"")) {%>selected<%} %> >
																		<%=(obj[1]!=null?obj[1]:(obj[2]!=null?obj[2]:""))+""+obj[5]+", "+obj[6] %>
																	</option>
															<%} }%>
														</select>
													</div>
													<div class="col-md-2 left">
														<button type="button" class="btn btn-sm" formnovalidate="formnovalidate" onclick="downloadMonthlyReport()" data-toggle="tooltip" data-placement="top" title="PDF Report" style="background-color: #fff">
															<i style="color: #cc0000;font-size: 24px;" class="fa fa-file-pdf-o" aria-hidden="true"></i>
													  	</button>
													  	<button type="submit" class="btn btn-sm" name="Action" value="GenerateExcel" formaction="WorkRegisterMonthlyViewExcel.htm" formtarget="blank" data-toggle="tooltip" data-placement="top" title="Excel Report" style="background-color: #fff">
															<i style="color: #009900;font-size: 24px;" class="fa fa-file-excel-o" aria-hidden="true"></i>
													  	</button>
													</div>
													<input type="hidden" name="activityDate" id ="activityDate" value="<%=activityDate%>">
													<input type="hidden" name="empName" value="<%=emp!=null?((emp[1]!=null?emp[1]:(emp[2]!=null?emp[2]:""))+""+emp[5]+", "+emp[6]):"-" %>">
													<%-- <div class="col-md-1">
														<label class="form-label mt-2">From: </label>
													</div>
													<div class="col-md-2">
														<input type="text" class="form-control " name="fromDate" id="fromDate" value="<%=fc.sdfTordf(fromDate) %>" onchange="this.form.submit()" >
													</div>
													<div class="col-md-1">
														<label class="form-label mt-2">To: </label>
													</div>
													<div class="col-md-2">
														<input type="text" class="form-control " name="toDate" id="toDate" value="<%=fc.sdfTordf(toDate)%>" onchange="this.form.submit()">
													</div> --%>
												</div>
											</form>
										</div>
									</div>
								</div>	
								<div class="table-wrapper table-responsive">
									<!-- <input type="text" id="searchBar2" class="search-bar form-control" placeholder="Search..." style="float: right;width: auto;" />
       								<br> -->
									<table class="table activitytable" id="dataTable2"> 
			                        	<thead style="">
			                        		<tr>
												<th width="5%">SN</th>
												<th width="7%">Date</th>
												<th width="7%">Activity No</th>
												<th width="10%">Activity Type</th>
												<th width="10%">Project</th>
												<th width="15%">Assigner</th>
												<th width="10%">Keywords</th>
												<th width="21%">Work Done</th>
												<th width="10%">Work Done on</th>
											</tr>
										</thead>
										<tbody>	
											<% if (timeSheetToListMap!=null && timeSheetToListMap.size() > 0) {
												int slno = 0;String key="";
												for (Map.Entry<String, List<Object[]>> map : timeSheetToListMap.entrySet()) {
			                  							
			                  							List<Object[]> values = map.getValue();
			                  							int i=0;
			                  							for (Object[] obj : values) {
											%>
												<tr>
													<%if(i==0) {%>
														<td rowspan="<%=values.size() %>" style="vertical-align: middle;" class="center"><%=++slno%></td>
											    		<td rowspan="<%=values.size() %>" style="vertical-align: middle;" class="center"><%=fc.sdfTordf(obj[2].toString()) %></td>
			         								<%} %>
			         								<td class="center"><%=obj[16]!=null?obj[16]:"-" %></td>
			    									<td ><%=obj[5]!=null?obj[5]:"-" %></td>
			    									<td class="center"><%=obj[8]!=null?obj[8]:"-" %></td>
			    									<td><%=obj[10]!=null?obj[10]+", "+(obj[11]!=null?obj[11]:"-"):"Not Available" %></td>
			    									<td class="center"><%=obj[13]!=null?obj[13].toString():"-" %></td>
			    									<td><%=obj[14]!=null?obj[14]:"-" %></td>
			    									<td class="center"><%=obj[15]!=null?(obj[15].toString().equalsIgnoreCase("A")?"AN":(obj[15].toString().equalsIgnoreCase("F")?"FN":"Full day")):"-" %></td>
												</tr>
											<% ++i; } } } else{%>
												<tr>
													<td colspan="9" style="text-align: center;">No Data Available</td>
												</tr>
											<%} %>
										</tbody>
									</table>
								</div>		
			  				</div>	
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>	
	<form action="TimeSheetView.htm" method="post" id="calenderdateform">
		<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
		<input type="hidden" class="activityDate" name="activityDate" id="activityDate">
		<input type="hidden" name="viewFlag" value="M">
	</form>
<script type="text/javascript">

//Show spinner when the DOM starts loading
/* $(document).ready(function () {
    $('#spinner').show(); // Display spinner
    $('#main').hide();    // Hide content
    $('body').css("filter", "blur(2px)"); // Optional: Add blur effect to the body
});

// Hide spinner when the page is fully loaded
window.onload = function () {
    $('#spinner').hide(); // Hide spinner
    $('#main').fadeIn();  // Show content with fade-in effect
    $('body').css("filter", "none"); // Remove blur effect
};  */

/* $(document).ready(function () {
    $('#searchBar').on('keyup', function () {
        const searchTerm = $(this).val().toLowerCase();
        $('#dataTable tbody tr').filter(function () {
            $(this).toggle($(this).text().toLowerCase().indexOf(searchTerm) > -1);
        });
    });
    $('#searchBar2').on('keyup', function () {
        const searchTerm = $(this).val().toLowerCase();
        $('#dataTable2 tbody tr').filter(function () {
            $(this).toggle($(this).text().toLowerCase().indexOf(searchTerm) > -1);
        });
    });
}); */

ChangeButton('1');
		
function ChangeButton(id) {
	  
	//console.log($( "#btn"+id ).hasClass( "btn btn-sm btn-success" ).toString());
	if($( "#btn"+id ).hasClass( "btn btn-sm btn-success" ).toString()=='true'){
	$( "#btn"+id ).removeClass( "btn btn-sm btn-success" ).addClass( "btn btn-sm btn-danger" );
	$( "#fa"+id ).removeClass( "fa fa-plus" ).addClass( "fa fa-minus" );
	$( ".row"+id).show();
    }else{
	$( "#btn"+id ).removeClass( "btn btn-sm btn-danger" ).addClass( "btn btn-sm btn-success" );
	$( "#fa"+id ).removeClass( "fa fa-minus" ).addClass( "fa fa-plus" );
	$( ".row"+id).hide();
    }
}

/* function approvalcheck(action, formId){

	var fields = $("input[form='"+formId+"'][name='timeSheetId']").serializeArray();

	if(fields.length === 0) {
		alert('Please select atleast one activity');

		event.preventDefault();
		return false;
	}
	
	if(action=='A'){
		return confirm('Are You Sure To Approve?');
	}else if(action=='R') {
		var remarksarea = $("input[form='"+formId+"'][name='remarks']").val();
		if (remarksarea!= "") {
	    	return confirm('Are You Sure To Return?');
	    	
	    } else {
	        alert("Please enter Remarks to Return");
	        return false;
	    }
	}
	return true;
	
	
} */
</script>
<script type="text/javascript">
$('#activityWeekDate').daterangepicker({
    singleDatePicker: true,
    linkedCalendars: false,
    showCustomRangeLabel: true,
    cancelClass: "btn-default",
    showDropdowns: true,
    locale: {
        format: 'DD-MM-YYYY'
    }
});

function highlightWeek(dateElement) {
    // Remove existing highlights
    $('.highlight-week').removeClass('highlight-week');

    // Get the date for the hovered cell
    var hoveredDate = $(dateElement).data('title');
    var day = parseInt(hoveredDate.split('c')[1]);

    // Highlight the entire week
    var $weekRow = $(dateElement).closest('tr');
    $weekRow.children().each(function() {
        $(this).addClass('highlight-week');
    });
}

// Add hover event to highlight the week for activityWeekDate only
$(document).on('mouseenter', '.daterangepicker td.available', function() {
    highlightWeek(this);
});

$(document).on('mouseleave', '.daterangepicker td.available', function() {
    // Remove highlights when mouse leaves the cell for activityWeekDate only
    $('.highlight-week').removeClass('highlight-week');
});

// Initialize other datepickers without affecting the week highlighting
<%-- $('#fromDate').daterangepicker({
    "singleDatePicker": true,
    "linkedCalendars": false,
    "showCustomRangeLabel": true,
    "startDate": new Date('<%=fromDate%>'),
    "maxDate": new Date('<%=toDate%>'),
    "cancelClass": "btn-default",
    showDropdowns: true,
    locale: {
        format: 'DD-MM-YYYY'
    }
});
$('#fromDate').on('change', function(){
	$('#toDate').daterangepicker({
	    "singleDatePicker": true,
	    "linkedCalendars": false,
	    "showCustomRangeLabel": true,
	    "startDate": new Date('<%=toDate%>'),
	    "minDate": $("#fromDate").val(),
	    "maxDate": new Date('<%=toDate%>'),
	    "cancelClass": "btn-default",
	    showDropdowns: true,
	    locale: {
	        format: 'DD-MM-YYYY'
	    }
	});
});
$('#toDate').daterangepicker({
    "singleDatePicker": true,
    "linkedCalendars": false,
    "showCustomRangeLabel": true,
    "startDate": new Date('<%=toDate%>'),
    "minDate": $("#fromDate").val(),
    "maxDate": new Date('<%=toDate%>'),
    "cancelClass": "btn-default",
    showDropdowns: true,
    locale: {
        format: 'DD-MM-YYYY'
    }
}); --%>

<% if(viewFlag!=null && viewFlag.equalsIgnoreCase("M")){%>
	$('#pills-tab-2').click();
<%}%>

function downloadMonthlyReport() {
	var docDefinition = {
			pageOrientation: 'landscape',
            content: [
                
                
                /* ************************************** Time Sheet Monthly Report List *********************************** */ 
                {
                    text: 'Work Register Monthly Report',
                    style: 'chapterHeader',
                    tocItem: false,
                    id: 'chapter1',
                    alignment: 'center',
                },
                
                {
                    table: {
                        headerRows: 1,
                        widths: ['10%', '45%', '25%', '10%', '10%'],
                        
                        body: [
                            // Table header
                            [
                                { text: 'Employee: ',bold: true,  },
                                { text: '<%=emp!=null?((emp[1]!=null?emp[1]:(emp[2]!=null?emp[2]:""))+""+emp[5]+", "+emp[6]):"-" %>',  },
                                { text: '', },
                                
                                { text: 'Month:',bold: true, }, 
                                { text: '<%=localdate.getMonth()%>', }, 
                                
                            ],
                            
                        ]
                    },
                    layout: {
                        /* fillColor: function(rowIndex) {
                            return (rowIndex % 2 === 0) ? '#f0f0f0' : null;
                        }, */
                        hLineWidth: function(i, node) {
                            return 0;
                        },
                        vLineWidth: function(i) {
                            return 0;
                        },
                        hLineColor: function(i) {
                            return '#aaaaaa';
                        },
                        vLineColor: function(i) {
                            return '#aaaaaa';
                        }
                    }
                },
                
                {text: '\n'},
                
                {
                    table: {
                        headerRows: 1,
                        widths: ['6%', '10%', '8%', '10%', '10%', '15%', '10%', '21%', '10%'],
                        body: [
                            // Table header
                            [
                                { text: 'SN', style: 'tableHeader' },
                                { text: 'Date', style: 'tableHeader' },
                                { text: 'Activity No', style: 'tableHeader' },
                                { text: 'Activity Type', style: 'tableHeader' }, 
                                { text: 'Project', style: 'tableHeader' }, 
                                { text: 'Assigner', style: 'tableHeader' }, 
                                { text: 'Keywords', style: 'tableHeader' }, 
                                { text: 'Work Done', style: 'tableHeader' }, 
                                { text: 'Work Done on', style: 'tableHeader' }, 
                            ],
                            // Populate table rows
                            <%if (timeSheetToListMap!=null && timeSheetToListMap.size() > 0) {
								int slno = 0;String key="";
								for (Map.Entry<String, List<Object[]>> map : timeSheetToListMap.entrySet()) {
              							
              							List<Object[]> values = map.getValue();
              							int i=0;
              							for (Object[] obj : values) {
              				%>
	                            [
	                            	<%if(i == 0) { %>
		                                { text: '<%= ++slno %>', style: 'tableData',alignment: 'center', rowSpan: <%=values.size() %>,  },
		                                { text: '<%=obj[2]!=null?fc.sdfTordf(obj[2].toString()):"-"%>', style: 'tableData',alignment: 'center', rowSpan: <%=values.size() %>,},
	                                <%} else { %>
									  {},
									  {},
									<%} %>
	                                { text: '<%=obj[16]!=null?obj[16]:"-" %>', style: 'tableData',alignment: 'center' },
	                                { text: '<%=obj[5]!=null?obj[5]:"-" %>', style: 'tableData',alignment: 'center' },
	                                { text: '<%=obj[8]!=null?obj[8]:"-" %>', style: 'tableData',alignment: 'center' },
	                                { text: '<%=obj[10]!=null?obj[10]+", "+(obj[11]!=null?obj[11]:"-"):"Not Available" %>', style: 'tableData' },
	                                { text: '<%=obj[13]!=null?obj[13]:"-" %>', style: 'tableData',alignment: 'center' },
	                                { text: '<%=obj[14]!=null?obj[14]:"-" %>', style: 'tableData',alignment: 'left' },
	                                { text: '<%=obj[15]!=null?(obj[15].toString().equalsIgnoreCase("A")?"AN":(obj[15].toString().equalsIgnoreCase("F")?"FN":"Full day")):"-" %>', style: 'tableData',alignment: 'center' },
	                            ],
	                        <% ++i; } } } else{%>
                            	[{ text: 'No Data Available', style: 'tableData',alignment: 'center', colSpan: 9 },]
                            <%} %>
                        ]
                    },
                    layout: {
                        /* fillColor: function(rowIndex) {
                            return (rowIndex % 2 === 0) ? '#f0f0f0' : null;
                        }, */
                        hLineWidth: function(i, node) {
                            return (i === 0 || i === node.table.body.length) ? 1 : 0.5;
                        },
                        vLineWidth: function(i) {
                            return 0.5;
                        },
                        hLineColor: function(i) {
                            return '#aaaaaa';
                        },
                        vLineColor: function(i) {
                            return '#aaaaaa';
                        }
                    }
                },
                /* ************************************** Time Sheet Monthly Report List End*********************************** */

                
			],
			styles: {
				chapterHeader: { fontSize: 16, bold: true, margin: [0, 0, 0, 10] },
                tableHeader: { fontSize: 12, bold: true, fillColor: '#f0f0f0', alignment: 'center', margin: [10, 5, 10, 5], fontWeight: 'bold' },
                tableData: { fontSize: 11.5, margin: [0, 5, 0, 5] },
            },
            footer: function(currentPage, pageCount) {
                /* if (currentPage > 2) { */
                    return {
                        stack: [
                        	{
                                canvas: [{ type: 'line', x1: 30, y1: 0, x2: 820, y2: 0, lineWidth: 1 }]
                            },
                            {
                                columns: [
                                    { text: '', alignment: 'left', margin: [30, 0, 0, 0], fontSize: 8 },
                                    { text: currentPage.toString() + ' of ' + pageCount, alignment: 'right', margin: [0, 0, 30, 0], fontSize: 8 }
                                ]
                            },
                            { text: '', alignment: 'center', fontSize: 8, margin: [0, 5, 0, 0], bold: true }
                        ]
                    };
                /* }
                return ''; */
            },
            /* header: function (currentPage) {
                return {
                    stack: [
                        
                        {
                            columns: [
                                {
                                    // Center: Text
                                    text: 'Restricted',
                                    alignment: 'center',
                                    fontSize: 10,
                                    bold: true,
                                    margin: [0, 10, 0, 0]
                                },
                            ]
                        },
                        
                    ]
                };
            }, */
			pageMargins: [30, 40, 20, 20],
            
            defaultStyle: { fontSize: 12, color: 'black', }
        };
		
        pdfMake.createPdf(docDefinition).open();
}
</script>

<script type="text/javascript">
	
	var empAllTimeSheetList = JSON.parse('<%= jsonempAllTimeSheetList %>');
	
	var activityDateSql = '<%=activityDateSql%>';
	
	document.addEventListener("DOMContentLoaded", function () {
	    var yearEl = document.getElementById("current-year");
	    var monthEl = document.getElementById("current-month");
	    var daysContainer = document.getElementById("days-container");

	    var currentYear = new Date().getFullYear();
	    var currentMonth = new Date().getMonth();

	    var months = ["Jan", "Feb", "Mar", "Apr", "May", "Jun", 
	                  "Jul", "Aug", "Sep", "Oct", "Nov", "Dec"];
	    var daysOfWeek = ["Sun", "Mon", "Tue", "Wed", "Thu", "Fri", "Sat"];

	    // Extract dates from empAllTimeSheetList
	    var empDates = empAllTimeSheetList.map(function (entry) {
	        return new Date(entry[3]); // Assuming the date is in SQL format at index 3
	    });

	    // Parse activityDateSql into a Date object
	    var defaultSelectedDate = new Date(activityDateSql);

	    function renderDays() {
	        daysContainer.innerHTML = "";
	        var daysInMonth = new Date(currentYear, currentMonth + 1, 0).getDate();
	        for (var i = 1; i <= daysInMonth; i++) {
	            var date = new Date(currentYear, currentMonth, i);
	            var dayEl = document.createElement("div");
	            dayEl.className = "day";

	            // Highlight the day if it's in empDates
	            var isHighlighted = empDates.some(function (empDate) {
	                return (
	                    empDate.getFullYear() === date.getFullYear() &&
	                    empDate.getMonth() === date.getMonth() &&
	                    empDate.getDate() === date.getDate()
	                );
	            });
	            if (isHighlighted) {
	                dayEl.classList.add("active");
	            }

	            // Highlight the defaultSelectedDate
	            if (
	                date.getFullYear() === defaultSelectedDate.getFullYear() &&
	                date.getMonth() === defaultSelectedDate.getMonth() &&
	                date.getDate() === defaultSelectedDate.getDate()
	            ) {
	                dayEl.classList.add("highlighted-date");
	                lastActiveDay = dayEl; // Set as the last active day
	            }

	            var dayName = document.createElement("span");
	            dayName.className = "day-name";
	            dayName.textContent = daysOfWeek[date.getDay()];
	            var dayNumber = document.createElement("span");
	            dayNumber.className = "day-number";
	            dayNumber.textContent = i;
	            dayEl.appendChild(dayName);
	            dayEl.appendChild(dayNumber);
	            dayEl.addEventListener("click", handleDayClick); // Assign the event listener
	            daysContainer.appendChild(dayEl);
	        }
	    }

	    var lastActiveDay = null; // Variable to keep track of the last active day

	    function handleDayClick() {
	        // Get the clicked day details
	        var dayNumber = this.querySelector(".day-number").textContent;
	        var currentMonth = document.getElementById("current-month").textContent;
	        var currentYear = document.getElementById("current-year").textContent;

	        var months = ["Jan", "Feb", "Mar", "Apr", "May", "Jun", "Jul", "Aug", "Sep", "Oct", "Nov", "Dec"];
	        var monthIndex = months.indexOf(currentMonth) + 1;
	        var formattedMonth = monthIndex < 10 ? "0" + monthIndex : monthIndex;
	        var formattedDate = (dayNumber.length === 1 ? "0" + dayNumber : dayNumber) + "-" + formattedMonth + "-" + currentYear;
	        $('.activityDate').val(formattedDate);
	        
	        // Create the selected date object
	        var selectedDate = new Date(currentYear, monthIndex - 1, dayNumber);
	        var today = new Date();
	        var restrictionDate = new Date(2024, 11, 1); // Corrected: December 01, 2024 (monthIndex 11 for December)

	        // Min date: 10 days before today
	        var minDate = new Date(today);
	        minDate.setDate(minDate.getDate() - 10);

	        // Check if the date exists in empAllTimeSheetList
	        var isDateExisting = empAllTimeSheetList.some(function (row) {
	            return row[3] === formattedDate.split("-").reverse().join("-");
	        });

	     	// If the date is valid, update the active day
	        // Remove the 'active' class from all days
	       	/* var activeDays = document.querySelectorAll(".day.active");
	        activeDays.forEach(function (activeDay) {
	            activeDay.classList.remove("active");
	        });
	        
	        // Add 'active' class to the clicked day
	        this.classList.add("highlighted-date"); */

	        // Update the last active day reference
	        /* lastActiveDay = this;  */
	        
	        // Validation checks
	        if (isDateExisting) {
	            $('#calenderdateform').submit();
	        } else if (selectedDate < restrictionDate) {
	            alert("Please select a date on or after 01-12-2024.");
	            restoreLastActiveDay();
	            return; // Stop further processing
	        }else if (selectedDate > today) {
	            alert("Future date selection is not allowed.");
	            restoreLastActiveDay();
	            return; // Stop further processing
	        }else{
	        	$('#calenderdateform').submit();
	        }

	    }

	    function restoreLastActiveDay() {
	        if (lastActiveDay) {
	            lastActiveDay.classList.add("highlighted-date");
	        }
	    }

	    function updateCalendar() {
	        yearEl.textContent = currentYear;
	        monthEl.textContent = months[currentMonth];
	        renderDays();
	    }

	    // Navigation buttons
	    document.getElementById("prev-year").addEventListener("click", function () {
	        currentYear--;
	        updateCalendar();
	    });

	    document.getElementById("next-year").addEventListener("click", function () {
	        currentYear++;
	        updateCalendar();
	    });

	    document.getElementById("prev-month").addEventListener("click", function () {
	        currentMonth = (currentMonth - 1 + 12) % 12;
	        if (currentMonth === 11) currentYear--;
	        updateCalendar();
	    });

	    document.getElementById("next-month").addEventListener("click", function () {
	        currentMonth = (currentMonth + 1) % 12;
	        if (currentMonth === 0) currentYear++;
	        updateCalendar();
	    });

	    // Initialize the calendar
	    currentYear = defaultSelectedDate.getFullYear();
	    currentMonth = defaultSelectedDate.getMonth();
	    updateCalendar();
	});

</script>
</body>
</html>