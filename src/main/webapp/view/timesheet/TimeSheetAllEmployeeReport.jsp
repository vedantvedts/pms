<%@page import="lombok.val"%>
<%@page import="java.util.HashMap"%>
<%@page import="com.vts.pfms.timesheet.model.TimeSheet"%>
<%@page import="com.vts.pfms.master.model.MilestoneActivityType"%>
<%@page import="com.vts.pfms.master.model.Employee"%>
<%@page import="com.vts.pfms.timesheet.model.TimesheetKeywords"%>
<%@page import="java.time.LocalDate"%>
<%@page import="java.time.temporal.TemporalAdjusters"%>
<%@page import="java.time.DayOfWeek"%>
<%@page import="java.util.LinkedHashMap"%>
<%@page import="java.util.stream.Collectors"%>
<%@page import="com.google.gson.Gson"%>
<%@page import="com.google.gson.GsonBuilder"%>
<%@page import="com.vts.pfms.FormatConverter"%>
<%@page import="java.util.List"%>
<%@page import="java.util.Map"%>
<%@page import="org.apache.commons.text.StringEscapeUtils"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<jsp:include page="../static/header.jsp"></jsp:include>
<spring:url
	value="/resources/css/Timesheet/TimeSheetAllEmployeeReport.css"
	var="timesheetEmpReport" />
<link href="${timesheetEmpReport}" rel="stylesheet" />

<%
List<Object[]> employeeList = (List<Object[]>) request.getAttribute("roleWiseEmployeeList");
List<Employee> allEmpList = (List<Employee>) request.getAttribute("allEmployeeList");
List<Long> empIdno = (List<Long>) request.getAttribute("empIdno");

String empId = (String) request.getAttribute("empId");
String[] empIds = (String[]) request.getAttribute("empIds");
String fromDate = (String) request.getAttribute("fromDate");
String toDate = (String) request.getAttribute("toDate");

Map<String, List<Object[]>> allEmpReportList = (Map<String, List<Object[]>>) request.getAttribute("allEmpReportList");

String viewFlag = (String) request.getAttribute("viewFlag");
viewFlag = viewFlag == null ? "W" : viewFlag;

FormatConverter fc = new FormatConverter();

