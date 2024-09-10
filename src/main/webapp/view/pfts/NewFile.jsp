<%-- <%@page import="java.util.List"%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
<title>Procurement Progress</title>
<jsp:include page="../static/header.jsp"></jsp:include>
 <style>
/* Header and row styles */
.timeline-header {
    margin-bottom: 20px;
}

.probable-bar{
 background-color: #7f88ec !important;
}
.actual-bar{
 background-color: #94e6a8 !important;
}

.year-header, .quarter-header {
    display: flex;
    justify-content: space-between;
    flex-wrap: wrap;
}

.year-header {
    background-color: #f1a9ce;
    font-weight: bold;
}

.quarter-header {
    background-color: #a9c1f1;
    font-weight: 500;
}

.header-cell {
    text-align: center;
    padding: 5px;
    border: 1px solid #dee2e6;
    flex: 1;
}

.status-row {
    display: flex;
    justify-content: space-between;
    align-items: center;
}

.status-cell {
    text-align: center;
    flex: 1;
}
.bg-light{
    display: inline-block;
    height: 22px;
    width: 22px;
    line-height: 22px;
    border-radius: 50px;
    text-align: center;
    font-size: 15px;
    font-weight: 600;
    color: black;
}
.statuslegends{
    display: flex; 
    justify-content: space-evenly; 
    border: 1px solid; 
    padding: 5px; 
    font-size: 18px; 
    font-weight: 500;    
    border-radius: 8px;
    border-color:#e0a247;
    background: #ECDFCC;
}
.scrollable-list {
    max-height: 300px;
    overflow-y: auto;
}
</style>
</head>
<body>
<%
String PftsFileId = request.getParameter("PftsFileId");
%>
<div class="container-fluid">
   <div class="card">
      <div class="card-body">
				<div class="statuslegends">
					<span style="color: red;">1.Demand Initiated </span> <span
						style="color: blue;">2.Demand Approved</span> <span
						style="color: green;">3.Tender Opening </span> <span
						style="color: darkviolet;">4.Order Placement </span> <span
						style="color: orangered;">5.PDR </span> 
						<span style="color: teal;">6.DDR</span>
					<span style="color: brown;">7.CDR </span> <span
						style="color: magenta;">8.FAT Completed</span> <span
						style="color: mediumvioletred;">9.Available for Integration
					</span>
				</div>
        
    <h2 class="mt-4">Procurement Milestone Status</h2>
    
    <div style="display: flex;justify-content: space-between;">
       <div >
         <span class="badge" style=" background-color: #2735d3;color: white;">Probable Date</span>
         <span class="badge" style="background-color: #1a9235; color: white;">Actual Date</span>
        </div >
       <div class="dropdown-container mt-2" align="right">
            <label for="view-selector">View by: </label>
            <select id="view-selector">
                <option value="quarter">Quarter</option>
                <option value="month">Month</option>
            </select>
      </div>
    </div>

    <!-- Header with Years and Quarters -->
    <div class="timeline-header">
        <!-- Year Header -->
        <div class="year-header" id="year-header"></div>
        <!-- Quarter Header -->
        <div class="quarter-header" id="quarter-header"></div>
    </div>

    <!-- Rows for Probable and Actual Dates -->
    <div id="status-rows" class="scrollable-list">

    </div>
    </div>
   </div>
</div>

