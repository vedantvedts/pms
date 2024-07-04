<%@page import="com.vts.pfms.FormatConverter"%>
<%@page import="java.util.stream.Collectors"%>
<%@page import="java.util.Arrays"%>
<%@page import="java.util.List"%>
<%@page import="java.time.LocalDate"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<jsp:include page="../static/header.jsp"></jsp:include>
<style type="text/css">
.btn1{
	border-top-left-radius: 5px !important;
	border-bottom-left-radius: 5px !important;
}

.btn2, .btn3, .btn4, .btn5{
    border-left: 1px solid black;
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
</style>
<style type="text/css">
.highcharts-figure,	.highcharts-data-table table {
	min-width: 310px;
	max-width: 800px;
}

.highcharts-data-table table {
    font-family: Verdana, sans-serif;
    border-collapse: collapse;
    border: 1px solid #ebebeb;
    margin: 10px auto;
    text-align: center;
    width: 100%;
    max-width: 500px;
}

.highcharts-data-table caption {
    padding: 1em 0;
    font-size: 1.2em;
    color: #555;
}

.highcharts-data-table th {
    font-weight: 600;
    padding: 0.5em;
}

.highcharts-data-table td,
.highcharts-data-table th,
.highcharts-data-table caption {
    padding: 0.5em;
}

.highcharts-data-table thead tr,
.highcharts-data-table tr:nth-child(even) {
    background: #f8f8f8;
}

.highcharts-data-table tr:hover {
    background: #f1f7ff;
}
</style>

<style type="text/css">
.view-table{
	border-collapse: collapse;
	width: 100%;
	/* border: 2px solid #216583; */
	padding: 10px;
    margin-top: 1.2rem;
	overflow-y: auto; 
	margin-left: 10px;
	margin-right: 10px;
	/* margin-top: -2rem; */
}

.view-table thead {
    position: sticky;
    top: 0; /* Stick the thead to the top */
    z-index: 1; /* Ensure thead is above tbody */
    background-color: #007bff;
    color: white;"
}

.view-table th, .view-table td{
	/* border: 2px solid #216583; */
	padding: 7px;
}

.table-wrapper {
    max-height: 400px; /* Set the max height for the table wrapper */
    overflow-y: auto; /* Enable vertical scrolling */
    overflow-x: hidden; 
	padding: 20px;
	background-color: #f8f9fa;
	border: 1px solid #dee2e6;
	border-radius: 5px;
}
.table-wrapper2 {
    max-height: 630px; /* Set the max height for the table wrapper */
    overflow-y: auto; /* Enable vertical scrolling */
    overflow-x: hidden; 
	padding: 20px;
	background-color: #f8f9fa;
	border: 1px solid #dee2e6;
	border-radius: 5px;
	margin-bottom: 10px;
}
.table-wrapper3 {
    max-height: 600px; /* Set the max height for the table wrapper */
    overflow-y: auto; /* Enable vertical scrolling */
    overflow-x: hidden; 
	padding: 20px;
	background-color: #f8f9fa;
	border: 1px solid #dee2e6;
	border-radius: 5px;
}


/* Firefox */
.table-wrapper, .table-wrapper2, .table-wrapper3 {
  scrollbar-width: thin;
  scrollbar-color: #007bff #f8f9fa;
}

/* Chrome, Edge, and Safari */
.table-wrapper::-webkit-scrollbar, .table-wrapper2::-webkit-scrollbar, .table-wrapper3::-webkit-scrollbar, {
  width: 12px;
}

.table-wrapper::-webkit-scrollbar-track, .table-wrapper2::-webkit-scrollbar-track, .table-wrapper3::-webkit-scrollbar-track {
  background: #f8f9fa;
  border-radius: 5px;
}

.table-wrapper::-webkit-scrollbar-thumb, .table-wrapper2::-webkit-scrollbar-thumb, .table-wrapper3::-webkit-scrollbar-thumb {
  background-color: #007bff;
  border-radius: 5px;
  border: 2px solid #f8f9fa;
}

.custom-scrollbar::-webkit-scrollbar-thumb:hover {
  background-color: #0056b3;
}

</style>
</head>
<body >
	<%
		String loginType = (String)session.getAttribute("LoginType");
		String sesEmpId = ((Long)session.getAttribute("EmpId")).toString();
		List<Object[]> empList = (List<Object[]>)request.getAttribute("empList");
		List<Object[]> projectList = (List<Object[]>)request.getAttribute("projectList");
		List<Object[]> holidayList = (List<Object[]>)request.getAttribute("holidayList");
		
		if(!Arrays.asList("A","Z","Y").contains(loginType)){
			empList = empList!=null?empList.stream()
					  .filter(e -> sesEmpId.equalsIgnoreCase(e[3]!=null?e[3].toString():"0") || sesEmpId.equalsIgnoreCase(e[0].toString()))
					  .collect(Collectors.toList())
					  : empList;
		}
		LocalDate today = LocalDate.now();
		String fromDate = today.minusMonths(1).toString();
		String fromDate2 = today.withDayOfMonth(1).toString();
		String fromDate3 = today.getYear()+"-01-01";
		String toDate = today.toString();
		
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
			<div class="col-md-9">
			</div>
			<div class="col-md-3">
				<!-- ----------- COMMON TOGGLE BUTTONS(PROJECT, INDIVIDUAL) STARTS --------------------------- --> 	
			   	<div style="float: right;padding:5px;margin-top:-10px;">
			  		<div class="btn-group "> 
			        	<button class="btn btn1 font-weight-bold">Project</button>
			        	<button class="btn btn2 font-weight-bold" style="">Individual</button>
			        	<button class="btn btn3 font-weight-bold" style="">Others</button>
			        	<button class="btn btn4 font-weight-bold" style="">Extra Hrs</button>
			        	<button class="btn btn5 font-weight-bold" style="">Extra Days</button>
			    	</div>
			  	</div>	
				<!-- ----------- COMMON TOGGLE BUTTONS(PROJECT, INDIVIDUAL) ENDS --------------------------- -->
			</div>
		</div>
		<!-- Project Statistics -->
		<div id="projectstats">
			<div class="row">
				<div class="col-md-12">
					<!-- ------------------------- Project ------------------------------  -->
					<div class="row">
						<div class="col-md-12">
							<form action="#">
								<div class="row">
									<div class="col-md-12">
										<div class="card " id="project-attributes" style="margin: 0px 0px 5px; background-color: rgba(0, 0, 0, 0.1) !important;">
											<div class="card-body" style="padding: 0px !important">
												<table style="width: 100%;border-collapse: collapse;">
													<tr>
														<td style="width: 24%;"></td>
														<th class="right" style="width: 5%;">From :</th>
														<td style="width: 8%;"><input type="text" class="form-control" name="fromDate" id="aapFromDate" value="<%=fc.sdfTordf(fromDate)%>"></td>
														<th class="right" style="width: 5%;">To :</th>
														<td style="width: 8%;"><input type="text" class="form-control" name="toDate" id="aapToDate" value="<%=fc.sdfTordf(toDate)%>"></td>
														<th class="right" style="width: 5%;">Project : </th>
														<td style="width: 20%;">
															<select class="form-control selectdee" name="projectId" id="aapProjectId">
																<option value="0" selected >General</option>
													            <%for(Object[] pro: projectList ){
													            	String projectshortName=(pro[17]!=null)?" ("+pro[17].toString()+") ":"";
													            %>
																	<option value="<%=pro[0]%>" ><%=pro[4]+projectshortName %></option>
																<%} %>
															</select>
														</td>
														<th class="right" style="width: 5%;">Employee : </th>
														<td style="width: 20%;">
															<select class="form-control selectdee" name="empId" id="aapEmpId">
																<!-- <option value="" disabled="disabled" selected="selected">--Select--</option> -->
																<option value="A">All</option>
																<%
																if(empList!=null && empList.size()>0){
																for(Object[] obj : empList) {%>
																	<option value="<%=obj[0]%>" <%if(sesEmpId.equalsIgnoreCase(obj[0].toString())) {%>selected<%} %> ><%=obj[1]+", "+obj[2] %></option>
																<%} }%>
															</select>
														</td>
													</tr>
												</table>
											</div>
										</div>		
									</div>
								</div>
							</form>
						</div>
					</div>
					<!-- ------------------------- Action Analytics (Project) ------------------------------  -->
					<div class="row">
						<div class="col-md-8">
							<div id="aapcontainer" style="display:block;" ></div>
						</div>
						<div class="col-md-4">
							<div id="aapcontainer2" style="display:block;" ></div>
						</div>
					</div>
					<!-- ------------------------- Action Analytics End (Project) ------------------------------  -->
					<!-- ------------------------- Activity wise Analytics (Project) ------------------------------  -->
					<div class="row mt-2">
						<div class="col-md-8">
							<div id="awapcontainer" style="display:block;" ></div>
						</div>
						<div class="col-md-4">
							<div id="awapcontainer2" style="display:block;" ></div>
						</div>
					</div>
					<!-- ------------------------- Activity wise Analytics End (Project) ------------------------------  -->
					<!-- ------------------------- Project End------------------------------------------------------------------  -->
				</div>
			</div>
		</div>
		
		<!-- Individual Statistics -->
		<div id="individualstats">
			<div class="row">
				<div class="col-md-12">
					<!-- ------------------------- Individual ------------------------------  -->
					<div class="row">
						<div class="col-md-12">
							<form action="#">
								<div class="row">
									<div class="col-md-12">
										<div class="card " id="project-attributes" style="margin: 0px 0px 5px; background-color: rgba(0, 0, 0, 0.1) !important;">
											<div class="card-body" style="padding: 0px !important">
												<table style="width: 100%;border-collapse: collapse;">
													<tr>
														<td style="width: 24%;"></td>
														<th class="right" style="width: 5%;">From :</th>
														<td style="width: 8%;"><input type="text" class="form-control" name="fromDate" id="aaiFromDate" value="<%=fc.sdfTordf(fromDate)%>"></td>
														<th class="right" style="width: 5%;">To :</th>
														<td style="width: 8%;"><input type="text" class="form-control" name="toDate" id="aaiToDate" value="<%=fc.sdfTordf(toDate)%>"></td>
														<th class="right" style="width: 5%;">Employee : </th>
														<td style="width: 20%;">
															<select class="form-control selectdee" name="empId" id="aaiEmpId">
																<option value="" disabled="disabled" selected="selected">--Select--</option>
																<%
																if(empList!=null && empList.size()>0){
																for(Object[] obj : empList) {%>
																	<option value="<%=obj[0]%>" <%if(sesEmpId.equalsIgnoreCase(obj[0].toString())) {%>selected<%} %> ><%=obj[1]+", "+obj[2] %></option>
																<%} }%>
															</select>
														</td>
														<th class="right" style="width: 5%;">Project : </th>
														<td style="width: 20%;">
															<select class="form-control selectdee" name="projectId" id="aaiProjectId">
																<option value="A" selected>All</option>
																<option value="0">General</option>
													            <%for(Object[] pro: projectList ){
													            	String projectshortName=(pro[17]!=null)?" ("+pro[17].toString()+") ":"";
													            %>
																	<option value="<%=pro[0]%>" ><%=pro[4]+projectshortName %></option>
																<%} %>
															</select>
														</td>
													</tr>
												</table>
											</div>
										</div>		
									</div>
								</div>
							</form>
						</div>
					</div>
					<!-- ------------------------- Action Analytics (Individual) ------------------------------  -->
					<div class="row">
						<div class="col-md-8">
							<div id="aaicontainer" style="display:block;" ></div>
						</div>
						<div class="col-md-4">
							<div id="aaicontainer2" style="display:block;" ></div>
						</div>
					</div>
					<!-- ------------------------- Action Analytics End (Individual) ------------------------------  -->
					<!-- ------------------------- Activity Wise Analytics (Individual) ------------------------------  -->
					<div class="row mt-2">
						<div class="col-md-8">
							<div id="awaicontainer" style="display:block;" ></div>
						</div>
						<div class="col-md-4">
							<div id="awaicontainer2" style="display:block;" ></div>
						</div>
					</div>
					<!-- ------------------------- Activity Wise Analytics End (Individual) ------------------------------  -->
					
					<!-- ------------------------- Individual End ------------------------------------------  -->
				</div>
			</div>
		</div>
		
		<!-- Other Statistics -->
		<div id="othersstats">
			<div class="row">
				<div class="col-md-12">
					<!-- ------------------------- Project Time Sheet ------------------------------  -->
					<div class="row">
						<div class="col-md-12">
							<form action="#">
								<div class="row">
									<div class="col-md-12">
										<div class="card " id="project-attributes" style="margin: 0px 0px 5px; background-color: rgba(0, 0, 0, 0.1) !important;">
											<div class="card-body" style="padding: 0px !important">
												<table style="width: 100%;border-collapse: collapse;">
													<tr>
														<td style="width: 40%;"></td>
														<th class="right" style="width: 5%;">Project : </th>
														<td style="width: 25%;">
															<select class="form-control selectdee" name="projectId" id="ptsProjectId">
																<option value="A" selected>All</option>
																<option value="0">General</option>
													            <%for(Object[] pro: projectList ){
													            	String projectshortName=(pro[17]!=null)?" ("+pro[17].toString()+") ":"";
													            %>
																	<option value="<%=pro[0]%>"
																	data-sancdate="<%=pro[12] %>"
																	 ><%=pro[4]+projectshortName %></option>
																<%} %>
															</select>
														</td>
														<th class="right" style="width: 5%;">From :</th>
														<td style="width: 10%;"><input type="text" class="form-control" name="fromDate" id="ptsFromDate" value="<%=fc.sdfTordf(fromDate)%>"></td>
														<th class="right" style="width: 5%;">To :</th>
														<td style="width: 10%;"><input type="text" class="form-control" name="toDate" id="ptsToDate" value="<%=fc.sdfTordf(toDate)%>"></td>
													</tr>
												</table>
											</div>
										</div>		
									</div>
								</div>
							</form>
						</div>
					</div>
					<div class="row ml-1">
						<div class="col-md-8 table-wrapper">
							<table class="table table-bordered table-hover table-striped table-condensed view-table" id="ptscontainer">
								<thead class="center" >
									<tr>
										<th colspan="4" style="text-transform: uppercase;">Project Time Sheet</th>
									</tr>
									<tr>
										<th>SN</th>
										<th>Name</th>
										<th>Cadre</th>
										<th>Total Hrs</th>
									</tr>
								</thead>
								<tbody id="ptscontainertbody" class="center">
								
								</tbody>	
							</table>
						</div>
						<div class="col-md-4">
							<div id="ptscontainer2" style="display:block;" ></div>
						</div>
					</div>
					<!-- ------------------------- Project Time Sheet End ------------------------------  -->
					
				</div>
			</div>
		</div>
		
		<!-- Extra Hours Statistics -->
		<div id="extrahrsstats">
			<div class="row">
				<div class="col-md-12">
					<!-- ------------------------- Time Sheet List -------------------------------------  -->
					<div class="row mt-2">
						<div class="col-md-12">
							<form action="#">
								<div class="row">
									<div class="col-md-12">
										<div class="card " id="project-attributes" style="margin: 0px 0px 5px; background-color: rgba(0, 0, 0, 0.1) !important;">
											<div class="card-body" style="padding: 0px !important">
												<table style="width: 100%;border-collapse: collapse;">
													<tr>
														<td style="width: 70%;"></td>
														<th class="right" style="width: 5%;">From :</th>
														<td style="width: 10%;"><input type="text" class="form-control" name="fromDate" id="tslFromDate" value="<%=fc.sdfTordf(fromDate)%>"></td>
														<th class="right" style="width: 5%;">To :</th>
														<td style="width: 10%;"><input type="text" class="form-control" name="toDate" id="tslToDate" value="<%=fc.sdfTordf(toDate)%>"></td>
													</tr>
												</table>
											</div>
										</div>		
									</div>
								</div>
							</form>
						</div>
					</div>
					<div class="row ml-1 mr-1">
						<div class="col-md-12 table-wrapper2">
							<table class="table table-bordered table-hover table-striped table-condensed view-table" id="tslcontainer">
								<thead class="center">
									<tr>
										<th style="font-size: 16px;color: white;" colspan="7">Time Sheet List</th>
									</tr>
									<tr>
										<th>SN</th>
										<th>Name</th>
										<!-- <th>Cadre</th> -->
										<th>Total Hrs</th>
										<th>No of Deficit</th>
										<th>Deficit Hrs</th>
										<th>No of Extra Hrs</th>
										<th>Extra Hrs</th>
									</tr>
								</thead>
								<tbody id="tslcontainertbody" class="center">
								
								</tbody>	
							</table>
						</div>
						
					</div>
					
					<!-- ------------------------- Time Sheet List End ------------------------------------------  -->
				</div>
			</div>
		</div>
		
		<!-- Extra Days Statistics -->
		<div id="extradaysstats">
			<div class="row">
				<div class="col-md-12">
					<!-- ------------------------- Time Sheet Extra Days List -------------------------------------  -->
					<div class="row mt-2">
						<div class="col-md-12">
							<form action="#">
								<div class="row">
									<div class="col-md-6">
										
									</div>
									<div class="col-md-6">
										<div class="card " id="project-attributes" style="margin: 0px 0px 5px; background-color: rgba(0, 0, 0, 0.1) !important;">
											<div class="card-body" style="padding: 0px !important">
												<table style="width: 100%;border-collapse: collapse;">
													<tr>
														<td style="width: 15%;"></td>
														<th class="right" style="width: 6%;">From :</th>
														<td style="width: 15%;"><input type="text" class="form-control" name="fromDate" id="tsl2FromDate" value="<%=fc.sdfTordf(fromDate3)%>"></td>
														<th class="right" style="width: 5%;">To :</th>
														<td style="width: 15%;"><input type="text" class="form-control" name="toDate" id="tsl2ToDate" value="<%=fc.sdfTordf(toDate)%>"></td>
														<th class="right" style="width: 10%;">Employee : </th>
														<td style="width: 39%;">
															<select class="form-control selectdee" name="empId" id="tsl2EmpId">
																<%
																if(empList!=null && empList.size()>0){
																for(Object[] obj : empList) {%>
																	<option value="<%=obj[0]%>" <%if(sesEmpId.equalsIgnoreCase(obj[0].toString())) {%>selected<%} %> ><%=obj[1]+", "+obj[2] %></option>
																<%} }%>
															</select>
														</td>
													</tr>
												</table>
											</div>
										</div>		
									</div>
									
								</div>
							</form>
						</div>
					</div>
					<div class="row ml-1 mr-1">
						<div class="col-md-6">
						</div>
						<div class="col-md-6 table-wrapper3">
							<table class="table table-bordered table-hover table-striped table-condensed view-table" id="tslcontainer2">
								<thead class="center">
									<tr>
										<th style="font-size: 16px;color: white;" colspan="4">Extra Days</th>
									</tr>
									<tr>
										<th>SN</th>
										<th>Date</th>
										<th>Day</th>
										<th>No of Hrs</th>
									</tr>
								</thead>
								<tbody id="tslcontainer2tbody" class="center">
								
								</tbody>	
							</table>
						</div>
						
					</div>
					
					<!-- ------------------------- Time Sheet Extra Days List End ------------------------------------------  -->
				</div>
			</div>
		</div>
		
	</div>

<script type="text/javascript">

var tab1 = 0;
var tab2 = 0;
var tab3 = 0;
var tab4 = 0;
var tab5 = 0;

$(document).ready(function(){
	$('.btn1').click();
});
$('.btn-toggle').click(function() {
	
    $(this).find('.btn').toggleClass('active');  
    
    if ($(this).find('.btn-success').length>0) {
    	
    	$(this).find('.btn').toggleClass('btn-success');
    }
    
    $(this).find('.btn').toggleClass('btn-default');
    
    
});

$('.btn1').click(function(){
	$('.btn1').css('background-color','green');
	$('.btn1').css('color','white');
	$('.btn2').css('background-color','white');
	$('.btn2').css('color','black');
	$('.btn3').css('background-color','white');
	$('.btn3').css('color','black');
	$('.btn4').css('background-color','white');
	$('.btn4').css('color','black');
	$('.btn5').css('background-color','white');
	$('.btn5').css('color','black');
	
	$('#projectstats').show();
	$('#individualstats').hide();
	$('#othersstats').hide();
	$('#extrahrsstats').hide();
	$('#extradaysstats').hide();
	
	tab1+=1;
	if(tab1<2){
		getProjectActionAnalyticsCount();
		getProjectActivityWiseAnalyticsCount();
	}
	
});

$('.btn2').click(function(){
	$('.btn1').css('background-color','white');
	$('.btn1').css('color','black');
	$('.btn2').css('background-color','green');
	$('.btn2').css('color','white');
	$('.btn3').css('background-color','white');
	$('.btn3').css('color','black');
	$('.btn4').css('background-color','white');
	$('.btn4').css('color','black');
	$('.btn5').css('background-color','white');
	$('.btn5').css('color','black');
	
	$('#projectstats').hide();
	$('#individualstats').show();
	$('#othersstats').hide();
	$('#extrahrsstats').hide();
	$('#extradaysstats').hide();
	
	tab2+=1;
	if(tab2<2){
		getEmpActionAnalyticsCount();
		getEmpActivityWiseAnalyticsCount();
	}
});

$('.btn3').click(function(){
	$('.btn1').css('background-color','white');
	$('.btn1').css('color','black');
	$('.btn2').css('background-color','white');
	$('.btn2').css('color','black');
	$('.btn3').css('background-color','green');
	$('.btn3').css('color','white');
	$('.btn4').css('background-color','white');
	$('.btn4').css('color','black');
	$('.btn5').css('background-color','white');
	$('.btn5').css('color','black');
	
	$('#projectstats').hide();
	$('#individualstats').hide();
	$('#othersstats').show();
	$('#extrahrsstats').hide();
	$('#extradaysstats').hide();
	
	tab3+=1;
	if(tab3<2){
		getProjectTimeSheetWorkingHrsList();
	}
});

$('.btn4').click(function(){
	$('.btn1').css('background-color','white');
	$('.btn1').css('color','black');
	$('.btn2').css('background-color','white');
	$('.btn2').css('color','black');
	$('.btn3').css('background-color','white');
	$('.btn3').css('color','black');
	$('.btn4').css('background-color','green');
	$('.btn4').css('color','white');
	$('.btn5').css('background-color','white');
	$('.btn5').css('color','black');
	
	$('#projectstats').hide();
	$('#individualstats').hide();
	$('#othersstats').hide();
	$('#extrahrsstats').show();
	$('#extradaysstats').hide();
	
	tab4+=1;
	if(tab4<2){
		getEmpTimeSheetWorkingHrsList();
	}
});

$('.btn5').click(function(){
	$('.btn1').css('background-color','white');
	$('.btn1').css('color','black');
	$('.btn2').css('background-color','white');
	$('.btn2').css('color','black');
	$('.btn3').css('background-color','white');
	$('.btn3').css('color','black');
	$('.btn4').css('background-color','white');
	$('.btn4').css('color','black');
	$('.btn5').css('background-color','green');
	$('.btn5').css('color','white');
	
	$('#projectstats').hide();
	$('#individualstats').hide();
	$('#othersstats').hide();
	$('#extrahrsstats').hide();
	$('#extradaysstats').show();
	
	tab5+=1;
	if(tab5<2){
		getEmpExtraWorkingDayList();
	}
});
</script>

<script type="text/javascript">

$(document).ready(function() {
	
	/* ------------------------- Action / Activitywise Analytics (Individual) ---------------------------- */
	$('#aaiFromDate').daterangepicker({
		"singleDatePicker" : true,
		"linkedCalendars" : false,
		"showCustomRangeLabel" : true,	
		"cancelClass" : "btn-default",
		/* "minDate" : tomorrow, */
		showDropdowns : true,
		locale : {
			format : 'DD-MM-YYYY'
		}
	});

	$('#aaiToDate').daterangepicker({
		"singleDatePicker" : true,
		"linkedCalendars" : false,
		"showCustomRangeLabel" : true,
		"minDate" :$('#aaiFromDate').val(),
		"cancelClass" : "btn-default",
		showDropdowns : true,
		locale : {
			format : 'DD-MM-YYYY'
		}
	});
	
	/* ------------------------- Action / Activitywise Analytics End (Individual) ---------------------------- */
	
	/* ------------------------- Action / Activitywise Analytics (Project) ------------------------------ */
	$('#aapFromDate').daterangepicker({
		"singleDatePicker" : true,
		"linkedCalendars" : false,
		"showCustomRangeLabel" : true,	
		"cancelClass" : "btn-default",
		/* "minDate" : tomorrow, */
		showDropdowns : true,
		locale : {
			format : 'DD-MM-YYYY'
		}
	});
	
	$('#aapToDate').daterangepicker({
		"singleDatePicker" : true,
		"linkedCalendars" : false,
		"showCustomRangeLabel" : true,
		"minDate" :$('#aapFromDate').val(),
		"cancelClass" : "btn-default",
		showDropdowns : true,
		locale : {
			format : 'DD-MM-YYYY'
		}
	});
	
	/* ------------------------- Action / Activitywise Analytics End (Project) ------------------------------ */
	
	/* ------------------------- Project Time Sheet ------------------------------ */
	$('#ptsFromDate').daterangepicker({
		"singleDatePicker" : true,
		"linkedCalendars" : false,
		"showCustomRangeLabel" : true,	
		"cancelClass" : "btn-default",
		/* "minDate" : tomorrow, */
		showDropdowns : true,
		locale : {
			format : 'DD-MM-YYYY'
		}
	});
	
	$('#ptsToDate').daterangepicker({
		"singleDatePicker" : true,
		"linkedCalendars" : false,
		"showCustomRangeLabel" : true,
		"minDate" :$('#ptsFromDate').val(),
		"cancelClass" : "btn-default",
		showDropdowns : true,
		locale : {
			format : 'DD-MM-YYYY'
		}
	});
	
	/* ------------------------- Project Time Sheet End ------------------------------ */
	
	/* ------------------------- Time Sheet List ------------------------------ */
	$('#tslFromDate').daterangepicker({
		"singleDatePicker" : true,
		"linkedCalendars" : false,
		"showCustomRangeLabel" : true,	
		"cancelClass" : "btn-default",
		/* "minDate" : tomorrow, */
		showDropdowns : true,
		locale : {
			format : 'DD-MM-YYYY'
		}
	});
	
	$('#tslToDate').daterangepicker({
		"singleDatePicker" : true,
		"linkedCalendars" : false,
		"showCustomRangeLabel" : true,
		"minDate" :$('#tslFromDate').val(),
		"cancelClass" : "btn-default",
		showDropdowns : true,
		locale : {
			format : 'DD-MM-YYYY'
		}
	});
	
	/* ------------------------- Time Sheet List End ------------------------------ */
	
	/* ------------------------- Time Sheet List2 (Extra Days) ------------------------------ */
	$('#tsl2FromDate').daterangepicker({
		"singleDatePicker" : true,
		"linkedCalendars" : false,
		"showCustomRangeLabel" : true,	
		"cancelClass" : "btn-default",
		/* "minDate" : tomorrow, */
		showDropdowns : true,
		locale : {
			format : 'DD-MM-YYYY'
		}
	});
	
	$('#tsl2ToDate').daterangepicker({
		"singleDatePicker" : true,
		"linkedCalendars" : false,
		"showCustomRangeLabel" : true,
		"minDate" :$('#tsl2FromDate').val(),
		"cancelClass" : "btn-default",
		showDropdowns : true,
		locale : {
			format : 'DD-MM-YYYY'
		}
	});
	
	/* ------------------------- Time Sheet List2 End (Extra Days) ------------------------------ */
	
	
	// Radialize the colors
	Highcharts.setOptions({
	    colors: Highcharts.map(Highcharts.getOptions().colors, function (color) {
	        return {
	            radialGradient: {
	                cx: 0.5,
	                cy: 0.3,
	                r: 0.7
	            },
	            stops: [
	                [0, color],
	                [1, Highcharts.color(color).brighten(-0.3).get('rgb')] // darken
	            ]
	        };
	    })
	});
	
	
});



/* ------------------------- Action / Activitywise Analytics (Individual) ---------------------------- */

$( "#aaiFromDate" ).change(function() {
	
	$('#aaiToDate').daterangepicker({
		"singleDatePicker" : true,
		"linkedCalendars" : false,
		"showCustomRangeLabel" : true,
		"minDate" : $('#aaiFromDate').val(), 
		/* "startDate" : new Date(), */
		"cancelClass" : "btn-default",
		showDropdowns : true,
		locale : {
			format : 'DD-MM-YYYY'
		}
	});
	getEmpActionAnalyticsCount();
	getEmpActivityWiseAnalyticsCount();
});

/* ------------------------- Action / Activitywise Analytics End (Individual) ---------------------------- */

/* ------------------------- Action / Activitywise Analytics (Project) ------------------------------ */

$( "#aapFromDate" ).change(function() {
	
	$('#aapToDate').daterangepicker({
		"singleDatePicker" : true,
		"linkedCalendars" : false,
		"showCustomRangeLabel" : true,
		"minDate" : $('#aapFromDate').val(), 
		/* "startDate" : new Date(), */
		"cancelClass" : "btn-default",
		showDropdowns : true,
		locale : {
			format : 'DD-MM-YYYY'
		}
	});
	
	getProjectActionAnalyticsCount();
	getProjectActivityWiseAnalyticsCount();
});

/* ------------------------- Action / Activitywise End (Project) ------------------------------ */

/* ------------------------- Project Time Sheet ------------------------------ */

$( "#ptsFromDate" ).change(function() {
	
	$('#ptsToDate').daterangepicker({
		"singleDatePicker" : true,
		"linkedCalendars" : false,
		"showCustomRangeLabel" : true,
		"minDate" : $('#ptsFromDate').val(), 
		/* "startDate" : new Date(), */
		"cancelClass" : "btn-default",
		showDropdowns : true,
		locale : {
			format : 'DD-MM-YYYY'
		}
	});
	
	getProjectTimeSheetWorkingHrsList();
});

/* ------------------------- Project Time Sheet End ------------------------------ */

/* ------------------------- Time Sheet List ------------------------------ */

$( "#tslFromDate" ).change(function() {
	
	$('#tslToDate').daterangepicker({
		"singleDatePicker" : true,
		"linkedCalendars" : false,
		"showCustomRangeLabel" : true,
		"minDate" : $('#tslFromDate').val(), 
		/* "startDate" : new Date(), */
		"cancelClass" : "btn-default",
		showDropdowns : true,
		locale : {
			format : 'DD-MM-YYYY'
		}
	});
	
	getEmpTimeSheetWorkingHrsList();
});

/* ------------------------- Time Sheet List End ------------------------------ */

/* ------------------------- Time Sheet List2 (Extra Days) ------------------------------ */

$( "#tsl2FromDate" ).change(function() {
	
	$('#tsl2ToDate').daterangepicker({
		"singleDatePicker" : true,
		"linkedCalendars" : false,
		"showCustomRangeLabel" : true,
		"minDate" : $('#tsl2FromDate').val(), 
		/* "startDate" : new Date(), */
		"cancelClass" : "btn-default",
		showDropdowns : true,
		locale : {
			format : 'DD-MM-YYYY'
		}
	});
	
	getEmpExtraWorkingDayList();
});

/* ------------------------- Time Sheet List2 End (Extra Days) ------------------------------ */




/* ------------------------------------- Action Analytics (Individual) ---------------------------------- */
$('#aaiToDate,#aaiEmpId,#aaiProjectId').change(function(){
	getEmpActionAnalyticsCount();
	getEmpActivityWiseAnalyticsCount();
});

function getEmpActionAnalyticsCount(){
	$.ajax({
		Type:'GET',
		url:'EmpActionAnalyticsCount.htm',
		datatype:'json',
		data:{
			fromDate : $('#aaiFromDate').val(),
			toDate : $('#aaiToDate').val(),
			empId : $('#aaiEmpId').val(),
			projectId : $('#aaiProjectId').val(),
		},
		success:function(result){
			var values = JSON.parse(result);
			
			/* ---------------------------------- Action Analytics (In Bar Graph) (Individual) --------------------------------------- */
			Highcharts.chart('aaicontainer', {
			    chart: {
			        type: 'column',
			        /* inverted: true  */
			    },
			    title: {
			        text: 'Action Analytics'
			    },
			    xAxis: {
			        categories: ['Completed', 'Ongoing', 'Not Started']
			    },
			    yAxis: {
			        min: 0,
			        title: {
			            text: 'Count'
			        },
			        allowDecimals: false // Disallow decimal increments
			    },
			    series: [{
			        name: 'Within time',
			        data: [
			            { y: values[0], color: 'green' }, // Completed
			            { y: values[2], color: '#FDD835' }, // Ongoing
			            { y: values[4], color: '#EF5350' }   // Not Started
			        ],
			        dataLabels: {
			            enabled: true, // Enable data labels
			            inside: false, // Position the label outside of the bar
			            verticalAlign: 'bottom', // Align at the bottom (top of the bar in inverted mode)
			            y: -10 // Adjust the position
			        }
			    }, {
			        name: 'Delayed',
			        data: [
			            { y: values[1], color: 'lightgreen' }, // Completed
			            { y: values[3], color: '#feb204' },  // Ongoing
			            { y: values[5], color: '#FF0000' }   // Not Started
			        ],
			        dataLabels: {
			            enabled: true, // Enable data labels
			            inside: false, // Position the label outside of the bar
			            verticalAlign: 'bottom', // Align at the bottom (top of the bar in inverted mode)
			            y: -10 // Adjust the position
			        }
			    }],
			    credits: {
			        enabled: false
			    },
			    responsive: {
			        rules: [{
			            condition: {
			                maxWidth: 500
			            },
			            // Make the labels less space demanding on mobile
			            chartOptions: {
			                xAxis: {
			                    labels: {
			                        formatter: function () {
			                            return this.value.charAt(0);
			                        }
			                    }
			                },
			                yAxis: {
			                    labels: {
			                        align: 'left',
			                        x: 0,
			                        y: -2
			                    },
			                    title: {
			                        text: ''
			                    }
			                }
			            }
			        }]
			    }
			});
			
			/* ---------------------------------- Action Analytics (In Bar Graph) End (Individual) --------------------------------------- */
			/* --------------------------- Action Analytics (In Pie Chart) (Project) ------------------------------ */
			
			Highcharts.chart('aaicontainer2', {
			    chart: {
			        plotBackgroundColor: null,
			        plotBorderWidth: null,
			        plotShadow: false,
			        type: 'pie',

			    },
			    title: {
			        text: 'Missed Actions'
			    },
			    tooltip: {
			    	pointFormat: '{series.name}: <b>{point.y} </b>'
			    },
			    
			    plotOptions: {
			        pie: {
			            allowPointSelect: true,
			            cursor: 'pointer',
			            dataLabels: {
			                enabled: true,
			                format: '<b>{point.name}</b>: {point.y} ',
			                connectorColor: 'silver'
			                
			            },
			        }
			    },
			    series: [{
			        name: 'Hours',
			        data: [
			        	{
				        	name: 'On Time',
		                    y: values[6],
		                	color: Highcharts.getOptions().colors[2],
			        	},
			        	{
				        	name: 'Missed',
		                    y: values[7],
		                	color: Highcharts.getOptions().colors[5],
				        },
			        ]
			    }],
			    credits: {
		            enabled: false
		        },
		        responsive: {
		            rules: [{
		                condition: {
		                    maxWidth: 500
		                },
		                // Make the labels less space demanding on mobile
		                chartOptions: {
		                    xAxis: {
		                        labels: {
		                            formatter: function () {
		                                return this.value.charAt(0);
		                            }
		                        }
		                    },
		                    yAxis: {
		                        labels: {
		                            align: 'left',
		                            x: 0,
		                            y: -2
		                        },
		                        title: {
		                            text: ''
		                        }
		                    }
		                }
		            }]
		        }
			});
			
			/* --------------------------- Action Analytics (In Pie Chart) End (Project) ------------------------------ */
		}
	});
	
}

/* ------------------------------------- Action Analytics End (Individual) ---------------------------------- */

/* ----------------------------------------------- Activitywise Analytics (Individual) ----------------------------- */

function getEmpActivityWiseAnalyticsCount(){
	$.ajax({
		Type:'GET',
		url:'EmpActivityWiseAnalyticsCount.htm',
		datatype:'json',
		data:{
			fromDate : $('#aaiFromDate').val(),
			toDate : $('#aaiToDate').val(),
			empId : $('#aaiEmpId').val(),
			projectId : $('#aaiProjectId').val(),
		},
		success:function(result){
			var values = JSON.parse(result);
			
			var categories = values.map(function(item) {
				return item[7] != null ? item[7] : "-";
			});
			
            var data = values.map(function(item) {
                var timeString = item[8] != null ? item[8] : '00:00:00';
                return convertTimeStringToHours(timeString);
            });
			
			/* --------------------------- Activity Wise Analytics (In Bar Graph) (Individual)------------------------------------- */
			Highcharts.chart('awaicontainer', {
			    chart: {
			        type: 'column',
			    },
			    title: {
			        text: 'Activity wise Analytics'
			    },
			    xAxis: {
			        categories: categories
			    },
			    yAxis: {
			        min: 0,
			        title: {
			            text: 'No of Hours'
			        },
			        allowDecimals: false // Disallow decimal increments
			    },
			    colors: [
			        '#187498',
			    ], 
			      series: [{
			        type: 'column',
			        name: 'Activities',
			        data: data,
			        dataLabels: {
			            enabled: true, // Enable data labels
			            inside: false, // Position the label outside of the bar
			            verticalAlign: 'bottom', // Align at the bottom (top of the bar in inverted mode)
			            y: -10 // Adjust the position
			        }
			    }
			    
			    ],
			    credits: {
			        enabled: false
			    },
			    responsive: {
			        rules: [{
			            condition: {
			                maxWidth: 500
			            },
			            chartOptions: {
			                xAxis: {
			                    labels: {
			                        formatter: function () {
			                            return this.value.charAt(0);
			                        }
			                    }
			                },
			                yAxis: {
			                    labels: {
			                        align: 'left',
			                        x: 0,
			                        y: -2
			                    },
			                    title: {
			                        text: ''
			                    }
			                }
			            }
			        }]
			    }
			});
			
			/* ----------------------- Activity Wise Analytics (In Bar Graph) End (Individual) -------------------------- */
			
			/* --------------------------- Activity Wise Analytics (In Pie Chart) (Individual) ------------------------------------- */
			
			var pieData = categories.map(function(category, index) {
                return {
                    name: category,
                    y: data[index],
                	color: Highcharts.getOptions().colors[index],
                };
            });
			
			Highcharts.chart('awaicontainer2', {
			    chart: {
			        plotBackgroundColor: null,
			        plotBorderWidth: null,
			        plotShadow: false,
			        type: 'pie',

			    },
			    title: {
			        text: 'Activity wise Analytics'
			    },
			    tooltip: {
			    	pointFormat: '{series.name}: <b>{point.y} </b>'
			    },
			    
			    plotOptions: {
			        pie: {
			            allowPointSelect: true,
			            cursor: 'pointer',
			            dataLabels: {
			                enabled: true,
			                format: '<b>{point.name}</b>: {point.y} ',
			                connectorColor: 'silver'
			                
			            },
			        }
			    },
			    series: [{
			        name: 'Hours',
			        data: pieData
			    }],
			    credits: {
		            enabled: false
		        },
		        responsive: {
		            rules: [{
		                condition: {
		                    maxWidth: 500
		                },
		                // Make the labels less space demanding on mobile
		                chartOptions: {
		                    xAxis: {
		                        labels: {
		                            formatter: function () {
		                                return this.value.charAt(0);
		                            }
		                        }
		                    },
		                    yAxis: {
		                        labels: {
		                            align: 'left',
		                            x: 0,
		                            y: -2
		                        },
		                        title: {
		                            text: ''
		                        }
		                    }
		                }
		            }]
		        }
			});
			
			/* --------------------------- Activity Wise Analytics (In Pie Chart) End (Individual) ------------------------------------- */
		}
	});
}

/* ----------------------------------------------- Activitywise Analytics End (Individual) ----------------------------- */

/* ----------------------------------------------- Activitywise Analytics (Project) ----------------------------- */
/* $('#awapFromDate,#awapToDate,#awapProjectId').change(function(){
	getProjectActivityWiseAnalyticsCount();
}); */

function getProjectActivityWiseAnalyticsCount(){

	$.ajax({
		Type:'GET',
		url:'ProjectActivityWiseAnalyticsCount.htm',
		datatype:'json',
		data:{
			fromDate : $('#aapFromDate').val(),
			toDate : $('#aapToDate').val(),
			projectId : $('#aapProjectId').val(),
			empId : $('#aapEmpId').val(),
		},
		success:function(result){
			var values = JSON.parse(result);
			
			var categories = values.map(function(item) {
				return item[7] != null ? item[7] : "-";
			});
			
            var data = values.map(function(item) {
                var timeString = item[8] != null ? item[8] : '00:00:00';
                return convertTimeStringToHours(timeString);
            });
			
			/* --------------------------- Activity Wise Analytics (In Bar Graph) (Project)------------------------------------- */
			Highcharts.chart('awapcontainer', {
			    chart: {
			        type: 'column',
			    },
			    title: {
			        text: 'Activity wise Analytics'
			    },
			    xAxis: {
			        categories: categories
			    },
			    yAxis: {
			        min: 0,
			        title: {
			            text: 'No of Hours'
			        },
			        allowDecimals: false // Disallow decimal increments
			    },
			    colors: [
			        '#187498',
			    ], 
			      series: [{
			        type: 'column',
			        name: 'Activities',
			        data: data,
			        dataLabels: {
			            enabled: true, // Enable data labels
			            inside: false, // Position the label outside of the bar
			            verticalAlign: 'bottom', // Align at the bottom (top of the bar in inverted mode)
			            y: -10 // Adjust the position
			        }
			    }
			    
			    ],
			    credits: {
			        enabled: false
			    },
			    responsive: {
			        rules: [{
			            condition: {
			                maxWidth: 500
			            },
			            chartOptions: {
			                xAxis: {
			                    labels: {
			                        formatter: function () {
			                            return this.value.charAt(0);
			                        }
			                    }
			                },
			                yAxis: {
			                    labels: {
			                        align: 'left',
			                        x: 0,
			                        y: -2
			                    },
			                    title: {
			                        text: ''
			                    }
			                }
			            }
			        }]
			    }
			});
			
			/* ----------------------- Activity Wise Analytics (In Bar Graph) End (Project) -------------------------- */
			
			/* --------------------------- Activity Wise Analytics (In Pie Chart) (Project) ------------------------------------- */
			
			var pieData = categories.map(function(category, index) {
                return {
                    name: category,
                    y: data[index],
                	color: Highcharts.getOptions().colors[index],
                };
            });
			
			Highcharts.chart('awapcontainer2', {
			    chart: {
			        plotBackgroundColor: null,
			        plotBorderWidth: null,
			        plotShadow: false,
			        type: 'pie',

			    },
			    title: {
			        text: 'Activity wise Analytics'
			    },
			    tooltip: {
			    	pointFormat: '{series.name}: <b>{point.y} </b>'
			    },
			    
			    plotOptions: {
			        pie: {
			            allowPointSelect: true,
			            cursor: 'pointer',
			            dataLabels: {
			                enabled: true,
			                format: '<b>{point.name}</b>: {point.y} ',
			                connectorColor: 'silver'
			                
			            },
			        }
			    },
			    series: [{
			        name: 'Hours',
			        data: pieData
			    }],
			    credits: {
		            enabled: false
		        },
		        responsive: {
		            rules: [{
		                condition: {
		                    maxWidth: 500
		                },
		                // Make the labels less space demanding on mobile
		                chartOptions: {
		                    xAxis: {
		                        labels: {
		                            formatter: function () {
		                                return this.value.charAt(0);
		                            }
		                        }
		                    },
		                    yAxis: {
		                        labels: {
		                            align: 'left',
		                            x: 0,
		                            y: -2
		                        },
		                        title: {
		                            text: ''
		                        }
		                    }
		                }
		            }]
		        }
			});
			
			/* --------------------------- Activity Wise Analytics (In Pie Chart) End (Project) ------------------------------------- */
		}
	});
}

/* ----------------------------------------------- Activitywise Analytics End (Project) ----------------------------- */

/* ------------------------------------- Action Analytics (Project) ---------------------------------- */
$('#aapToDate,#aapProjectId,#aapEmpId').change(function(){
	getProjectActionAnalyticsCount();
	getProjectActivityWiseAnalyticsCount();
});

function getProjectActionAnalyticsCount(){
	
	$.ajax({
		Type:'GET',
		url:'ProjectActionAnalyticsCount.htm',
		datatype:'json',
		data:{
			fromDate : $('#aapFromDate').val(),
			toDate : $('#aapToDate').val(),
			projectId : $('#aapProjectId').val(),
			empId : $('#aapEmpId').val(),
		},
		success:function(result){
			var values = JSON.parse(result);
			
			/* ----------------------------- Action Analytics (In Bar Graph) (Project) ------------------------------- */
			Highcharts.chart('aapcontainer', {
			    chart: {
			        type: 'column',
			    },
			    title: {
			        text: 'Action Analytics'
			    },
			    xAxis: {
			        categories: ['Completed', 'Ongoing', 'Not Started']
			    },
			    yAxis: {
			        min: 0,
			        title: {
			            text: 'Count'
			        },
			        allowDecimals: false // Disallow decimal increments
			    },
			    series: [{
			        name: 'Within time',
			        data: [
			            { y: values[0], color: 'green' }, // Completed
			            { y: values[2], color: '#FDD835' }, // Ongoing
			            { y: values[4], color: '#EF5350' }   // Not Started
			        ],
			        dataLabels: {
			            enabled: true, // Enable data labels
			            inside: false, // Position the label outside of the bar
			            verticalAlign: 'bottom', // Align at the bottom (top of the bar in inverted mode)
			            y: -10 // Adjust the position
			        }
			    }, {
			        name: 'Delayed',
			        data: [
			            { y: values[1], color: 'lightgreen' }, // Completed
			            { y: values[3], color: '#feb204' },  // Ongoing
			            { y: values[5], color: '#FF0000' }   // Not Started
			        ],
			        dataLabels: {
			            enabled: true, // Enable data labels
			            inside: false, // Position the label outside of the bar
			            verticalAlign: 'bottom', // Align at the bottom (top of the bar in inverted mode)
			            y: -10 // Adjust the position
			        }
			    }],
			    credits: {
			        enabled: false
			    },
			    responsive: {
			        rules: [{
			            condition: {
			                maxWidth: 500
			            },
			            // Make the labels less space demanding on mobile
			            chartOptions: {
			                xAxis: {
			                    labels: {
			                        formatter: function () {
			                            return this.value.charAt(0);
			                        }
			                    }
			                },
			                yAxis: {
			                    labels: {
			                        align: 'left',
			                        x: 0,
			                        y: -2
			                    },
			                    title: {
			                        text: ''
			                    }
			                }
			            }
			        }]
			    }
			});
			
			/* ----------------------------- Action Analytics (In Bar Graph) End (Project) ------------------------------- */
			/* --------------------------- Action Analytics (In Pie Chart) (Project) ------------------------------ */
			
			Highcharts.chart('aapcontainer2', {
			    chart: {
			        plotBackgroundColor: null,
			        plotBorderWidth: null,
			        plotShadow: false,
			        type: 'pie',

			    },
			    title: {
			        text: 'Missed Actions'
			    },
			    tooltip: {
			    	pointFormat: '{series.name}: <b>{point.y} </b>'
			    },
			    
			    plotOptions: {
			        pie: {
			            allowPointSelect: true,
			            cursor: 'pointer',
			            dataLabels: {
			                enabled: true,
			                format: '<b>{point.name}</b>: {point.y} ',
			                connectorColor: 'silver'
			                
			            },
			        }
			    },
			    series: [{
			        name: 'Hours',
			        data: [
			        	{
				        	name: 'On Time',
		                    y: values[6],
		                	color: Highcharts.getOptions().colors[2],
			        	},
			        	{
				        	name: 'Missed',
		                    y: values[7],
		                	color: Highcharts.getOptions().colors[5],
				        },
			        ]
			    }],
			    credits: {
		            enabled: false
		        },
		        responsive: {
		            rules: [{
		                condition: {
		                    maxWidth: 500
		                },
		                // Make the labels less space demanding on mobile
		                chartOptions: {
		                    xAxis: {
		                        labels: {
		                            formatter: function () {
		                                return this.value.charAt(0);
		                            }
		                        }
		                    },
		                    yAxis: {
		                        labels: {
		                            align: 'left',
		                            x: 0,
		                            y: -2
		                        },
		                        title: {
		                            text: ''
		                        }
		                    }
		                }
		            }]
		        }
			});
			
			/* --------------------------- Action Analytics (In Pie Chart) End (Project) ------------------------------ */
		}
	});
	
}

/* ------------------------------------- Action Analytics End (Project) ---------------------------------- */

/* ------------------------------------- Time Sheet List ---------------------------------- */
$('#tslToDate').change(function(){
	getEmpTimeSheetWorkingHrsList();
});

function getEmpTimeSheetWorkingHrsList(){
	
	$.ajax({
		Type:'GET',
		url:'EmpTimeSheetWorkingHrsList.htm',
		datatype:'json',
		data:{
			fromDate : $('#tslFromDate').val(),
			toDate : $('#tslToDate').val(),
		},
		success:function(result){
			var values = JSON.parse(result);
			var x='';
			
			if(values.length>0){
				for(var i=0;i<values.length;i++){
					x+='<tr>';
					x+='<td>'+(i+1)+'</td>';
					x+='<td class="left">'+values[i][1] +", "+values[i][2]+'</td>';
					//x+='<td>'+values[i][3]+'</td>';
					x+='<td>'+values[i][4]+'</td>';
					x+='<td>'+values[i][5]+'</td>';
					x+='<td>'+values[i][6]+'</td>';
					x+='<td>'+values[i][7]+'</td>';
					x+='<td>'+values[i][8]+'</td>';
					x+='</tr>';
				}
			}else{
				x+='<tr><td class="center" colspan="7">No Data Available</td></tr>';
			}
			$('#tslcontainertbody').html(x);
		}
	});
}

/* ------------------------------------- Time Sheet List End ---------------------------------- */

/* ------------------------------------- Project Time Sheet ---------------------------------- */
$('#ptsToDate,#ptsProjectId').change(function(){
	
	var ptsProjectId = $('#ptsProjectId').val();
	if(ptsProjectId!='0' && ptsProjectId!='A'){
		var sqlsancDate = $('#ptsProjectId option:selected').attr('data-sancdate');
		var regularsancDate =  sqlDateToRegularDate(sqlsancDate);
		$('#ptsFromDate').val(regularsancDate);
	}
	
	getProjectTimeSheetWorkingHrsList();
});

function getProjectTimeSheetWorkingHrsList(){

	$.ajax({
		Type:'GET',
		url:'ProjectTimeSheetWorkingHrsList.htm',
		datatype:'json',
		data:{
			projectId : $('#ptsProjectId').val(),
			fromDate : $('#ptsFromDate').val(),
			toDate : $('#ptsToDate').val(),
		},
		success:function(result){
			var values = JSON.parse(result);
			var x='';
			
			if(values.length>0){
				for(var i=0;i<values.length;i++){
					x+='<tr>';
					x+='<td>'+(i+1)+'</td>';
					x+='<td class="left">'+values[i][1] +", "+values[i][2]+'</td>';
					x+='<td>'+values[i][3]+'</td>';
					x+='<td>'+values[i][4]+'</td>';
					x+='</tr>';
				}
				
				// Initialize counters for each type
				var drds = 0;
				var drtc = 0;
				var others = 0;
				
				values.forEach(function(item) {
				    var type = item[3]; // Type is at index 3
				    var time = item[4]; // Time is at index 4
	
				    // Convert time from HH:mm:ss format to seconds
				    var parts = time.split(':');
				    var seconds = parseInt(parts[0], 10) * 3600 + parseInt(parts[1], 10) * 60 + parseInt(parts[2], 10);
	
				    // Sum the time based on the type
				    if (type === 'DRDS') {
				    	drds += seconds;
				    } else if (type === 'DRTC') {
				    	drtc += seconds;
				    } else if (type === 'Others') {
				    	others += seconds;
				    }
				});
				
				var totalseconds = drds+drtc+others;
				var totalhm = secondsToHM(totalseconds)+":00";
				x+='<tr>'
				x+='<td colspan="3" class="right">Total</td>';
				x+='<td>'+totalhm+'</td>';
				x+='</tr>';
			}else{
				x+='<tr><td class="center" colspan="4">No Data Available</td></tr>';
			}
			$('#ptscontainertbody').html(x);
			
			
			/* --------------------------- Project Time Sheet (In Pie Chart) ------------------------------ */
			
			

			var totaldrds = secondsToDecimalHours(drds);
			var totaldrtc = secondsToDecimalHours(drtc);
			var totalothers = secondsToDecimalHours(others);
			
			Highcharts.chart('ptscontainer2', {
			    chart: {
			        plotBackgroundColor: null,
			        plotBorderWidth: null,
			        plotShadow: false,
			        type: 'pie',

			    },
			    title: {
			        text: 'Project Time Sheet'
			    },
			    tooltip: {
			    	pointFormat: '{series.name}: <b>{point.y} </b>'
			    },
			    
			    plotOptions: {
			        pie: {
			            allowPointSelect: true,
			            cursor: 'pointer',
			            dataLabels: {
			                enabled: true,
			                format: '<b>{point.name}</b>: {point.y} ',
			                connectorColor: 'silver'
			                
			            },
			        }
			    },
			    series: [{
			        name: 'Hours',
			        data: [
			        	{
				        	name: 'DRDS',
		                    y: totaldrds,
		                	color: Highcharts.getOptions().colors[2],
			        	},
			        	{
				        	name: 'DRTC',
		                    y: totaldrtc,
		                	color: Highcharts.getOptions().colors[3],
				        },
			        	{
				        	name: 'Others',
		                    y: totalothers,
		                	color: Highcharts.getOptions().colors[1],
				        },
			        ]
			    }],
			    credits: {
		            enabled: false
		        },
		        responsive: {
		            rules: [{
		                condition: {
		                    maxWidth: 500
		                },
		                // Make the labels less space demanding on mobile
		                chartOptions: {
		                    xAxis: {
		                        labels: {
		                            formatter: function () {
		                                return this.value.charAt(0);
		                            }
		                        }
		                    },
		                    yAxis: {
		                        labels: {
		                            align: 'left',
		                            x: 0,
		                            y: -2
		                        },
		                        title: {
		                            text: ''
		                        }
		                    }
		                }
		            }]
		        }
			});
			
			/* --------------------------- Project Time Sheet End  (In Pie Chart)------------------------------ */
		}
	});
}

/* ------------------------------------- Project Time Sheet End ---------------------------------- */

 var holidayList = [
		            <% for (int i = 0; i < holidayList.size(); i++) { %>
		                [
		                    <% Object[] array = holidayList.get(i); %>
		                    <% for (int j = 0; j < array.length; j++) { %>
		                        "<%= array[j] %>"
		                        <% if (j < array.length - 1) { %>
		                            ,
		                        <% } %>
		                    <% } %>
		                ]
		                <% if (i < holidayList.size() - 1) { %>
		                    ,
		                <% } %>
		            <% } %>
		        ];

$('#tsl2ToDate,#tsl2EmpId').change(function(){
	 getEmpExtraWorkingDayList();
});

function getEmpExtraWorkingDayList(){

	$.ajax({
		Type:'GET',
		url:'EmpExtraWorkingDayList.htm',
		datatype:'json',
		data:{
			empId : $('#tsl2EmpId').val(),
			fromDate : $('#tsl2FromDate').val(),
			toDate : $('#tsl2ToDate').val(),
		},
		success:function(result){
			var values = JSON.parse(result);
			var x='';
			var data = 0;
			if(values.length>0){
				for(var i=0;i<values.length;i++){
					var day = getDayOfWeek(values[i][4]);
					var holidayName = '';
					
					var isFound = holidayList.some(function(holiday) {
						if(holiday[1] === values[i][4]){
							holidayName = holiday[2];
							return true;
						}
			        });
					
					if(day=='Saturday' || day=='Sunday' || isFound){
						x+='<tr>';
						x+='<td>'+(++data)+'</td>';
						x+='<td>'+(sqlDateToRegularDate(values[i][4]))+'</td>';
						x+='<td class="left">'+day+''+(holidayName!=''?' ('+holidayName+')':'')+'</td>';
						x+='<td>'+values[i][5]+'</td>';
						x+='</tr>';
						
					}
				}
				if(data==0){
					x+='<tr><td class="center" colspan="4">No Data Available</td></tr>';
				}
			}else{
				x+='<tr><td class="center" colspan="4">No Data Available</td></tr>';
			}
			$('#tslcontainer2tbody').html(x);
		}
	});
}


/* -------------------------------------------------- Utility Functions ----------------------------------------------------- */


//Function to convert time strings (e.g., "10:00:00 am") to hours
function convertTimeStringToHours(timeString) {
 var timeParts = timeString.match(/(\d+):(\d+):(\d+)/);
 var hours = parseInt(timeParts[1]);
 var minutes = parseInt(timeParts[2]);
 var seconds = parseInt(timeParts[3]);
 //var period = timeParts[4];

 //if (period.toLowerCase() === "pm" && hours < 12) {
 //    hours += 12;
 //}
 //if (period.toLowerCase() === "am" && hours === 12) {
 //    hours = 0;
 //}

 // Convert to fractional hours
 return hours + minutes / 60 + seconds / 3600;
}

//Convert total seconds back to HH:mm format and to decimal hours
function secondsToHM(seconds) {
    var h = Math.floor(seconds / 3600);
    var m = Math.floor((seconds % 3600) / 60);
    return [h, m].map(function(val) { return val < 10 ? '0' + val : val; }).join(':');
}

function secondsToDecimalHours(seconds) {
    var h = Math.floor(seconds / 3600);
    var m = Math.floor((seconds % 3600) / 60);
    return h + m / 60;
}

function sqlDateToRegularDate(dateString) {
    // Split the input date string into an array [yyyy, mm, dd]
    const parts = dateString.split("-");
    
    // Rearrange the parts to [dd, mm, yyyy]
    const formattedDate = parts[2] + "-" + parts[1] + "-" + parts[0];
    
    return formattedDate;
}

function getDayOfWeek(dateString) {
	  // Create a new Date object from the date string
	  const date = new Date(dateString);
	  
	  // Array of day names
	  const daysOfWeek = ["Sunday", "Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday"];
	  
	  // Get the day of the week as a number (0-6)
	  const dayIndex = date.getDay();
	  
	  // Get the corresponding day name
	  return daysOfWeek[dayIndex];
	}
</script>
</body>
</html>