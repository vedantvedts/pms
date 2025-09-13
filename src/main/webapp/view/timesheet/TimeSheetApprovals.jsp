<%@page import="org.apache.commons.text.StringEscapeUtils"%>
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
<spring:url value="/resources/css/Timesheet/TimeSheetApprovals.css" var="holidayAddEdit" />     
<link href="${holidayAddEdit}" rel="stylesheet" />

</head>
<body>

<%
List<Object[]> employeeList = (List<Object[]>)request.getAttribute("employeesofSuperiorOfficer");
Map<String, Map<LocalDate, TimeSheet>> timeSheetData = (Map<String, Map<LocalDate, TimeSheet>>)request.getAttribute("timesheetDataForSuperior");

List<Object[]> empActivityAssignList = (List<Object[]>)request.getAttribute("empActivityAssignList");
List<MilestoneActivityType> milestoneActivityTypeList = (List<MilestoneActivityType>)request.getAttribute("milestoneActivityTypeList");
List<Object[]> projectList = (List<Object[]>)request.getAttribute("projectList");

String activityWeekDate = (String)request.getAttribute("activityWeekDate");
String activityWeekDateSql = (String)request.getAttribute("activityWeekDateSql");

LocalDate localdate = LocalDate.parse(activityWeekDateSql);
// Get the start of the week (Sunday)
LocalDate startOfWeek = localdate.with(TemporalAdjusters.previousOrSame(DayOfWeek.SUNDAY));