<!-- jQuery and Bootstrap 4 JS -->
<script>
$(document).ready(function() {
	
    var demandid = '<%=pftsStatusId%>';
    
    var startDate = new Date('2022-02-15');
    var endDate = new Date('2026-12-30');

    // Generate and display years and quarters
    function generateYearsAndQuarters(start, end) {
        var years = [];
        var quarters = [];
        var currentDate = new Date(start);

        while (currentDate <= end) {
            var year = currentDate.getFullYear();
            var quarter = Math.ceil((currentDate.getMonth() + 1) / 3);
            if (!years.includes(year)) {
                years.push(year);
            }
            quarters.push({ year: year, quarter: 'Q' + quarter });
            currentDate.setMonth(currentDate.getMonth() + 3);
        }

        return { years: years, quarters: quarters };
    }

    var generatedData = generateYearsAndQuarters(startDate, endDate);
    var years = generatedData.years;
    var quarters = generatedData.quarters;

    var yearHeader = $('#year-header');
    years.forEach(function(year) {
        yearHeader.append('<div class="header-cell">' + year + '</div>');
    });

    var quarterHeader = $('#quarter-header');
    quarters.forEach(function(q) {
        quarterHeader.append('<div class="header-cell">' + q.quarter + '</div>');
    });

    $.ajax({
        type: "GET",
        url: 'filestatus.htm', // Replace with your actual endpoint
        dataType: 'json',
        success: function(result) {
            var statusRows = $('#status-rows');

            // Group statuses by demandId
            var groupedStatuses = {};

            result.forEach(function(item) {
                var demandId = item[4]; // Assuming demandId is at index 2
                var statusNumber = item[7]; // Assuming status number is at index 7
                var probableDate = new Date(item[6]); // Assuming probableDate is at index 6
                var actualDate = new Date(item[6]); // Assuming actualDate is at index 5
	
                if (!groupedStatuses[demandId]) {
                    groupedStatuses[demandId] = { probableStatuses: [], actualStatuses: [] };
                }

                groupedStatuses[demandId].probableStatuses.push({ statusNumber: statusNumber, date: probableDate });
                groupedStatuses[demandId].actualStatuses.push({ statusNumber: statusNumber, date: actualDate });
            });
			console.log(groupedStatuses)
            // Iterate over grouped statuses to create rows
			for (var demandId in groupedStatuses) {
			    (function(demandId) {
			        var pcount = 0;
			        var acount = 0;
			        var demandHeader = $('<h6 style="margin-top: 5px; margin-bottom: 0.5px;">').text('Demand No: ' + demandId);
			        

			        var statuses = groupedStatuses[demandId];

			        // Create a row for Probable Dates
			        var probableRow = $('<div>').addClass('status-row probable-bar');
			        quarters.forEach(function(q) {
			            var probableContent = '';
			            var class1 = "empty";
			            statuses.probableStatuses.forEach(function(status) {
			                var probableQuarter = 'Q' + Math.ceil((status.date.getMonth() + 1) / 3);
			                var probableYear = status.date.getFullYear();

			                if (probableYear === q.year && probableQuarter === q.quarter) {
			                    if (status.statusNumber > 0) {
			                        class1 = "bg-light";
			                    }
			                    probableContent = probableContent + '<span class="' + class1 + '">' + (++pcount) + ' </span> ';
			                }
			            });
			            probableRow.append('<div class="status-cell"><span class="">' + probableContent + '</span></div>');
			        });
			       

			        // Create a row for Actual Dates
			        var actualRow = $('<div>').addClass('status-row actual-bar');

			        // Array to keep track of AJAX promises
			        var ajaxPromises = [];

			        // Function to handle AJAX and appending
			        quarters.forEach(function(q) {
			            var promise = $.ajax({
			                type: "GET",
			                url: 'getActualStatus.htm', // Replace with your actual endpoint
			                dataType: 'json',
			                data: {
			                    projectId: 11,
			                    demandId: demandId
			                },
			                success: function(result) {
			                    var actualContent = '';
			                    var class2 = "empty";

			                    result.forEach(function(status) {
			                        var actualQuarter = status[1] != null ? 'Q' + Math.ceil((new Date(status[1]).getMonth() + 1) / 3) : "";
			                        var actualYear = status[1] != null ? new Date(status[1]).getFullYear() : "";

			                        if (actualYear === q.year && actualQuarter === q.quarter) {
			                            if (status[0] > 0) {
			                                class2 = "bg-light";
			                            }
			                            actualContent = actualContent + '<span class="' + class2 + '">' + status[0] + ' </span> ';
			                        }
			                    });

			                    actualRow.append('<div class="status-cell"><span class="">' + actualContent + '</span></div>');
			                }
			            });

			            ajaxPromises.push(promise);
			        });

			        // Once all AJAX calls are completed, append the actualRow
			        // append all row here dont do in in ajax otherwise it append in last only.
			        $.when.apply($, ajaxPromises).done(function() {
			        	statusRows.append(demandHeader);
			        	statusRows.append(probableRow);
			            statusRows.append(actualRow);
			        });

			    })(demandId);
			}

        }
    });
});
</script>
</body>
</html>
 --%>
 <%@page import="java.util.Calendar"%>
<%@page import="java.util.List"%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Activity Table</title>
<jsp:include page="../static/header.jsp"></jsp:include>
    <style>
        .quarter-header {
            text-align: center;
            background-color: #a9c1f1;
        }
        .year-header, .align-middle {
            text-align: center;
            border-bottom: 2px solid #dee2e6;
            background-color: #f1a9ce;
        }
    </style>
