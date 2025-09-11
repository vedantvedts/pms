<%@page import="org.apache.commons.text.StringEscapeUtils"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.util.Calendar"%>
<%@page import="java.util.List"%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<title>Milestone View</title>
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
Object[] pftsMileDemandList = (Object[])request.getAttribute("pftsMileDemandList");
/* Object[] pftsActualDate = (Object[])request.getAttribute("pftsActualDate"); */
List<Object[]> milestoneStatus = new ArrayList<Object[]>();
milestoneStatus.add(new Object[]{1, "Demand Initiated"});
milestoneStatus.add(new Object[]{2, "Demand Approved"});
milestoneStatus.add(new Object[]{3, "Tender Opening"});
milestoneStatus.add(new Object[]{4, "Order Placement"});
milestoneStatus.add(new Object[]{5, "PDR"});
milestoneStatus.add(new Object[]{6, "SO for Critical BoM by Dev Partner"});
milestoneStatus.add(new Object[]{7, "DDR"});
milestoneStatus.add(new Object[]{8, "CDR"});
milestoneStatus.add(new Object[]{9, "Acceptance of Critical BoM by Dev Partner"});
milestoneStatus.add(new Object[]{10, "FAT Completed"});
milestoneStatus.add(new Object[]{11, "Delivery at Stores"});
milestoneStatus.add(new Object[]{12, "SAT / SoFT"});
milestoneStatus.add(new Object[]{13, "Available for Integration"});
%>
    <div class="container-fluid">
       <div class="card">
       <div class="card-body">
       <div style="display: flex;justify-content: space-between;">
	      <div>
	        <h4>Procurement Milestone For Demand Number : <%=demandNumber!=null?StringEscapeUtils.escapeHtml4(demandNumber): " - " %></h4>
	      </div>
	      <div >
	        <span class="badge" style=" background-color: green;color: white;font-size: 15px;">Probable Date</span>
	        <span class="badge" style="background-color: #ffae00; color: black;font-size: 15px;">Actual Date</span>
	        <span class="badge" style="background-color: #462fb7; color: white;font-size: 15px;">Both are same quarter</span>
	      </div >
       </div>
       <div class="table-responsive">
	      <table class="table table-bordered table-hover table-condensed">  
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
			if (milestoneStatus != null && milestoneStatus.size() > 0) {
			    for (Object[] obj : milestoneStatus) { 
			    	java.sql.Date sqlDate = null;

			    	if (obj[0] != null) {
			    	    int index = Integer.parseInt(obj[0].toString());

			    	    if (index >= 1 && index <= 13) {
			    	        sqlDate = (java.sql.Date) pftsMileDemandList[index + 1];
			    	    }
			    	}
			    	
			    	sqlDate = sqlDate==null? new java.sql.Date(System.currentTimeMillis()):sqlDate;
			    	
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
			<td style="font-size: 17px;font-weight: 600;"><%= obj[1]!=null?StringEscapeUtils.escapeHtml4(obj[1].toString()):"-" %></td>
			<%
			startCal.setTime(startDate);
			while (startCal.get(Calendar.YEAR) <= endCal.get(Calendar.YEAR)) {
			    int year = startCal.get(Calendar.YEAR);
			    for (int q = 1; q <= 4; q++) { 
			        if (year == objYear && q == quarter) { 
			%>
			<td id="tdid_<%= obj[0] %>_<%= year %>_Q<%= q %>" style="background-color: green;">
			<input type="hidden"id="tdcell_<%= obj[0] %>_<%= year %>_Q<%= q %>"  value="<%= obj[0] %>">
			</td>
			<% } else {%>
			<td id="tdid_<%= obj[0] %>_<%= year %>_Q<%= q %>"></td>
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
            	var value1=Number($('#tdcell_1_'+year+'_'+quarter).val());
            	sameQuarter(value1,1,year,quarter);
            }
            if(ajaxresult[3]!=null){
            	var year = new Date(ajaxresult[3]).getFullYear();
            	var month = new Date(ajaxresult[3]).getMonth()+1;
            	var quarter = getQuarter(month);
            	var value1=Number($('#tdcell_2_'+year+'_'+quarter).val());
            	sameQuarter(value1,2,year,quarter); 
            }
            if(ajaxresult[4]!=null){
            	var year = new Date(ajaxresult[4]).getFullYear();
            	var month = new Date(ajaxresult[4]).getMonth()+1;
            	var quarter = getQuarter(month);
            	var value1=Number($('#tdcell_3_'+year+'_'+quarter).val());
            	sameQuarter(value1,3,year,quarter);
            }
            if(ajaxresult[5]!=null){
            	var year = new Date(ajaxresult[5]).getFullYear();
            	var month = new Date(ajaxresult[5]).getMonth()+1;
            	var quarter = getQuarter(month);
            	var value1=Number($('#tdcell_4_'+year+'_'+quarter).val());
            	sameQuarter(value1,4,year,quarter);
            }
            if(ajaxresult[6]!=null){
            	var year = new Date(ajaxresult[6]).getFullYear();
            	var month = new Date(ajaxresult[6]).getMonth()+1;
            	var quarter = getQuarter(month);
            	var value1=Number($('#tdcell_5_'+year+'_'+quarter).val());
            	sameQuarter(value1,5,year,quarter);
            }
            if(ajaxresult[11]!=null){
            	var year = new Date(ajaxresult[11]).getFullYear();
            	var month = new Date(ajaxresult[11]).getMonth()+1;
            	var quarter = getQuarter(month);
            	var value1=Number($('#tdcell_6_'+year+'_'+quarter).val());
            	sameQuarter(value1,6,year,quarter);
            }
            if(ajaxresult[7]!=null){
            	var year = new Date(ajaxresult[7]).getFullYear();
            	var month = new Date(ajaxresult[7]).getMonth()+1;
            	var quarter = getQuarter(month);
            	var value1=Number($('#tdcell_7_'+year+'_'+quarter).val());
            	sameQuarter(value1,7,year,quarter); 
            } 
            if(ajaxresult[8]!=null){
            	var year = new Date(ajaxresult[8]).getFullYear();
            	var month = new Date(ajaxresult[8]).getMonth()+1;
            	var quarter = getQuarter(month);
            	var value1=Number($('#tdcell_8_'+year+'_'+quarter).val());
            	sameQuarter(value1,8,year,quarter);
            }
            if(ajaxresult[12]!=null){
            	var year = new Date(ajaxresult[12]).getFullYear();
            	var month = new Date(ajaxresult[12]).getMonth()+1;
            	var quarter = getQuarter(month);
            	var value1=Number($('#tdcell_9_'+year+'_'+quarter).val());
            	sameQuarter(value1,9,year,quarter);
            }
            if(ajaxresult[9]!=null){
            	var year = new Date(ajaxresult[9]).getFullYear();
            	var month = new Date(ajaxresult[9]).getMonth()+1;
            	var quarter = getQuarter(month);
            	var value1=Number($('#tdcell_10_'+year+'_'+quarter).val());
            	sameQuarter(value1,10,year,quarter);
            }
            if(ajaxresult[14]!=null){
            	var year = new Date(ajaxresult[14]).getFullYear();
            	var month = new Date(ajaxresult[14]).getMonth()+1;
            	var quarter = getQuarter(month);
            	var value1=Number($('#tdcell_11_'+year+'_'+quarter).val());
            	sameQuarter(value1,11,year,quarter); 
            }
            if(ajaxresult[13]!=null){
            	var year = new Date(ajaxresult[13]).getFullYear();
            	var month = new Date(ajaxresult[13]).getMonth()+1;
            	var quarter = getQuarter(month);
            	var value1=Number($('#tdcell_12_'+year+'_'+quarter).val());
            	sameQuarter(value1,12,year,quarter);
            }
            if(ajaxresult[10]!=null){
            	var year = new Date(ajaxresult[10]).getFullYear();
            	var month = new Date(ajaxresult[10]).getMonth()+1;
            	var quarter = getQuarter(month);
            	var value1=Number($('#tdcell_13_'+year+'_'+quarter).val());
            	sameQuarter(value1,13,year,quarter); 
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

function sameQuarter(value1,id,year,quarter){
	if(value1>0){
		$('#tdid_'+id+'_'+year+'_'+quarter).css('background-color','#462fb7'); 
	}else{
	    $('#tdid_'+id+'_'+year+'_'+quarter).css('background-color','#ffae00'); 
	}
}

</script>
</html>
 