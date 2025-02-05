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
</style> 
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
								
					<div class="row" style="margin: 0.5rem;">
						<div class="col-12">
		         			<ul class="nav nav-pills" id="pills-tab" role="tablist" style="background-color: #E1E5E8;padding:0px;">
				  				<li class="nav-item" style="width: 50%;"  >
				    				<div class="nav-link active" style="text-align: center;" id="pills-tab-1" data-toggle="pill" data-target="#tab-1" role="tab" aria-controls="tab-1" aria-selected="true">
					   					<span>Submitted Employees</span> 
					   					<span class="badge badge-danger badge-counter count-badge" style="margin-left: 0px;">
				   		 					<%-- <%if(timeSheetToListMap.size()>99){ %>
				   								99+
				   							<%}else{ %> --%>
				   								<%=timeSheetToListMap.size() %>
											<%-- <%} %>	 --%>		   			
				  						</span>
				    				</div>
				  				</li>
				  				<li class="nav-item"  style="width: 50%;">
				    				<div class="nav-link" style="text-align: center;" id="pills-tab-2" data-toggle="pill" data-target="#tab-2" role="tab" aria-controls="tab-2" aria-selected="false">
				    	 				<span>Not Submitted Employees</span> 
				    	 				<span class="badge badge-danger badge-counter count-badge" style="margin-left: 0px;">
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
            						<input type="text" id="searchBar" class="search-bar form-control" placeholder="Search..." style="float: right;width: auto;" />
       								<br>
									<table class="table activitytable" id="dataTable"> 
			                        	<thead style="">
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
														<td rowspan="<%=values.size() %>" style="vertical-align: middle;" class="center"><%=++slno%></td>
											    		<td rowspan="<%=values.size() %>" style="vertical-align: middle;">
											    			<%=obj[17]!=null?obj[17]+", "+(obj[18]!=null?obj[18]:"-"):"-" %>
											    		</td>
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
							<div class="tab-pane fade" id="tab-2" role="tabpanel" aria-labelledby="pills-tab-2">
								<div class="table-wrapper table-responsive">
									<input type="text" id="searchBar2" class="search-bar form-control" placeholder="Search..." style="float: right;width: auto;" />
       								<br>
									<table class="table activitytable" id="dataTable2"> 
			                        	<thead style="">
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
										    		<td style="vertical-align: middle;">
										    			<%=obj[1]!=null?obj[1]:obj[2] %>
										    			<%=obj[5]!=null?(obj[5]+", "+(obj[6]!=null?obj[6]:"-")):"-" %>
										    		</td>
			         								<td class="center" colspan="7">No Data Available</td>
												</tr>
											<% } }  else{%>
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