</head>
<body>
<%
String PftsFileId = (String)request.getAttribute("PftsFileId");
String ProjectId = (String)request.getAttribute("ProjectId");
String demandNumber = (String)request.getAttribute("demandNumber");
List<Object[]> pftsMileDemandList = (List<Object[]>)request.getAttribute("pftsMileDemandList");
/* Object[] pftsActualDate = (Object[])request.getAttribute("pftsActualDate"); */
%>
    <div class="container-fluid">
       <div class="card">
       <div class="card-body">
       <div style="display: flex;justify-content: space-between;">
	      <div>
	        <h4>Procurement Milestone For Demand Number : <%=demandNumber %></h4>
	      </div>
	      <div >
	        <span class="badge" style=" background-color: green;color: white;font-size: 15px;">Probable Date</span>
	        <span class="badge" style="background-color: #ffae00; color: black;font-size: 15px;">Actual Date</span>
	        <span class="badge" style="background-color: #462fb7; color: white;font-size: 15px;">Both are same quarter</span>
	      </div >
       </div>
       <div class="table-responsive">
	      <table class="table table-bordered table-hover table-striped table-condensed">  
            <thead>
			<% 
			Object[] pftsProjectDate = (Object[]) request.getAttribute("pftsProjectDate");
			java.sql.Date startDateSql = (java.sql.Date) pftsProjectDate[2];
			java.sql.Date endDateSql = (java.sql.Date) pftsProjectDate[3];
			java.util.Date startDate = new java.util.Date(startDateSql.getTime());
			java.util.Date endDate = new java.util.Date(endDateSql.getTime());
			Calendar startCal = Calendar.getInstance();
			startCal.setTime(startDate);
			Calendar endCal = Calendar.getInstance();
			endCal.setTime(endDate);
			%>
			<tr>
			    <th rowspan="2" class="align-middle">Sl No</th>
			    <th rowspan="2" class="align-middle">Activity</th>
			<%
			while (startCal.get(Calendar.YEAR) <= endCal.get(Calendar.YEAR)) {
			    int year = startCal.get(Calendar.YEAR);
			%>
			<th colspan="4" class="year-header"><%= year %></th>
			<%startCal.add(Calendar.YEAR, 1);}%>
			</tr>
			<tr style="border-bottom: 3px solid #6252528a;">
			<% 
			startCal.setTime(startDate);
			while (startCal.get(Calendar.YEAR) <= endCal.get(Calendar.YEAR)) {
			%>
			<th class="quarter-header">Q1</th> 
			<th class="quarter-header">Q2</th> 
			<th class="quarter-header">Q3</th> 
			<th class="quarter-header">Q4</th> 
			<%startCal.add(Calendar.YEAR, 1); }%>
			</tr>
			
			</thead>
			<tbody>
			<% 
			int count = 1;
			if (pftsMileDemandList != null && pftsMileDemandList.size() > 0) {
			    for (Object[] obj : pftsMileDemandList) { 
			        java.sql.Date sqlDate = (java.sql.Date) obj[6];
			        java.util.Date probableDate = new java.util.Date(sqlDate.getTime());
			        Calendar cal = Calendar.getInstance();
			        cal.setTime(probableDate);
			        int objYear = cal.get(Calendar.YEAR); 
			        int objMonth = cal.get(Calendar.MONTH) + 1;
			        int quarter;
			        if (objMonth >= 4 && objMonth <= 6) {
			            quarter = 1; 
			        } else if (objMonth >= 7 && objMonth <= 9) {
			            quarter = 2; 
			        } else if (objMonth >= 10 && objMonth <= 12) {
			            quarter = 3; 
			        } else {
			            quarter = 4;
			            objYear--; 
			        }
			%>
			<tr>
			<td style="text-align: center;font-size: 17px;font-weight: 600;"><%= count + " . " %></td>
			<td style="font-size: 17px;font-weight: 600;"><%= obj[11].toString() %></td>
			<%
			startCal.setTime(startDate);
			while (startCal.get(Calendar.YEAR) <= endCal.get(Calendar.YEAR)) {
			    int year = startCal.get(Calendar.YEAR);
			    for (int q = 1; q <= 4; q++) { 
			        if (year == objYear && q == quarter) { 
			%>
			<td id="tdid_<%= obj[7] %>_<%= year %>_Q<%= q %>" style="background-color: green;"></td>
			<% } else {%>
			<td id="tdid_<%= obj[7] %>_<%= year %>_Q<%= q %>"></td>
			<%}}startCal.add(Calendar.YEAR, 1); } %>
			</tr>
			<% count++;}}%>
			</tbody>
        </table>
        </div>
         <span style="color: red;font-size: large;font-weight: 500;">Note : All The Quarters Are Based on Financial Year</span>
    </div>
    <div class="form-group" align="center">
		 <a class="btn btn-info btn-sm  shadow-nohover back" href="ProcurementStatus.htm?projectid=<%=ProjectId%>">Back</a>
	</div>
   </div>
   </div>
