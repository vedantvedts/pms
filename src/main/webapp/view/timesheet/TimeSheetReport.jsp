<%@page import="org.apache.commons.text.StringEscapeUtils"%>
<%@page import="java.util.Set"%>
<%@page import="java.util.HashMap"%>
<%@page import="java.util.LinkedHashMap"%>
<%@page import="java.util.stream.Collectors"%>
<%@page import="java.util.Date"%>
<%@page import="java.util.ArrayList"%>
<%@page import="com.vts.pfms.FormatConverter"%>
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
<spring:url value="/resources/css/Timesheet/TimeSheetReport.css" var="holidayAddEdit" />     
<link href="${holidayAddEdit}" rel="stylesheet" />
</head>
<body>

<%
List<Object[]> employeeList = (List<Object[]>)request.getAttribute("roleWiseEmployeeList");

String activityDate = (String)request.getAttribute("activityDate");
String activityDateSql = (String)request.getAttribute("activityDateSql");

List<Object[]> employeeNewTimeSheetList = (List<Object[]>)request.getAttribute("employeeNewTimeSheetList");
Map<String, List<Object[]>> timeSheetToListMap = employeeNewTimeSheetList!=null && employeeNewTimeSheetList.size()>0?employeeNewTimeSheetList.stream()
		  										  .collect(Collectors.groupingBy(array -> array[0] + "", LinkedHashMap::new, Collectors.toList())) : new HashMap<>();

//Extract empIds from employeeNewTimeSheetList into a Set for efficient lookup
Set<Object> newTimeSheetEmpIds = employeeNewTimeSheetList.stream().map(e -> e[1]).collect(Collectors.toSet());