// Get the end of the week (Saturday)
LocalDate endOfWeek = localdate.with(TemporalAdjusters.nextOrSame(DayOfWeek.SATURDAY));

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
			<div class="col-md-12">	
				<div class="card shadow-nohover">
					<div class="card-header">
						<div class="row">
							<div class="col-md-6">
								<h4 class="">Time Sheet Approvals</h4>
							</div>
							<div class="col-md-6">
								<form action="TimeSheetApprovals.htm" method="get">
									<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
									<div class="row right style1">
										<div class="col-md-1"></div>
										<div class="col-md-1">
											<label class="form-label mt-2">Date: </label>
										</div>
										<div class="col-md-2">
											<input type="text" class="form-control " name="activityWeekDate" id="activityWeekDate" value="<%=activityWeekDate!=null?StringEscapeUtils.escapeHtml4(activityWeekDate):"-"%>" onchange="this.form.submit()">
										</div>
										<div class="col-md-2">
											<label class="form-label mt-2">Start Date: </label>
										</div>
										<div class="col-md-2">
											<input type="text" class="form-control " id="activityWeekStartDate" value="<%=startOfWeek!=null?fc.SqlToRegularDate(startOfWeek.toString()):"-" %>" readonly>
										</div>
										<div class="col-md-2">
											<label class="form-label mt-2">End Date: </label>
										</div>
										<div class="col-md-2">
											<input type="text" class="form-control " id="activityWeekEndDate" value="<%=endOfWeek!=null?fc.SqlToRegularDate(endOfWeek.toString()):"-" %>" readonly>
										</div>
									</div>
								</form>
							</div>
						</div>
					</div>
					<div class="card">
						<div class="card-body">
							<div class="table-responsive">
								<table class="table" id="activitytable"> 
		                        	<thead>
		                            	<tr>
		                            		<th>Expand</th>
		                            		<th>Employee</th>
											<th>Sunday <br> <span class="datecolor"><%=startOfWeek!=null?fc.SqlToRegularDate(StringEscapeUtils.escapeHtml4(startOfWeek.toString())) :"-"%></span></th>
											<th>Monday <br> <span class="datecolor"><%=startOfWeek!=null?fc.SqlToRegularDate(startOfWeek.plusDays(1).toString()) :"-"%></span></th>
											<th>Tuesday <br> <span class="datecolor"><%=startOfWeek!=null?fc.SqlToRegularDate(startOfWeek.plusDays(2).toString()):"-" %></span></th>
											<th>Wednesday <br> <span class="datecolor"><%=startOfWeek!=null?fc.SqlToRegularDate(startOfWeek.plusDays(3).toString()):"-" %></span></th>
											<th>Thursday <br> <span class="datecolor"><%=startOfWeek!=null?fc.SqlToRegularDate(startOfWeek.plusDays(4).toString()):"-" %></span></th>
											<th>Friday <br> <span class="datecolor"><%=startOfWeek!=null?fc.SqlToRegularDate(startOfWeek.plusDays(5).toString()):"-" %></span></th>
											<th>Saturday <br> <span class="datecolor"><%=endOfWeek!=null?fc.SqlToRegularDate(StringEscapeUtils.escapeHtml4(endOfWeek.toString())):"-" %></span></th>
											<th>Approve / Return</th>
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
												<td><%=obj[5]+", "+obj[6] %></td>
												<%for (LocalDate date = startOfWeek; !date.isAfter(endOfWeek); date = date.plusDays(1)) { 
													TimeSheet timeSheet = employeeTimesheet.get(date);
												%>
													<td class="center">
														<%if(timeSheet!=null && timeSheet.getTotalDuration()!=null) {
															SimpleDateFormat st=new SimpleDateFormat("HH:mm");
															Date time=st.parse("7:59");
											                Date some=st.parse(timeSheet.getTotalDuration()!=null?timeSheet.getTotalDuration():"00:00");
														%>
															<div class="row">
																<div class="col-md-4 right">
																	<%if(timeSheet!=null && timeSheet.getTimeSheetStatus().equalsIgnoreCase("FWD")) {%>
																		<input form="inlineapprform<%=count%>" type="checkbox" class="form-control mt-1 style2" name="timeSheetId" value="<%=timeSheet.getTimeSheetId()!=null?StringEscapeUtils.escapeHtml4(timeSheet.getTimeSheetId().toString()):"-" %>" checked>
																	<%} else if(timeSheet!=null && timeSheet.getTimeSheetStatus().equalsIgnoreCase("ABS")){%>
																		<span class="spanStyle1">
																			<i class="fa fa-check" aria-hidden="true" class="istyle1"></i>
																		</span>
																	<%} else if(timeSheet!=null && timeSheet.getTimeSheetStatus().equalsIgnoreCase("RBS")){%>
																		<span class="spanStyle2">
																			<i class="fa fa-times" aria-hidden="true" class="istyle2"></i>
																		</span>
																	<%} %>
																</div>
															<div class="col-md-7 left ml-2">
															    <% if (some.before(time)) { %>
															        <span class="spancolorRed">
															            <%= timeSheet.getTotalDuration() != null 
															                    ? StringEscapeUtils.escapeHtml4(timeSheet.getTotalDuration().toString()) : "-" %>
															        </span>
															    <% } else { %>
															        <span class="spancolorGreen">
															            <%= timeSheet.getTotalDuration() != null 
															                    ? StringEscapeUtils.escapeHtml4(timeSheet.getTotalDuration().toString()) : "-" %>
															        </span>
															    <% } %>
															</div>
															</div>
														<%} else{%>
															<button class="buttonstyle1">
																--:--
															</button>
														<%} %>
													</td>
												<%} %>
												<td class="left">
													<form action="TimeSheetDetailsForward.htm" method="post" id="inlineapprform<%=count%>">
														<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
														<input form="inlineapprform<%=count%>" type="text" name="remarks" maxlength="255" placeholder="Enter Remarks" class="inputstyle1">
														&emsp;
														<button type="submit" class="btn btn-sm btn-success buttonstyle2" name="action" value="A" data-toggle="tooltip" data-placement="top" title="Approve" onclick="return approvalcheck('A', 'inlineapprform<%=count %>')">
															<i class="fa fa-check" aria-hidden="true"></i> 
														</button>
														&nbsp;
														<button type="submit" class="btn btn-sm btn-danger buttonstyle3" name="action" value="R" data-toggle="tooltip" data-placement="top" title="Return" onclick="return approvalcheck('R', 'inlineapprform<%=count %>')" >
															<i class="fa fa-times istyle3" aria-hidden="true"></i>
														</button>	
													</form>
												</td>
											</tr>
											
											<!-- Sub-Level for Time Sheet Activity -->
											<%-- <tr class="collapse row<%=count %>"  id="rowcollapse<%=count%>" style="font-weight: bold;">
												<td></td>
												<td colspan="8">Details</td>
											</tr> --%>
											<tr class="collapse row<%=count %>" id="rowcollapse<%=count%>" >
												<td></td>
												<td colspan="9">
													
													<table id="activityviewtable tablestyle1">
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
															<%
															int activitycount=0;
															for (LocalDate date = startOfWeek; !date.isAfter(endOfWeek); date = date.plusDays(1)) { 
																TimeSheet timeSheet = employeeTimesheet.get(date);
																List<TimeSheetActivity> timeSheetActivityList = timeSheet!=null?timeSheet.getTimeSheetActivity():new ArrayList<TimeSheetActivity>();
															%>
															<%if(timeSheetActivityList!=null && timeSheetActivityList.size()>0 ) { ++activitycount;%>
																<tr>
																	<td class="center">
																		
																		<%if(timeSheet.getTimeSheetStatus().equalsIgnoreCase("FWD")) {%>
																			<input form="apprform<%=count %>" type="checkbox" class="form-control inputtag1" name="timeSheetId" value="<%=timeSheet.getTimeSheetId()!=null?StringEscapeUtils.escapeHtml4(timeSheet.getTimeSheetId().toString()):"-" %>" checked>
																		<%} else if(timeSheet.getTimeSheetStatus().equalsIgnoreCase("ABS")){%>
																			<span>
																				<i class="fa fa-check istyle4" aria-hidden="true"></i>
																			</span>
																		<%} else if(timeSheet.getTimeSheetStatus().equalsIgnoreCase("RBS")){%>
																			<span>
																				<i class="fa fa-times istyle5" aria-hidden="true"></i>
																			</span>
																		<%} %>
																		
																	</td>
																	<td colspan="4">
    <% if (timeSheet.getTimeSheetStatus().equalsIgnoreCase("ABS")) { %>
       
        <span class="spanStyle3">
            <%= date != null 
                    ? fc.SqlToRegularDate(StringEscapeUtils.escapeHtml4(date.toString())) : "-" %>
        </span>
    <% } else if (timeSheet.getTimeSheetStatus().equalsIgnoreCase("RBS")) { %>
       
        <span class="spanStyle4">
            <%= date != null 
                    ? fc.SqlToRegularDate(StringEscapeUtils.escapeHtml4(date.toString())) : "-" %>
        </span>
    <% } %>
</td>

																</tr>
															<%} %>
															<%
															
															if(timeSheetActivityList!=null && timeSheetActivityList.size()>0) {
																int slno = 0;
																for(TimeSheetActivity act : timeSheetActivityList) {
																	
																	Object[] activity = empActivityAssignList!=null && empActivityAssignList.size()>0?empActivityAssignList.stream()
																			 			.filter(e -> act.getActivityId() == Long.parseLong(e[10].toString()))
																			 	        .findFirst()
																			 	        .orElse(null)
																			 	    	: null;
															%>
																<tr>
																	<td class="center"><%=++slno %></td>
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
																		<%} else{%>
																			<%=activity!=null&&activity[5]!=null?StringEscapeUtils.escapeHtml4(activity[5].toString()):"-" %>	
																		<%} %>
																	</td>
																	<td class="center">
																		<%if(act.getActivityDuration()!=null) {%><%=StringEscapeUtils.escapeHtml4(act.getActivityDuration()) %><%} %>
																	</td>
																	<td>
																		<%if(act.getRemarks()!=null && !act.getRemarks().isEmpty()) {%><%=StringEscapeUtils.escapeHtml4(act.getRemarks())%><%} else{%>-<%} %>
																	</td>
																</tr>
																<%} %>
																<tr>
																	<td class="right tdstyle1" colspan="3" >Work Duration</td>
																	<td colspan="1" class="center">
																		<%if(timeSheet!=null && timeSheet.getTotalDuration()!=null) {%><%=StringEscapeUtils.escapeHtml4(timeSheet.getTotalDuration()) %><%} else{%>00:00<%} %>
																	</td>
																	<td colspan="1"></td>
																</tr>
															<%-- <% }else {%>
																<tr>
																	<td colspan="5" class="center">No Data Available</td>
																</tr> --%>
															<%} %>	
															
															<%} %>
															<%if(activitycount>0) {%>
																<tr>
																	<td colspan="1" class="tdstyle2"><label class="form-label">Remarks</label></td>
																	<td colspan="2" class="tdstyle3">
																		<input form="apprform<%=count %>" type="text" class="w-100 inputtag2" name="remarks" maxlength="255" placeholder="Enter Maximum of 255 characters">
																	</td>
																	<td colspan="2" class="tdstyle4" >
																		<form action="TimeSheetDetailsForward.htm" id="apprform<%=count %>">
																			<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
																			<button type="submit" class="btn btn-sm btn-success mt-1 btnstyle1" name="action" value="A" formmethod="post" formnovalidate="formnovalidate"
																				 onclick="return approvalcheck('A', 'apprform<%=count %>')">
																				Approve
																			</button>
																			&nbsp;
																			<button type="submit" class="btn btn-sm btn-danger mt-1 btnstyle2" name="action" value="R" formmethod="GET" onclick="return approvalcheck('R', 'apprform<%=count %>')">
																				Return
																			</button>
																		</form>
																	</td>
																</tr>	
															<%} else{%>
																<tr>
																	<td class="center" colspan="6">No Data Available</td> 
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

// Add hover event to highlight the week
$(document).on('mouseenter', '.daterangepicker td.available', function() {
    highlightWeek(this);
});

$(document).on('mouseleave', '.daterangepicker td.available', function() {
    // Remove highlights when mouse leaves the cell
    $('.highlight-week').removeClass('highlight-week');
});
</script>				
</body>
</html>