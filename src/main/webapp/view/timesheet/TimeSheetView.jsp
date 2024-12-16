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
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<jsp:include page="../static/header.jsp"></jsp:include>
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
String fromDate = (String)request.getAttribute("fromDate");
String toDate = (String)request.getAttribute("toDate");

List<Object[]> employeeNewTimeSheetList = (List<Object[]>)request.getAttribute("employeeNewTimeSheetList");
Map<String, List<Object[]>> timeSheetToListMap = employeeNewTimeSheetList!=null && employeeNewTimeSheetList.size()>0?employeeNewTimeSheetList.stream()
		  										  .collect(Collectors.groupingBy(array -> array[0] + "", LinkedHashMap::new, Collectors.toList())) : new HashMap<>();
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
											<div class="row right" style="margin-top: -0.5rem;">
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
											</div>
										</form>
									</div>
								</div>
								<div class="table-wrapper table-responsive">
									<table class="table activitytable"> 
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
												for(Object[] obj : employeeList) {
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
																	<th width="5%">SN</th>
																	<th width="15%">Activity Type</th>
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
																		<td colspan="7">
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
																		<td class="center" colspan="7">No Data Available</td> 
																	</tr>
																<%} %>
															</tbody>
														</table>
														
													</td>
												</tr>
											<%count++;} } else{%>
												<tr>
													<td class="center" colspan="10">No Data Available</td>
												</tr>
											<%} %>
										</tbody>
									</table>
								</div>
							</div>
							<div class="tab-pane fade" id="tab-2" role="tabpanel" aria-labelledby="pills-tab-2">
			  					<div class="row mb-3">
									<div class="col-md-6">
										<%Object[] emp = employeeList!=null && employeeList.size()>0?employeeList.stream()
														.filter(e -> empId.equalsIgnoreCase(e[0]+"")).findFirst().orElse(null):null; %>
										<b class="ml-2">Report</b> of <b><%=emp!=null?((emp[1]!=null?emp[1]:(emp[2]!=null?emp[2]:""))+""+emp[5]+", "+emp[6]):"-" %></b>
										from <b><%=fc.sdfTordf(fromDate) %></b> to <b><%=fc.sdfTordf(toDate) %></b>
									</div>
									<div class="col-md-6">
										<form action="TimeSheetView.htm" method="get">
											<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
											<input type="hidden" name="viewFlag" value="M">
											<div class="row right" style="margin-top: -0.5rem;">
												<div class="col-md-1">
													<label class="form-label mt-2">Employee: </label>
												</div>
												<div class="col-md-5">
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
												<div class="col-md-1">
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
												</div>
											</div>
										</form>
									</div>
								</div>
								<div class="table-wrapper table-responsive">
									<table class="table activitytable"> 
			                        	<thead style="">
			                        		<tr>
												<th width="5%">SN</th>
												<th width="7%">Date</th>
												<th width="10%">Activity Type</th>
												<th width="10%">Project</th>
												<th width="15%">Assigner</th>
												<th width="10%">Keywords</th>
												<th width="28%">Work Done</th>
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
													<td class="center"><%=++slno%></td>
													<%if(i==0) {%>
											    		<td rowspan="<%=values.size() %>" style="vertical-align: middle;" class="center"><%=fc.sdfTordf(obj[2].toString()) %></td>
			         								<%} %>
			    									<td ><%=obj[5]!=null?obj[5]:"-" %></td>
			    									<td class="center"><%=obj[8]!=null?obj[8]:"-" %></td>
			    									<td><%=obj[10]!=null?obj[10]+", "+(obj[11]!=null?obj[11]:"-"):"Not Available" %></td>
			    									<td class="center"><%=obj[13]!=null?obj[13].toString():"-" %></td>
			    									<td><%=obj[14]!=null?obj[14]:"-" %></td>
			    									<td class="center"><%=obj[15]!=null?(obj[15].toString().equalsIgnoreCase("A")?"AN":(obj[15].toString().equalsIgnoreCase("F")?"FN":"Full day")):"-" %></td>
												</tr>
											<% ++i; } } } else{%>
												<tr>
													<td colspan="8" style="text-align: center;">No Data Available</td>
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

<script type="text/javascript">
$("#myTable").DataTable({
	 "lengthMenu": [  5,10,25, 50, 75, 100 ],
	 "pagingType": "simple"
	
});

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

function approvalcheck(action, formId){

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
	
	
}
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
$('#fromDate').daterangepicker({
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
});

<% if(viewFlag!=null && viewFlag.equalsIgnoreCase("M")){%>
	$('#pills-tab-2').click();
<%}%>
</script>


</body>
</html>