// Filter employees in employeeList whose empId is not in newTimeSheetEmpIds
List<Object[]> notSubmittedEmployees = employeeList.stream().filter(e -> !newTimeSheetEmpIds.contains(e[0])).collect(Collectors.toList());
		
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
								<h4 class="">Work Register Report</h4>
							</div>
							<div class="col-md-6">
								
							</div>
						</div>
					</div>
					
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
								
					<div class="row style1">
						<div class="col-12">
		         			<ul class="nav nav-pills" id="pills-tab" role="tablist">
				  				<li class="nav-item style3" >
				    				<div class="nav-link active style4" id="pills-tab-1" data-toggle="pill" data-target="#tab-1" role="tab" aria-controls="tab-1" aria-selected="true">
					   					<span>Submitted Employees</span> 
					   					<span class="badge badge-danger count-badge style5">
				   		 					<%-- <%if(timeSheetToListMap.size()>99){ %>
				   								99+
				   							<%}else{ %> --%>
				   								<%=timeSheetToListMap.size() %>
											<%-- <%} %>	 --%>		   			
				  						</span>
				    				</div>
				  				</li>
				  				<li class="nav-item style3">
				    				<div class="nav-link style4" id="pills-tab-2" data-toggle="pill" data-target="#tab-2" role="tab" aria-controls="tab-2" aria-selected="false">
				    	 				<span>Not Submitted Employees</span> 
				    	 				<span class="badge badge-danger count-badge style5">
				   		 					<%-- <%if(notSubmittedEmployees.size()>99){ %>
				   								99+
				   							<%}else{ %> --%>
				   								<%=notSubmittedEmployees.size() %>
											<%-- <%} %> --%>				   			
				  						</span>
				    				</div>
				  				</li>
							</ul>
			   			</div>
					</div>
					<div class="card-body">
						<div class="tab-content" id="pills-tabContent">
       			
            				<div class="tab-pane fade show active" id="tab-1" role="tabpanel" aria-labelledby="pills-tab-1">
            					<div class="table-wrapper table-responsive">
            						<input type="text" id="searchBar" class="search-bar form-control style6" placeholder="Search..." />
       								<br>
									<table class="table activitytable" id="dataTable"> 
			                        	<thead>
			                        		<tr>
												<th width="3%">SN</th>
												<th width="13%">Employee</th>
												<th width="7%">Activity No</th>
												<th width="8%">Activity Type</th>
												<th width="10%">Project</th>
												<th width="15%">Assigner</th>
												<th width="10%">Keywords</th>
												<th width="20%">Work Done</th>
												<th width="10%">Work Done on</th>
											</tr>
										</thead>
										<tbody>	
											<% if (timeSheetToListMap!=null && timeSheetToListMap.size() > 0) {
												int slno = 0;
												for (Map.Entry<String, List<Object[]>> map : timeSheetToListMap.entrySet()) {
			                  							
			                  							List<Object[]> values = map.getValue();
			                  							int i=0;
			                  							for (Object[] obj : values) {
											%>
												<tr>
													<%if(i==0) {%>
														<td rowspan="<%=values.size() %>" class="center style7"><%=++slno%></td>
											    		<td rowspan="<%=values.size() %>" class="style7">
											    			<%=obj[17]!=null?StringEscapeUtils.escapeHtml4(obj[17].toString())+", "+(obj[18]!=null?StringEscapeUtils.escapeHtml4(obj[18].toString()):"-"):"-" %>
											    		</td>
			         								<%} %>
			         								<td class="center"><%=obj[16]!=null?StringEscapeUtils.escapeHtml4(obj[16].toString()):"-" %></td>
			    									<td ><%=obj[5]!=null?StringEscapeUtils.escapeHtml4(obj[5].toString()):"-" %></td>
			    									<td class="center"><%=obj[8]!=null?StringEscapeUtils.escapeHtml4(obj[8].toString()):"-" %></td>
			    									<td><%=obj[10]!=null?StringEscapeUtils.escapeHtml4(obj[10].toString())+", "+(obj[11]!=null?StringEscapeUtils.escapeHtml4(obj[11].toString()):"-"):"Not Available" %></td>
			    									<td class="center"><%=obj[13]!=null?StringEscapeUtils.escapeHtml4(obj[13].toString()):"-" %></td>
			    									<td><%=obj[14]!=null?StringEscapeUtils.escapeHtml4(obj[14].toString()):"-" %></td>
			    									<td class="center"><%=obj[15]!=null?(StringEscapeUtils.escapeHtml4(obj[15].toString()).equalsIgnoreCase("A")?"AN":(StringEscapeUtils.escapeHtml4(obj[15].toString()).equalsIgnoreCase("F")?"FN":"Full day")):"-" %></td>
												</tr>
											<% ++i; } } } else{%>
												<tr>
													<td colspan="9" class="style4">No Data Available</td>
												</tr>
											<%} %>
										</tbody>
									</table>
								</div>		
							</div>
							<div class="tab-pane fade" id="tab-2" role="tabpanel" aria-labelledby="pills-tab-2">
								<div class="table-wrapper table-responsive">
									<input type="text" id="searchBar2" class="search-bar form-control style6"  placeholder="Search..." />
       								<br>
									<table class="table activitytable" id="dataTable2"> 
			                        	<thead>
			                        		<tr>
												<th width="3%">SN</th>
												<th width="13%">Employee</th>
												<th width="7%">Activity No</th>
												<th width="8%">Activity Type</th>
												<th width="10%">Project</th>
												<th width="15%">Assigner</th>
												<th width="10%">Keywords</th>
												<th width="20%">Work Done</th>
												<th width="10%">Work Done on</th>
											</tr>
										</thead>
										<tbody>	
											<%if (notSubmittedEmployees!=null && notSubmittedEmployees.size() > 0) {
												int slno = 0;
			                  					for (Object[] obj : notSubmittedEmployees) {
											%>
												<tr>
													<td class="center"><%=++slno%></td>
										    		<td class="style7">
										    			<%=obj[1]!=null?StringEscapeUtils.escapeHtml4(obj[1].toString()):StringEscapeUtils.escapeHtml4(obj[2].toString())%>
										    			<%=obj[5]!=null?(StringEscapeUtils.escapeHtml4(obj[5].toString())+", "+(obj[6]!=null?StringEscapeUtils.escapeHtml4(obj[6].toString()):"-")):"-" %>
										    		</td>
			         								<td class="center" colspan="7">No Data Available</td>
												</tr>
											<% } }  else{%>
												<tr>
													<td colspan="9" class="style4">No Data Available</td>
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
	<form action="TimeSheetReport.htm" method="post" id="calenderdateform">
		<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
		<input type="hidden" class="activityDate" name="activityDate" id="activityDate">
		<input type="hidden" name="viewFlag" value="M">
	</form>
<script type="text/javascript">

$(document).ready(function () {
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
});

</script>

<script type="text/javascript">
	
	<%-- var empAllTimeSheetList = JSON.parse('<%= jsonempAllTimeSheetList %>'); --%>
	
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
	    /* var empDates = empAllTimeSheetList.map(function (entry) {
	        return new Date(entry[3]); // Assuming the date is in SQL format at index 3
	    }); */

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
	            /* var isHighlighted = empDates.some(function (empDate) {
	                return (
	                    empDate.getFullYear() === date.getFullYear() &&
	                    empDate.getMonth() === date.getMonth() &&
	                    empDate.getDate() === date.getDate()
	                );
	            }); */
	            /* if (isHighlighted) {
	                dayEl.classList.add("active");
	            } */

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
	        /* var isDateExisting = empAllTimeSheetList.some(function (row) {
	            return row[3] === formattedDate.split("-").reverse().join("-");
	        }); */

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
	        /* if (isDateExisting) {
	            $('#calenderdateform').submit();
	        } else  */if (selectedDate < restrictionDate) {
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