<%@page import="com.ibm.icu.text.DecimalFormat"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="java.util.*,com.vts.*,java.text.SimpleDateFormat,java.io.ByteArrayOutputStream,java.io.ObjectOutputStream"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<jsp:include page="../static/header.jsp"></jsp:include>

 

<title>Statistics List</title>
<style type="text/css">
.auditnavbar{
    box-shadow: 0px 0px 10px 0px rgba(0,0,0,0.2);
    padding: 5px 68px 3px 45px;
    background: #fff;
    /* margin: -83px 0px 0px 0px; */
    line-height: 15px;
    font-size: 14px;
    width: 100%;
}

</style>
</head>
<body>
<%
List<Object[]> StatsEmployeeList=(List<Object[]>)request.getAttribute("StatsEmployeeList");
SimpleDateFormat sdf=new SimpleDateFormat("dd-MM-yyyy");
String frmDt=(String)request.getAttribute("frmDt");
String toDt=(String)request.getAttribute("toDt");

List<Object[]> employeelist=(List<Object[]>)request.getAttribute("ds");
Long EmployeeId=(Long)request.getAttribute("EmployeeId");
String ses=(String)request.getParameter("result"); 
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
			<div class="nav navbar auditnavbar" style="background-color: white; padding: 10px;">		
					<form class="form-inline " method="POST" action="StatisticsList.htm">
						
						<label style="margin-left: 100px; margin-right: 10px;font-weight: 800">User Name: <span class="mandatory" style="color: red;">*</span></label>
					<select class="form-control form-control selectdee" id="SelectedEmpId" required="required" data-live-search="true" name="SelectedEmpId"style="margin-left: 12px;"  >
					<%if (StatsEmployeeList != null && StatsEmployeeList.size() > 0) {
					for (Object[] obj : StatsEmployeeList) {%>
					<option value=<%=obj[0]%> <%if(EmployeeId.toString().equalsIgnoreCase(obj[0].toString())) {%>selected="selected"<%} %>><%=obj[1]%>, <%=obj[2] %></option>
						<%}}%>
						</select> 
		
						<%-- <label style="margin-left: 80px; margin-right: 20px; font-weight: 800">From Date:</label>
						<input  class="form-control form-control date"  data-date-format="dd-mm-yyyy" id="datepicker1" name="Fromdate"  required="required"  style="width: 120px;"
						<%if(Fromdate!=null){%> value="<%=(Fromdate) %>" <%} %> >
							  
			
						<label style="margin-left: 20px; margin-right: 20px;font-weight: 800">To Date:</label>
						<input  class="form-control form-control" data-date-format="dd-mm-yyyy" id="datepicker3" name="Todate"  style="width: 120px;"
					 	<%if(Todate!=null){%> value="<%=(Todate) %>" <%} %>  --%> 
				   <label style="margin-left: 80px; margin-right: 20px; font-weight: 800">From Date:</label>
                   <input type="text" style="width:113px;  " class="form-control input-sm mydate" readonly="readonly" value="" id="fromdate" name="FromDate" required="required"> 
                   &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                   <label style="margin-left: 20px; margin-right: 20px;font-weight: 800">To Date:</label>
                   <input type="text" style="width:113px; " class="form-control input-sm mydate" readonly="readonly" value="" id="todate" name="ToDate" required="required"> 
				   <button type="submit" class="btn btn-primary btn-sm submit" style="margin-left: 12px;padding: 5px;" id="submit">SUBMIT</button>
			
						<input type="hidden" name="${_csrf.parameterName}"	value="${_csrf.token}" /> 
			
						<button type="submit" class="btn btn4" data-toggle="tooltip" title="" style="background-color: white; color: green;margin-left: 10rem;8" data-original-title="Refresh" formaction="UpdatetheEmployeedata.htm" formmethod="POST">
						<i class="fa fa-refresh" style="font-size: 21px" aria-hidden="true"></i>
						</button>
					
					</form>
				</div>
		
				<div class="row mb-2 mt-2">
					<div class="col-md-12" align="center">
						<div class="badge badge-info" style="padding: 8px; ">
						<h6 id="text"></h6>
						</div>
					</div>
				</div>
		</div>
    <div class="card-body bg-light ml-3 mr-3"> 
					<div class="table-responsive">
						<table
							class="table table-bordered table-hover table-striped table-condensed " id="myTable1">
							<thead>
								<tr >
									<th style="text-align: center;">SN</th>
									<th style="text-align: center;">Log Date</th>
									<th style="text-align: center;">Login Count</th>
									<th style="text-align: center;">ActionCreated</th>
									<th style="text-align: center;">Action Assigned</th>
									<th style="text-align: center;">MilestoneCount</th>
									<th style="text-align: center;">Meeting Created</th>
								</tr>
							</thead>
							<tbody>
							<%int count=0; 
							if(employeelist.size()>0){
								for(Object[]obj:employeelist){
								%>
								<tr>
								<td style="text-align: center;"><%=++count %></td>
								<td style="text-align: center;"><%if(obj[6]!=null) {%><%=sdf.format(obj[6])%><%}else {%>-<%} %></td>
								<td style="text-align: center;"><%if(obj[5]!=null) {%><%=obj[5].toString()%><%}else {%>-<%} %></td>
								<td style="text-align: center;"><%if(obj[7]!=null) {%><%=obj[7].toString()%><%}else {%>-<%} %></td>
								<td style="text-align: center;"><%if(obj[10]!=null) {%><%=obj[10].toString()%><%}else {%>-<%} %></td>
								<td style="text-align: center;"><%if(obj[8]!=null) {%><%=obj[8].toString()%><%}else {%>-<%} %></td>
								<td style="text-align: center;"><%if(obj[9]!=null) {%><%=obj[9].toString()%><%}else {%>-<%} %></td>
								</tr>
								<%} }%>
							</tbody>
							</table>
							</div>
							</div>