String fromDateR = fc.sdfTordf(fromDate);
String toDateR = fc.sdfTordf(toDate);
%>
</head>
<body>

	<%
	String ses = (String) request.getParameter("result");
	String ses1 = (String) request.getParameter("resultfail");
	if (ses1 != null) {
	%>
	<div align="center">
		<div class="alert alert-danger" role="alert">
			<%=StringEscapeUtils.escapeHtml4(ses1)%>
		</div>
	</div>
	<%
	}
	if (ses != null) {
	%>
	<div align="center">
		<div class="alert alert-success" role="alert">
			<%=StringEscapeUtils.escapeHtml4(ses)%>
		</div>
	</div>
	<%
	}
	%>


	<div class="container-fluid">
		<div class="row">
			<div class="col-md-12">
				<div class="card">
					<div class="card-header">
						<div class="row">
							<div class="col-md-6">
								<h4>All Employee Report</h4>
							</div>
						</div>
					</div>
					<div class="card-body">
						<div class="form-group">
							<div class="row mb-3 mt-4">
								<%-- <div class="col-md-5">
									<%Object[] emp2 = employeeList!=null && employeeList.size()>0?employeeList.stream()
													.filter(e -> empIdP.equalsIgnoreCase(e[0]+"")).findFirst().orElse(null):null; %>
									<b class="ml-2">Report</b> of <b><%= emp2 != null ? ((emp2[1] != null ? StringEscapeUtils.escapeHtml4(emp2[1].toString()): (emp2[2] != null ? StringEscapeUtils.escapeHtml4(emp2[2].toString())  : "") )+ (emp2[5] != null ? StringEscapeUtils.escapeHtml4(emp2[5].toString())  : "") + ", " + (emp2[6] != null  ? StringEscapeUtils.escapeHtml4(emp2[6].toString())  : "")  ): "-"%></b>
								</div> --%>
								<div class="col-md-3"></div>
								<div class="col-md-9">
									<form action="TimeSheetAllEmployeeReport.htm" method="get">
										<input type="hidden" name="${_csrf.parameterName}"
											value="${_csrf.token}" /> <input type="hidden"
											name="viewFlag" value="P"> <input type="hidden"
											name="empId" value="<%=empId%>">
										<div class="row style15">
											<div class="col-md-1">
												<label class="form-label mt-2">Employee: </label>
											</div>
											<div class="col-md-3 right empIdPdiv">
												<select class="form-control empIdP selectdee"
													multiple="multiple" name="allEmpIds"
													data-placeholder="Select Employees" >
													<%
													if (employeeList != null && employeeList.size() > 0) {
														for (Object[] obj : employeeList) {
													%>
													<option value="<%=obj[0]%>"
														<%if (empIdno != null && empIdno.size() > 0 && empIdno.contains(obj[0])) {%>
														selected <%}%>>
														<%=(obj[1] != null
		? StringEscapeUtils.escapeHtml4(obj[1].toString())
		: (obj[2] != null ? StringEscapeUtils.escapeHtml4(obj[2].toString()) : ""))%>
														<%=obj[5] != null ? StringEscapeUtils.escapeHtml4(obj[5].toString()) : ""%>,
														<%=obj[6] != null ? StringEscapeUtils.escapeHtml4(obj[6].toString()) : ""%>
													</option>
													<%
													}
													}
													%>
												</select>
											</div>
											<div class="col-md-1 right">
												<label class="form-label mt-2">From: </label>
											</div>
											<div class="col-md-2">
												<input type="text" class="form-control " name="fromDate"
													id="fromDate"
													value="<%=fromDateR != null ? StringEscapeUtils.escapeHtml4(fromDateR) : ""%>">
											</div>
											<div class="col-md-1 toWidth">
												<label class="form-label mt-2">To: </label>
											</div>
											<div class="col-md-2">
												<input type="text" class="form-control " name="toDate"
													id="toDate"
													value="<%=toDateR != null ? StringEscapeUtils.escapeHtml4(toDateR) : ""%>"">
											</div>
											<div class="col-md-2 ">
												<button type="submit" class="btn btn-sm submit">
													Submit</button>
												<button type="submit" class="btn btn-sm style16"
													formnovalidate="formnovalidate"
													formaction="AllEmployeesReportPdfGeneration.htm"
													formtarget="blank" data-toggle="tooltip"
													data-placement="top" title="PDF Report">
													<i class="fa fa-file-pdf-o style17" aria-hidden="true"></i>
												</button>
												<button type="submit" class="btn btn-sm style16"
													name="Action" value="GenerateExcel"
													formaction="AllEmployeeReportViewExcel.htm"
													formtarget="blank" data-toggle="tooltip"
													data-placement="top" title="Excel Report">
													<i class="fa fa-file-excel-o style18" aria-hidden="true"></i>
												</button>
											</div>
										</div>
									</form>
								</div>
							</div>
						</div>

						<div class="table-wrapper table-responsive">
							<!-- <input type="text" id="searchBar2" class="search-bar form-control" placeholder="Search..." style="float: right;width: auto;" />
	    								<br> -->
							<table class="table activitytable" id="dataTable3">
								<thead>
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
								<tbody id="reportTableBody">
									<%
									if (allEmpReportList != null && !allEmpReportList.isEmpty()) {
										int slno = 0;
										String prevEmp = "";
										for (Map.Entry<String, List<Object[]>> map : allEmpReportList.entrySet()) {
											String currEmpId = map.getKey();
											List<Object[]> values = map.getValue();

											Map<String, List<Object[]>> valuesbasedonId = values.stream()
											.collect(Collectors.groupingBy(obj -> obj[0].toString(), LinkedHashMap::new, Collectors.toList()));

											Object[] emp2 = (employeeList != null && !employeeList.isEmpty())
											? employeeList.stream().filter(e -> currEmpId.equalsIgnoreCase(String.valueOf(e[0]))).findFirst()
													.orElse(null)
											: null;

											if (!prevEmp.equalsIgnoreCase(currEmpId)) {
									%>
									<!-- Employee Header -->
									<tr class="employee-header">
										<td colspan="9" class="text-center">
										<%=emp2 != null
											? ((emp2[1] != null
													? StringEscapeUtils.escapeHtml4(emp2[1].toString())
													: (emp2[2] != null ? StringEscapeUtils.escapeHtml4(emp2[2].toString()) : ""))
													+ (emp2[5] != null ? StringEscapeUtils.escapeHtml4(emp2[5].toString()) : "") + ", "
													+ (emp2[6] != null ? StringEscapeUtils.escapeHtml4(emp2[6].toString()) : ""))
											: "-"%>
										</td>
									</tr>

									<%
									}
									if (values == null || values.isEmpty()) {
									%>
									<tr>
										<td colspan="9" class="style4">No Data Available.</td>
									</tr>
									<%
									continue;
									}
									for (Map.Entry<String, List<Object[]>> map2 : valuesbasedonId.entrySet()) {

									List<Object[]> values2 = map2.getValue();
									int i = 0;
									for (Object[] obj : values2) {
									%>
									<tr>
										<%
										if (i == 0) {
										%>
										<td rowspan="<%=values2.size()%>" class="center style19"><%=++slno%></td>
										<td rowspan="<%=values2.size()%>" class="center style19"><%=obj[2] != null ? fc.sdfTordf(StringEscapeUtils.escapeHtml4(obj[2].toString())) : ""%></td>
										<%
										}
										%>
										<%-- <td class="center"><%= ++slno %></td>
								                    <td class="center"><%= obj[2] != null ? fc.sdfTordf(StringEscapeUtils.escapeHtml4(obj[2].toString())) : "" %></td> --%>
										<td class="center"><%=obj[16] != null ? StringEscapeUtils.escapeHtml4(obj[16].toString()) : "-"%></td>
										<td><%=obj[5] != null ? StringEscapeUtils.escapeHtml4(obj[5].toString()) : "-"%></td>
										<td class="center"><%=obj[8] != null ? StringEscapeUtils.escapeHtml4(obj[8].toString()) : "-"%></td>
										<td><%=obj[10] != null
											? StringEscapeUtils.escapeHtml4(obj[10].toString()) + ", "
													+ (obj[11] != null ? StringEscapeUtils.escapeHtml4(obj[11].toString()) : "-")
											: "Not Available"%>
										</td>
										<td class="center"><%=obj[13] != null ? StringEscapeUtils.escapeHtml4(obj[13].toString()) : "-"%></td>
										<td><%=obj[14] != null ? StringEscapeUtils.escapeHtml4(obj[14].toString()) : "-"%></td>
										<td class="center"><%=obj[15] != null
		? ("A".equalsIgnoreCase(obj[15].toString())
				? "AN"
				: "F".equalsIgnoreCase(obj[15].toString()) ? "FN" : "Full day")
		: "-"%></td>
									</tr>
									<%
									i++;
									} // end inner loop
									} // second Map Loop
									} // end outer loop
									} else {
									%>
									<tr>
										<td colspan="9" class="style4">No Data Available</td>
									</tr>
									<%
									}
									%>
								</tbody>
							</table>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
	<script>

// Convert Java array to JS array


//Initialize other datepickers without affecting the week highlighting
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
"cancelClass" : "btn-default",
showDropdowns : true,
locale : {
	format : 'DD-MM-YYYY'
}
		});
	</script>
</body>
</html>