</body>
<script type="text/javascript">
var pftsId = '<%=PftsFileId%>';

$(document).ready(function() {
    $.ajax({
        type: 'GET',
        url: 'getpftsActualDate.htm',
        dataType: 'json',
        data: {
            PftsFileId: pftsId
        },
        success: function(data) {
            var ajaxresult=data;
            if(ajaxresult[2]!=null){
            	var year = new Date(ajaxresult[2]).getFullYear();
            	var month = new Date(ajaxresult[2]).getMonth()+1;
            	var quarter = getQuarter(month);
            	$('#tdid_1_'+year+'_'+quarter).css('background-color','#ffae00'); 
            }
            if(ajaxresult[3]!=null){
            	var year = new Date(ajaxresult[3]).getFullYear();
            	var month = new Date(ajaxresult[3]).getMonth()+1;
            	var quarter = getQuarter(month);
            	$('#tdid_3_'+year+'_'+quarter).css('background-color','#ffae00'); 
            }
            if(ajaxresult[4]!=null){
            	var year = new Date(ajaxresult[4]).getFullYear();
            	var month = new Date(ajaxresult[4]).getMonth()+1;
            	var quarter = getQuarter(month);
            	$('#tdid_6_'+year+'_'+quarter).css('background-color','#ffae00'); 
            }
            if(ajaxresult[5]!=null){
            	var year = new Date(ajaxresult[5]).getFullYear();
            	var month = new Date(ajaxresult[5]).getMonth()+1;
            	var quarter = getQuarter(month);
            	$('#tdid_10_'+year+'_'+quarter).css('background-color','#ffae00'); 
            }
            if(ajaxresult[6]!=null){
            	var year = new Date(ajaxresult[6]).getFullYear();
            	var month = new Date(ajaxresult[6]).getMonth()+1;
            	var quarter = getQuarter(month);
            	$('#tdid_11_'+year+'_'+quarter).css('background-color','#ffae00'); 
            }
            if(ajaxresult[7]!=null){
            	var year = new Date(ajaxresult[7]).getFullYear();
            	var month = new Date(ajaxresult[7]).getMonth()+1;
            	var quarter = getQuarter(month);
            	$('#tdid_12_'+year+'_'+quarter).css('background-color','#ffae00'); 
            }
            if(ajaxresult[8]!=null){
            	var year = new Date(ajaxresult[8]).getFullYear();
            	var month = new Date(ajaxresult[8]).getMonth()+1;
            	var quarter = getQuarter(month);
            	$('#tdid_13_'+year+'_'+quarter).css('background-color','#ffae00'); 
            }
            if(ajaxresult[9]!=null){
            	var year = new Date(ajaxresult[9]).getFullYear();
            	var month = new Date(ajaxresult[9]).getMonth()+1;
            	var quarter = getQuarter(month);
            	$('#tdid_15_'+year+'_'+quarter).css('background-color','#ffae00'); 
            }
            if(ajaxresult[10]!=null){
            	var year = new Date(ajaxresult[10]).getFullYear();
            	var month = new Date(ajaxresult[10]).getMonth()+1;
            	var quarter = getQuarter(month);
            	$('#tdid_22_'+year+'_'+quarter).css('background-color','#ffae00'); 
            }
        },
        error: function(xhr, status, error) {
            console.error("Error fetching data:", error);
        }
    });
});

function getQuarter(month) {
    // Define the month arrays for each quarter
    const Q1 = [4, 5, 6];  // April, May, June
    const Q2 = [7, 8, 9];  // July, August, September
    const Q3 = [10, 11, 12];  // October, November, December
    const Q4 = [1, 2, 3];  // January, February, March

    // Determine the quarter based on the month
    if (Q1.includes(month)) {
        return 'Q1';
    } else if (Q2.includes(month)) {
        return 'Q2';
    } else if (Q3.includes(month)) {
        return 'Q3';
    } else if (Q4.includes(month)) {
        return 'Q4';
    } else {
        return '';
    }
}

</script>
</html>
 