</body>
<script>
$(document).ready(function(){
	var dateValue1='<%=frmDt%>'.split("-");
	var dateValue2='<%=toDt%>'.split("-");
	
	var date1=dateValue1[2]+"-"+dateValue1[1]+"-"+dateValue1[0];
	var date2=dateValue2[2]+"-"+dateValue2[1]+"-"+dateValue2[0];
	
	var selectElement = document.getElementById("SelectedEmpId");
    // Get an array of selected options
    var selectedOptions = Array.from(selectElement.selectedOptions).map(option => option.text);
	console.log(selectedOptions[0]);
	$('#text').text("Activity of "+selectedOptions[0]+ " from "+date1+" to "+date2);

 var currentDate = new Date();
 var maxDate = currentDate.toISOString().split('T')[0];
	$('#fromdate').daterangepicker({
		"singleDatePicker" : true,
		"linkedCalendars" : false,
		"showCustomRangeLabel" : true,
		/* "minDate" :datearray,   */
		 "startDate" : new Date('<%=frmDt%>'),
		/* "maxDate" : new Date(maxDate), */
		"cancelClass" : "btn-default",
		showDropdowns : true,
		locale : {
			format : 'DD-MM-YYYY'
		}
	});
	$('#todate').daterangepicker({
			"singleDatePicker" : true,
			"linkedCalendars" : false,
			"showCustomRangeLabel" : true,
			"startDate" : new Date('<%=toDt%>'), 
			/* "maxDate" : new Date(maxDate),  */ 
			"cancelClass" : "btn-default",
			showDropdowns : true,
			locale : {
				format : 'DD-MM-YYYY'
			}
		});
});
$(function () {
	  $('[data-toggle="tooltip"]').tooltip()
	})
$("#myTable1").DataTable({
    "lengthMenu": [10, 25, 50, 75, 100],
     ordering: false

});	

$( "#fromdate" ).change(function() {
	
	$('#todate').daterangepicker({
		"singleDatePicker" : true,
		"linkedCalendars" : false,
		"showCustomRangeLabel" : true,
		"minDate" : $('#fromdate').val(), 
		"startDate" : new Date(),
		"cancelClass" : "btn-default",
		showDropdowns : true,
		locale : {
			format : 'DD-MM-YYYY'
		}
	});
});
if (navigator.userAgent.indexOf("Edg") !== -1) {
    alert("You are using Microsoftedge.The site will be best viewed at 1360 x 768 resolution in I.E 11+, Mozilla 70+, Google Chrome 79+");
} 
</script>

</html>