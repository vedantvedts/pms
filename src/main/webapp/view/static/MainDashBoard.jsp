<%@page import="java.util.stream.Collectors"%>
<%@page import="java.math.BigDecimal"%>
<%@page import="com.vts.pfms.FormatConverter"%>
<%@ page import="java.time.LocalDate"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1" import="java.util.*,com.vts.*,java.text.SimpleDateFormat,java.text.ParseException,java.math.BigInteger"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@page import="com.vts.pfms.master.dto.ProjectSanctionDetailsMaster"%>
<%@page import="com.vts.pfms.IndianRupeeFormat" %>
<%@ page import="com.fasterxml.jackson.databind.ObjectMapper" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>PMS</title>

<jsp:include page="../static/header.jsp"></jsp:include>

<spring:url value="/resources/css/newfont.css" var="NewFontCss" />
<link href="${NewFontCss}" rel="stylesheet" /> 

<spring:url value="/resources/css/master.css" var="masterCss" />
<link href="${masterCss}" rel="stylesheet" />

<spring:url value="/resources/css/masterdashboard.css" var="masterdashboardCss" />
<link href="${masterdashboardCss}" rel="stylesheet" />


<style type="text/css">
   .modalcontainer {
      position: fixed;
      bottom: 45%;
      right: 20px;
      width: 300px;
      max-width: 80%;
      background-color: #fff;
      box-shadow: 0 0 10px rgba(0, 0, 0, 0.2);
      border-radius: 8px;
      z-index: 1000;
      font-family: Arial, sans-serif;
     display: none;
    }


    .modal-container {
      position: fixed;
      bottom: 20px;
      right: 20px;
      width: 300px;
      max-width: 80%;
    
      background-color: #fff;
      box-shadow: 0 0 10px rgba(0, 0, 0, 0.2);
      border-radius: 8px;
      display: none;
      z-index: 1000;
      font-family: Arial, sans-serif;
     
    }

    .modalheader {
    display: flex;
    align-items: center;
    justify-content: end;
    padding:8px;
      background-color: #FFC436;
      color: #fff;
      border-top-left-radius: 8px;
      border-top-right-radius: 8px;
    }

    .modalcontent {
    
      padding: 10px 10px 10px 10px;
    }

    .modalfooter {
      text-align: right;
      border-bottom-left-radius: 8px;
      border-bottom-right-radius: 8px;
    }

    .modal-close {
      cursor: pointer;
      color: red;
    }

    /* Style for the button */
    .open-modal-button {
      position: fixed;
      bottom: 10px;
      right: 10px;
      background-color: #007bff;
      color: #fff;
      padding: 5px;
      border: none;
      border-radius: 5px;
      font-weight:bold;
      cursor: pointer;
      z-index: 1001; /* Make sure the button is above the modal */
    }
    
    #brifingBtn{
    display:none;
      position: fixed;
      bottom: 70px;
      right: 10px;
      background-color: #007bff;
      color: #fff;
      padding: 5px;
      border: none;
      border-radius: 20px;
      font-weight:bold;
      cursor: pointer;
      z-index: 1001; /* Make sure the button is above the modal */
    }

 	#wrapper{
		background-image: url("view/images/pfmsbg.png") !important;
		background-repeat: no-repeat;
		background-size: auto 100%;
		width: 100%;
	}
	
	.myschedule{
		background-image: url("view/images/myschedule.png") !important;
		background-repeat: no-repeat;
		background-position: left;
		background-position-x: 5px;
    	padding-left: 16px;
	}
	
	.gantt{
	background-image: url("view/images/gantt.png");
	background-repeat: no-repeat;
	background-position: left;
	background-position-x: 5px;
    padding-left: 16px;
}

.approval{
	margin-left: -0.75rem !important;
    margin-top: -.15rem !important;
}

.badge-today{
	font-size: 65% !important;
}

.btn1{
	border-top-left-radius: 5px !important;
	border-bottom-left-radius: 5px !important;
}

.btn2{
	
    border-left: 1px solid black;
}

.btn3{
	border-left: 1px solid black;
}
.btn4{
	margin: 0px 10px;
	color:green !important;
}
.meeting thead tr td{
	font-family: 'Muli',sans-serif;
	font-size: 16px !important
}


.overall-card{
	box-shadow: 5px 10px 11px -3px rgb(0 0 0 / 20%);
    border: none;
}

.yellow{
	color: #ffc107;
}

.red{
	color:#dc3545!important;
}

.green{
	color:#28a745!important;
}

.blue{
	color:#007bff!important;
}

.legend-shadow{
	text-shadow:
    -1px -1px 0 #000,
    1px -1px 0 #000,
    -1px 1px 0 #000,
    1px 1px 0 #000;
}

.overall-card{
	background: #005C97;  /* fallback for old browsers */
	background: -webkit-linear-gradient(to left, #363795, #005C97);  /* Chrome 10-25, Safari 5.1-6 */
	background: linear-gradient(to left, #363795, #005C97); /* W3C, IE 10+/ Edge, Firefox 16+, Chrome 26+, Opera 12+, Safari 7+ */
	color:white;
}


.overall-card h3{
	line-height: inherit;
}

@media  screen and (max-width: 1565px){
	
	.health-title{
		    margin-bottom: 12px !important;
    		font-size: 20px !important;
	}
}

/* Project Details Graph Css */

.highcharts-figure,
.highcharts-data-table table {
    min-width: 310px;
    max-width: 800px;
    margin: 1em auto;
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

.fixed-table tbody .custom-td{
	padding-left : 1rem !important;
}

.fixed-table tbody .custom-td .col-md-11, .fixed-table tbody .custom-td .col-md-10 {
	padding-left : 25px !important;
}

.overall-card .card-body{
	padding: 0.8rem 1rem !important;
}

.tableFixHead          { overflow: auto;  }
.tableFixHead thead td { position: sticky; top: 0; z-index: 1; }
.tableFixHead thead td {background-color: #1363DF}

.progress {
	height : 1.3rem !important;
	cursor:pointer;
}


.flex-container-new {
    display: flex;
}

.flex-child {
    flex: 1;
}  

.health-circle {
    display: inline-block;
    height: 22px;
    width: 22px;
    line-height: 22px;
    border-radius: 50px;
    color: white;
    text-align: center;
    font-size: 10px;
    font-weight: 800;
}

.modal-hr{
	margin: 0px 10px -10px 10px !important;
}

.modal-list{
	font-size: 14px;
	text-align: left;
	padding: 0px !important;
	margin-bottom: 5px;
}

.modal-list li{
	display: inline-block;
}

.modal-list li .modal-span{
	font-size: 2rem;
	padding: 0px 7px;
}

.modal-list li .modal-text{
	font-size: 1rem;
	vertical-align: text-bottom;
	font-family: Lato;
}


@media screen and (max-width:1380px){
	.tableprojectname{
		font-size: 12px !important;
	}
	.tableprojectnametd{
		width:13% !important;
	}

}

.changes-btn:hover{
	background-color: #A6D1E6 !important;
}

.changes-btn{
	background-color: rgba(255, 255, 255, 0.08888) !important;
	border: 1px solid rgba(0,0,0,.125);
	padding: 0px 7px !important;
}

.changes-font{
	font-size: 0.7rem !important;
}

.changes-badge{
	top:-8px !important;
}

/* DG Dashboard */


.circular-progress .progress {
  width: 110px;
  height: 110px !important ;
  background: none;
  position: relative;
  margin-bottom: 10px
}

.circular-progress .progress::after {
  content: "";
  width: 100%;
  height: 100%;
  border-radius: 50%;
  border: 15px solid #eee;
  position: absolute;
  top: 0;
  left: 0;
}

.circular-progress .progress>span {
  width: 50%;
  height: 100%;
  overflow: hidden;
  position: absolute;
  top: 0;
  z-index: 1;
}

.circular-progress .progress .progress-left {
  left: 0;
}

.circular-progress .progress .progress-bar {
  width: 100%;
  height: 100%;
  background: none;
  border-width: 15px;
  border-style: solid;
  position: absolute;
  top: 0;
}

.circular-progress .progress .progress-left .progress-bar {
  left: 100%;
  border-top-right-radius: 80px;
  border-bottom-right-radius: 80px;
  border-left: 0;
  -webkit-transform-origin: center left;
  transform-origin: center left;
}

.circular-progress .progress .progress-right {
  right: 0;
}

.circular-progress .progress .progress-right .progress-bar {
  left: -100%;
  border-top-left-radius: 80px;
  border-bottom-left-radius: 80px;
  border-right: 0;
  -webkit-transform-origin: center right;
  transform-origin: center right;
}

.circular-progress .progress .progress-value {
  position: absolute;
  top: 0;
  left: 0;
}


.detailscard{
	background-color: rgba(0,0,0,.08) !important;
	border: none !important;
}

.detailscard .card-body{
	padding:0.5rem !important;	
}
	
.detailscard hr{
	margin: 10px !important;
}

.detailscard h5{
	margin: 0px !important;
}
.countstable , .normalfont{
	font-family: 'Lato';
	font-weight: 700;
}

.card-deck-table tr td{
	padding: 0px 0px !important;
}

.border-orange{
	border-color: #EE5007 !important;
}

@media screen and (min-width:1100px) and (max-width:1500px){
	.circular-progress .progress{
		width:75px !important;
		height:75px !important;
	} 
	
	.circular-progress .progress-value .h4{
		font-size: 16px;
	}
	
	.circular-progress .progress .progress-bar {
		border-width:7px;
	}
	
	.circular-progress .progress::after {
		border-width: 7px;	
	}
	
	.bigcount h1{
		font-size: 2rem !important;
	}
	
	.normalfont{
		font-size: 12px !important;
	}
	
	.bigcount h3{
		font-size: 20px !important;
	}
	
	.bigcount h4{
		font-size: 1.2rem !important;
	}
	
	.detailscard h5{
		font-size: 16px !important;
	}
	
	.bigcount p{
		margin-bottom: 0rem !important;
	}
	
	.countstable tbody {
		font-size: 14px !important;
	}
	
	
}

	.bigcount h1{
		margin-bottom: -7px;
	}
		
	.bigcount h4,h3{
		margin-bottom: -4px;
	}
	
	.cashoutgotable, .financetable{
		margin-bottom: 0rem !important
	}
	
	.financetable tr td{
		font-size: 13px !important;
		font-weight: 600 !important;
	}
	
	.financetable tr th{
		font-size: 13px !important;
		padding: 0.5rem !important;
		text-align: left;
	}
	
	.cashoutgotable > tbody > tr >td, .financetable > tbody > tr >td{
		 border-top:1px solid grey !important;
	}
	
	.cashoutgotable > tbody > tr >th, .financetable > tbody > tr >th{
		 border-top:1px solid grey !important;
	}
	
	.cashoutgotable > thead > tr >th , .financetable > thead > tr >th{
		 border-top:1px solid transparent !important;
		 border-bottom:1px solid grey !important;
		 text-align: center;
	}

	.textfont{
		font-size: 12px !important;
	}
	
	.nil-bar{
		margin: 0px 10px !important;
	}
	
	.cashoutgotable tr {
		font-size: 13px !important;
		font-weight: 600 !important;
	}
	.cashoutgotable tr th{
		font-size: 13px !important;
		padding: 0.1rem !important;
		text-align: left;
	}
	
	.cashoutgotable thead{
		height: auto !important;
	}
	
	.bigcount p{
		margin-bottom: 0rem !important;
	}
	
	label{
		font-weight: bold;
	  	font-size: 13px;
	}

	.cashoutgo .primary{
			/* background-color: #5C192F !important; */
			background-color: #8D0404 !important; 
	}
		
	.cashoutgo .bg-success{
			/* background-color: #466136 !important; */
			background-color: #39850C !important; 
	}
		
	.cashoutgo .bg-info{
			/* background-color:#591A69 !important; */
			background-color: #7F109B !important;			 
	}
  #popupModal {
      position: fixed;
      bottom: 0;
      right: 0;
      transform: translate(-50%, -50%);
    }	

</style>

</head>

<body>
<!-- Mahesh code  -->
<%  if(request.getAttribute("showmodal").equals("yes")){ List<Object[]> projectdet=(List<Object[]>)request.getAttribute("lastupdatedate");%>
	<!-- Button trigger modal -->
	<button type="button" style="display: none;" id="showmodal"
		class="btn btn-primary" data-toggle="modal"
		data-target=".bd-example-modal-lg"></button>
	<!-- Modal -->	
	<div class="modal fade bd-example-modal-lg" tabindex="-1" role="dialog" aria-labelledby="myExtraLargeModalLabel" aria-hidden="true">
		<div class="modal-dialog modal-lg modal-dialog-centered" >
			<div class="modal-content" style="border: 15px solid #0C2B89;">
				<div class="modal-header">
					<h5 class="modal-title" id="exampleModalLabel">Weekly Update</h5>
					<p  style="display:flex;" class="modal-title mx-auto"> 
					<select  class="form-control" name="UProjects" id="UProjects" 
					onclick="getElementById('Usubmit').value=getElementById('UProjects').value;"
					onchange="changedates(getElementById('UProjects').value)">
					<% List<Object[]> projectEmp = (List<Object[]>)request.getAttribute("projectsOfEmp"); %>
						<%  for (int i=0;i< projectEmp.size();i++){ %>
						
							<option class="form-control" value="<%= projectEmp.get(i)[0] %>"><%= projectEmp.get(i)[6] %> (<%= projectEmp.get(i)[4] %>)</option>
						
						<%} %>
					</select></p>
					
					<button type="button" class="close" data-dismiss="modal"
						aria-label="Close">
						<span aria-hidden="true">&times;</span>
					</button>
				</div>
				<form action="weeklyupdate.htm" id="weeklyupdate" onsubmit="getElementById('weeklyupdate').disable=true;">
					<div class="container" >
						<div class="row"style="text-align: left">
							<div class="col-3" style="margin-top: 20px; margin-bottom: 20px;" >
							<p id="actionmodifieddate"></p>
							</div>
							<div class="col-sm"
								style="margin-top: 20px; margin-bottom: 20px;">
								<lable for="actionpoints">Have you updated action
								Items?</lable>
							</div>
							<div class="col-3"
								style="margin-top: 20px; margin-bottom: 20px;">
								
								<select required="required" class="form-control" name="actionpoints" id="actionpoints" required="required">
									<option value="" selected disabled hidden>Update Here</option>
									<option value="Yes">Yes</option>
									<option value="No">No</option>
									<option value="NA">NA</option>
								</select> <br />
							</div>
						</div>
						<div class="row"style="text-align: left">
							<div class="col-3">
							<p id="meetingdate"></p>
							</div>
							<div class="col-sm">
								<lable for="Meeting">Have you updated Meeting details?</lable>
							</div>
							<div class="col-3">
								<select required="required" class="form-control" name="Meeting" id="Meeting" required="required"><option
										value="" selected disabled hidden>Update Here</option>
									<option value="Yes">Yes</option>
									<option value="No">No</option>
									<option value="NA">NA</option>
								</select> <br /> <br />
							</div>
						</div>
						<div class="row"style="text-align: left">
							<div class="col-3">
							<p id="Milestones"></p>
							</div>
							<div class="col-sm">
								<lable for="Mile">Have you updated Milestones?</lable>
							</div>
							<div class="col-3">
								<select required="required" class="form-control" name="Mile" id="Mile" required="required">
								<option value="" selected disabled hidden>Update Here</option>
									<option value="Yes">Yes</option>
									<option value="No">No</option>
									<option value="NA">NA</option>
								</select> <br /> <br />
							</div>
						</div>
						<div class="row"style="text-align: left">
							<div class="col-3">
							<p id="ProcurementDate"></p>
							</div>
							<div class="col-sm">
								<lable for="Procurement">Have you updated Procurement
								Status?</lable>
							</div>
							<div class="col-3">
								<select required="required" class="form-control" name="Procurement" id="Procurement" required="required"><option
										value="" selected disabled hidden>Update Here</option>
									<option value="Yes">Yes</option>
									<option value="No">No</option>
									<option value="NA">NA</option>
								</select> <br /> <br />
							</div>
						</div>
						<div class="row"style="text-align: left">
							<div class="col-3">
							<p id="riskdetailsdate"></p>
							</div>
							<div class="col-sm">
								<lable for="riskdetails">Have you updated Risk details?
								</lable>
							</div>
							<div class="col-3">
								<select required="required" class="form-control" name="riskdetails" id="riskdetails" required="required"><option
										value="" selected disabled hidden=true;>Update Here</option>
									<option value="Yes">Yes</option>
									<option value="No">No</option>
									<option value="NA">NA</option>
								</select> <br /> <br />
							</div>
						</div>
						<button type="submit" name="USubmit" class="btn btn-primary" style="width: 300px" id="Usubmit">Update</button>
					</div>
				</form>
				<div class="modal-header">
					<p id='lastupdatedate' style="float: left;">last update date: ---- </p> </div>
				</div>
			</div>
			</div>
	<script type="text/javascript">
	document.getElementById("showmodal").click();

	<% if(projectdet!=null)for (int i=0;i<projectdet.size();i++){ %>
	if(document.getElementById('UProjects').value== <%=projectdet.get(i)[1]%> ){document.getElementById('lastupdatedate').innerHTML='last update date: '+'<%=projectdet.get(i)[0] %>';<%i++;%>}
	else {document.getElementById('lastupdatedate').innerHTML='last update date: '+'----';}<%}%>
	document.getElementById('Usubmit').value=document.getElementById('UProjects').value;
	
	$.ajax({
		
		type:"GET",
		url:"GetUpdateDates.htm",
		data :{
			
			ProjectId : document.getElementById('UProjects').value
			
		},
		datatype : 'json',
		success : function(result){
			
			var result = JSON.parse(result);
			var modifieddate=result[0];
			if (modifieddate[0]==',' || modifieddate[0][0]==null){document.getElementById('actionmodifieddate').innerHTML='----';}else{
			document.getElementById('actionmodifieddate').innerHTML=modifieddate[0][0].toString().substring(0,10);}
			var updateddate=result[1];
			if(updateddate.length>0){ 
			if ( result[1]==null  ){document.getElementById('lastupdatedate').innerHTML='last update date: '+'----';}else{
			document.getElementById('lastupdatedate').innerHTML='last update date: '+updateddate[0][0];}}
			else{
				document.getElementById('lastupdatedate').innerHTML='last update date: '+'----';
			}
			if (result[2][0][0]==null	){document.getElementById('riskdetailsdate').innerHTML='----';}else{
				document.getElementById('riskdetailsdate').innerHTML=result[2][0][0].toString().substring(0,10);}	
			if (result[3]==',' || result[3][0][0]==null	){document.getElementById('Milestones').innerHTML='----';}else{
				document.getElementById('Milestones').innerHTML=result[3][0][0].toString().substring(0,10);}
			if (result[4]==',' || result[4][0]==null	){document.getElementById('meetingdate').innerHTML='----';}else{
				document.getElementById('meetingdate').innerHTML=result[4][0].toString().substring(0,10);}
			if (result[5][0].length==0 || result[5][0][0]==null	){document.getElementById('ProcurementDate').innerHTML='----';}else{
				document.getElementById('ProcurementDate').innerHTML=result[5][0][0].toString().substring(0,10);}

		}

	});
	
	function changeit(val)
	{
		document.getElementById('weeklyupdate').reset();
		var name = document.getElementById('UProjects').innerHTML;
		var value = document.getElementById('UProjects').value;

	}
	
	function changedates(val)
	{

		document.getElementById('Usubmit').value=document.getElementById('UProjects').value;
		$pid=val;
		$.ajax({
			
			type:"GET",
			url:"GetUpdateDates.htm",
			data :{
				
				ProjectId : $pid
				
			},
			datatype : 'json',
			success : function(result){
				
				var result = JSON.parse(result);
				var modifieddate=result[0];
				if (modifieddate[0]==',' || modifieddate[0][0]==null){document.getElementById('actionmodifieddate').innerHTML='----';}else{
				document.getElementById('actionmodifieddate').innerHTML=modifieddate[0][0].toString().substring(0,10);}
				var updateddate=result[1];
				if(updateddate.length>0){ 
				if ( result[1]==null  ){document.getElementById('lastupdatedate').innerHTML='last update date: '+'----';}else{
				document.getElementById('lastupdatedate').innerHTML='last update date: '+updateddate[0][0];}}
				else{
					document.getElementById('lastupdatedate').innerHTML='last update date: '+'----';
				}
				if (result[2][0][0]==null	){document.getElementById('riskdetailsdate').innerHTML='----';}else{
					document.getElementById('riskdetailsdate').innerHTML=result[2][0][0].toString().substring(0,10);}	
				if (result[3]==',' || result[3][0][0]==null	){document.getElementById('Milestones').innerHTML='----';}else{
					document.getElementById('Milestones').innerHTML=result[3][0][0].toString().substring(0,10);}
				if (result[4]==',' || result[4][0]==null	){document.getElementById('meetingdate').innerHTML='----';}else{
					document.getElementById('meetingdate').innerHTML=result[4][0].toString().substring(0,10);}
				if (result[5][0]=='' || result[5][0][0]==null	){document.getElementById('ProcurementDate').innerHTML='----';}else{
					document.getElementById('ProcurementDate').innerHTML=result[5][0][0].toString().substring(0,10);}

			}

		});
	}
	
	
	</script>
<%} %>
<!-- end -->

<%

String Username =(String)session.getAttribute("Username");  
String EmpNo=(String)session.getAttribute("empNo");
String LabCode=(String)session.getAttribute("labcode");
String ibasUri=(String)request.getAttribute("ibasUri");
/* Long loginId=(Long)session.getAttribute("LoginId");  */
/* Long divisionId=(Long)session.getAttribute("Division");  */
/* Long empId =(Long)session.getAttribute("EmpId");  */
/* Long formRoleId=(Long)session.getAttribute("FormRole");  */
String statsUrl=(String)request.getAttribute("statsUrl");
String pmsToStatsUrl = statsUrl+"/login";
List<Object[]> todayschedulelist=(List<Object[]>)request.getAttribute("todayschedulelist");
List<Object[]> todaysMeetings= new ArrayList<>();
long todayMeetingCount=0;
if(todayschedulelist.size()>0){
	todayMeetingCount=todayschedulelist.stream().filter(i -> i[3].toString().equalsIgnoreCase(LocalDate.now().toString())).count();
	todaysMeetings=todayschedulelist.stream().filter(i -> i[3].toString().equalsIgnoreCase(LocalDate.now().toString())).collect(Collectors.toList());
}
ObjectMapper objectMapper = new ObjectMapper();
String jsonArray = objectMapper.writeValueAsString(todaysMeetings);

List<Object[]> rfaPendingCountList= (List<Object[]>)request.getAttribute("rfaPendingCountList");
Integer rfaForwardCount=(Integer)request.getAttribute("rfaForwardCount");
Integer rfaInspectionCount=(Integer)request.getAttribute("rfaInspectionCount");
Integer rfaInspectionAprCount=(Integer)request.getAttribute("rfaInspectionAprCount");
long todayRfaCount1=0;
List<String> status1 = Arrays.asList("AA","REV", "RC", "RV", "RE");
if(rfaPendingCountList!=null && rfaPendingCountList.size()>0){
	todayRfaCount1=rfaPendingCountList.stream().filter(i -> status1.contains(i[14].toString().toUpperCase())).count();
}

/* List<Object[]> todayactionlist=(List<Object[]>)request.getAttribute("todayactionlist"); */
List<Object[]>  notice=(List<Object[]>)request.getAttribute("dashbordNotice");
List<Object[]> actionscount=(List<Object[]>)request.getAttribute("actionscount");
Integer selfremindercount=(Integer)request.getAttribute("selfremindercount");  
Integer noticeElib= Integer.parseInt(request.getAttribute("noticeEligibility").toString());
/* List<Object[]> noticeList =(List<Object[]>)request.getAttribute("NotiecList"); */
Integer selfremaindercount=(Integer)request.getAttribute("selfremaindercount");

/* Object[] allschedulescount=(Object[])request.getAttribute("AllSchedulesCount"); */

List<ProjectSanctionDetailsMaster>  budgetlist=(List<ProjectSanctionDetailsMaster>)request.getAttribute("budgetlist");
List<Object[]> ProjectList=(List<Object[]>)request.getAttribute("ProjectList");
List<Object[]> ProjectMeetingCount=(List<Object[]>)request.getAttribute("ProjectMeetingCount");
/* Object[] GeneralMeetingCount=(Object[])request.getAttribute("GeneralMeetingCount"); */
List<Object[]> ganttchartlist=(List<Object[]>)request.getAttribute("ganttchartlist");
String interval =(String)request.getAttribute("interval");
String error = (String) request.getAttribute("errorMsg");
List<Object[]> MyTaskList=(List<Object[]>)request.getAttribute("mytasklist");
List<Object[]> approvallist=(List<Object[]>)request.getAttribute("approvallist");
List<Object[]> mytaskdetails=(List<Object[]>)request.getAttribute("mytaskdetails");
List<Object[]> dashboardactionpdc=(List<Object[]>)request.getAttribute("dashboardactionpdc");
ArrayList<String> loginlist=new ArrayList<String>(Arrays.asList("L","A","Y","P","Z","E","Q")); 
SimpleDateFormat formatter = new SimpleDateFormat("yyyy/MM/dd");  
String TodayDate = formatter.format(new Date()).toString().replace("/", "-") ;
List<Object[]> QuickLinkList=(List<Object[]>)request.getAttribute("QuickLinkList");
List<Object[]> ProjectHealthData = (List<Object[]>)request.getAttribute("projecthealthdata");
Object[] ProjectHealthTotalData = (Object[])request.getAttribute("projecthealthtotal"); 
//Object[] ChangesTotalData =(Object[])request.getAttribute("changestotalcount");
/* List<Object[]> CCMFinanceData = (List<Object[]>)request.getAttribute("CCMFinanceData"); */
List<Object[]> CashOutGo= (List<Object[]>)request.getAttribute("DashboardFinanceCashOutGo");
List<Object[]> DashboardFinance= (List<Object[]>)request.getAttribute("DashboardFinance");


FormatConverter fc=new FormatConverter(); 
SimpleDateFormat sdf=fc.getRegularDateFormat();
SimpleDateFormat sdf3=new SimpleDateFormat("dd-MM-yy");
SimpleDateFormat sdf1=new SimpleDateFormat("yyyy-MM-dd");
SimpleDateFormat sdf2=new SimpleDateFormat("yy-MM-dd");
IndianRupeeFormat nfc=new IndianRupeeFormat();



String logintype="U";

String View="";
if(logintype!=null ){
	logintype=(String)request.getAttribute("logintype"); 
	if(logintype.equalsIgnoreCase("A")|| logintype.equalsIgnoreCase("P")|| logintype.equalsIgnoreCase("E") || logintype.equalsIgnoreCase("Z") || logintype.equalsIgnoreCase("Y")|| logintype.equalsIgnoreCase("Q") || logintype.equalsIgnoreCase("C") || logintype.equalsIgnoreCase("I") || logintype.equalsIgnoreCase("G") || logintype.equalsIgnoreCase("F")){
		logintype="A";
	}
}

String LoginTypes[] = {"A","P","E","Z","Y","Q","X","K","C","I","G","F"}  ;

int ProjectCount = 0;

List<Object[]> projecthealthtotaldg = (List<Object[]>)request.getAttribute("projecthealthtotaldg");
String IsDG = (String)request.getAttribute("IsDG");

%>
<%
 String ses=(String)request.getParameter("result"); 
 String ses1=(String)request.getParameter("resultfail");
 if(ses1!=null){
%>	
	<div align="center">
		<div class="alert alert-danger" role="alert"><%=ses1 %></div>
	</div>
<%} 
if(ses!=null){ %>
<div align="center">
	<div class="alert alert-success" role="alert" ><%=ses %></div>
</div>
<%} %>


<!-- @@@@@@@@ CONTAINER FLUID START @@@@@@@ -->
<div class="container-fluid" >


<!-- @@@@@@@@ MAIN ROW START @@@@@@@ -->	
	<div class="row" style="margin-bottom: -20px;">
	
<!-- @@@@@@@@ MAIN ROW col-md-9 START @@@@@@@ -->			
		<div class="col-md-9" >
			
			
<!-- @@@@@@@@ NESTED ROW START @@@@@@@ -->				
				<div class="row">
			      
			     
<!-- @@@@@@@@@@ NESTED ROW SCHEDULE START @@@@@@@@@@  -->
              <div class="col-4 col-md-3" >

         <!-- ----------------PROJECT DASHBOARD PROJECT NAME DISPLAY START --------------- -->
			      	 <%if(ProjectList!=null){ %>
						
						 <div class="row" style="display: none" id="projectname" >
							
							<div class="col-md-12" align="center">
								
								<div id="carouselExampleSlidesOnly" class=""  data-ride=""  >
						
									<div class="carousel-inner">	
									
										<%	for (Object[] obj : ProjectList) { 
											String projectshortName=(obj[17]!=null)?" ( "+obj[17].toString()+" ) ":"";
										%>
									
										 <div class="carousel-item" id="projectname<%=obj[0]%>">
										 
										 	<div class="row" style="margin:0px !important">
						
												<div class="col-md-12" style="text-transform: uppercase;font-size: 22px; ">
												
													<%=obj[4]+projectshortName %>
												
													<br><br>
													
												</div>
		
											</div>
										 
										 </div>
									
										<%} %>
									
									</div>
						
								</div>
							
							</div>
	
					</div> 
	
				 <%} %> 
			 <!-- ----------------PROJECT DASHBOARD PROJECT NAME DISPLAY END --------------- -->      
			      
			 <!-- ----------------- ACTION DASHBOARD TODAY'S SCHEDULE START -------------------------- -->
			 	
				      <div class="card" style="background: transparent;display: none" id="todayschedules">
							<nav class="navbar navbar-light bg-primary " style="background-color: #e3f2fd;">
								<span style="color:white">Today's Schedule <span class="badge badge-today badge-success" style="position: absolute;top: 0px;"></span> </span> 
					 	  		<form class=" form-inline" method="post" action="MySchedules.htm" id="myform" >
									<input  class="btn btn-primary myschedule" type="submit" name="sub" value=" &nbsp;&nbsp;" style="background-color: #23689b;font-size: 0.875rem;border: 2px solid lightslategrey" >
									<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
								</form>
							</nav>	
							
							<div class="card-body" style="padding: 0.5rem 0.5rem 0rem 0.5rem;" >
								<div  style="color:black ">

								    <div style="height:6.2rem ;overflow-y: hidden ; ">
								    
								     <div id="carouselExampleControls5" class="carousel vert slide" data-ride="carousel" data-interval="5000">
								       
										<div class="carousel-inner">
																        
											<% 
											int count=0;
											if(todayschedulelist.size()>0){
										  for(Object[] obj : todayschedulelist){
											  	if(!obj[6].toString().equalsIgnoreCase("E")){
											  		if(obj[3].toString().equalsIgnoreCase(TodayDate)){
											  		%>
																        
												<div class="carousel-item action" id="schedule" style="background-color: rgba(255, 255, 255, 0.08888) !important;color:black ;overflow: hidden">
																            
														<ul style="padding: 0px;margin-bottom: 5px !important">	
															<li class="list-group-item" style="background-color: rgba(255, 255, 255, 0.08888) !important; padding : 10px 0px !important;">
																	            	
																 <a href="javascript:void(0)" onclick="location.href='CommitteeScheduleView.htm?scheduleid=<%=obj[2] %>' " style="color:black" >
									               
													                <i class="fa fa-arrow-right faa-pulse animated faa-fast" aria-hidden="true" style="color: green;font-size: 1.3rem !important"></i> 
															    	<%=obj[7] %> -
															    	<i class="fa fa-clock-o" aria-hidden="true"></i> <%=obj[4] %> &nbsp;&nbsp;
					
															    </a>
																				    
														 	</li>
														</ul>
								
												</div>
												<%count++;}} }}%>
								
												<%if(count==0) { %>
													<ul>
														<li class="list-group-item" style="background-color: rgba(255, 255, 255, 0.08888) !important;color:black " >No Events ! </li>
													</ul>
												<%} %>
											
											</div>
																        
										</div>									 
								    
								    </div>
			
								</div>
					 	  </div>
					 	  
					 	  <div class="card-footer" style="padding: 0.2rem 1.25rem !important;text-align: left">
					 	  	
					 	  	<a class="navbar-brand" href="MySchedules.htm" style="color:black;">Upcoming Schedule</a><span class="badge <%if(todayschedulelist.size()-count> 0) {%>  badge-danger <%} else { %> badge-success <%} %>badge-counter"><%if(todayschedulelist.size()-count >0){%> <%=todayschedulelist.size()-count %><%} %></span>
					
					 	  </div>
					 	  <div class="card-footer" style="padding: 0.2rem 1.25rem !important;text-align: left">
					 	  	
					 	  
					 	  	<a class="navbar-brand"  href="ActionSelfReminderAdd.htm" style="color:black;">My Reminders</a><span class="badge <%if(selfremindercount> 0) {%>  badge-danger <%} %> badge-counter"><%if(selfremindercount >0){%><%=selfremindercount %><%} %></span>
					 	  </div>
					
					</div> 
					
		<!-- -----------------ACTION DASHBOARD TODAY'S SCHEDULE END -------------------------- -->
					
					
		<!-- ----------------PROJECT DASHBOARD PROJECT DETAILS LEFT SIDE START --------------- -->
					
					<div  style="display: none" id="projectdetails1">
					 
					 	 <%if(ProjectList!=null){ %>
						
						 <div class="row" style="" >
							
							<div class="col-md-12" align="center">
								
								
								<div id=carouselprojectdetailsSlidesOnly class=""  data-ride=""  >	
									<div class="carousel-inner">	
									
										<%	for (Object[] obj : ProjectList) { %>
									
										 <div class="carousel-item" id="projectdetailsname<%=obj[0]%>">
										 
										 	<div class="row" style="margin:0px !important">
						
												<div class="col-md-12" style="text-align: right;">
													
													<%if(obj[8]!=null) { if(!obj[8].toString().equals("0")){ %>
													
													<h6>Project Code : </h6>
													<h6>Project Name : </h6>
													<br>
													<h6>Sanction Date : </h6>
													<h6>PDC : </h6>
													<h6>PMRC Due On : </h6>
													<h6>EB Due On : </h6>

													<%}}else{ %>
													
														<br><br><br><br><br><br><br>
													
													<%} %>
													
													<br><br>
													
												</div>
		
											</div>
										 
										 </div>
									
										<%} %>
									
									</div>
						
								</div>
							
							</div>
	
					</div> 
	
				 <%} %>
					 </div>
					 
	    <!--------------- PROJECT DASHBOARD PROJECT DETAILS LEFT SIDE END  ------------- -->		 
					 	
		<!---------------- OVERALL DASHBOARD CHANGES,WEEK,TODAY AND MONTH DIV START --------->
					 	
				<div style="display: none" class="overallheader" id="changes-tab">
					<% if(Arrays.asList(LoginTypes).contains((String)request.getAttribute("logintype"))){ %>
					<div data-toggle="tooltip" title="" style="text-align: left;" >
														<button data-toggle="tooltip" onclick ="showDashboardProjectModal()" class="btn btn-sm bg-transparent faa-pulse animated faa-fast" style="cursor: pointer;"  type="button"  data-toggle="tooltip" data-placement="right"  title="Select DashBoard Projects" >
														<img src="view/images/dashboard.png" style="width: 25px;" > 
														</button>
															<jsp:include page="../static/DashBoardSelection.jsp"></jsp:include>
													</div> 
					<%} %>
			       <%--    	<div class="btn-group" role="group" aria-label="Basic example" style="margin-bottom: 12px">
			          	<button type="button" class="btn " style="background-color: #145374;color: white;font-size: 13px" onclick="ChangesForm('A')" ><i class="fa fa-arrows-alt" aria-hidden="true"></i> Changes</button>
			          	  <button type="button"  onclick="ChangesForm('T')" class="btn changes-btn" ><span class="navbar-brand changes-font"  style="color:black;">Today</span>
			          	  	<span class="badge changes-badge badge-danger badge-counter" id="todaychangescount">
			          	  		<%=ProjectHealthTotalData[26] %>
			          	  	</span></button>
						  <button type="button" onclick="ChangesForm('W')" class="btn changes-btn"><span class="navbar-brand changes-font"  style="color:black;">Week</span>
						  	<span class="badge  changes-badge badge-danger badge-counter" id="weeklychangescount">
						  		<%=ProjectHealthTotalData[27] %>
						  	</span></button>
						  <button type="button" onclick="ChangesForm('M')" class="btn changes-btn"><span class="navbar-brand changes-font"  style="color:black;">Month</span>
						  <span class="badge changes-badge badge-danger badge-counter" id="monthlychangescount">
						  		<%=ProjectHealthTotalData[28] %>
						  </span></button>
						</div> --%>
						
				</div>
     <!----------------- OVERALL DASHBOARD CHANGES,WEEK,TODAY AND MONTH DIV END ---------------->
         </div>
<!-- @@@@@@@@@@ NESTED ROW SCHEDULE END @@@@@@@@@@  -->		     

<!-- @@@@@@@@@@ NESTED ROW(2) START @@@@@@@@@@  -->
              
               <div class="col-4 col-md-3" >
			      
		 <!-- -----------------PROJECT DASHBOARD PROJECTDROPDOWN START---------------------------- -->
			      		<%if(ProjectList!=null){ %>
						
						 <div class="row">
							
							<div class="col-md-12" style="display: none" id="projectdropdown" >
		
								<select class="form-control selectdee" id="projectid" required="required" name="projectid" onchange="dropdown()"  >
									<%	for (Object[] obj2 : ProjectList) {
										String projectshortName=(obj2[17]!=null)?" ( "+obj2[17].toString()+" ) ":"";
										%>
										<option value="<%=obj2[0]%>"  style="text-align: left !important" ><%=obj2[4]+projectshortName%></option>
									<%} %>
								</select>
								<br><br>
								
						    </div>
						
						</div> 
						
				 	<%} %> 
	   <!-- -----------------PROJECT DASHBOARD PROJECTDROPDOWN END---------------------------- -->

	   <!-- -----------------ACTION DASHBOARD APPROVAL'S(TO BE APPROVED BY ME) SCHEDULE START---------------------------- -->
							
						<div class="card" style="background: transparent;display: none" id="approvalblock">
						
							<nav class="navbar navbar-light bg-primary " style="background-color: #e3f2fd;">
								<a class="navbar-brand" style="color:white"; >To be Approved By Me</a>
							</nav>					
											
							<div id="carouselExampleControls8" class="carousel slide carousel-interval" data-ride="carousel"  style="padding: 3px 0px 7px 4px;">
								
								<div class="carousel-inner">

									<% int approvalcount=0;
										for(Object[] obj : approvallist){ %>

										<%if((obj[0]).toString().equalsIgnoreCase("DO")){ if(Integer.valueOf((String) obj[1].toString())>0){ %>
									
									<div class="card-footer" style="padding: 0.2rem 1.25rem !important;text-align: left">
										<a class="navbar-brand" href="ProjectApprovalPd.htm" style="color:black;" id="" >Initiation (DO)
										<i class="fa fa-bell fa-fw " aria-hidden="true" style="color: purple"></i> 
										<span class="badge badge-danger badge-counter approval" id=""><%=obj[1] %></span> 
										</a>
										
										
									</div>
									
										<%approvalcount++; }} %>
										
										<%if((obj[0]).toString().equalsIgnoreCase("RTMD-DO")){ if(Integer.valueOf((String) obj[1].toString())>0){ %>
									
									<div class="card-footer" style="padding: 0.2rem 1.25rem !important;text-align: left">
										<a class="navbar-brand" href="ProjectApprovalRtmddo.htm" style="color:black" id="" >Initiation (P&C-DO)
										<i class="fa fa-bell fa-fw " aria-hidden="true" style="color: purple"></i>
										<span class="badge badge-danger badge-counter approval" id=""><%=obj[1] %></span></a>
									</div>
									
										<%approvalcount++;} }%>
										
										<%if((obj[0]).toString().equalsIgnoreCase("AD")){ if(Integer.valueOf((String) obj[1].toString())>0){  %>
										
									<div class="card-footer" style="padding: 0.2rem 1.25rem !important;text-align: left">
										<a class="navbar-brand" href="ProjectApprovalAd.htm" style="color:black" id="" >Initiation (AD)
										<i class="fa fa-bell fa-fw " aria-hidden="true" style="color: purple"></i>
										<span class="badge badge-danger badge-counter approval" id=""><%=obj[1] %></span></a>
									</div>
									
										<%approvalcount++;} }%>
										
										<%if((obj[0]).toString().equalsIgnoreCase("TCM")){ if(Integer.valueOf((String) obj[1].toString())>0){  %>
									
									<div class="card-footer" style="padding: 0.2rem 1.25rem !important;text-align: left">
										<a class="navbar-brand" href="ProjectApprovalTcc.htm" style="color:black" id="" >Initiation (TCM)
										<i class="fa fa-bell fa-fw " aria-hidden="true" style="color: purple"></i>
										<span class="badge badge-danger badge-counter approval" id=""><%=obj[1] %></span></a>
									</div> 
										
										<%approvalcount++;}} %>
										
										<%if((obj[0]).toString().equalsIgnoreCase("Meeting")){ if(Integer.valueOf((String) obj[1].toString())>0){  %>
									
								<%-- 	<div class="card-footer" style="padding: 0.2rem 1.25rem !important;text-align: left">
										<a class="navbar-brand" href="MeetingApprovalAgenda.htm" style="color:black" id="" >Meeting
										<i class="fa fa-bell fa-fw " aria-hidden="true" style="color: purple"></i>
										<span class="badge badge-danger badge-counter approval" id=""><%=obj[1] %></span></a>
									</div>  --%>
										
										<%/* approvalcount++; */}} %>
										
										<%if((obj[0]).toString().equalsIgnoreCase("Committee")){ if(Integer.valueOf((String) obj[1].toString())>0){  %>
									
									<div class="card-footer" style="padding: 0.2rem 1.25rem !important;text-align: left">
										<a class="navbar-brand" href="CommitteeMainApprovalList.htm" style="color:black" id="" >Committee
										<i class="fa fa-bell fa-fw " aria-hidden="true" style="color: purple"></i>
										<span class="badge badge-danger badge-counter approval" id=""><%=obj[1] %></span></a>
									</div> 
										
										<%approvalcount++;}} %>
										
									
									<%} %>
						
									
									<%if(approvalcount==0){ %>
									
										<div class="card-footer" style="padding: 0.2rem 1.25rem !important;text-align: left">
										<a class="navbar-brand"  style="color:black" id="" >No Approvals</a>
										
									</div> 
									
									<%} %>
									
										    
								</div>
								
							</div> 
							
						</div>
							
						
         <!-- -------------------------ACTION DASHBOARD APPROVAL'S SCHEDULE END---------------------------  -->				
					
	     <!-- -----------------PROJECT DASHBOARD SELECTED PROJECTED DETAILS DISPLAY START---------------------------- -->				
						
					<div  style="display: none" id="projectdetails2">
					 
					 	<%if(ProjectList!=null){ %>
						
						 <div class="row" style="" >
							
							<div class="col-md-12" align="center">
								
								<div id=carouselprojectdetailsSlides2Only class=""  data-ride=""  >	
								
						
									<div class="carousel-inner">	
									
										<%	for (Object[] obj : ProjectList) { %>
										
										
									
										 <div class="carousel-item" id="projectinfo<%=obj[0]%>">
										 
										 	<div class="row" style="margin:0px !important">
						
												<div class="col-md-12" style="text-align: left;">
													<h6><%if(!obj[0].toString().equals("0")){%><%=obj[4]%><%} %></h6>
													<%if(!obj[0].toString().equals("0")){ if(obj[1].toString().chars().count()>17){ %>
														<div style="font-size: 12px;margin-bottom: 0px !important;min-height: 48px"><%=obj[1]%></div>
													<%}else{ %>
														<h6><%=obj[1]%><br><br></h6>
													<%} %>
													<%} %>
													<h6><%if(!obj[12].toString().equals("0")){%><%= sdf.format(sdf1.parse( obj[12].toString()))%><%}else{ %><%} %></h6>
													<h6><%if(!obj[9].toString().equals("0")){%><%= sdf.format(sdf1.parse( obj[9].toString()))%><%}else{ %><%} %></h6>
													<h6><%if(obj[15]!=null){%><%= sdf.format(sdf1.parse( obj[15].toString()))%><%}else{ %>-<%} %></h6>
													<h6><%if(obj[16]!=null){%><%= sdf.format(sdf1.parse( obj[16].toString()))%><%}else{ %>-<%} %></h6>
												</div>
		
											</div>
										 
										 </div>
									
										<%} %>
									
									</div>
						
								</div>
							
							</div>
	
					</div> 
	
				 <%} %>
					 
					 
					 </div>
					 
	 <!-- -----------------PROJECT DASHBOARD SELECTED PROJECTED DETAILS DISPLAY END---------------------------- -->	

			      </div>
<!-- @@@@@@@@@@ NESTED ROW SCHEDULE END( 2 ) @@@@@@@@@@  -->    		      


<!-- @@@@@@@@@@ NESTED ROW BUDGET START @@@@@@@@@@  --> 				      
			      
		 <div class="col-4 col-md-6">
			  
	 <!-- -----------------PROJECT DASHBOARD SELECTED FINANCIAL PERFORMANCE DISPLAY START---------------------------- -->	
	 	 
		<%if(error!=null){ %>
				<h4 style="color:#ce1212;margin-top: 25%;display:none" id="financialdataerror" ><%=error %></h4>  
		 <%} %> 
			      
		 <% if(!logintype.equalsIgnoreCase("U")){ %>
			 			 
			 <%if(budgetlist!=null && budgetlist.size()>0){ %>	
				
				<div class="card-body" style="padding: 0.4rem !important;display:none" align="center" id="financialdata"  > 
					
					<div id="carouselExampleControls" class=""  data-ride=""  >		
					
							<div class="carousel-inner">					
							
							<div style="background-color: white;">
									
									<%long i=0;
									for(ProjectSanctionDetailsMaster obj : budgetlist){
										%>
											 
											 <div class="carousel-item" style="border-radius: 15px;padding-bottom: 10px;" id="chart<%=obj.getProjectid()%>"> 
										
										
										
										<nav class="navbar navbar-light " style="background-color: #e3f2fd;">
										
											<a class="navbar-brand" >Financial Performance</a>
										    <form class="form-inline" target="_blank" method="post" id="ibasform" action="<%=ibasUri%>/loginFromPfms">
										    <input type="hidden" name="empNo" value="<%=EmpNo%>">
											<input type="hidden" name="ProjectId" value="<%=obj.getProjectid()%>">
											<input type="hidden" name="ProjectCode" value="<%=obj.getProjectCode()%>">
											<input type="hidden" name="Expenditure" value="<%=obj.getExpAmt()%>">
											<input type="hidden" name="Commitment" value="<%=obj.getOsComAmt()%>">
											<input type="hidden" name="Dipl" value="<%=obj.getDipl()%>">
											<input type="hidden" name="BalAmt" value="<%=obj.getBalAmt()%>">
											<input type="hidden" name="asOndate" value="<%=obj.getAsOnDate()%>">
										   
										    <!-- ----Ibas Vers 3 required---- -->
										    <%-- <input type="hidden" name="loginType" value="<%=logintype%>">
										    <input type="hidden" name="empId" value="<%=empId%>">
										    <input type="hidden" name="loginId" value="<%=loginId%>">
										    <input type="hidden" name="divisionId" value="<%=divisionId%>">
										    <input type="hidden" name="formRoleId" value="<%=formRoleId%>">
										    <input type="hidden" name="userName" value="<%=Username%>"> --%>
                                            <!-- -------- -->
											
										    
										 
										    
										    <button type="submit" class="btn btn-sm" style="float: right;background-color: #23689b;color: white" ><img src="view/images/projecticon.png"/> &nbsp;Project Details</button>
										  
										  </form>
										</nav>
										
										
										<div class="" id="container<%=obj.getSno()%>" style="height: 12rem;"></div>
											<div>
												<table>
													<tr>
														<td  style="padding : 0px 30px;"><span style="font-size :12px;font-weight: bold; ">SANC	</span></td>
											       		<td  style="padding : 0px 30px;"><span style="font-size :12px;font-weight: bold; ">EXP</span></td>
											       		<td  style="padding : 0px 30px;"><span style="font-size :12px;font-weight: bold;  ">OS</span></td>
											       		<td  style="padding : 0px 30px;"><span style="font-size :12px;font-weight: bold;  ">DIPL</span></td>
											       		<td  style="padding : 0px 30px;"><span style="font-size :12px;font-weight: bold;  ">BAL</span></td>	       			
											       	</tr>
													<tr>
														<td align="center"><button type="button"  class="btn btn-sm " style="background-color: #f7be16; "  ><%=obj.getSancAmt() %> L </button></td>
														<td align="center"><button type="button"  class="btn btn-sm " style="background-color: #ac0d0d;color:white; "><%=obj.getExpAmt() %> L</button></td>
													    <td align="center"><button type="button"  class="btn btn-sm " style="background-color: #fb7813;color:white; "><%=obj.getOsComAmt() %> L</button></td>
													    <td align="center"><button type="button"  class="btn btn-sm " style="background-color: #0e49b5;color:white; "><%=obj.getDipl() %> L</button></td>
													    <td align="center"><button type="button"  class="btn btn-sm " style="background-color: #06623b;color:white; "><%=obj.getBalAmt() %> L</button></td>					
											       	</tr>
												</table>
											</div>	
										</div> 
									<% i++;
									} %>
									
							
							</div>
							
						</div>
						
						
						</div>
						
						
					</div>
				
				
				<%for(ProjectSanctionDetailsMaster obj : budgetlist){ %>
				
				
				
					<script>
					
					
					
					anychart.onDocumentReady(function () {

					    // create data
					    var data = [
					      {x: "EXP ", value: <%=obj.getExpAmt()%>, fill : "#ac0d0d"},
					      {x: "OS ", value: <%=obj.getOsComAmt()%> , fill : "#fb7813"},
					      {x: "DIPL ", value: <%=obj.getDipl()%> , fill : "#0e49b5"},
					      {x: "BAL  ", value: <%=obj.getBalAmt()%>, fill : "#06623b"},
					      
					    ];
					    
					    // create a chart and set the data
					    var chart = anychart.pie3d(data);
					    
					    var legend= chart.legend();
					    //legend.enabled(false);
					    //legend.position("right");
					    
					    legend.positionMode("inside");
						// set position and alignement
						legend.position("center");
						legend.align("right");
						legend.itemsLayout("vertical");
					    
					    
					 	
					    var tooltip = chart.tooltip();

					    tooltip.enabled(true);
					    tooltip.fontColor('white');
					    tooltip.fontWeight(600);
					    tooltip.background('black');
					    tooltip.titleFormat('{%x}');
					    tooltip.format('Amount : {%value} Lakhs \n Percentage : {%yPercentOfTotal} %');
					    
					   /*  var credits = chart.credits();
					    credits.alt("VTS"); */
					 
					  /*   chart.labels().position("outside"); */
					 				    
					    chart.startAngle(90);
					    
					    // set the chart title

					    // set the container id
					    chart.container('container<%=obj.getSno()%>');

					    // initiate drawing the chart
					    chart.draw();
					    
					});				
						
					
					
					
					</script>
				<%} %>
				
			<%} %>	 
			
			<%} %>
			
		<!-- -----------------PROJECT DASHBOARD SELECTED FINANCIAL PERFORMANCE DISPLAY END---------------------------- -->	
		       
		       
		<!-- -----------------ACTION DASHBOARD TASKBAR STARTS---------------------------- -->	
		      
		       <div class="card" style="background: transparent;display:none" id="mytasks">
						
							<nav class="navbar navbar-light bg-primary " style="background-color: #e3f2fd;">
								<a class="navbar-brand" style="color:white;" >My Tasks</a><a style="color:white" href="FeedBack.htm" title="Feedback"><i class="fa fa-commenting" aria-hidden="true"></i></a>
							</nav>					
											
								<div id="" class="carousel slide carousel-interval" data-ride="carousel"  style="padding: 3px 0px 7px 4px;">
									<div class="carousel-inner">
									   
										    	<table class="table meeting" style="height: 70px; margin : 0px 0px 0px 0px;"  >													
													<tr>
														<td style="padding : 5px 15px 5px 15px;"></td>
													    <td  style="padding : 5px 15px 5px 15px;"><span style="font-size :12px;font-weight: bold; ">All PDC</span></td>
													    <td  style="padding : 5px 15px 5px 15px;"><span style="font-size :12px;font-weight: bold;  ">In Progress</span></td>
													    <td  style="padding : 5px 15px 5px 15px;"><span style="font-size :12px;font-weight: bold;  ">Today PDC</span></td>
<!-- 													    <td  style="padding : 5px 15px 5px 15px;"><span style="font-size :12px;font-weight: bold;  ">Upcoming</span></td>
 -->													    <td  style="padding : 5px 15px 5px 15px;"><span style="font-size :12px;font-weight: bold;  ">Review</span></td>
													</tr>
				
				
													<tr>
														<td  style="padding : 5px 0px 5px 0px;text-align: left">Action</td>
														<%int actionCounts=0;
														for(Object[] obj : MyTaskList){
														  	if(obj[0].toString().equalsIgnoreCase("Actions")){ %>
														
														<td><button type="button" onclick="actionformtask('N','N')" class="btn btn-sm <%if(!obj[1].toString().equals("0")){ %> <%} %> " style="background-color: #dc3545;color:white; "><%=obj[1] %></button></td>
														<td><button type="button" onclick="actionformtask('I','N')"  class="btn btn-sm " style="background-color: #ff8400;color:white; "><%=obj[2] %></button></td>
														<td><button type="button" <%if(!obj[3].toString().equals("0")){ %> onclick="document.location='AssigneeList.htm'"<%} %>  class="btn btn-sm  <%if(!obj[3].toString().equals("0")){ %> fa faa-pulse animated faa-fast <%} %> " style="background-color: #448fea;color:white; "><%=obj[3] %></button></td>
<%-- 														<td><button type="button" onclick="actionformtask('S','N')"  class="btn btn-sm " style="background-color: #008891;color:white; "><%=obj[4] %></button></td>
 --%>														<td><button type="button" onclick="document.location='ActionForwardList.htm'"  class="btn btn-sm " style="background-color: #233E8B;color:white; "><%=obj[5] %></button></td>
														
														<% actionCounts+=Integer.parseInt(obj[3].toString());}   } %>
														
													</tr>
													<tr>
														<td  style="padding : 5px 0px 5px 0px;text-align: left">Meeting</td>
														
														<%for(Object[] obj : MyTaskList){
														  	if(obj[0].toString().equalsIgnoreCase("Meeting")){ %>
														
														<td><button type="button" onclick="actionformtask('N','S')"  class="btn btn-sm <%if(!obj[1].toString().equals("0")){ %>  <%} %> " style="background-color: #dc3545;color:white; "><%=obj[1] %></button></td>   <!--changed 'E' to 'N'  -->   
														<td><button type="button" onclick="actionformtask('I','S')"  class="btn btn-sm " style="background-color: #ff8400;color:white; "><%=obj[2] %></button></td>
														<td><button type="button" <%if(!obj[3].toString().equals("0")){ %> onclick="document.location='AssigneeList.htm'"<%} %> class="btn btn-sm <%if(!obj[3].toString().equals("0")){ %> fa faa-pulse animated faa-fast <%} %> " style="background-color: #448fea;color:white; "><%=obj[3] %></button></td>
<%-- 														<td><button type="button" onclick="actionformtask('S','S')"  class="btn btn-sm " style="background-color: #008891;color:white; "><%=obj[4] %></button></td>
 --%>														<td><button type="button" onclick="document.location='ActionForwardList.htm'" class="btn btn-sm " style="background-color: #233E8B;color:white; "><%=obj[5] %></button></td>
														
														<% actionCounts+=Integer.parseInt(obj[3].toString());}  } %>
														
													<tr>
													
													<%if(!IsDG.equalsIgnoreCase("Yes")){ %>
													
													<tr>
														<td  style="padding : 5px 0px 5px 0px;text-align: left">Milestone</td>
														
														<%for(Object[] obj : MyTaskList){
														  	if(obj[0].toString().equalsIgnoreCase("Milestone")){ %>
														
														<td><button type="button" onclick="actionformtask('N','M')"  class="btn btn-sm <%if(!obj[1].toString().equals("0")){ %>  <%} %> " style="background-color: #dc3545;color:white; "><%=obj[1] %></button></td>
														<td><button type="button" onclick="actionformtask('I','M')"  class="btn btn-sm " style="background-color: #ff8400;color:white; "><%=obj[2] %></button></td>
														<td><button type="button" <%if(!obj[3].toString().equals("0")){ %> onclick="document.location='AssigneeList.htm'"<%} %>  class="btn btn-sm <%if(!obj[3].toString().equals("0")){ %> fa faa-pulse animated faa-fast <%} %> " style="background-color: #448fea;color:white; "><%=obj[3] %></button></td>
<%-- 														<td><button type="button" onclick="actionformtask('S','A')"  class="btn btn-sm " style="background-color: #008891;color:white; "><%=obj[4] %></button></td>
 --%>														<td><button type="button" onclick="document.location='ActionForwardList.htm'" class="btn btn-sm " style="background-color: #233E8B;color:white; "><%=obj[5] %></button></td>
														
														<% actionCounts+=Integer.parseInt(obj[3].toString());} } %>
														
													</tr>
													<tr>
														<td  style="padding : 5px 0px 5px 0px;text-align: left">Fracas</td>
														
														<%for(Object[] obj : MyTaskList){
														  	if(obj[0].toString().equalsIgnoreCase("Fracas")){ %>
														
														<td><button type="button" onclick="document.location='FracasAssigneeList.htm'" class="btn btn-sm <%if(!obj[1].toString().equals("0")){ %>  <%} %> " style="background-color: #dc3545;color:white; "><%=obj[1] %></button></td>
														<td><button type="button" onclick="document.location='FracasAssigneeList.htm'" class="btn btn-sm " style="background-color: #ff8400;color:white; "><%=obj[2] %></button></td>
														<td><button type="button" onclick="document.location='FracasAssigneeList.htm'" class="btn btn-sm <%if(!obj[3].toString().equals("0")){ %> fa faa-pulse animated faa-fast <%} %> " style="background-color: #448fea;color:white; "><%=obj[3] %></button></td>
<%-- 														<td><button type="button" onclick="document.location='FracasAssigneeList.htm'" class="btn btn-sm " style="background-color: #008891;color:white; "><%=obj[4] %></button></td>
 --%>														<td><button type="button" onclick="document.location='FracasToReviewList.htm'" class="btn btn-sm " style="background-color: #233E8B;color:white; "><%=obj[5] %></button></td>
													
														<% actionCounts+=Integer.parseInt(obj[3].toString());} } %>
													
													</tr>
													
													
													<%} %>
				
													
												 </table>
								
										  </div>
				
									</div> 
							
							</div> 
				
		<!-- -----------------ACTION DASHBOARD TASKBAR ENDS---------------------------- -->	
			
		<!-- -----------------OVERALL DASHBOARD HEADING STARTS---------------------------- -->							
		
						<div class="row" >
							<div class="col-md-6">
								<div style="display: none" class="overallheader">
									<h4 style="color: #145374;margin-bottom: 7px" id="projecttitle" class="health-title"> PROJECT HEALTH</h4>
									<hr style="margin: 3px 0px 9px 0px !important">
								</div>
							</div>
							<div class="col-md-2">
								
							</div>
						</div>

	 <!-- -----------------OVERALL DASHBOARD HEADING ENDS---------------------------- -->	

			</div>
<!-- @@@@@@@@@@ NESTED ROW BUDGET START @@@@@@@@@@  --> 	
			      

 
    <!-- -----------------PROJECT DASHBOARD GANTT CHART STARTS---------------------------- -->	
	          <div class="col-md-12">
			    	
			      	<%if(ProjectList!=null){ %>
						<div style="background: transparent;display: none" id="ganttchart" >
						<div class="card"  >
				
							<div id="carouselExampleControls2" class="" data-ride=""  >
								<div class="carousel-inner">
								 <%if(ProjectList!=null) {for(Object[] obj1 : ProjectList){ 
								 if(!"0".equalsIgnoreCase(obj1[0].toString())){
								 %>
			
								    <div class="carousel-item " style="overflow-y: auto;" id="Mil<%=obj1[0]%>">
								    
									    <nav class="navbar navbar-light bg-primary " style="background-color: #e3f2fd;">
												<form class="form-inline" method="post" action="GanttChart.htm" id="myform" >
													<input type="hidden" name="ProjectId"  id="ProjectId" value="<%=obj1[0] %>" /> 
								 					<input  class="btn btn-primary gantt navbar-brand text-white" id="gantt" type="submit" name="sub" value=" &nbsp;&nbsp;&nbsp; Gantt Chart" style="background-color: #23689b;color:white" > 
								 					<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" /> 
								 				</form>
								 				

												<%if(!obj1[0].toString().equalsIgnoreCase("0")){ %>
														<span style="font-size: 15px;text-transform: capitalize;color:white"><%=obj1[14] %> (<%=obj1[11] %>)</span>
												<%} %>
												
								 				
								 				<form method="post" action="ProjectBriefingPaper.htm">
													<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
													<button  class="btn btn-primary navbar-brand text-white" style="background-color: #23689b;color:white" ><img src="view/images/camera.png"/> Project Snapshot </button>
													<input type="hidden" name="projectid" value="<%=obj1[0] %>" />
												</form>
								 				
										</nav> 
						

					   				<div class="flex-container" id="containers<%=obj1[0] %>" style="height:13.5rem" ></div>

									   
									</div>
			
								 <%} } } %>
			
									  </div>
								</div> 
			
							</div>
						</div>	
							
					<%if(ProjectList!=null){
						for(Object[] obj1 : ProjectList){%> 
					
						<script>
							anychart.onDocumentReady(function () {
								    	  var data = [
								    		  <%
								    		  for(Object[] obj : ganttchartlist){
								    			  if(obj1[0].toString().equalsIgnoreCase(obj[1].toString())){
								    			  %>	
								    		  {
								    		    id: "<%=obj[3]%>",
								    		    name: "<%=obj[2]%>",
								    		    <%if(!obj[9].toString().equalsIgnoreCase("0")){%>
								    		   	baselineStart: "<%=obj[6]%>",
								    		    baselineEnd: "<%=obj[7]%>", 
								    		    <%}%>
								    		    baseline: {fill: "#f25287 0.5", stroke: "0.5 #dd2c00"},
								    		    actualStart: "<%=obj[4]%>",
								    		    actualEnd: "<%=obj[5]%>",
								    		    actual: {fill: "#046582", stroke: "0.8 #150e56"},
								    		    progressValue: "<%= Math.round((int)obj[8])%>%",
								    		    progress: {fill: "#81b214 0.5", stroke: "0.5 #150e56"},
								    		    rowHeight: "35",
								    		   
								    		  },
								    		  
								    		  <%}}%>
								    	
								    		  ];
								    		    
								    		 
								    	// create a data tree
								    		var treeData = anychart.data.tree(data, "as-tree");
								
								    		// create a chart
								    		var chart = anychart.ganttProject();
								
								    		// set the data
								    		chart.data(treeData);   
								  
								        	// set the container id
								        	
								        	chart.container("containers<%=obj1[0]%>");  
								        	

								        	// initiate drawing the chart
								        	chart.draw();    
									
								        	 // fit elements to the width of the timeline
								        	chart.fitAll(); 
								        
								        	 
								        	 /* ToolTip */
								        	chart.getTimeline().tooltip().useHtml(true);    
									        chart.getTimeline().tooltip().format(
									          "<span style='font-weight:600;font-size:10pt;text-align:left'> Actual : " +
									          "{%actualStart}{dateTimeFormat:dd MMM yyyy} - " +
									          "{%actualEnd}{dateTimeFormat:dd MMM yyyy}</span><br>" +
									          "<span style='font-weight:600;font-size:10pt;text-align:left'> Revised : " +
									          "{%baselineStart}{dateTimeFormat:dd MMM yyyy} - " +
									          "{%baselineEnd}{dateTimeFormat:dd MMM yyyy}</span><br>" +
									          "Progress: {%progress}<br>" 
									          
									        ); 
								        	 
								        /* Hover */
								        
								        chart.rowHoverFill("#8fd6e1 0.3");
								        chart.rowSelectedFill("#8fd6e1 0.3");
								        chart.rowStroke("0.5 #64b5f6");
								        chart.columnStroke("0.5 #64b5f6");
								        
								        chart.defaultRowHeight(35);
								     	chart.headerHeight(90);
								     	
								     	/* Hiding the middle column */
								     	chart.splitterPosition("17.4%");
								     	
								     	var dataGrid = chart.dataGrid();
								     	dataGrid.rowEvenFill("gray 0.3");
								     	dataGrid.rowOddFill("gray 0.1");
								     	dataGrid.rowHoverFill("#ffd54f 0.3");
								     	dataGrid.rowSelectedFill("#ffd54f 0.3");
								     	dataGrid.columnStroke("2 #64b5f6");
								     	dataGrid.headerFill("#64b5f6 0.2");
								     	
								     
								     	/* Title */
								     	var column_1 = chart.dataGrid().column(0);
								     	column_1.title().enabled(false);
								     	
								     	var column_2 = chart.dataGrid().column(1);
								     	column_2.title().text("Activity");
								     	column_2.title().fontColor("#145374");
								     	column_2.title().fontWeight(600);
								     	
								     	chart.dataGrid().column(0).width(20);

								     	var column_1 = chart.dataGrid().column(1);
								     	column_1.labels().fontWeight(600);
								     	column_1.labels().useHtml(true);
								     	column_1.labels().fontColor("#055C9D");

									    chart.getTimeline().scale().zoomLevels([["quarter", "semester","year"]]);
	
									    chart.dataGrid().tooltip().useHtml(true);    	
									    
								     	/* Header */
								     	var header = chart.getTimeline().header();
								     	header.level(0).fill("#64b5f6 0.2");
								     	header.level(0).stroke("#64b5f6");
								     	header.level(0).fontColor("#145374");
								     	header.level(0).fontWeight(600);
								     	
								     	header.level(1).format(function() {
							     			
							     			var duration = '';
							     		
							     			if(this.value=='Q1')
							     				duration='H1';
							     			if(this.value=='Q3')
							     				duration='H2'
		
							     		  return duration;
							     		});
								     	
								     	
								     	/* Marker */
								     	var marker_1 = chart.getTimeline().lineMarker(0);
								     	marker_1.value("current");
								     	marker_1.stroke("2 #dd2c00");
								     	
								     	/* Progress */
								     	var timeline = chart.getTimeline();
								     	
								     	timeline.tasks().labels().useHtml(true);
								     	 timeline.tasks().labels().format(function() {
								     	  if (this.progress == 1) {
								     	    return "<span style='color:orange;font-weight:bold;font-family:'Lato';'>Completed</span>";
								     	  } else {
								     	    return "<span style='color:black;font-weight:bold'>" +
								     	           Math.round(this.progress * 100) + "</span>%";
								     	  }
								     	}); 

								       
								      } );    
	
								    </script>	
							
						<% } } %>

					<%} %> 
		
				</div>
     <!-- -----------------PROJECT DASHBOARD GANTT CHART ENDS---------------------------- -->	
			
    <!-- -----------------ACTION DASHBOARD UPCOMING SCHEDULE STARTS---------------------------- -->	
    
          <div class="col-md-4">
		       
		       <br>	
		       <div class="card" style="background: transparent;display: none" id="upcomingschedules">
						
							<nav class="navbar navbar-light bg-primary " style="background-color: #e3f2fd;">
								<a class="navbar-brand" style="color:white"; >Upcoming Schedule Details</a>
							</nav>					
											
								<div style="background-color: rgba(255, 255, 255, 0.39999) !important;max-height:14rem ;overflow-y: auto ;border-radius: 4px ">
								
									<table class="table meeting " >	
										<thead>												
											<tr>
												<td ><span style="font-size :15px;font-weight: bold; "></span></td>
												<td ><span style="font-size :15px;font-weight: bold; ">Date</span></td>
												<td ><span style="font-size :15px;font-weight: bold;  ">Time</span></td>
												<td ><span style="font-size :15px;font-weight: bold;  ">Committee</span></td>
											</tr>
										</thead>
										
										<%
										int newsize=0;
										if(todayschedulelist.size()!=0){
											int count1=1;
											for(Object[] obj : todayschedulelist) {
												if(!obj[3].toString().equalsIgnoreCase(TodayDate)){	%>
							
										<tbody>
										
											<tr>
												<td><a href="javascript:void(0)" onclick="location.href='CommitteeScheduleView.htm?scheduleid=<%=obj[2] %>' " ><i class="fa fa-hand-o-right" aria-hidden="true" style="color: purple;font-size: 1.3rem !important"></i></a></td>
												<td><%=sdf.format(obj[3]) %></td>
												<td><%=obj[4] %></td>
												<td><%=obj[7] %></td>
											</tr>
											
											<%count1++;newsize++;}}} %>
											
											<%if(newsize==0){%>
												<tr>
												<td colspan="5">
													<br>
														<h6 align="center">No Upcoming Schedules</h6>
													<br>
												</td>	
												<tr>
											<%} %>
											
										</tbody>
											
											
									</table>				
				
								</div> 
							
							</div> 
							
					</div>		
            <!-- -----------------ACTION DASHBOARD UPCOMING SCHEDULE ENDS---------------------------- -->				
					
		
					
		<div class="col-md-8">
		       <br>	
		       	<!-- -----------------ACTION DASHBOARD MY TASK DETAILS STARTS---------------------------- -->	
		       	
		       		 <div class="card" style="background: transparent;display:none" id="mytaskdetails">
						
							<nav class="navbar navbar-light bg-primary " style="background-color: #e3f2fd;">
								<a class="navbar-brand" style="color:white"; >My Task Details</a>
							</nav>					
											
								<div style="background-color: rgba(255, 255, 255, 0.39999) !important;max-height:14rem ;overflow-y: auto ;border-radius: 4px ">
								
									<table class="table meeting " >	
										<thead>												
											<tr>
												<td ><span style="font-size :15px;font-weight: bold; "></span></td>
												<td ><span style="font-size :15px;font-weight: bold; ">Action Item</span></td>
												<td ><span style="font-size :15px;font-weight: bold;">PDC </span></td>
												<td ><span style="font-size :15px;font-weight: bold;  ">Assigned By</span></td>
											</tr>
										</thead>
										
										<%
										int newsizefortask=0;
										if(mytaskdetails.size()!=0){
											int count1=1;
											for(Object[] obj : mytaskdetails) {
												if(obj[11].toString().equalsIgnoreCase("A")){
												
												%>
							
										<tbody>
										
											<tr>
												<td><a href="javascript:MyTaskDetails(<%=obj[0]%>)"> <i class="fa fa-hand-o-right" aria-hidden="true" style="color: purple;font-size: 1.3rem !important"></i></a></td>
												<td style="text-align:justify; "><%=obj[2] %></td>
												<td style="width:100px"><%=sdf.format(obj[4]) %></td>
												<td><%=obj[12] %>

													<form name="MyTaskDetails<%=obj[0]%>" id="MyTaskDetails<%=obj[0]%>" action="<%=obj[14] %>" method="POST" >
														<input type="hidden" name="Assigner" value="<%=obj[12]%>,<%=obj[13]%>"/>													
		                                                <input type="hidden" name="ActionLinkId" value="<%=obj[15]%>"/>
														<input type="hidden" name="ActionNo" value="<%=obj[1]%>"/>
		 												<input type="hidden" name="ActionMainId" value="<%=obj[0]%>"/>
		 												<input type="hidden" name="fracasassignid" value="<%=obj[0]%>"/>
		 												<input type="hidden" name="ActionAssignid" value="<%=obj[16]%>"/>
		 												<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
													</form> 
												
												</td>
												
											</tr>
											
											<%count1++;newsizefortask++;}}} %>
											
											<%if(newsizefortask==0){%>
												<tr>
												<td colspan="5">
													<br>
														<h6 align="center">No Task Details</h6>
													<br>
												</td>	
												<tr>
											<%} %>
											
										</tbody>
											
											
									</table>	
									
												
				
								</div> 
							
							</div> 
							<!-- -----------------ACTION DASHBOARD MY TASK DETAILS ENDS---------------------------- -->	
							
							<!-- -----------------ACTION DASHBOARD Briefing Paper,Project Meeting,Annual Meeting STARTS---------------------------- -->	
							
							<%if(!IsDG.equalsIgnoreCase("Yes")){ %>
							
							<%if(QuickLinkList.size()>0){ %>
							<div class="multi-button" id="quicklinks" style="display: none">
									  <span><span class="badge badge-success"><i class="fa fa-link" aria-hidden="true"></i></span>  Links : </span>
									  
									<%for(Object[] obj : QuickLinkList){ %>
										<a class="button" href="<%=obj[1] %>" id="cut"><span><%=obj[0] %> &nbsp;<i class="fa fa-file-text" aria-hidden="true"></i></span></a>									  <%} %>
										</div>
									<%} %>
							
							<%} %>
						  <!-- -----------------ACTION DASHBOARD Briefing Paper,Project Meeting,Annual Meeting ENDS---------------------------- -->	
		
			</div>
		 
			
		
			
		   
			 
			      
		</div>
<!-- @@@@@@@@@@ NESTED ROW END @@@@@@@@@@  --> 				
		    
		    
		</div>  
<!-- @@@@@@@@ MAIN ROW col-md-9 END @@@@@@@ -->		
		  	
	
<!-- @@@@@@@@ MAIN ROW col-md-3 START @@@@@@@ -->		

		 <div class="col-md-3" >
		
		 <!-- ----------- COMMON TOGGLE BUTTONS(ACTION,PROJECT,OVERALL) STARTS --------------------------- --> 	
		   <div style="float: right;padding:5px;margin-top:-7px; <%if(logintype.equalsIgnoreCase("U") ) { %>  display:none   <%}%> ">
		  	 <div class="btn-group "> 
	
		  	 	  	<form id="pmsToIbasForm" action="<%=pmsToStatsUrl%>" target="blank" method="get"> 
             <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
             <input type="hidden" name="username" value="<%=Username%>">
             <input type="hidden" name="action" value="loginFromPms">
             <!--  <input type="hidden" name="redirectVal" value="">  -->
<!-- 		  <button type="submit" class="btn External" data-toggle="tooltip" title="STATS" ><img src="view/images/stats.png" /></button>
 -->		  	</form>
		  	 	
		  	 	<form action="ProjectHealthUpdate.htm" method="get" style=" <%if (IsDG.equalsIgnoreCase("Yes") ){%> display:none   <%}%>" >
		        	<button type="submit" class="btn btn4" data-toggle="tooltip" title="Refresh" ><i class="fa fa-refresh" style="font-size: 21px" aria-hidden="true"></i></button>
		        </form>
		        <button class="btn btn1">Action</button>
		        <button class="btn btn2" style="<% if(Arrays.asList(LoginTypes).contains((String)request.getAttribute("logintype"))){ %> border-right: 1px solid black !important;<%}%><%if (IsDG.equalsIgnoreCase("Yes") ){%>display:none<%} %>">Project</button>
		        <button class="btn <%if (IsDG.equalsIgnoreCase("Yes") ){%>btn5<%} else {%>btn3<%} %>"  style="<% if(!Arrays.asList(LoginTypes).contains((String)request.getAttribute("logintype"))){ %> display:none  <%}%>  " >Overall</button>
		      </div>
		  </div>	
		 <!-- ----------- COMMON TOGGLE BUTTONS(ACTION,PROJECT,OVERALL) ENDS --------------------------- --> 	

		 <!-- ----------- ACTION DASHBOARD NOTICE MAIN ROW STARTS--------------------------- --> 	
		  		<div class="card notice col-12 "  style="margin-top: 4px;"  >
					
					<div class="card-body"  style="background-color : #0000 ;padding-bottom: 5px !important;display: none" id="noticeboard" >
						<span class="side-stick"></span>
						<div class="side-stick-right "  style="max-width: 10%;" > 
							
							<table>
								<%if(noticeElib>0){%> 	
									<tr>
										<td style="padding: 5px;"> <a  data-toggle="modal" data-target="#exampleModal" data-whatever="@mdo" ><i class="fa fa-plus-square fa-lg" style="color: #ec524b" aria-hidden="true"></i> </a></td>
									</tr>
									<tr>
										<td style="padding: 5px;"> <a  href="IndividualNoticeList.htm" ><i class="fa fa-file-text fa-lg "  style="color: #7868e6 "  aria-hidden="true">  </i></a> </td>
									</tr>
								<%} %>
								<%if(notice!=null&& notice.size()>1){%> 
									<tr>
									</tr>
									
										     	<%} %>
							</table>
						</div>
						
						<div style="max-width: 90%;" >
 							<blink>	<h5 style="color: #e84545;">Notice</h5></blink>
							
							<div id="carouselExampleControls6" class="carousel vert slide" data-ride="carousel" data-interval="5000">
								       
								    <div class="carousel-inner">
								        
								        	<% if(notice.size()>0){
										  for(Object[] obj : notice){
											  	%>
								        
								            <div class="carousel-item " id="notice" style="background-color: rgba(255, 255, 255, 0.08888) !important;color:black ;">
								            
											    <p style="font-weight: lighter; font-size: 12px;text-align:justify;  text-justify: inter-word;" align = "center" ><%if(notice!=null && notice.size()>0){ %> <%=obj[1] %> <%} %> </p>
												<p style="font-weight: lighter; font-size: 12px;" align="right" > <%if(notice!=null && notice.size()>0){ %>-&nbsp; <%=obj[2]%> <%} %> </p> 

								            </div>

											
											<%} }else{%>

										 	<p style="font-weight: lighter; font-size: 12px;" align="right" > No Notice. </p> 
										 	
										 <%} %> 
			
								      </div>
								        
							</div> 
						
						</div>
										
					</div>
				</div>
				
	 <!-- ----------- ACTION DASHBOARD NOTICE MAIN ROW ENDS--------------------------- --> 	
							
							
    <!-- @@@@@@@@@@@@@@@@ DIV CARD BOX STARTS @@@@@@@@@@@@@@@@@@@@@@@ -->

				<div class="card box" style="background: transparent;margin-top: 5px;background-color: rgba(255, 255, 255, 0.3) !important;display:none" id="mainactivitystatus" >
							
						<div class="card-header" style="padding: .25rem 1.25rem !important;background-color: #007bff;color:white;text-align: left;border-radius:5px;display: none" id="activitystatusheader">
								    Activity Status 
						</div>
						
						<div class="card-body" style="padding: 0px;">
						
					 <!-- ----------- PROJECT DASHBOARD ACTIVITY STATUS STARTS------------- -->
					 
							<%if(!logintype.equalsIgnoreCase("U") ) { %>
							
							<!-- <div id="carouselExampleControls3" class="carousel slide carousel-interval" data-ride="carousel"  style="padding: 3px 0px 7px 4px;"> -->
							<!-- Uncomment the above line to add carousel -->	
							<div id="carouselExampleControls3" class="" data-ride=""  style="padding: 3px 0px 7px 4px;">
									
									<div class="carousel-inner" style="display: none" id="activitystatus">
									
											<%if(actionscount!=null){									
												if(loginlist.contains(logintype))
												    { %>	
										    
										    	<%if(ProjectList!=null){ %>
									   				 <%for(Object[] obj : ProjectList){ %>
										    
										    
										<div class="carousel-item "  id="act<%=obj[0]%>">
									    
										    	<table class="table" style="height: 70px; margin : 0px 0px 0px 0px;"  >													
													<tr>
																		<td style="padding : 5px 15px 5px 15px;"></td>
													       				<td  style="padding : 5px 15px 5px 15px;"><span style="font-size :12px;font-weight: bold; ">P</span></td>
													       				<td  style="padding : 5px 15px 5px 15px;"><span style="font-size :12px;font-weight: bold;  ">F</span></td>
													       				<td  style="padding : 5px 15px 5px 15px;"><span style="font-size :12px;font-weight: bold;  ">C</span></td>
													       				<td  style="padding : 5px 15px 5px 15px;"><span style="font-size :12px;font-weight: bold;  ">D</span></td>	       			
													       			</tr>
				
													<%if(actionscount!=null){ %>	
															
													<%for(Object[] obj2 : actionscount){ %>
				
														<%if(obj[0].toString().equalsIgnoreCase(obj2[4].toString())) { %>
																						
													<tr>
																		<td  style="padding : 5px 0px 5px 0px;text-align: left" >Action Items</td>
																	   	<td><button type="button" onclick="submitForm('P','<%=obj[0] %>');" class="btn btn-sm " style="background-color: #ff8400;color:white;; "><%=obj2[0] %> </button></td>
															            <td><button type="button" onclick="submitForm('F','<%=obj[0] %>');" class="btn btn-sm " style="background-color: #448fea; color:white; "><%=obj2[1] %> </button></td>
															            <td><button type="button" onclick="submitForm('Y','<%=obj[0] %>');" class="btn btn-sm " style="background-color: #008891;color:white; "><%=obj2[2] %> </button></td>
															            <td><button type="button" onclick="submitForm('E','<%=obj[0] %>');" class="btn btn-sm " style="background-color: #e85342;color:white; "><%=obj2[3] %> </button></td>					
													       			</tr>
													       			 <tr>
																		<td  style="padding : 5px 0px 5px 0px;text-align: left">Milestones</td>
																	   	<td><button type="button" onclick="submitForm('P','<%=obj[0] %>');" class="btn btn-sm " style="background-color: #ff8400;color:white;color:white; ">0 </button></td>
															            <td><button type="button" onclick="submitForm('F','<%=obj[0] %>');" class="btn btn-sm " style="background-color: #448fea;color:white; ">0 </button></td>
															            <td><button type="button" onclick="submitForm('Y','<%=obj[0] %>');" class="btn btn-sm " style="background-color: #008891;color:white; ">0 </button></td>
															            <td><button type="button" onclick="submitForm('E','<%=obj[0] %>');" class="btn btn-sm " style="background-color: #e85342;color:white; ">0</button></td>					
													       			</tr>
													       			<tr>
																		<td  style="padding : 5px 0px 5px 0px;text-align: left">Activity</td>
																	   	<td><button type="button" onclick="submitForm('P','<%=obj[0] %>');" class="btn btn-sm " style="background-color: #ff8400;color:white;color:white; ">0</button></td>
															            <td><button type="button" onclick="submitForm('F','<%=obj[0] %>');" class="btn btn-sm " style="background-color: #448fea;color:white; ">0 </button></td>
															            <td><button type="button" onclick="submitForm('Y','<%=obj[0] %>');" class="btn btn-sm " style="background-color: #008891;color:white; ">0 </button></td>
															            <td><button type="button" onclick="submitForm('E','<%=obj[0] %>');" class="btn btn-sm " style="background-color: #e85342;color:white; ">0 </button></td>					
													       			</tr>
													       			<tr>
																		<td  style="padding : 5px 0px 5px 0px;text-align: left">Risks</td>
																	   	<td><button type="button" onclick="submitForm('P','<%=obj[0] %>');" class="btn btn-sm " style="background-color: #ff8400;color:white;color:white; ">0</button></td>
															            <td><button type="button" onclick="submitForm('F','<%=obj[0] %>');" class="btn btn-sm " style="background-color: #448fea;color:white; ">0 </button></td>
															            <td><button type="button" onclick="submitForm('Y','<%=obj[0] %>');" class="btn btn-sm " style="background-color: #008891;color:white; ">0 </button></td>
															            <td><button type="button" onclick="submitForm('E','<%=obj[0] %>');" class="btn btn-sm " style="background-color: #e85342;color:white; ">0 </button></td>					
													       			</tr>
													       			<tr>
																		<td  style="padding : 5px 0px 5px 0px;text-align: left;">Issues</td>
																	   	<td><button type="button" onclick="submitForm('P','<%=obj[0] %>');" class="btn btn-sm " style="background-color: #ff8400;color:white;color:white; ">0</button></td>
															            <td><button type="button" onclick="submitForm('F','<%=obj[0] %>');" class="btn btn-sm " style="background-color: #448fea;color:white; ">0 </button></td>
															            <td><button type="button" onclick="submitForm('Y','<%=obj[0] %>');" class="btn btn-sm " style="background-color: #008891;color:white; ">0 </button></td>
															            <td><button type="button" onclick="submitForm('E','<%=obj[0] %>');" class="btn btn-sm " style="background-color: #e85342;color:white; ">0 </button></td>					
													       			</tr> 
												       	
															<%}%>
				
														<%} %>
													
													<%} %>
				
													
												 </table>
										    </div>
										    
										    <%}} %>
										    
										    
										    
										    <%} %>
										    
										    <%} else{ %>
										    
										    
										    	<div class="list-group-item" style="background-color: rgba(255, 255, 255, 0.08888) !important;border: none;margin: 19%">
										    		No Activities
										    	</div>
										    
										    <%} %>
										    
										  </div>
										  
				
								</div> 
								
							<%} %>	
							
		<!-- ----------- PROJECT DASHBOARD ACTIVITY STATUS ENDS------------- -->
								

	     <!-- ----------- ACTION DASHBOARD  REVIEW  BLOCK STARTS------------- -->

		   					<div class="card-header" style="padding: .25rem 1.25rem !important;background-color: #007bff;color:white;text-align: left;border-radius:5px;display:none" id="reviewheader">
								<span style="font-size:12px ">Review - Pending with My Approver</span>
							</div>	
		   
							<div style="margin-top:5px;display:none" id="review">
									
									 <!-- <div align="center"> Action Items</div> -->		
													
													<!-- Actions Start -->
													
											<div style="  <%if(logintype.equalsIgnoreCase("U")){ %>   max-height:9rem <%}else{ %> max-height:9rem  <%} %>;overflow-y: auto ; ">
																				
															<ul style="padding: 0px">	 
																					  
																<% int formcount=1;
																	if(dashboardactionpdc.size()>0){
																  for(Object[] obj : dashboardactionpdc){
																	  if(obj[15].toString().equalsIgnoreCase("A")){
																	  	%>
																  
																    <li class="list-group-item" style="background-color: rgba(255, 255, 255, 0.08888) !important; padding : 12px 0px !important;">
																    	
																    	<form name="Action<%=formcount%>" id="Action<%=formcount%>" action="<%=obj[7] %>" method="POST" >
																    	
																    		<input type="hidden" name="Assigner" value="<%=obj[11]%>,<%=obj[13]%>"/>													
		                                                                    <input type="hidden" name="ActionLinkId" value="<%=obj[10]%>"/>
																			<input type="hidden" name="ActionMainId" value="<%=obj[9]%>"/>
																			<input type="hidden" name="ActionNo" value="<%=obj[0]%>"/>
																			<input type="hidden" name="Assignee" value="<%=obj[11] %>" />
																			<input type="hidden" name="fracasassignid" value="<%=obj[10]%>"/>
																			<input type="hidden" name="ActionAssignId" value="<%=obj[16]%>">
																			
		 																	<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
																    		
																    	
																    	</form>
																    	
																    	

																    	<a href="javascript:actionform(<%=formcount%>)" class="btn btn-sm" style=" border-radius: 3px; 
																	    	<%if("A".equalsIgnoreCase(obj[3].toString())&&"1".equalsIgnoreCase(obj[8].toString())){ %> box-shadow: 0 0 0 2px #FF4500; <%} %>
																	    	<%if("I".equalsIgnoreCase(obj[3].toString()) || "F".equalsIgnoreCase(obj[3].toString()) &&"1".equalsIgnoreCase(obj[8].toString())){ %> box-shadow: 0 0 0 2px #FF4500; <%} %>
																	    	<%if("C".equalsIgnoreCase(obj[3].toString())&&"1".equalsIgnoreCase(obj[8].toString())){ %> box-shadow: 0 0 0 2px #00917c; <%} %>
																	    	<%if("2".equalsIgnoreCase(obj[8].toString())){ %> box-shadow: 0 0 0 2px 	#DC143C; <%} %>
																    		transition: all 200ms ease-out;color:black;font-weight:bold;"> 
																    	<!-- <i class="fa fa-arrow-right" aria-hidden="true" style="color: #1687a7;font-size: 1.00 rem !important"></i>  -->
																    		<%=obj[11] %> <br> <%=obj[0] %> &nbsp;&nbsp;
																		    		
																    	</a> 
																    	
																    	
														   			 </li>
														   			 
													
																 <%formcount++;}} }else{%>
																 	
																 	<li class="list-group-item" style="background-color: rgba(255, 255, 255, 0.08888) !important;color:black " >No Review Pending !
																 	</li>
																 
																 <%} %> 
		 
													 	 </ul> 
													 	 
													</div>
										
				 				</div>   
				 				
				 				<!--  Second Review Except User---------------- -->
				 		<%-- 	 <%if(!logintype.equalsIgnoreCase("U")){ %>	 --%>
				 				
				 			<br>	
				 			<div class="card-header" style="padding: .25rem 1.25rem !important;background-color: #007bff;color:white;text-align: left;border-radius:5px;display:none" id="reviewheader2">
							<span style="font-size:12px ">Review - Pending with Me</span>
							</div>	
		   					
		   
								<div style="margin-top:5px;display:none" id="review2">
				
													
											<div style="max-height:9rem ;overflow-y: auto ; ">
																				
															<ul style="padding: 0px">	 
																					  
																<% int formcount1=55;
																	if(dashboardactionpdc.size()>0){
																  for(Object[] obj : dashboardactionpdc){
																	  if(obj[15].toString().equalsIgnoreCase("G")){
																	  	%>
																  
																    <li class="list-group-item" style="background-color: rgba(255, 255, 255, 0.08888) !important; padding : 12px 0px !important;">
																    	
																    	<form name="Action<%=formcount1%>" id="Action<%=formcount1%>" action="<%=obj[7] %>" method="POST" >
																    	
																    		<input type="hidden" name="Assigner" value="<%=obj[11]%>,<%=obj[13]%>"/>													
		                                                                    <input type="hidden" name="ActionLinkId" value="<%=obj[10]%>"/>
																			<input type="hidden" name="ActionMainId" value="<%=obj[9]%>"/>
																			<input type="hidden" name="ActionNo" value="<%=obj[0]%>"/>
																			<input type="hidden" name="Assignee" value="<%=obj[11] %>" />
																			<input type="hidden" name="fracasassignid" value="<%=obj[10]%>"/>
																			<input type="hidden" name="forceclose" value="N"/>
																			<input type="hidden" name="ActionAssignId" value="<%=obj[16]%>">
		 																	<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
																    		
																    	
																    	</form>
																    	
																    	

																    	<a href="javascript:actionform(<%=formcount1%>)" class="btn btn-sm" style=" border-radius: 3px; 
																	    	<%if("A".equalsIgnoreCase(obj[3].toString())&&"1".equalsIgnoreCase(obj[8].toString())){ %> box-shadow: 0 0 0 2px #FF4500; <%} %>
																	    	<%if("I".equalsIgnoreCase(obj[3].toString()) || "F".equalsIgnoreCase(obj[3].toString()) &&"1".equalsIgnoreCase(obj[8].toString())){ %> box-shadow: 0 0 0 2px #FF4500; <%} %>
																	    	<%if("C".equalsIgnoreCase(obj[3].toString())&&"1".equalsIgnoreCase(obj[8].toString())){ %> box-shadow: 0 0 0 2px #00917c; <%} %>
																	    	<%if("2".equalsIgnoreCase(obj[8].toString())){ %> box-shadow: 0 0 0 2px 	#DC143C; <%} %>
																    		transition: all 200ms ease-out;color:black;font-weight:bold;"> 
																    		<%=obj[1] %> <br> <%=obj[0] %> &nbsp;&nbsp;
																		    		
																    	</a> 
																    	
																    	
														   			 </li>
														   			 
														   			 
														   			 
														   			 
													
																 <%formcount1++;} }}else{%>
																 	
																 	<li class="list-group-item" style="background-color: rgba(255, 255, 255, 0.08888) !important;color:black " >No Review Pending !
																 	</li>
																 
																 <% } %> 
		 
													 	 </ul> 
													 	 
													</div>
													
										<!-- Actions Flow End -->
				 				</div> <br>  
				 			
				 		<%-- <%} %>	 --%><!-- Closing of condition for second review block --><!--------- Closing if loop of action items ------------->
				 				
				 				
			<!-- ----------- ACTION DASHBOARD  REVIEW  BLOCK ENDS------------- -->
				 	
				 
				 				
			
		
					 </div>	
				</div>
	<!-- @@@@@@@@@@@@@@@@ DIV CARD BOX ENDS @@@@@@@@@@@@@@@@@@@@@@@ -->

					<!-- Removing Card 5 -->	

					<%-- <div class="card overall-card normal-dashboard" id="overallcard5" style="display: none;margin-top: 4px">
				          <div class="card-content">
				            <div class="card-body" >
								<div class="row">
							     	<div class="col-md-7" style="padding-right: 0px !important" >
							       		
							       		<form action="ProjectHoaUpdate.htm" method="get">
									       <h6 class="text-left" style="margin-bottom: 3px !important;">Finance 
									       	<button type="submit" class="btn btn4 btn-sm" style=" padding: 0px 17px;" data-toggle="tooltip" title="Finance Refresh"><i class="fa fa-refresh" aria-hidden="true"></i></button></h6>  
									    </form>
							       		<ul class="small-list">
								           	<li><span class="green">&#x220E;</span> E</li>
								           	<li><span class="yellow">&#x220E;</span> O/S</li>
								           	<li><span class="blue">&#x220E;</span> D</li>
								           	<li><span class="red">&#x220E;</span> B</li>
							           	</ul>
							       	</div>
							       	<div class="col-md-5" style="padding-right: 0px !important">
							       		<h6 class="text-left" >&#8377; <span id="financevalue"><%if(ProjectHealthTotalData[23]!=null){%><%=nfc.rupeeFormat(String.valueOf(Math.round(Double.parseDouble(ProjectHealthTotalData[23].toString() ))))%><%} %></span> </h6>
							      	</div>
							     </div>
					         </div>
				          </div>
				        </div> --%>





				<!-- ----------- PROJECT DASHBOARD  MEETINGS  BLOCK STARTS------------- -->
				 			
				 			<div class="card" style="background: transparent;margin-top:1%;display: none"  id="meetingblock">
						
							<nav class="navbar navbar-light bg-primary " style="background-color: #e3f2fd;">
								<a class="navbar-brand" style="color:white;" >Meetings</a>
							</nav>					
											
								<!-- <div id="carouselExampleControls1" class="carousel slide carousel-interval" data-ride="carousel"  style="padding: 3px 0px 7px 4px;"> -->
								<!-- Uncomment the above line to add carousel -->
								<div id="carouselExampleControls1" class="" data-ride=""  style="padding: 3px 0px 7px 4px;">
									<div class="carousel-inner">
									
										<%if(ProjectList!=null){ %>
									    <%for(Object[] obj : ProjectList){
									    	%>
										    
									    <div class="carousel-item" id="Meeting<%=obj[0]%>" <%if(obj[0].toString().equals("0")){ %> style="display: none" <%} %>>
				
				
										    	<table class="table meeting" style="height: 70px; margin : 0px 0px 0px 0px;"  >													
													<tr>
														<td style="padding : 5px 15px 5px 15px;"></td>
													    <td  style="padding : 5px 15px 5px 15px;"><span style="font-size :12px;font-weight: bold; ">Total</span></td>
													    <td  style="padding : 5px 15px 5px 15px;"><span style="font-size :12px;font-weight: bold;  ">Held</span></td>
													    <td  style="padding : 5px 15px 5px 15px;"><span style="font-size :12px;font-weight: bold;  ">Rem</span></td>
													</tr>
				
													<%if(ProjectMeetingCount!=null ){ %>	
															
													<%for(Object[] obj2 : ProjectMeetingCount){ %>
				
														<%if(obj[0].toString().equalsIgnoreCase(obj2[9].toString())) { %>
														
														  <!-- (project status) ==> all = All, B = held and C = remaining -->
													<tr>
														<td  style="padding : 5px 0px 5px 0px;text-align: left">EB</td>
														<td><button type="button" onclick="CommitteeForm('<%=obj2[9] %>',2,'all');" class="btn btn-sm " style="background-color: #448fea;color:white; "><%=obj2[0] %></button></td>
														<td><button type="button" onclick="CommitteeForm('<%=obj2[9] %>',2,'B');" class="btn btn-sm " style="background-color: #008891;color:white; "><%=obj2[1] %></button></td>
														<td><button type="button" onclick="CommitteeForm('<%=obj2[9] %>',2,'C');" class="btn btn-sm " style="background-color: #ff8400;color:white; "><%=obj2[2] %></button></td>
													</tr>
													<tr>
														<td  style="padding : 5px 0px 5px 0px;text-align: left">PMRC</td>
														<td><button type="button" onclick="CommitteeForm('<%=obj2[9] %>',1,'all');" class="btn btn-sm " style="background-color: #448fea;color:white; "><%=obj2[3] %></button></td>
														<td><button type="button" onclick="CommitteeForm('<%=obj2[9] %>',1,'B');" class="btn btn-sm " style="background-color: #008891;color:white; "><%=obj2[4] %></button></td>
														<td><button type="button" onclick="CommitteeForm('<%=obj2[9] %>',1,'C');" class="btn btn-sm " style="background-color: #ff8400;color:white; "><%=obj2[5] %></button></td>
													<tr>
													<tr>
														<td  style="padding : 5px 0px 5px 0px;text-align: left">Others</td>
														<td><button type="button" onclick="CommitteeForm('<%=obj2[9] %>','others','all');" class="btn btn-sm " style="background-color: #448fea;color:white; "><%=obj2[6] %></button></td>
														<td><button type="button" onclick="CommitteeForm('<%=obj2[9] %>','others','B');" class="btn btn-sm " style="background-color: #008891;color:white; "><%=obj2[7] %></button></td>
														<td><button type="button" onclick="CommitteeForm('<%=obj2[9] %>','others','C');" class="btn btn-sm " style="background-color: #ff8400;color:white; "><%=obj2[8] %></button></td>
													</tr>
													
													<%}%>
				
													<%} %>
													
													<%} %>
				
													
												 </table>
										    </div>
										    
										    <%} %>
										    
										    <%} else{ %>
										    
										    
										    	<div class="list-group-item" style="background-color: rgba(255, 255, 255, 0.08888) !important;border: none; ">
										    		No Meetings
										    	</div>
										    
										    <%} %>
										    
										  </div>
				
									</div> 
							
							</div>
					<!-- ----------- PROJECT DASHBOARD  MEETINGS  BLOCK ENDS------------- -->
		



			</div>
<!-- @@@@@@@@ MAIN ROW col-md-3 END @@@@@@@ -->	
	
	
		</div>
<!-- @@@@@@@@ MAIN ROW END @@@@@@@ -->

</div>
<!-- @@@@@@@@ CONTAINER FLUID END @@@@@@@ -->



<!-- ------------------------------------------------------------- NOTICE MODAL (popup when clicked on + symbol of NOTICE IN ACTION DASHBOARD)   ------------------------------------------------------------------------------------ -->		
			
					<div class="modal fade" id="exampleModal" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
					  <div class="modal-dialog">
					    <div class="modal-content">
					      <div class="modal-header ">
					        <h5 class="modal-title" id="exampleModalLabel">Add Notice</h5>
					        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
					          <span aria-hidden="true">&times;</span>
					        </button>
					      </div>
					      <div class="modal-body">
					      <form action="NoticeAddSubmit.htm" method="POST" name="myfrm" id="noticeForm">
					          	<div class="row">
					                            <div class="col-md-2"></div>
														<div class="col-md-4">
															<div class="form-group">
																<label class="control-label">From </label>
																 <input  class="form-control"  data-date-format="dd/mm/yyyy" readonly="readonly" id="fdate" name="fdate"  required="required">
															</div>
														</div>
					
														<div class="col-md-4">
															<div class="form-group">
																<label class="control-label">To </label> 
																<input  class="form-control"  data-date-format="dd/mm/yyyy" readonly="readonly" id="tdate" name="tdate"  required="required">
															</div>
														</div>
								</div>					 
					                                     <div class="col-md-12">
															<div class="form-group">
																<label class="control-label">Notice</label> 
															    <textarea class="form-control" name="noticeFiled" id="noticeText" style="height: 9rem;" maxlength="255"  placeholder="Enter Notice here with max 255 characters" required="required"></textarea>
															</div>
														</div>       
														<input type="hidden" name="${_csrf.parameterName}"	value="${_csrf.token}" />
							</form>
					      </div>
					      <div class="modal-footer">
					       
					            <input type="submit" class="btn btn-primary btn-sm submit " formaction="NoticeAddSubmit.htm"
															id="sub" value="SUBMIT" name="sub" onclick="addNoticeForm()">
					        
					   
					      </div>
					    </div>
					  </div>
					</div>
					
<!-- ------------------------------------------------------------- NOTICE MODAL ENDS  ------------------------------------------------------------------------------------ -->		

<!-- ****************************************************************** OVERALL DASHBOARD MODULE STARTS********************************************************************************* -->

	<div class="container-fluid" style="display: none" id="overalltable">
		
		<!-- ///////////////  CAR DECK (MEETING,MILESTONE,ACTION,RISK,FINANCE) STARTS //////////// -->
		<div class="card-deck" style="margin-top: -20px;" id="overallmodulecarddeck" >
		  <div class="card detailscard">
		    <div class="card-body">
		      <h5 class="card-title"><img src="view/images/discuss.png" /> Meeting</h5>
		      <hr>
		      <div class="row">
		      	<div class="col-md-6 circular-progress">
		      		 <div class="progress " data-value='<%=ProjectHealthTotalData[29]%>'>
			         <span class="progress-left">
			          		<span class="progress-bar <%if(Integer.parseInt(ProjectHealthTotalData[29].toString())<=25){%> border-danger<%}%>
														<%if( (Integer.parseInt(ProjectHealthTotalData[29].toString())>25) && (Integer.parseInt(ProjectHealthTotalData[29].toString())<=50)){%> border-orange<%}%>
														<%if( (Integer.parseInt(ProjectHealthTotalData[29].toString())>50) && (Integer.parseInt(ProjectHealthTotalData[29].toString())<=75)){%> border-warning <%}%>
														<%if( (Integer.parseInt(ProjectHealthTotalData[29].toString())>75) && (Integer.parseInt(ProjectHealthTotalData[29].toString())<=100)){%> border-success <%}%>
														"></span>             
			         </span>
			         <span class="progress-right">
			                <span class="progress-bar <%if(Integer.parseInt(ProjectHealthTotalData[29].toString())<=25){%> border-danger<%}%>
														<%if( (Integer.parseInt(ProjectHealthTotalData[29].toString())>25) && (Integer.parseInt(ProjectHealthTotalData[29].toString())<=50)){%> border-orange<%}%>
														<%if( (Integer.parseInt(ProjectHealthTotalData[29].toString())>50) && (Integer.parseInt(ProjectHealthTotalData[29].toString())<=75)){%> border-warning <%}%>
														<%if( (Integer.parseInt(ProjectHealthTotalData[29].toString())>75) && (Integer.parseInt(ProjectHealthTotalData[29].toString())<=100)){%> border-success <%}%>
														"></span>   
			          </span>
			          <div class="progress-value w-100 h-100 rounded-circle d-flex align-items-center justify-content-center">
			            <div class="h4 font-weight-bold" id="pmrcprogress" ><%=(ProjectHealthTotalData[29] )%>%</div>
			          </div>
			        </div>
			        <!-- <div><h6 style="margin-bottom: 5px">PMRC</h6></div> -->
			        <hr style="margin: 5px !important">
			        <table class="countstable" style="margin: 0px auto">
			        	<tr>
			        		<th style="font-size: 14px">PMRC </th>
			        	</tr>
				        <tr>
			        		<td style="font-size: 14px;cursor: pointer;" id="meetingsvaluepmrc"  data-toggle="tooltip" title="Held / To be Held / Total to be Held" >
			        			<%if(ProjectHealthTotalData !=null){%>
			        				<span><%=ProjectHealthTotalData[0] %> / <%=ProjectHealthTotalData[2] %> / <%=ProjectHealthTotalData[46] %></span>
			        			<%}%>
			        		</td>
			        	</tr>
			        </table>
		      	</div>
		      	<div class="col-md-6 circular-progress">
		      		 <div class="progress "  data-value='<%=(ProjectHealthTotalData[31] )%>'>
			          <span class="progress-left">
			          		<span class="progress-bar <%if(Integer.parseInt(ProjectHealthTotalData[31].toString())<=25){%> border-danger<%}%>
																								   <%if( (Integer.parseInt(ProjectHealthTotalData[31].toString())>25) && (Integer.parseInt(ProjectHealthTotalData[31].toString())<=50)){%> border-orange<%}%>
																								   <%if( (Integer.parseInt(ProjectHealthTotalData[31].toString())>50) && (Integer.parseInt(ProjectHealthTotalData[31].toString())<=75)){%> border-warning <%}%>
																								   <%if( (Integer.parseInt(ProjectHealthTotalData[31].toString())>75) && (Integer.parseInt(ProjectHealthTotalData[31].toString())<=100)){%> border-success <%}%>
																"></span>             
			          </span>
			          <span class="progress-right">
			                <span class="progress-bar <%if(Integer.parseInt(ProjectHealthTotalData[31].toString())<=25){%> border-danger<%}%>
																								   <%if( (Integer.parseInt(ProjectHealthTotalData[31].toString())>25) && (Integer.parseInt(ProjectHealthTotalData[31].toString())<=50)){%> border-orange<%}%>
																								   <%if( (Integer.parseInt(ProjectHealthTotalData[31].toString())>50) && (Integer.parseInt(ProjectHealthTotalData[31].toString())<=75)){%> border-warning <%}%>
																								   <%if( (Integer.parseInt(ProjectHealthTotalData[31].toString())>75) && (Integer.parseInt(ProjectHealthTotalData[31].toString())<=100)){%> border-success <%}%>
																"></span>   
			          </span>
			          <div class="progress-value w-100 h-100 rounded-circle d-flex align-items-center justify-content-center">
			            <div class="h4 font-weight-bold" ><%=(ProjectHealthTotalData[31] )%>%</div>
			          </div>
			        </div>
			       <!--  <div><h6 style="margin-bottom: 5px">EB</h6></div> -->
			        <hr style="margin: 5px !important">
			        <table class="countstable" style="margin: 0px auto">
				        	<tr>
				        		<th style="font-size: 14px">EB </th>
				        	</tr>
				        	<tr>
				        		<td style="font-size: 14px" id="meetingsvalueeb"  data-toggle="tooltip" title="Held / To be Held / Total to be Held"  ><%if(ProjectHealthTotalData !=null){%><%=ProjectHealthTotalData[3] %> / <%=ProjectHealthTotalData[5] %> / <%=ProjectHealthTotalData[47] %><%}%></td>
				        	</tr>
				     </table>
		      	</div>
		      </div>
		    </div>
		    
		  </div>
		  <div class="card detailscard">
		    <div class="card-body">
		      <h5 class="card-title"><img src="view/images/goal.png" /> Milestone</h5>
		      <hr>
		      <div class="row">
		      	<div class="col-md-6 circular-progress">
		      		<div class="progress " data-value='<%if(ProjectHealthTotalData[10] !=null){%><%=ProjectHealthTotalData[10] %><%} %>'>
			          <span class="progress-left">
			                        <span class="progress-bar <%if(Integer.parseInt(ProjectHealthTotalData[10].toString())<=25){%> border-danger<%}%>
																<%if( (Integer.parseInt(ProjectHealthTotalData[10].toString())>25) && (Integer.parseInt(ProjectHealthTotalData[10].toString())<=50)){%> border-orange<%}%>
																<%if( (Integer.parseInt(ProjectHealthTotalData[10].toString())>50) && (Integer.parseInt(ProjectHealthTotalData[10].toString())<=75)){%> border-warning <%}%>
																<%if( (Integer.parseInt(ProjectHealthTotalData[10].toString())>75) && (Integer.parseInt(ProjectHealthTotalData[10].toString())<=100)){%> border-success <%}%>
																"></span>   
			          </span>
			          <span class="progress-right">
			                        <span class="progress-bar <%if(Integer.parseInt(ProjectHealthTotalData[10].toString())<=25){%> border-danger<%}%>
																<%if( (Integer.parseInt(ProjectHealthTotalData[10].toString())>25) && (Integer.parseInt(ProjectHealthTotalData[10].toString())<=50)){%> border-orange<%}%>
																<%if( (Integer.parseInt(ProjectHealthTotalData[10].toString())>50) && (Integer.parseInt(ProjectHealthTotalData[10].toString())<=75)){%> border-warning <%}%>
																<%if( (Integer.parseInt(ProjectHealthTotalData[10].toString())>75) && (Integer.parseInt(ProjectHealthTotalData[10].toString())<=100)){%> border-success <%}%>
																"></span>   
			          </span>
			          <div class="progress-value w-100 h-100 rounded-circle d-flex align-items-center justify-content-center">
			            <div class="h4 font-weight-bold"><span id="milestonepercentage"><%if(ProjectHealthTotalData[10] !=null){%><%=ProjectHealthTotalData[10] %><%} %>%</span></div>
			          </div>
			     	</div>
		      	</div>
		      	<div class="col-md-6">
		      		<div class="bigcount">
		      			<h1><%if(ProjectHealthTotalData[8] !=null){%><%=ProjectHealthTotalData[8] %><%} %></h1>
		      			<p class="textfont" style="margin-bottom: 5px !important"><span class="green legend-shadow">&#x220E;</span> &nbsp;Completed</p>
		      		</div>
		      		
		      		<div class="bigcount">
		      			<h4><%if(ProjectHealthTotalData[9] !=null){%><%=ProjectHealthTotalData[9] %><%} %></h4>
		      			<p class="textfont">Total</p>
		      		</div>
		      	</div>
		      </div>
		    </div>
		    <table class="countstable card-deck-table" style="margin-bottom: 0px !important;border-top:1px solid darkgrey;">
				  <thead style="height: 2rem">
				  	<tr>
				  		<td style="border-right:1px solid darkgrey;" data-toggle="tooltip" title="Delayed" >
				  			<span class="yellow">&#x220E;</span>
				  			<span style="font-size: 11px !important;text-shadow: none !important; ">Delayed&nbsp;</span>
				  			<%if(ProjectHealthTotalData[7] !=null){%><%=ProjectHealthTotalData[7] %><%} %>
				  		</td>
				  		<td data-toggle="tooltip" title="Pending"  >
				  			<span class="red">&#x220E;</span>
				  			<span style="font-size: 11px !important;text-shadow: none !important; ">Pending&nbsp;</span>
				  			<%if(ProjectHealthTotalData[6] !=null){%><%=ProjectHealthTotalData[6] %><%} %>
				  		</td>
				  	</tr>
				  </thead>
				 <!--  <tbody>
				  	<tr>
				  		<th scope="col" class="textfont" style="border-right:1px solid darkgrey;" ><span class="yellow">&#x220E;</span> &nbsp;Delayed</th>
				      	<th scope="col" class="textfont"><span class="red">&#x220E;</span> &nbsp;Pending</th>
				    </tr>
				  </tbody>  -->
			</table>
		  </div>
		  <div class="card detailscard">
		    <div class="card-body">
		      <h5 class="card-title"><img src="view/images/action1.png" /> Action</h5>
		      <hr>
		      <div class="row">
		      	<div class="col-md-6 circular-progress">
		      		<div class="progress " data-value='<%if(ProjectHealthTotalData[37] !=null){%><%=ProjectHealthTotalData[37] %><%} %>'>
			          <span class="progress-left">
			                        <span class="progress-bar <%if(Integer.parseInt(ProjectHealthTotalData[37].toString())<=25){%> border-danger<%}%>
																<%if( (Integer.parseInt(ProjectHealthTotalData[37].toString())>25) && (Integer.parseInt(ProjectHealthTotalData[37].toString())<=50)){%> border-orange<%}%>
																<%if( (Integer.parseInt(ProjectHealthTotalData[37].toString())>50) && (Integer.parseInt(ProjectHealthTotalData[37].toString())<=75)){%> border-warning <%}%>
																<%if( (Integer.parseInt(ProjectHealthTotalData[37].toString())>75) && (Integer.parseInt(ProjectHealthTotalData[37].toString())<=100)){%> border-success <%}%>
																"></span>
			          </span>
			          <span class="progress-right">
			                        <span class="progress-bar <%if(Integer.parseInt(ProjectHealthTotalData[37].toString())<=25){%> border-danger<%}%>
																<%if( (Integer.parseInt(ProjectHealthTotalData[37].toString())>25) && (Integer.parseInt(ProjectHealthTotalData[37].toString())<=50)){%> border-orange<%}%>
																<%if( (Integer.parseInt(ProjectHealthTotalData[37].toString())>50) && (Integer.parseInt(ProjectHealthTotalData[37].toString())<=75)){%> border-warning <%}%>
																<%if( (Integer.parseInt(ProjectHealthTotalData[37].toString())>75) && (Integer.parseInt(ProjectHealthTotalData[37].toString())<=100)){%> border-success <%}%>
																"></span>
			          </span>
			          <div class="progress-value w-100 h-100 rounded-circle d-flex align-items-center justify-content-center">
			            <div class="h4 font-weight-bold"><%if(ProjectHealthTotalData[37] !=null){%><%=ProjectHealthTotalData[37] %><%} %>%</div>
			          </div>
			     	</div>
		      	</div>
		      	<div class="col-md-6">
		      		<div class="bigcount">
		      			<h1><%if(ProjectHealthTotalData[14] !=null){%><%=ProjectHealthTotalData[14] %><%} %></h1>
		      			<p class="textfont" style="margin-bottom: 5px !important"><span class="green legend-shadow">&#x220E;</span> &nbsp;Completed</p>
		      		</div>
		      		<div class="bigcount">
		      			<h4><%if(ProjectHealthTotalData[15] !=null){%><%=ProjectHealthTotalData[15] %><%} %></h4>
		      			<p class="textfont">Total</p>
		      		</div>
		      	</div>
		      </div>
		    </div>
		    <table class="countstable card-deck-table" style="margin-bottom: 0px !important;border-top:1px solid darkgrey;">
				  <thead style="height:2rem">
				  	<tr>
				  		<td style="border-right:1px solid darkgrey;" data-toggle="tooltip" title="Delayed" >
				  			<span class="yellow">&#x220E;</span>
				  			<span style="font-size: 11px !important;text-shadow: none !important; ">Delayed&nbsp;</span>
				  			<%if(ProjectHealthTotalData[13] !=null){%>&nbsp;<%=ProjectHealthTotalData[13] %><%} %>
				  		</td>
				  		<td style="border-right:1px solid darkgrey;" data-toggle="tooltip" title="Forwarded" >
				  			<span class="blue">&#x220E;</span>
				  			<span style="font-size: 11px !important;text-shadow: none !important; ">Forward &nbsp;</span>
				  			<%if(ProjectHealthTotalData[12] !=null){%> &nbsp;<%=ProjectHealthTotalData[12] %><%} %>
				  		</td>
				  		<td data-toggle="tooltip" title="Pending" >
				  			<span class="red">&#x220E;</span>
				  			<span style="font-size: 11px !important;text-shadow: none !important; ">Pending&nbsp;</span>
				  			<%if(ProjectHealthTotalData[11] !=null){%>&nbsp;<%=ProjectHealthTotalData[11] %><%} %>
				  		</td>
				  	</tr>
				  </thead>
				  <!-- <tbody>
				  	<tr>
				      <th scope="col" class="textfont" style="border-right:1px solid darkgrey;"><span class="yellow">&#x220E;</span> &nbsp;Delayed</th>
				      <th scope="col" class="textfont" style="border-right:1px solid darkgrey;"><span class="blue">&#x220E;</span> &nbsp;Forwarded</th>
				      <th scope="col" class="textfont"><span class="red">&#x220E;</span> &nbsp;Pending</th>
				    </tr>
				  </tbody> -->
			</table>
		  </div>
		  <div class="card detailscard">
		    <div class="card-body">
		      <h5 class="card-title"><img src="view/images/risk 1.png" /> Risk</h5>
		      <hr>
		      <div class="row">
		      	<div class="col-md-6 circular-progress">
		      		<div class="progress " data-value='<%if(ProjectHealthTotalData[39] !=null){%><%=ProjectHealthTotalData[39] %><%} %>'>
			          <span class="progress-left">
			                         <span class="progress-bar <%if(Integer.parseInt(ProjectHealthTotalData[39].toString())<=25){%> border-danger<%}%>
																								   <%if( (Integer.parseInt(ProjectHealthTotalData[39].toString())>25) && (Integer.parseInt(ProjectHealthTotalData[39].toString())<=50)){%> border-orange<%}%>
																								   <%if( (Integer.parseInt(ProjectHealthTotalData[39].toString())>50) && (Integer.parseInt(ProjectHealthTotalData[39].toString())<=75)){%> border-warning <%}%>
																								   <%if( (Integer.parseInt(ProjectHealthTotalData[39].toString())>75) && (Integer.parseInt(ProjectHealthTotalData[39].toString())<=100)){%> border-success <%}%>
																"></span>  
			          </span>
			          <span class="progress-right">
			                         <span class="progress-bar <%if(Integer.parseInt(ProjectHealthTotalData[39].toString())<=25){%> border-danger<%}%>
																								   <%if( (Integer.parseInt(ProjectHealthTotalData[39].toString())>25) && (Integer.parseInt(ProjectHealthTotalData[39].toString())<=50)){%> border-orange<%}%>
																								   <%if( (Integer.parseInt(ProjectHealthTotalData[39].toString())>50) && (Integer.parseInt(ProjectHealthTotalData[39].toString())<=75)){%> border-warning <%}%>
																								   <%if( (Integer.parseInt(ProjectHealthTotalData[39].toString())>75) && (Integer.parseInt(ProjectHealthTotalData[39].toString())<=100)){%> border-success <%}%>
																"></span>  
			          </span>
			          <div class="progress-value w-100 h-100 rounded-circle d-flex align-items-center justify-content-center">
			            <div class="h4 font-weight-bold"><%if(ProjectHealthTotalData[39] !=null){%><%=ProjectHealthTotalData[39] %><%} %>%</div>
			          </div>
			     	</div>
		      	</div>
		      	<div class="col-md-6">
		      		<div class="bigcount">
		      			<h1><%if(ProjectHealthTotalData[16] !=null){%><%=ProjectHealthTotalData[16] %><%} %></h1>
		      			<p class="textfont" style="margin-bottom: 5px !important"><span class="green legend-shadow">&#x220E;</span> &nbsp;Completed</p>
		      		</div>
		      		<div class="bigcount">
		      			<h4><%if(ProjectHealthTotalData[18] !=null){%><%=ProjectHealthTotalData[18] %><%} %></h4>
		      			<p class="textfont">Total</p>
		      		</div>
		      	</div>
		      </div>
		    </div>
		    <table class="countstable card-deck-table" style="margin-bottom: 0px !important;border-top:1px solid darkgrey;">
				  <thead style="height: 2rem">
				  	<tr>
				  		<td style="border-right:1px solid darkgrey;" data-toggle="tooltip" title="Delayed" >
				  		<span class="yellow">&#x220E;</span>
				  		<span style="font-size: 11px !important;text-shadow: none !important; ">Delayed&nbsp;</span>
				  		&nbsp;0
				  		</td>
				  		<td data-toggle="tooltip" title="Pending" >
				  			<span class="red">&#x220E;</span>
				  			<span style="font-size: 11px !important;text-shadow: none !important; ">Pending&nbsp;</span>
				  			<%if(ProjectHealthTotalData[17] !=null){%>&nbsp;<%=ProjectHealthTotalData[17] %><%} %>
				  		</td>
				  	</tr>
				  </thead>
				 <!-- <tbody>
				  	<tr>
				      <th scope="col" class="textfont"style="border-right:1px solid darkgrey;"><span class="yellow">&#x220E;</span> &nbsp;Delayed</th>
				      <th scope="col" class="textfont"><span class="red">&#x220E;</span> &nbsp;Pending</th>
				    </tr>
				  </tbody>  -->
			</table>
		  </div>
		   <div class="card detailscard">
		    <div class="card-body">
		    	<div style="display: inline-flex">
			      <h5 class="card-title" style="margin-bottom: 8px !important">
							<img src="view/images/rupee.png" /> Finance <!-- <span style="font-size: 14px !important">(&#8377;Cr)</span> -->
				  </h5>
				 	<form action="ProjectHoaUpdate.htm" method="get">
						<button type="submit" class="btn btn4 btn-sm" style="padding: 0px 10px;" data-toggle="tooltip" title="Finance Refresh"><i class="fa fa-refresh" aria-hidden="true"></i></button></h6>  
				 	</form>
			   	</div>
		      <hr style="margin:3px 10px !important">
				<table class="table financetable " >
				  <thead>
				    <tr>
				      <th scope="col">
				     	(In &#8377; k Cr)
				      </th>
				      <th scope="col">Sanc</th>
				      <th scope="col">Exp</th>
				      <th scope="col">Bal</th>
				    </tr>
				  </thead>
				  <%
				  		BigDecimal sanction=new BigDecimal(0.00);
					  	BigDecimal expenditure=new BigDecimal(0.00);
					  	BigDecimal balance=new BigDecimal(0.00);
				  %>
				  <tbody>
				  	<tr>
				      <th scope="row">Revenue</th>
				      <td><span style="color:green">&#8377;</span> <%=DashboardFinance.get(0)[3] %></td>
				      <td><span style="color:green">&#8377;</span> <%=DashboardFinance.get(0)[4] %></td>
				      <% BigDecimal revBal = new BigDecimal(DashboardFinance.get(0)[3].toString()).subtract(new BigDecimal(DashboardFinance.get(0)[4].toString())) ; %>
				      <td><span style="color:green">&#8377;</span> <%=revBal%></td>
				    </tr>
				     <% sanction	= sanction.add(new BigDecimal(DashboardFinance.get(0)[3].toString())); %>
				     <% expenditure	= expenditure.add(new BigDecimal(DashboardFinance.get(0)[4].toString())); %>
				     <% balance	= balance.add(revBal); %>
				     <tr>
				      <th scope="row">Capital</th>
				      <td><span style="color:green">&#8377;</span> <%=DashboardFinance.get(1)[3] %></td>
				      <td><span style="color:green">&#8377;</span> <%=DashboardFinance.get(1)[4] %></td>
				      <% BigDecimal capBal = new BigDecimal(DashboardFinance.get(1)[3].toString()).subtract(new BigDecimal(DashboardFinance.get(1)[4].toString())) ; %>
				      <td><span style="color:green">&#8377;</span> <%=capBal %></td>
				    </tr>
				     <% sanction	= sanction.add(new BigDecimal(DashboardFinance.get(1)[3].toString())); %>
				     <% expenditure	= expenditure.add(new BigDecimal(DashboardFinance.get(1)[4].toString())); %>
				     <% balance	= balance.add(capBal); %>
				    
				    <tr>
				      <th scope="row">Others</th>
				      <td><span style="color:green">&#8377;</span> <%=DashboardFinance.get(2)[3] %></td>
				      <td><span style="color:green">&#8377;</span> <%=DashboardFinance.get(2)[4] %></td>
				      <% BigDecimal othBal = new BigDecimal(DashboardFinance.get(2)[3].toString()).subtract(new BigDecimal(DashboardFinance.get(2)[4].toString())) ; %>
				      <td><span style="color:green">&#8377;</span> <%=othBal %></td>
				    </tr> 
				     <% sanction	= sanction.add(new BigDecimal(DashboardFinance.get(2)[3].toString())); %>
				     <% expenditure	= expenditure.add(new BigDecimal(DashboardFinance.get(2)[4].toString())); %>
				     <% balance	= balance.add(othBal); %>
				    <tr>
				      <th scope="row">Total</th>
				      <td><span style="color:green">&#8377;</span> <%=sanction%></td>
				      <td><span style="color:green">&#8377;</span> <%=expenditure %></td>
				      <td><span style="color:green">&#8377;</span> <%=balance %></td>
				    </tr>
				  </tbody>
				</table>
	
			   </div>
		  	</div>	 
		</div>
		
		<!-- ///////////////  CAR DECK (MEETING,MILESTONE,ACTION,RISK,FINANCE) ENDS //////////// -->
		
		<!-- ///////////////  CASH OUTGO(Cr) STARTS //////////// -->

		<jsp:include page="Dashboard-COG.jsp" />
		
		<!-- ///////////////  CASH OUTGO(Cr) ENDS //////////// -->
		
		
		<!-- /////////////// ALL PROJECT DETAILS IN OVERALL DASHBOARD STARTS //////////// -->

		<div class="card" style="background: transparent;margin-top:5px" >
		
								<div id="overalldiv" style="background-color: rgba(255, 255, 255, 0.39999) !important ;border-radius: 4px ;/* max-height: 26rem */; overflow-y:auto;overflow-x:hidden  ">
								
									<table class="table meeting tableFixHead fixed-table "  style="table-layout: fixed"> 
										<thead style=" background: #1363DF; color: white;">												
											<tr>
												<td style="width:4%">
													<a  data-toggle="modal"  class="fa faa-pulse animated " data-target="#exampleModal1" data-whatever="@mdo" style="padding: 0px 1.5rem;cursor:pointer" ><i class="fa fa-info-circle " style="font-size: 1.3rem;color: " aria-hidden="true"></i> </a>
												</td>
												<td class="tableprojectnametd" style="width:12%"><span style="font-size :15px;font-weight: bold; ">Project</span></td>
												<td style="width:2%">
													<div data-toggle="tooltip" title="Master Slide">
														<a style="cursor: pointer;"   target="_blank"  >
															<div type="button" data-toggle="modal" data-target="" id="slideDIv">
																<img src="view/images/silde.png" style="width: 25px;"/>
															</div>
														</a>
													</div>
												</td>
												<!-- Button trigger modal -->
												<!-- Modal -->
												<jsp:include page="../print/ProjectsSlideShowSelection.jsp"></jsp:include>
												<td style="width:6%"><span style="font-size :15px;font-weight: bold; ">DoS</span></td>
												<td style="width:6%"><span style="font-size :15px;font-weight: bold; ">PDC</span></td>
												<td style="padding: 0px !important"><span style="font-size :15px;font-weight: bold;">PMRC </span></td>
												<td style="padding: 0px !important"><span style="font-size :15px;font-weight: bold;">EB </span></td>
												<td ><span style="font-size :15px;font-weight: bold;  ">Milestone </span></td>
												<td ><span style="font-size :15px;font-weight: bold;  ">Action</span></td>
												<td ><span style="font-size :15px;font-weight: bold;  ">Risk</span></td>
												<td ><span style="font-size :15px;font-weight: bold;  ">Finance</span></td>
											</tr>
										</thead>
										
										<tbody>
										
											<%
											
											for(Object[] obj : ProjectHealthData){
												
												if(ProjectList!=null){  for(Object[] obj2 : ProjectList) 
												{
													if(obj[2].equals(obj2[0]))
													{
											%>
										
											<tr>
												<td><a href="javascript:ProjectDetails('<%=obj[2]%>','<%=obj[46]%>')"> <i class="fa fa-hand-o-right" aria-hidden="true" style="color: purple;font-size: 1.3rem !important"></i></a></td>
												<td style="font-weight: 800; font-size:1rem;text-align:left;
												
														<% if(obj[45]!=null) {if(obj[45].toString().equalsIgnoreCase("IA")){%>color: green<%} 
														else if(obj[45].toString().equalsIgnoreCase("IN")){%>color: #007bff <%} 
														else if(obj[45].toString().equalsIgnoreCase("IAF")){%>color: #1F4690 <%} 
														else if(obj[45].toString().equalsIgnoreCase("IH")){%>color: #8E3200 <%} 
														else if(obj[45].toString().equalsIgnoreCase("OH")){%>color: #EE5007 <%} 
														else if(obj[45].toString().equalsIgnoreCase("DRDO")){%>color: #231955 <%} 
														else {%>color:black <%} }else{ %>color:black <%}%>">
												
												<div data-toggle="tooltip" 
													title="<%if(obj[45]!=null) { if(obj[45].toString().equalsIgnoreCase("IA")){%>Indian Army<%}
													else if(obj[45].toString().equalsIgnoreCase("IN")){%>Indian Navy <%} 
													else if(obj[45].toString().equalsIgnoreCase("IAF")){%>Indian Air Force<%} 
													else if(obj[45].toString().equalsIgnoreCase("IH")){%>Home Land Security <%} 
													else if(obj[45].toString().equalsIgnoreCase("DRDO")){%>DRDO <%} 
													else if(obj[45].toString().equalsIgnoreCase("OH")){%>Others <%} 
													else {%> -  <%} }else{ %>-<%}%>">
												
														  &#11044;&nbsp; <span class="tableprojectname" style="color:black !important;font-size: 13px"> 
														  	<%if(obj[46]!=null){%><%=obj[46] %><%}else {%>-<%} %> /
														  	<%if(obj[3]!=null){%><%=obj[3] %><%}else {%>-<%} %> /
														  	<%if(obj[44]!=null){%><%=obj[44] %><%}else {%>-<%} %>
														  	</span> 	
												
													</div>
												
												</td>
												<td><a style="cursor: pointer;" href="PfmsProjectSlides.htm?projectid=<%=obj[2]%>" target="_blank" > <img src="view/images/silde.png" style="width: 25px;"/></a></td>
												<td style="font-size: 13px;font-weight: 600; "><%if(obj[50]!=null){%><%= sdf3.format(sdf2.parse(obj[50].toString()))%><%}else{ %> - <%} %></td>
												<td style="font-size: 13px;font-weight: 600; <%if(obj[47]!=null){ if(LocalDate.parse(obj[47].toString()).isBefore(LocalDate.now())){ %>color:maroon<%}}%>  "><%if(obj[47]!=null){%><%= sdf3.format(sdf2.parse(obj[47].toString()))%><%}else{ %> - <%} %></td>
												<td class="custom-td">
													<%if(Integer.parseInt(obj[8].toString())>0){ %>
														
														<div class="row">
															<div class="col-md-11">
															    <div class="progress" data-toggle="tooltip" title="PMRC Held : <%=obj[4]%> <br> PMRC To Be Held : <%=obj[8] %><br> Total PMRC To Be Held : <%=obj[48] %>"  >
																  <div class="progress-bar progress-bar-striped bg-success" onclick="overallmeetingredirect('<%=obj[2]%>','1', 'B')" style="width:<%=obj[5]%>%;" ></div>
																  <div class="progress-bar progress-bar-striped bg-primary" onclick="overallmeetingredirect('<%=obj[2]%>','1', 'C' )" style="width:<%=obj[7]%>%;" ></div>
																</div>
														  	</div>
															<div class="col-md-1" style="padding-left: 0px !important">
																<span class="health-circle" style="<%if(Integer.parseInt(obj[5].toString())<=25){%> background-color:red <%}%>
																								   <%if( (Integer.parseInt(obj[5].toString())>25) && (Integer.parseInt(obj[5].toString())<=50)){%> background-color: #EE5007; <%}%>
																								   <%if( (Integer.parseInt(obj[5].toString())>50) && (Integer.parseInt(obj[5].toString())<=75)){%> background-color:  #F8CB2E;color:black;  <%}%>
																								   <%if( (Integer.parseInt(obj[5].toString())>75)){%> background-color:green <%}%>
																">
																<%if(Integer.parseInt(obj[5].toString())>100){ %>
																	100
																<%}else{ %>
																<%=obj[5] %>
																<%} %>
																</span>
															</div>
														</div>
						
													<%}else{ %>
													<div class="progress nil-bar" style="background-color:#cdd0cb !important;height: 1.2rem !important;">
														<div class="progress-bar" role="progressbar" style=" width: 100%; background-color:#cdd0cb !important;color:black;font-weight: bold;  "  >
															Nil
														</div>
													</div>
													<%} %>
												</td>
												<td class="custom-td">
													<%if(Integer.parseInt(obj[13].toString())>0){ %>
														<div class="row">
															<div class="col-md-11">
																<div class="progress" data-toggle="tooltip" title="EB Held : <%=obj[9]%> <br> EB To Be Held : <%=obj[13] %><br> Total EB To Be Held : <%=obj[49] %>">
																  <div class="progress-bar progress-bar-striped bg-success" onclick="overallmeetingredirect('<%=obj[2]%>','2', 'B')" style="width:<%=obj[10]%>%;"></div>
																  <div class="progress-bar progress-bar-striped bg-primary" onclick="overallmeetingredirect('<%=obj[2]%>','2', 'C')" style="width:<%=obj[12]%>%;"></div>
																</div>
															</div>
															<div class="col-md-1" style="padding-left: 0px !important">
																<span class="health-circle" style="<%if(Integer.parseInt(obj[10].toString())<=25){%> background-color:red <%}%>
																								   <%if( (Integer.parseInt(obj[10].toString())>25) && (Integer.parseInt(obj[10].toString())<=50)){%> background-color:#EE5007; <%}%>
																								   <%if( (Integer.parseInt(obj[10].toString())>50) && (Integer.parseInt(obj[10].toString())<=75)){%> background-color:#F8CB2E;color:black; <%}%>
																								   <%if( (Integer.parseInt(obj[10].toString())>75) && (Integer.parseInt(obj[10].toString())<=100)){%> background-color:green<%}%>
																"><%=obj[10] %></span>
															</div>
														</div>
													<%}else{ %>
													<div class="progress nil-bar" style="background-color:#cdd0cb !important;height: 1.2rem !important;">
														<div class="progress-bar" role="progressbar" style=" width: 100%; background-color:#cdd0cb !important;color:black;font-weight: bold;  "  >
															Nil
														</div>
													</div>
													<%} %>
												</td>
												<td class="custom-td">
													<%if(Integer.parseInt(obj[20].toString())>0){ %>
													<div class="row">
														<div class="col-md-11">
															<div class="progress" onclick="overallcommonredirect('mil','<%=obj[2]%>')">
															  <div class="progress-bar progress-bar-striped bg-success" style="width:<%=obj[19]%>%" data-toggle="tooltip" title="Completed : <%=obj[18]%> / <%=obj[20] %>" ></div>
															  <div class="progress-bar progress-bar-striped bg-warning" style="width:<%=obj[17]%>%" data-toggle="tooltip" title="Delayed : <%=obj[16]%> / <%=obj[20] %>" ></div>
															  <div class="progress-bar progress-bar-striped bg-danger" style="width:<%=obj[15]%>%" data-toggle="tooltip" title="Pending : <%=obj[14]%> / <%=obj[20] %>" ></div>															  
															</div>
														</div>
														<div class="col-md-1" style="padding-left: 0px !important">
																<span class="health-circle" style="<%if(Integer.parseInt(obj[19].toString())<=25){%> background-color:red <%}%>
																								   <%if( (Integer.parseInt(obj[19].toString())>25) && (Integer.parseInt(obj[19].toString())<=50)){%> background-color: #EE5007;<%}%>
																								   <%if( (Integer.parseInt(obj[19].toString())>50) && (Integer.parseInt(obj[19].toString())<=75)){%> background-color:#F8CB2E;color:black;<%}%>
																								   <%if( (Integer.parseInt(obj[19].toString())>75) && (Integer.parseInt(obj[19].toString())<=100)){%> background-color:green <%}%>
																"><%=obj[19] %></span>
														</div>
													</div>
													<%}else{ %>
													<div class="progress nil-bar" style="background-color:#cdd0cb !important;height: 1.2rem !important;">
														<div class="progress-bar " role="progressbar" style=" width: 100%; background-color:#cdd0cb !important;color:black;font-weight: bold;  "  >
															Nil
														</div>
													</div>
													<%} %>
												</td>
												<td class="custom-td">
													<%if(Integer.parseInt(obj[29].toString())>0){ %>
													<div class="row">
														<div class="col-md-11">
															<div class="progress" onclick="overallcommonredirect('action','<%=obj[2]%>')">
															  <div class="progress-bar progress-bar-striped bg-success" style="width:<%=obj[28]%>%" data-toggle="tooltip" title="Completed : <%=obj[27]%> / <%=obj[29]%>" ></div>
															  <div class="progress-bar progress-bar-striped bg-warning" style="width:<%=obj[26]%>%" data-toggle="tooltip" title="Delayed : <%=obj[25]%> / <%=obj[29]%>" ></div>
															  <div class="progress-bar progress-bar-striped bg-primary" style="width:<%=obj[24]%>%" data-toggle="tooltip" title="Forwarded : <%=obj[23]%> / <%=obj[29]%>" ></div>
															  <div class="progress-bar progress-bar-striped bg-danger" style="width:<%=obj[22]%>%" data-toggle="tooltip" title="Pending : <%=obj[21]%> / <%=obj[29]%>" ></div>
															</div>
														</div>
														<div class="col-md-1" style="padding-left: 0px !important">
															<span class="health-circle" style="<%if(Integer.parseInt(obj[28].toString())<=25){%> background-color:red<%}%>
																									   <%if( (Integer.parseInt(obj[28].toString())>25) && (Integer.parseInt(obj[28].toString())<=50)){%> background-color: #EE5007; <%}%>
																									   <%if( (Integer.parseInt(obj[28].toString())>50) && (Integer.parseInt(obj[28].toString())<=75)){%> background-color: #F8CB2E;color:black <%}%>
																									   <%if( (Integer.parseInt(obj[28].toString())>75) && (Integer.parseInt(obj[28].toString())<=100)){%> background-color:green <%}%>
															"><%=obj[28] %></span>
														</div>
													</div>
													<%}else{ %>
													<div class="progress nil-bar" style="background-color:#cdd0cb !important;height: 1.2rem !important;">
														<div class="progress-bar" role="progressbar" style=" width: 100%; background-color:#cdd0cb !important;color:black;font-weight: bold;  "  >
															Nil
														</div>
													</div>
													<%} %>
												</td>
												<td class="custom-td">
													<%if(Integer.parseInt(obj[34].toString())>0){ %>
													<div class="row">
														<div class="col-md-11">
															<div class="progress" onclick="overallcommonredirect('risk','<%=obj[2]%>')">
															  <div class="progress-bar progress-bar-striped bg-success" style="width:<%=obj[31]%>%" data-toggle="tooltip" title="Completed : <%=obj[30]%> / <%=obj[34] %>" ></div>
															  <div class="progress-bar progress-bar-striped bg-danger" style="width:<%=obj[33]%>%" data-toggle="tooltip" title="Pending : <%=obj[32]%> / <%=obj[34] %>" ></div>
															</div>
														</div>
														<div class="col-md-1" style="padding-left: 0px !important">
																<span class="health-circle" style="<%if(Integer.parseInt(obj[31].toString())<=25){%> background-color:red <%}%>
																										   <%if( (Integer.parseInt(obj[31].toString())>25) && (Integer.parseInt(obj[31].toString())<=50)){%> background-color: #EE5007; <%}%>
																										   <%if( (Integer.parseInt(obj[31].toString())>50) && (Integer.parseInt(obj[31].toString())<=75)){%> background-color: #F8CB2E;color:black <%}%>
																										   <%if( (Integer.parseInt(obj[31].toString())>75) && (Integer.parseInt(obj[31].toString())<=100)){%> background-color:green <%}%>
																"><%=obj[31] %></span>
														</div>
													</div>
													<%}else{ %>
													<div class="progress nil-bar" style="background-color:#cdd0cb !important;height: 1.2rem !important;">
														<div class="progress-bar" role="progressbar" style=" width: 100%; background-color:#cdd0cb !important;color:black;font-weight: bold;  "  >
															Nil
														</div>
													</div>
													<%} %>
												</td>
												<td class="custom-td">
													<%
													BigInteger number = new BigInteger(obj[43].toString());
													BigInteger total = new BigInteger("0");
													if(number.compareTo(new BigInteger("0")) >0){ %>
													<div class="row">
														<div class="col-md-10">
															<%total = total.add(new BigInteger(String.valueOf(Math.round(Double.parseDouble(obj[35].toString() ))))); %>
															<%total = total.add(new BigInteger(String.valueOf(Math.round(Double.parseDouble(obj[37].toString() ))))); %>
															<%total = total.add(new BigInteger(String.valueOf(Math.round(Double.parseDouble(obj[39].toString() ))))); %>
															<%total = total.add(new BigInteger(String.valueOf(Math.round(Double.parseDouble(obj[41].toString() ))))); %>
															<div class="progress" onclick="overallfinance()" data-toggle="tooltip" title="Expenditure : &#8377; <%=nfc.rupeeFormat(String.valueOf(Math.round(Double.parseDouble(obj[35].toString() ))))%>
																																		<br>OC : &#8377; <%=nfc.rupeeFormat(String.valueOf(Math.round(Double.parseDouble(obj[37].toString() ))))%> 
																																		<br>DIPL : &#8377; <%=nfc.rupeeFormat(String.valueOf(Math.round(Double.parseDouble(obj[39].toString() ))))%> 
																																		<br>Balance : &#8377; <%=nfc.rupeeFormat(String.valueOf(Math.round(Double.parseDouble(obj[41].toString() ))))%> 
																																		<br><b>Total : &#8377; <%=nfc.rupeeFormat(total.toString())%> </b>
																																																		">

															  	<div class="progress-bar progress-bar-striped bg-success" style="width:<%=obj[36]%>%"  > </div>
															 	<div class="progress-bar progress-bar-striped bg-warning" style="width:<%=obj[38]%>%" > </div>
															  	<div class="progress-bar progress-bar-striped bg-primary" style="width:<%=obj[40]%>%"  > </div>
															  	<div class="progress-bar progress-bar-striped bg-danger" style="width:<%=obj[42]%>%" > </div>
															  	
															</div>
														</div>
														<div class="col-md-1" style="padding-left: 0px !important;">
																	<span class="health-circle"  style="cursor: pointer;<%if(Integer.parseInt(obj[42].toString())<=25){%> background-color:red<%}%>
																											   <%if( (Integer.parseInt(obj[42].toString())>25) && (Integer.parseInt(obj[42].toString())<=50)){%> background-color: #EE5007; <%}%>
																											   <%if( (Integer.parseInt(obj[42].toString())>50) && (Integer.parseInt(obj[42].toString())<=75)){%> background-color: #F8CB2E;color:black <%}%>
																											   <%if( (Integer.parseInt(obj[42].toString())>75) && (Integer.parseInt(obj[42].toString())<=100)){%> background-color:green <%}%>"
																	><%=obj[42] %></span>
														</div>
														<div class="col-md-1" style="padding-left: 0px !important">
														</div>
													</div>
													
													<%}else{ %>
													<div class="progress nil-bar" style="background-color:#cdd0cb !important;height: 1.2rem !important;">
														<div class="progress-bar" role="progressbar" style=" width: 100%; background-color:#cdd0cb !important;color:black;font-weight: bold;  "  >
															Nil
														</div>
													</div>
													<%} %>
												</td>
											</tr> 
											
											<%  ProjectCount++; } }  } } %>
											
										</tbody>
											
											
									</table>	
									
												
				
								</div> 
							
							</div> 
					<!-- /////////////// ALL PROJECT DETAILS IN OVERALL DASHBOARD ENDS //////////// -->		
							
					</div>
<!-- ****************************************************************** OVERALL DASHBOARD MODULE STARTS********************************************************************************* -->

	 <!-- *************************************** INDIVIDUAL PROJECT DETAILS STARTS ******************************** -->
	
	<div class="card" style="background: white;display:none;margin: -2px 10px" id="projectgraph" >
		<div style="background-color: rgba(255, 255, 255, 0.39999) !important ;border-radius: 4px ;overflow-x:hidden " align="center">
			<div  style="margin: 5px">
				<span class="ProjecChartCardTitle" style="color: #145374;font-size: 20px;text-decoration: underline;"></span>
				<button class="btn prints" style="float: left;padding: 3px 7px;margin: 0px 5px ;" onclick="overalldoc()" data-toggle="tooltip" title="Doc"><i class="fa fa-file-text-o" aria-hidden="true"></i></button>
				<button class="btn  btn-danger" style="float: left;padding: 3px 7px;" onclick="overalldetails('A')" data-toggle="tooltip" title="Close" >CLOSE &nbsp;<i class="fa fa-times-circle faa-pulse animated faa-fast" aria-hidden="true"></i></button>
				
				<br>
			</div>
		</div>
				<div class="row">
					<div class="col-md-3">
	 					<figure class="highcharts-figure">
							<div id="containerh"></div>
						</figure>
					</div>
					<div class="col-md-1"></div>
					<div class="col-md-3">
	 					<figure class="highcharts-figure">
							<div id="containerh2"></div>
						</figure>
					</div>
					<div class="col-md-1"></div>
					<div class="col-md-3">
	 					<figure class="highcharts-figure">
							<div id="containerh3"></div>
						</figure>
					</div>
				</div>
				<hr>
				<div class="row">
					<div class="col-md-3">
	 					<figure class="highcharts-figure">
							<div id="containerh4"></div>
						</figure>
					</div>
					<div class="col-md-1"></div>
					<div class="col-md-3">
	 					<figure class="highcharts-figure">
							<div id="containerh5"></div>
						</figure>
					</div>
					<div class="col-md-1"></div>
					<div class="col-md-3">
	 					<figure class="highcharts-figure">
							<div id="containerh6"></div>
						</figure>
					</div>
				</div>
			
		</div>
     <!-- *************************************** INDIVIDUAL PROJECT DETAILS ENDS ******************************** -->
     
	 <!-- *************************************** INFORMATIVE MODAL STARTS **************************************** -->
	 
	<div class="modal fade " id="exampleModal1" tabindex="-1" aria-labelledby="exampleModalLabel1" aria-hidden="true">
		<div class="modal-dialog modal-lg">
			<div class="modal-content">
				      
				<div class="modal-header ">
					<h5 class="modal-title" id="exampleModalLabel" style="color:#145374">Colour Coding Summary</h5>
					<button type="button" class="close" data-dismiss="modal" aria-label="Close">
						<span aria-hidden="true">&times;</span>
			        </button>
			  	</div>
					      
				<div class="modal-body">
						
					<%
					 if(!IsDG.equalsIgnoreCase("Yes") ) { %>	
						
					<div class="row">
						<div style="text-align: left">
								<p style="margin-bottom: 0px !important;margin-left:10px">Project </p>
								<hr class="modal-hr">
								<ul class="modal-list">
						          	<li><span class="modal-span" style="color:green">&#8226;</span><span class="modal-text">Indian Army</span></li>
						           	<li><span class="modal-span" style="color:#007bff">&#8226;</span><span class="modal-text">Indian Navy</span></li>
						           	<li><span class="modal-span" style="color:#1F4690">&#8226;</span><span class="modal-text">Indian Air Forces</span></li>
						           	<li><span class="modal-span" style="color:#8E3200">&#8226;</span><span class="modal-text">Home Land Security</span></li>
						           	<li><span class="modal-span" style="color:#231955">&#8226;</span><span class="modal-text">DRDO</span></li>
						           	<li><span class="modal-span" style="color:#EE5007">&#8226;</span><span class="modal-text">Others</span></li>
					            </ul>
							</div>
					</div>
					
					<%} %>
						
					<div class="row">
						<div style="text-align: left">
								<p style="margin-bottom: 0px !important;margin-left:10px">Project Health (Completed %)</p>
								<hr class="modal-hr">
								<ul class="modal-list">
									<li><span class="modal-span" style="color:red">&#8226;</span><span class="modal-text">0-25%</span></li>
						           	<li><span class="modal-span" style="color:#EE5007;">&#8226;</span><span class="modal-text">25-50%</span></li>
						           	<li><span class="modal-span" style="color:#F8CB2E;">&#8226;</span><span class="modal-text">50-75%</span></li>
						           	<li><span class="modal-span" style="color:green">&#8226;</span><span class="modal-text">75-100%</span></li>
					            </ul>
							</div>
					</div>		

					<div class="row">
						<div style="text-align: left">
								<p style="margin-bottom: 0px !important;margin-left:10px">Milestone</p>
								<hr class="modal-hr">
								<ul class="modal-list">
									<li><span class="modal-span green" >&#8226;</span><span class="modal-text">Completed</span></li>
									<li><span class="modal-span yellow" >&#8226;</span><span class="modal-text">Delayed</span></li>
						          	<li><span class="modal-span red" >&#8226;</span><span class="modal-text">Pending</span></li>
					            </ul>
							</div>
					</div>		
					
					<div class="row">
						<div style="text-align: left">
								<p style="margin-bottom: 0px !important;margin-left:10px">Action</p>
								<hr class="modal-hr">
								<ul class="modal-list">
						           	<li><span class="modal-span green" >&#8226;</span><span class="modal-text">Completed</span></li>
						           	<li><span class="modal-span yellow" >&#8226;</span><span class="modal-text">Delayed</span></li>
						           	<li><span class="modal-span blue" >&#8226;</span><span class="modal-text">Forwarded</span></li>
						           	<li><span class="modal-span red" >&#8226;</span><span class="modal-text">Pending</span></li>
					            </ul>
							</div>
					</div>
					
					<div class="row">
						<div style="text-align: left">
								<p style="margin-bottom: 0px !important;margin-left:10px">Risks</p>
								<hr class="modal-hr">
								<ul class="modal-list">
									<li><span class="modal-span green" >&#8226;</span><span class="modal-text">Completed</span></li>
									<li><span class="modal-span yellow" >&#8226;</span><span class="modal-text">Delayed</span></li>
						          	<li><span class="modal-span red" >&#8226;</span><span class="modal-text">Pending</span></li>
					            </ul>
							</div>
					</div>
					
					<div class="row">
						<div style="text-align: left">
								<p style="margin-bottom: 0px !important;margin-left:10px">Finance</p>
								<hr class="modal-hr">
								<ul class="modal-list">
						          	<li><span class="modal-span green" >&#8226;</span><span class="modal-text">Expenditure</span></li>
						           	<li><span class="modal-span yellow" >&#8226;</span><span class="modal-text">O/S</span></li>
						           	<li><span class="modal-span blue" >&#8226;</span><span class="modal-text">DIPL</span></li>
						           	<li><span class="modal-span red" >&#8226;</span><span class="modal-text">Balance</span></li>
					            </ul>
							</div>
					</div>
					<div class="row">
						<div style="text-align: left">
								<p style="margin-bottom: 0px !important;margin-left:10px">Cash Out Go</p>
								<hr class="modal-hr">
								<ul class="modal-list">
						          	<li><span class="modal-span" style="color:#5C192F;">&#8226;</span><span class="modal-text">Capital</span></li>
						           	<li><span class="modal-span" style="color:#466136;">&#8226;</span><span class="modal-text">Revenue</span></li>
						           	<li><span class="modal-span" style="color:#591A69;">&#8226;</span><span class="modal-text">Others</span></li>
					            </ul>
							</div>
					</div>
					          
				</div>
				
					      
			</div>
		</div>
	</div>
    <!-- *************************************** INFORMATIVE MODAL ENDS **************************************** -->

	<!-- *************************************** DG VIEW START****************************************************** -->
	
	<div style="display:none" id="dgdashboard">
	
		<div class="container-fluid">
	
		<div class="card-deck" style="margin-top: -20px;margin-bottom: 5px;" >
		  <div class="card detailscard">
		    <div class="card-body">
		      <h5 class="card-title"><img src="view/images/discuss.png" /> Meeting</h5>
		      <hr>
		      <div class="row">
		      	<div class="col-md-6 circular-progress">
		      		 <div class="progress " data-value='<%=(ProjectHealthTotalData[29] )%>'>
			          <span class="progress-left">
			          		<span class="progress-bar <%if(Integer.parseInt(ProjectHealthTotalData[29].toString())<=25){%> border-danger<%}%>
																								   <%if( (Integer.parseInt(ProjectHealthTotalData[29].toString())>25) && (Integer.parseInt(ProjectHealthTotalData[29].toString())<=50)){%> border-orange<%}%>
																								   <%if( (Integer.parseInt(ProjectHealthTotalData[29].toString())>50) && (Integer.parseInt(ProjectHealthTotalData[29].toString())<=75)){%> border-warning <%}%>
																								   <%if( (Integer.parseInt(ProjectHealthTotalData[29].toString())>75) && (Integer.parseInt(ProjectHealthTotalData[29].toString())<=100)){%> border-success <%}%>
																"></span>             
			          </span>
			          <span class="progress-right">
			                <span class="progress-bar <%if(Integer.parseInt(ProjectHealthTotalData[29].toString())<=25){%> border-danger<%}%>
																								   <%if( (Integer.parseInt(ProjectHealthTotalData[29].toString())>25) && (Integer.parseInt(ProjectHealthTotalData[29].toString())<=50)){%> border-orange<%}%>
																								   <%if( (Integer.parseInt(ProjectHealthTotalData[29].toString())>50) && (Integer.parseInt(ProjectHealthTotalData[29].toString())<=75)){%> border-warning <%}%>
																								   <%if( (Integer.parseInt(ProjectHealthTotalData[29].toString())>75) && (Integer.parseInt(ProjectHealthTotalData[29].toString())<=100)){%> border-success <%}%>
																"></span>   
			          </span>
			          <div class="progress-value w-100 h-100 rounded-circle d-flex align-items-center justify-content-center">
			            <div class="h4 font-weight-bold" id="pmrcprogress" ><%=(ProjectHealthTotalData[29] )%>%</div>
			          </div>
			        </div>
			        <div><h6 style="margin-bottom: 5px">PMRC</h6></div>
			        <hr style="margin: 5px !important">
			        <table class="countstable" style="margin: 0px auto">
			        	<tr>
			        		<td style="font-size: 14px" id="meetingsvaluepmrc" data-toggle="tooltip" title="Held / To be Held / Total to be Held" >
			        			<%if(ProjectHealthTotalData !=null){%> <span><%=ProjectHealthTotalData[0] %> / <%=ProjectHealthTotalData[2] %> / <%=ProjectHealthTotalData[46] %></span> <%}%>
			        		</td>
			        	</tr>
			        </table>
		      	</div>
		      	<div class="col-md-6 circular-progress">
		      		 <div class="progress "  data-value='<%=(ProjectHealthTotalData[31] )%>'>
			          <span class="progress-left">
			          		<span class="progress-bar <%if(Integer.parseInt(ProjectHealthTotalData[31].toString())<=25){%> border-danger<%}%>
																								   <%if( (Integer.parseInt(ProjectHealthTotalData[31].toString())>25) && (Integer.parseInt(ProjectHealthTotalData[31].toString())<=50)){%> border-orange<%}%>
																								   <%if( (Integer.parseInt(ProjectHealthTotalData[31].toString())>50) && (Integer.parseInt(ProjectHealthTotalData[31].toString())<=75)){%> border-warning <%}%>
																								   <%if( (Integer.parseInt(ProjectHealthTotalData[31].toString())>75) && (Integer.parseInt(ProjectHealthTotalData[31].toString())<=100)){%> border-success <%}%>
																"></span>             
			          </span>
			          <span class="progress-right">
			                <span class="progress-bar <%if(Integer.parseInt(ProjectHealthTotalData[31].toString())<=25){%> border-danger<%}%>
																								   <%if( (Integer.parseInt(ProjectHealthTotalData[31].toString())>25) && (Integer.parseInt(ProjectHealthTotalData[31].toString())<=50)){%> border-orange<%}%>
																								   <%if( (Integer.parseInt(ProjectHealthTotalData[31].toString())>50) && (Integer.parseInt(ProjectHealthTotalData[31].toString())<=75)){%> border-warning <%}%>
																								   <%if( (Integer.parseInt(ProjectHealthTotalData[31].toString())>75) && (Integer.parseInt(ProjectHealthTotalData[31].toString())<=100)){%> border-success <%}%>
																"></span>   
			          </span>
			          <div class="progress-value w-100 h-100 rounded-circle d-flex align-items-center justify-content-center">
			            <div class="h4 font-weight-bold" ><%=(ProjectHealthTotalData[31] )%>%</div>
			          </div>
			        </div>
			        <div><h6 style="margin-bottom: 5px">EB</h6></div>
			        <hr style="margin: 5px !important">
			        <table class="countstable" style="margin: 0px auto">
				        	<tr>
				        		<td style="font-size: 14px" id="meetingsvalueeb"  data-toggle="tooltip" title="Held / To be Held / Total to be Held"  >
				        		<%if(ProjectHealthTotalData !=null){%> <span><%=ProjectHealthTotalData[3] %> / <%=ProjectHealthTotalData[5] %> / <%=ProjectHealthTotalData[47] %></span> <%}%>
				        		</td>
				        	</tr>
				     </table>
		      	</div>
		      </div>
		    </div>
		    
		  </div>
		  <div class="card detailscard">
		    <div class="card-body">
		      <h5 class="card-title"><img src="view/images/goal.png" /> Milestone</h5>
		      <hr>
		      <div class="row">
		      	<div class="col-md-6 circular-progress">
		      		<div class="progress " data-value='<%if(ProjectHealthTotalData[10] !=null){%><%=ProjectHealthTotalData[10] %><%} %>'>
			          <span class="progress-left">
			                        <span class="progress-bar <%if(Integer.parseInt(ProjectHealthTotalData[10].toString())<=25){%> border-danger<%}%>
																<%if( (Integer.parseInt(ProjectHealthTotalData[10].toString())>25) && (Integer.parseInt(ProjectHealthTotalData[10].toString())<=50)){%> border-orange<%}%>
																<%if( (Integer.parseInt(ProjectHealthTotalData[10].toString())>50) && (Integer.parseInt(ProjectHealthTotalData[10].toString())<=75)){%> border-warning <%}%>
																<%if( (Integer.parseInt(ProjectHealthTotalData[10].toString())>75) && (Integer.parseInt(ProjectHealthTotalData[10].toString())<=100)){%> border-success <%}%>
																"></span>   
			          </span>
			          <span class="progress-right">
			                        <span class="progress-bar <%if(Integer.parseInt(ProjectHealthTotalData[10].toString())<=25){%> border-danger<%}%>
																<%if( (Integer.parseInt(ProjectHealthTotalData[10].toString())>25) && (Integer.parseInt(ProjectHealthTotalData[10].toString())<=50)){%> border-orange<%}%>
																<%if( (Integer.parseInt(ProjectHealthTotalData[10].toString())>50) && (Integer.parseInt(ProjectHealthTotalData[10].toString())<=75)){%> border-warning <%}%>
																<%if( (Integer.parseInt(ProjectHealthTotalData[10].toString())>75) && (Integer.parseInt(ProjectHealthTotalData[10].toString())<=100)){%> border-success <%}%>
																"></span>   
			          </span>
			          <div class="progress-value w-100 h-100 rounded-circle d-flex align-items-center justify-content-center">
			            <div class="h4 font-weight-bold"><span id="milestonepercentage"><%if(ProjectHealthTotalData[10] !=null){%><%=ProjectHealthTotalData[10] %><%} %>%</span></div>
			          </div>
			     	</div>
		      	</div>
		      	<div class="col-md-6">
		      		<div class="bigcount">
		      			<h1><%if(ProjectHealthTotalData[8] !=null){%><%=ProjectHealthTotalData[8] %><%} %></h1>
		      			<p class="textfont"><span class="green legend-shadow">&#x220E;</span> &nbsp;Completed</p>
		      		</div>
		      		
		      		<div class="bigcount">
		      			<h4><%if(ProjectHealthTotalData[9] !=null){%><%=ProjectHealthTotalData[9] %><%} %></h4>
		      			<p class="textfont">Total</p>
		      		</div>
		      	</div>
		      </div>
		    </div>
		    <table class="countstable card-deck-table" style="margin-bottom: 0px !important;border-top:1px solid darkgrey;">
				  <thead>
				  	<tr>
				  		<td style="border-right:1px solid darkgrey;" data-toggle="tooltip" title="Delayed" >&nbsp;<%if(ProjectHealthTotalData[7] !=null){%><%=ProjectHealthTotalData[7] %><%} %></td>
				  		<td data-toggle="tooltip" title="Pending"  >&nbsp;<%if(ProjectHealthTotalData[6] !=null){%><%=ProjectHealthTotalData[6] %><%} %></td>
				  	</tr>
				  </thead>
				  <tbody>
				  	<tr>
				  		<th scope="col" class="textfont" style="border-right:1px solid darkgrey;" ><span class="yellow">&#x220E;</span> &nbsp;Delayed</th>
				      	<th scope="col" class="textfont"><span class="red">&#x220E;</span> &nbsp;Pending</th>
				    </tr>
				  </tbody> 
			</table>
		  </div>
		  <div class="card detailscard">
		    <div class="card-body">
		      <h5 class="card-title"><img src="view/images/action1.png" /> Action</h5>
		      <hr>
		      <div class="row">
		      	<div class="col-md-6 circular-progress">
		      		<div class="progress " data-value='<%if(ProjectHealthTotalData[37] !=null){%><%=ProjectHealthTotalData[37] %><%} %>'>
			          <span class="progress-left">
			                        <span class="progress-bar <%if(Integer.parseInt(ProjectHealthTotalData[37].toString())<=25){%> border-danger<%}%>
																<%if( (Integer.parseInt(ProjectHealthTotalData[37].toString())>25) && (Integer.parseInt(ProjectHealthTotalData[37].toString())<=50)){%> border-orange<%}%>
																<%if( (Integer.parseInt(ProjectHealthTotalData[37].toString())>50) && (Integer.parseInt(ProjectHealthTotalData[37].toString())<=75)){%> border-warning <%}%>
																<%if( (Integer.parseInt(ProjectHealthTotalData[37].toString())>75) && (Integer.parseInt(ProjectHealthTotalData[37].toString())<=100)){%> border-success <%}%>
																"></span>   
			          </span>
			          <span class="progress-right">
			                        <span class="progress-bar <%if(Integer.parseInt(ProjectHealthTotalData[37].toString())<=25){%> border-danger<%}%>
																<%if( (Integer.parseInt(ProjectHealthTotalData[37].toString())>25) && (Integer.parseInt(ProjectHealthTotalData[37].toString())<=50)){%> border-orange<%}%>
																<%if( (Integer.parseInt(ProjectHealthTotalData[37].toString())>50) && (Integer.parseInt(ProjectHealthTotalData[37].toString())<=75)){%> border-warning <%}%>
																<%if( (Integer.parseInt(ProjectHealthTotalData[37].toString())>75) && (Integer.parseInt(ProjectHealthTotalData[37].toString())<=100)){%> border-success <%}%>
																"></span>   
			          </span>
			          <div class="progress-value w-100 h-100 rounded-circle d-flex align-items-center justify-content-center">
			            <div class="h4 font-weight-bold"><%if(ProjectHealthTotalData[37] !=null){%><%=ProjectHealthTotalData[37] %><%} %>%</div>
			          </div>
			     	</div>
		      	</div>
		      	<div class="col-md-6">
		      		<div class="bigcount">
		      			<h1><%if(ProjectHealthTotalData[14] !=null){ %><%=ProjectHealthTotalData[14] %><% } %></h1>
		      			<p class="textfont"><span class="green legend-shadow">&#x220E;</span> &nbsp;Completed</p>
		      		</div>
		      		<div class="bigcount">
		      			<h4><%if(ProjectHealthTotalData[15] !=null){ %><%=ProjectHealthTotalData[15] %><% } %></h4>
		      			<p class="textfont">Total</p>
		      		</div>
		      	</div>
		      </div>
		    </div>
		    <table class="countstable card-deck-table" style="margin-bottom: 0px !important;border-top:1px solid darkgrey;">
				  <thead>
				  	<tr>
				  		<td style="border-right:1px solid darkgrey;" data-toggle="tooltip" title="Delayed" ><%if(ProjectHealthTotalData[13] !=null){%>&nbsp;<%=ProjectHealthTotalData[13] %><%} %></td>
				  		<td style="border-right:1px solid darkgrey;" data-toggle="tooltip" title="Forwarded" ><%if(ProjectHealthTotalData[12] !=null){%> &nbsp;<%=ProjectHealthTotalData[12] %><%} %></td>
				  		<td data-toggle="tooltip" title="Pending" ><%if(ProjectHealthTotalData[11] !=null){%>&nbsp;<%=ProjectHealthTotalData[11] %><%} %></td>
				  	</tr>
				  </thead>
				  <tbody>
				  	<tr>
				      <th scope="col" class="textfont" style="border-right:1px solid darkgrey;"><span class="yellow">&#x220E;</span> &nbsp;Delayed</th>
				      <th scope="col" class="textfont" style="border-right:1px solid darkgrey;"><span class="blue">&#x220E;</span> &nbsp;Forwarded</th>
				      <th scope="col" class="textfont"><span class="red">&#x220E;</span> &nbsp;Pending</th>
				    </tr>
				  </tbody>
			</table>
		  </div>
		  <div class="card detailscard">
		    <div class="card-body">
		      <h5 class="card-title"><img src="view/images/risk 1.png" /> Risk</h5>
		      <hr>
		      <div class="row">
		      	<div class="col-md-6 circular-progress">
		      		<div class="progress " data-value='<%if(ProjectHealthTotalData[39] !=null){%><%=ProjectHealthTotalData[39] %><%} %>'>
			          <span class="progress-left">
			                         <span class="progress-bar <%if(Integer.parseInt(ProjectHealthTotalData[39].toString())<=25){%> border-danger<%}%>
																								   <%if( (Integer.parseInt(ProjectHealthTotalData[39].toString())>25) && (Integer.parseInt(ProjectHealthTotalData[39].toString())<=50)){%> border-orange<%}%>
																								   <%if( (Integer.parseInt(ProjectHealthTotalData[39].toString())>50) && (Integer.parseInt(ProjectHealthTotalData[39].toString())<=75)){%> border-warning <%}%>
																								   <%if( (Integer.parseInt(ProjectHealthTotalData[39].toString())>75) && (Integer.parseInt(ProjectHealthTotalData[39].toString())<=100)){%> border-success <%}%>
																"></span>  
			          </span>
			          <span class="progress-right">
			                         <span class="progress-bar <%if(Integer.parseInt(ProjectHealthTotalData[39].toString())<=25){%> border-danger<%}%>
																								   <%if( (Integer.parseInt(ProjectHealthTotalData[39].toString())>25) && (Integer.parseInt(ProjectHealthTotalData[39].toString())<=50)){%> border-orange<%}%>
																								   <%if( (Integer.parseInt(ProjectHealthTotalData[39].toString())>50) && (Integer.parseInt(ProjectHealthTotalData[39].toString())<=75)){%> border-warning <%}%>
																								   <%if( (Integer.parseInt(ProjectHealthTotalData[39].toString())>75) && (Integer.parseInt(ProjectHealthTotalData[39].toString())<=100)){%> border-success <%}%>
																"></span>  
			          </span>
			          <div class="progress-value w-100 h-100 rounded-circle d-flex align-items-center justify-content-center">
			            <div class="h4 font-weight-bold"><%if(ProjectHealthTotalData[39] !=null){%><%=ProjectHealthTotalData[39] %><%} %>%</div>
			          </div>
			     	</div>
		      	</div>
		      	<div class="col-md-6">
		      		<div class="bigcount">
		      			<h1><%if(ProjectHealthTotalData[16] !=null){%><%=ProjectHealthTotalData[16] %><%} %></h1>
		      			<p class="textfont"><span class="green legend-shadow">&#x220E;</span> &nbsp;Completed</p>
		      		</div>
		      		<div class="bigcount">
		      			<h4><%if(ProjectHealthTotalData[18] !=null){%><%=ProjectHealthTotalData[18] %><%} %></h4>
		      			<p class="textfont">Total</p>
		      		</div>
		      	</div>
		      </div>
		    </div>
		    <table class="countstable card-deck-table" style="margin-bottom: 0px !important;border-top:1px solid darkgrey;">
				  <thead>
				  	<tr>
				  		<td style="border-right:1px solid darkgrey;" data-toggle="tooltip" title="Delayed" >&nbsp;0</td>
				  		<td data-toggle="tooltip" title="Pending" ><%if(ProjectHealthTotalData[17] !=null){%>&nbsp;<%=ProjectHealthTotalData[17] %><%} %></td>
				  	</tr>
				  </thead>
				 <tbody>
				  	<tr>
				      <th scope="col" class="textfont"style="border-right:1px solid darkgrey;"><span class="yellow">&#x220E;</span> &nbsp;Delayed</th>
				      <th scope="col" class="textfont"><span class="red">&#x220E;</span> &nbsp;Pending</th>
				    </tr>
				  </tbody> 
			</table>
		  </div>
		   <div class="card detailscard">
		    <div class="card-body">
		    	<div style="display: inline-flex">
			      <h5 class="card-title" style="margin-bottom: 8px !important">
					<img src="view/images/rupee.png" /> Finance<!--  <span style="font-size: 14px !important">(&#8377;Cr)</span> -->
				  </h5>
			   </div>
		      <hr style="margin:3px 10px !important">
				<table class="table  financetable" >
				  <thead>
				    <tr>
				      <th scope="col">
				     	(In &#8377; k Cr)
				      </th>
				      <th scope="col">Sanc</th>
				      <th scope="col">Exp</th>
				      <th scope="col">Bal</th>
				    </tr>
				  </thead>
				  <%
				  		sanction=new BigDecimal(0.00);
					  	expenditure=new BigDecimal(0.00);
					  	balance=new BigDecimal(0.00);
					  	revBal=new BigDecimal(0.00);
					  	capBal=new BigDecimal(0.00);
					  	othBal=new BigDecimal(0.00);
				  %>
				  <tbody>
				  	<tr>
				      <th scope="row">Revenue</th>
				      <td><span style="color:green">&#8377;</span> <%=DashboardFinance.get(0)[3] %></td>
				      <td><span style="color:green">&#8377;</span> <%=DashboardFinance.get(0)[4] %></td>
				      <%  revBal = new BigDecimal(DashboardFinance.get(0)[3].toString()).subtract(new BigDecimal(DashboardFinance.get(0)[4].toString())) ; %>
				      <td><span style="color:green">&#8377;</span> <%=revBal%></td>
				    </tr>
				     <% sanction	= sanction.add(new BigDecimal(DashboardFinance.get(0)[3].toString())); %>
				     <% expenditure	= expenditure.add(new BigDecimal(DashboardFinance.get(0)[4].toString())); %>
				     <% balance	= balance.add(revBal); %>
				     <tr>
				      <th scope="row">Capital</th>
				      <td><span style="color:green">&#8377;</span> <%=DashboardFinance.get(1)[3] %></td>
				      <td><span style="color:green">&#8377;</span> <%=DashboardFinance.get(1)[4] %></td>
				      <%  capBal = new BigDecimal(DashboardFinance.get(1)[3].toString()).subtract(new BigDecimal(DashboardFinance.get(1)[4].toString())) ; %>
				      <td><span style="color:green">&#8377;</span> <%=capBal %></td>
				    </tr>
				     <% sanction	= sanction.add(new BigDecimal(DashboardFinance.get(1)[3].toString())); %>
				     <% expenditure	= expenditure.add(new BigDecimal(DashboardFinance.get(1)[4].toString())); %>
				     <% balance	= balance.add(capBal); %>
				    
				    <tr>
				      <th scope="row">Others</th>
				      <td><span style="color:green">&#8377;</span> <%=DashboardFinance.get(2)[3] %></td>
				      <td><span style="color:green">&#8377;</span> <%=DashboardFinance.get(2)[4] %></td>
				      <%  othBal = new BigDecimal(DashboardFinance.get(2)[3].toString()).subtract(new BigDecimal(DashboardFinance.get(2)[4].toString())) ; %>
				      <td><span style="color:green">&#8377;</span> <%=othBal %></td>
				    </tr> 
				     <% sanction	= sanction.add(new BigDecimal(DashboardFinance.get(2)[3].toString())); %>
				     <% expenditure	= expenditure.add(new BigDecimal(DashboardFinance.get(2)[4].toString())); %>
				     <% balance	= balance.add(othBal); %>
				    <tr>
				      <th scope="row">Total</th>
				      <td><span style="color:green">&#8377;</span> <%=sanction%></td>
				      <td><span style="color:green">&#8377;</span> <%=expenditure %></td>
				      <td><span style="color:green">&#8377;</span> <%=balance %></td>
				    </tr>
				  </tbody>
				</table>
	
			   </div>
		  	</div>	 
		</div>
		</div>



		<div class="container-fluid">

		<div class="card" style="background: transparent;">
		
			<div id="overalldivdg" style="background-color: rgba(255, 255, 255, 0.39999) !important ;border-radius: 4px ;/* max-height: 26rem */; overflow-y:auto;overflow-x:hidden  ">
								
				<table class="table meeting tableFixHead fixed-table "  style="table-layout: fixed;margin-bottom: 0rem !important"> 
										<thead style=" background: #1363DF; color: white;">												
											<tr>
												<td style="width:4%">
													<!-- <a  data-toggle="modal"  class="fa faa-pulse animated " data-target="#exampleModal1" data-whatever="@mdo" style="padding: 0px 1.5rem;cursor:pointer" ><i class="fa fa-info-circle " style="font-size: 1.3rem;color: " aria-hidden="true"></i> </a> -->
												</td>
												<td style="width:5%"><span style="font-size :15px;font-weight: bold; ">Lab</span></td>
												<td style="padding: 0px !important"><span style="font-size :15px;font-weight: bold;">PMRC </span></td>
												<td style="padding: 0px !important"><span style="font-size :15px;font-weight: bold;">EB </span></td>
												<td ><span style="font-size :15px;font-weight: bold;  ">Milestone </span></td>
												<td ><span style="font-size :15px;font-weight: bold;  ">Action</span></td>
												<td ><span style="font-size :15px;font-weight: bold;  ">Risk</span></td>
												<td ><span style="font-size :15px;font-weight: bold;  ">Finance</span></td>
											</tr>
										</thead>
										
										<tbody>
	
											<%for(Object[] obj : projecthealthtotaldg) { %>
		
											<tr>
											
												<td><a href="javascript:LabDetails('<%=obj[45] %>')"> <i class="fa fa-hand-o-right" aria-hidden="true" style="color: purple;font-size: 1.3rem !important"></i></a></td>
												<td style="font-weight: 800; font-size:0.75rem;text-align:left;"><%=obj[45] %>	</td>
												<td class="custom-td">
													<%if(Integer.parseInt(obj[2].toString())>0){ %>
														
														<div class="row">
															<div class="col-md-11">
															    <div class="progress"  >
																  <div class="progress-bar progress-bar-striped bg-success" onclick="overallmeetingredirectdg('<%=obj[2]%>','1', 'B')" style="width:<%=obj[29]%>%;" data-toggle="tooltip" title="PMRC Held : <%=obj[0]%> / <%=obj[2] %>" ></div>
																  <div class="progress-bar progress-bar-striped bg-primary" onclick="overallmeetingredirectdg('<%=obj[2]%>','1', 'C' )" style="width:<%=obj[30]%>%;" data-toggle="tooltip" title="PMRC Pending : <%=obj[1]%> / <%=obj[2] %>" ></div>
																</div>
														  	</div>
															<div class="col-md-1" style="padding-left: 0px !important">
																<span class="health-circle" style="<%if(Integer.parseInt(obj[29].toString())<=25){%> background-color:red <%}%>
																								   <%if( (Integer.parseInt(obj[29].toString())>25) && (Integer.parseInt(obj[29].toString())<=50)){%> background-color: #EE5007; <%}%>
																								   <%if( (Integer.parseInt(obj[29].toString())>50) && (Integer.parseInt(obj[29].toString())<=75)){%> background-color: #F8CB2E;color:black <%}%>
																								   <%if( (Integer.parseInt(obj[29].toString())>75) && (Integer.parseInt(obj[29].toString())<=100)){%> background-color:green <%}%>
																"><%=obj[29] %></span>
															</div>
											
														</div>
						
													<%}else{ %>
													<div class="progress" style="background-color:#cdd0cb !important;height: 1.2rem !important;">
														<div class="progress-bar" role="progressbar" style=" width: 100%; background-color:#cdd0cb !important;color:black;font-weight: bold;  "  >
															Nil
														</div>
													</div>
													<%} %>
												</td>	
												<td class="custom-td">
													<%if(Integer.parseInt(obj[5].toString())>0){ %>
														
														<div class="row">
															<div class="col-md-11">
															    <div class="progress"  >
																  <div class="progress-bar progress-bar-striped bg-success" onclick="overallmeetingredirectdg('<%=obj[2]%>','1', 'B')" style="width:<%=obj[31]%>%;" data-toggle="tooltip" title="EB Held : <%=obj[3]%> / <%=obj[5] %>" ></div>
																  <div class="progress-bar progress-bar-striped bg-primary" onclick="overallmeetingredirectdg('<%=obj[2]%>','1', 'C' )" style="width:<%=obj[32]%>%;" data-toggle="tooltip" title="EB Pending : <%=obj[4]%> / <%=obj[5] %>" ></div>
																</div>
														  	</div>
															<div class="col-md-1" style="padding-left: 0px !important">
																<span class="health-circle" style="<%if(Integer.parseInt(obj[31].toString())<=25){%> background-color:red <%}%>
																								   <%if( (Integer.parseInt(obj[31].toString())>25) && (Integer.parseInt(obj[31].toString())<=50)){%> background-color: #EE5007; <%}%>
																								   <%if( (Integer.parseInt(obj[31].toString())>50) && (Integer.parseInt(obj[31].toString())<=75)){%> background-color: #F8CB2E;color:black <%}%>
																								   <%if( (Integer.parseInt(obj[31].toString())>75) && (Integer.parseInt(obj[31].toString())<=100)){%> background-color: green <%}%>
																"><%=obj[31] %></span>
															</div>
														</div>
						
													<%}else{ %>
													<div class="progress" style="background-color:#cdd0cb !important;height: 1.2rem !important;">
														<div class="progress-bar" role="progressbar" style=" width: 100%; background-color:#cdd0cb !important;color:black;font-weight: bold;  "  >
															Nil
														</div>
													</div>
													<%} %>
												</td>
												<td class="custom-td">
													<%if(Integer.parseInt(obj[9].toString())>0){ %>
													<div class="row">
														<div class="col-md-11">
															<div class="progress" onclick="overallcommonredirectdg('mil','<%=obj[2]%>')">
															  <div class="progress-bar progress-bar-striped bg-success" style="width:<%=obj[10]%>%" data-toggle="tooltip" title="Completed : <%=obj[8]%> / <%=obj[9] %>" ></div>
															  <div class="progress-bar progress-bar-striped bg-warning" style="width:<%=obj[33]%>%" data-toggle="tooltip" title="Delayed : <%=obj[7]%> / <%=obj[9] %>" ></div>
															  <div class="progress-bar progress-bar-striped bg-danger" style="width:<%=obj[44]%>%" data-toggle="tooltip" title="Pending : <%=obj[6]%> / <%=obj[9] %>" ></div>															  
															</div>
														</div>
														<div class="col-md-1" style="padding-left: 0px !important">
																<span class="health-circle" style="<%if(Integer.parseInt(obj[10].toString())<=25){%> background-color:red <%}%>
																								   <%if( (Integer.parseInt(obj[10].toString())>25) && (Integer.parseInt(obj[10].toString())<=50)){%> background-color: #EE5007; <%}%>
																								   <%if( (Integer.parseInt(obj[10].toString())>50) && (Integer.parseInt(obj[10].toString())<=75)){%> background-color: #F8CB2E;color:black <%}%>
																								   <%if( (Integer.parseInt(obj[10].toString())>75) && (Integer.parseInt(obj[10].toString())<=100)){%> background-color:green <%}%>
																"><%=obj[10] %></span>
														</div>
													</div>
													<%}else{ %>
													<div class="progress" style="background-color:#cdd0cb !important;height: 1.2rem !important;">
														<div class="progress-bar" role="progressbar" style=" width: 100%; background-color:#cdd0cb !important;color:black;font-weight: bold;  "  >
															Nil
														</div>
													</div>
													<%} %>
												</td>
												<td class="custom-td">
													<%if(Integer.parseInt(obj[15].toString())>0){ %>
													<div class="row">
														<div class="col-md-11">
															<div class="progress" onclick="overallcommonredirect('action','<%=obj[2]%>')">
															  <div class="progress-bar progress-bar-striped bg-success" style="width:<%=obj[37]%>%" data-toggle="tooltip" title="Completed : <%=obj[14]%> / <%=obj[15]%>" ></div>
															  <div class="progress-bar progress-bar-striped bg-warning" style="width:<%=obj[36]%>%" data-toggle="tooltip" title="Delayed : <%=obj[13]%> / <%=obj[15]%>" ></div>
															  <div class="progress-bar progress-bar-striped bg-primary" style="width:<%=obj[35]%>%" data-toggle="tooltip" title="Forwarded : <%=obj[12]%> / <%=obj[15]%>" ></div>
															  <div class="progress-bar progress-bar-striped bg-danger" style="width:<%=obj[34]%>%" data-toggle="tooltip" title="Pending : <%=obj[11]%> / <%=obj[15]%>" ></div>
															</div>
														</div>
														<div class="col-md-1" style="padding-left: 0px !important">
															<span class="health-circle" style="<%if(Integer.parseInt(obj[37].toString())<=25){%> background-color:red <%}%>
																									   <%if( (Integer.parseInt(obj[37].toString())>25) && (Integer.parseInt(obj[37].toString())<=50)){%> background-color: #EE5007; <%}%>
																									   <%if( (Integer.parseInt(obj[37].toString())>50) && (Integer.parseInt(obj[37].toString())<=75)){%> background-color: #F8CB2E;color:black <%}%>
																									   <%if( (Integer.parseInt(obj[37].toString())>75) && (Integer.parseInt(obj[37].toString())<=100)){%> background-color:green <%}%>
															"><%=obj[37] %></span>
														</div>
													</div>
													<%}else{ %>
													<div class="progress" style="background-color:#cdd0cb !important;height: 1.2rem !important;">
														<div class="progress-bar" role="progressbar" style=" width: 100%; background-color:#cdd0cb !important;color:black;font-weight: bold;  "  >
															Nil
														</div>
													</div>
													<%} %>
												</td> 
												<td class="custom-td">
													<%if(Integer.parseInt(obj[18].toString())>0){ %>
													<div class="row">
														<div class="col-md-11">
															<div class="progress" onclick="overallcommonredirect('risk','<%=obj[2]%>')">
															  <div class="progress-bar progress-bar-striped bg-success" style="width:<%=obj[39]%>%" data-toggle="tooltip" title="Completed : <%=obj[16]%> / <%=obj[18] %>" ></div>
															  <div class="progress-bar progress-bar-striped bg-danger" style="width:<%=obj[38]%>%" data-toggle="tooltip" title="Pending : <%=obj[17]%> / <%=obj[18] %>" ></div>
															</div>
														</div>
														<div class="col-md-1" style="padding-left: 0px !important">
																<span class="health-circle" style="<%if(Integer.parseInt(obj[39].toString())<=25){%> background-color:red <%}%>
																										   <%if( (Integer.parseInt(obj[39].toString())>25) && (Integer.parseInt(obj[39].toString())<=50)){%> background-color: #EE5007; <%}%>
																										   <%if( (Integer.parseInt(obj[39].toString())>50) && (Integer.parseInt(obj[39].toString())<=75)){%> background-color: #F8CB2E;color:black<%}%>
																										   <%if( (Integer.parseInt(obj[39].toString())>75) && (Integer.parseInt(obj[39].toString())<=100)){%> background-color: green <%}%>
																"><%=obj[39] %></span>
														</div>
													</div>
													<%}else{ %>
													<div class="progress" style="background-color:#cdd0cb !important;height: 1.2rem !important;">
														<div class="progress-bar" role="progressbar" style=" width: 100%; background-color:#cdd0cb !important;color:black;font-weight: bold;  "  >
															Nil
														</div>
													</div>
													<%} %>
												</td>
												<td class="custom-td">
													<%
													BigInteger number = new BigInteger(obj[23].toString());
													if(number.compareTo(new BigInteger("0")) >0){ %>
													<div class="row">
														<div class="col-md-10">
															<div class="progress" onclick="overallfinance()">
															  <div class="progress-bar progress-bar-striped bg-success" style="width:<%=obj[40]%>%" data-toggle="tooltip" title="Expenditure : &#8377; <%=nfc.rupeeFormat(String.valueOf(Math.round(Double.parseDouble(obj[19].toString() ))))%>" ></div>
															  <div class="progress-bar progress-bar-striped bg-warning" style="width:<%=obj[41]%>%" data-toggle="tooltip" title="OC : &#8377; <%=nfc.rupeeFormat(String.valueOf(Math.round(Double.parseDouble(obj[20].toString() ))))%> " ></div>
															  <div class="progress-bar progress-bar-striped bg-primary" style="width:<%=obj[42]%>%" data-toggle="tooltip" title="DIPL : &#8377; <%=nfc.rupeeFormat(String.valueOf(Math.round(Double.parseDouble(obj[21].toString() ))))%> " ></div>
															  <div class="progress-bar progress-bar-striped bg-danger" style="width:<%=obj[43]%>%" data-toggle="tooltip" title="Balance : &#8377; <%=nfc.rupeeFormat(String.valueOf(Math.round(Double.parseDouble(obj[22].toString() ))))%> " ></div>
															</div>
														</div>
														<div class="col-md-1" style="padding-left: 0px !important">
																	<span class="health-circle" style="<%if(Integer.parseInt(obj[43].toString())<=25){%> background-color:green <%}%>
																											   <%if( (Integer.parseInt(obj[43].toString())>25) && (Integer.parseInt(obj[43].toString())<=50)){%> background-color: #F8CB2E;color:black <%}%>
																											   <%if( (Integer.parseInt(obj[43].toString())>50) && (Integer.parseInt(obj[43].toString())<=75)){%> background-color: #EE5007 <%}%>
																											   <%if( (Integer.parseInt(obj[43].toString())>75) && (Integer.parseInt(obj[43].toString())<=100)){%> background-color:red <%}%>
																	"><%=obj[43] %></span>
														</div>
														<div class="col-md-1" style="padding-left: 0px !important">
														</div>
													</div>
													
													<%}else{ %>
													<div class="progress" style="background-color:#cdd0cb !important;height: 1.2rem !important;">
														<div class="progress-bar" role="progressbar" style=" width: 100%; background-color:#cdd0cb !important;color:black;font-weight: bold;  "  >
															Nil
														</div>
													</div>
													<%} %>
												</td> 
												
												
											</tr>
											
											
											<%} %>
											
											
										</tbody>
											
											
									</table>	
									
												
				
								</div> 
							
							</div> 

		
		</div>
		
		
	
	</div>
	
	<!-- *************************************** DG VIEW END****************************************************** -->

	

	<form method="post" action="ActionWiseAllReport.htm" name="dateform" id="dateform">                                                    	
		<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" /> 													
		<input type="hidden" name="ActionType"  id="TypeId" />
		<input type="hidden" name="ProjectId"	id="Id"/>		
	</form>
	
	<form method="post" action="CommitteeAutoScheduleList.htm" name="committeeform" id="committeeform">                                                    	
		<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" /> 	
		<input type="hidden" name="projectid"  id="projectidauto" />	
		<input type="hidden" name="projectstatus"  id="projectstatus" />	
		<input type="hidden" name="committeeid"  id="committeeid" />	
		<input type="hidden" name="divisionid"	value="D" /> 
		<input type="hidden" name="initiationid" value="0" /> 													
	</form>
	
	<form method="post" action="NonProjectCommitteeAutoSchedule.htm" name="committeegeneralform" id="committeegeneralform">                                                    	
		<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" /> 	
		<input type="hidden" name="committeeid" value="A"  id="committeeid" />	
		<input type="hidden" name="dashboardlink" value="dashboard" id="dashboardlink" />
	</form>
	
	<form method="post" action="ActionReportSubmit.htm" name="mytaskactionform" id="mytaskactionform">                                                    	
		<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" /> 	
		<input type="hidden" name="Term"  id="term" />	
		<input type="hidden" name="Type"  id="type" />
	</form> 
	
	<form method="POST"  action="MilestoneActivityList.htm" name="milestoneform" id="milestoneform">
		<input type="hidden" name="ProjectId" id="projectIdMil" />
		<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" /> 
	</form>
	
	<form method="POST"  action="ActionPDReports.htm" name="actionredirectform" id="actionredirectform">
		<input type="hidden" name="ProjectId" id="projectIdAction" />
		<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" /> 
	</form>
	
	<form method="POST"  action="ProjectRisk.htm" name="projectriskform" id="projectriskform">
		<input type="hidden" name="projectid" id="projectIdRisk" />
		<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" /> 
	</form>
	
	<form method="POST"  action="TestingFileRepo.htm" name="docrepoform" id="docrepoform">
		<input type="hidden" name="projectid" id="projectiddoc" />
		<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" /> 
	</form>
	
	<form method="POST"  action="ChangesinProject.htm" name="changesform" id="changesform">
		<input type="hidden" name="projectid" id="projectidchanges" value="A" />
		<input type="hidden" name="interval" id="intervalchanges" value="T" />
		<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" /> 
	</form>

	<form method="POST" action="LabWiseProjectDetails.htm" name="labdetailsform" id="labdetailsform">
		<input type="hidden" name="labcode" id="labcode">
		<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" /> 
	</form>
 <button class="open-modal-button" id="modalbtn" onclick="openModal()"><i class="fa fa-arrow-left" aria-hidden="true"></i></button>
<form action="#" >
 <%if(ProjectList.size()>0){%><button type="submit" class="open-modal-button " id="brifingBtn" onclick="" data-toggle="tooltip" title="Briefing"  formaction="ProjectBriefingPaper.htm" formmethod="get"><img class="fa faa-pulse animated faa-fast" alt="" src="view/images/requirements.png" style="width:21px" ></button><%} %>
</form>
  <!-- Modal Container -->
  <div id="myModal" class="modal-container" >
    <div class="modalheader" style="justify-content: start;color:red;">
    	<p style="margin-top:0.3rem; margin-bottom:0.4rem;"><b> Today's Date : &nbsp;</b><%=sdf.format(sdf1.parse( LocalDate.now().toString()))%></p>
     <!--  <span class="modal-close"  onclick="closeModal()">&times;</span> -->
    </div>
    <div class="modalcontent" >
      <p style="font-weight: 600;text-align: justify; cursor: pointer;"onclick="openModalDetails('M',<%=todayMeetingCount%>)"> <span style="text-decoration: underline">Meetings Scheduled Today</span>:&nbsp;&nbsp;<span style="border:1px solid trasparent;padding:4px;border-radius: 5px;background: green;color:white;"><%=todayMeetingCount %></span> </p>
      <a <%if(actionCounts>0){ %> href="AssigneeList.htm"<%} %> style="font-weight: 600;float:left; color:black; "><span style="text-decoration: underline">Actions PDC Today</span>:
      <span style="border:1px solid trasparent;padding:4px;border-radius: 5px;background: green;color:white;"><%=actionCounts %></span>
      </a>
      <%if(LabCode.equalsIgnoreCase("ADE")){ %>
      <%if(todayRfaCount1>0){ %>
      <a href="RfaAction.htm?Status=O" style="font-weight: 600;float:left; color:black; margin-top: 10px"><span style="text-decoration: underline">RFA Pending</span>:
      <span style="border:1px solid trasparent;padding:4px;border-radius: 5px;background: green;color:white;"><%=todayRfaCount1 %></span>
      </a>
      <%} %>
       <%if(rfaForwardCount>0){ %>
      <a href="RfaActionForwardList.htm" style="font-weight: 600;float:left; color:black; margin-top: 10px"><span style="text-decoration: underline">RFA Forward Pending</span>:
      <span style="border:1px solid trasparent;padding:4px;border-radius: 5px;background: green;color:white;"><%=rfaForwardCount %></span>
      </a>
      <%} %>
       <%if(rfaInspectionCount>0){ %>
      <a href="RfaInspection.htm" style="font-weight: 600;float:left; color:black; margin-top: 10px"><span style="text-decoration: underline">RFA Inspection Pending</span>:
      <span style="border:1px solid trasparent;padding:4px;border-radius: 5px;background: green;color:white;"><%=rfaInspectionCount %></span>
      </a>
      <%} %>
       <%if(rfaInspectionAprCount>0){ %>
      <a href="RfaInspectionApproval.htm" style="font-weight: 600;float:left; color:black; margin-top: 10px"><span style="text-decoration: underline">RFA Inspection Forward Pending</span>:
      <span style="border:1px solid trasparent;padding:4px;border-radius: 5px;background: green;color:white;"><%=rfaInspectionAprCount %></span>
      </a>
      <%} %>
      <%}%>
    </div>
    <div class="modalfooter">
      <button class="btn" style="padding: 0px !important;font-weight: 500" onclick="closeModal()">Close</button>
    </div>
  </div>

  <div id="ModalDetails" class="modalcontainer">
    <div class="modalheader">
      <span class="modal-close"  onclick="closeModals()">&times;</span>
    </div>
    <div class="modalcontent"  id="modalcontents">
    </div>
  </div>



<script type="text/javascript">



function scrollProjectAttributesTop(e) 
{ 
    $('html, body').animate({ scrollTop: $('#overalltable').offset().top }, 'slow'); 
}

function ProjectDetails(value,ProjectCode)
{
	$("#overalldiv").css("display","none");
	$('#projectgraph').css("display","block");
	
	$('#projectiddoc').val(value);
	$('#projectidchanges').val(value);
	charts(value);
	
	$('#COG-Buildup-row').hide();
	$('#COG-Total-row').hide();
	$('#overallmodulecarddeck').hide();
	$('#changes-tab').hide();
	scrollProjectAttributesTop(this);
	CashOutGoProject(ProjectCode);
}

function overalldetails(value){
	
	$("#overalldiv").css("display","block");
	$('#projectgraph').css("display","none");
	$('#projectidchanges').val("A");
	
	charts(value);
	
	$('#COG-Buildup-row').show();
	$('#COG-Total-row').show();
	$('#overallmodulecarddeck').show();
	$('#changes-tab').show();
	CashOutGoProject('0');
}

function LabDetails(value){
	
	$("#labcode").val(value);
	$('#labdetailsform').submit();
	
}


</script>


<script type="text/javascript">
$(function () {
    $("[data-toggle='tooltip']").tooltip({
        animated: 'fade',
       
        html : true,
        boundary: 'window'
    });
});

$(function() {

	  $(".progress").each(function() {

	    var value = $(this).attr('data-value');
	    var left = $(this).find('.progress-left .progress-bar');
	    var right = $(this).find('.progress-right .progress-bar');

	    if (value > 0) {
	      if (value <= 50) {
	        right.css('transform', 'rotate(' + percentageToDegrees(value) + 'deg)')
	      } else {
	        right.css('transform', 'rotate(180deg)')
	        left.css('transform', 'rotate(' + percentageToDegrees(value - 50) + 'deg)')
	      }
	    }

	  })

	  function percentageToDegrees(percentage) {

	    return percentage / 100 * 360

	  }

	});




function ChangesForm(value){
	
	$('#intervalchanges').val(value);
	$('#changesform').submit();
}


function overallmeetingredirect(projectid,committeeid,projectstatus){
	
	$('#projectstatus').val(projectstatus);
	$('#committeeid').val(committeeid);
	$('#projectidauto').val(projectid);
	$('#committeeform').submit();
}

function overallcommonredirect(form,projectid){
		
	if(form=='mil'){
		$('#projectIdMil').val(projectid);
		$('#milestoneform').submit();	
	}
	
	if(form=='action'){
		$('#projectIdAction').val(projectid);
		$('#actionredirectform').submit();
	}
	
	if(form=='risk'){
		$('#projectIdRisk').val(projectid);
		$('#projectriskform').submit();
	}
	
}

function overallfinance(){
	
	$('#ibasform').submit();
	
}

function overalldoc(){
	$('#docrepoform').submit();
}

 $(document).ready(function(){

	var logintype = '<%=(String)request.getAttribute("logintype")%>'
	 
	 var DG= '<%=IsDG%>';
	 
	 	if(DG=='Yes'){
	 		if(logintype =='A' || logintype=='Z' || logintype=='X' || logintype=='K' || logintype=='C' || logintype=='I'  ){
	 			$('.btn5').click();
	 		}else{
	 			$('.btn1').click();
	 		}
	 		
	 	}
	 	else if(logintype == 'A' || logintype == 'Z' || logintype == 'E' || logintype=='C' || logintype=='I'|| logintype=='G' || logintype=='F'){	
				$('.btn3').click();
		} else{
			$('.btn1').click();
		}
		
	 
 })
 
 </script>



<script type="text/javascript">


$('.progress-bar[data-toggle="tooltip"]').tooltip({
    animated: 'fade',
    placement: 'bottom',
    html : true,
    boundary: 'window'
});

$('.btn-toggle').click(function() {
	
    $(this).find('.btn').toggleClass('active');  
    
    if ($(this).find('.btn-success').length>0) {
    	
    	$(this).find('.btn').toggleClass('btn-success');
    }
    
    $(this).find('.btn').toggleClass('btn-default');
    
    
});

$('.btn4').hide(); 

 $('.btn1').click(function(){
	$('.btn4').hide();
	$('.btn1').css('background-color','green');
	$('.btn1').css('color','white');
	$('.btn2').css('background-color','white');
	$('.btn2').css('color','black');
	$('.btn3').css('background-color','white');
	$('.btn3').css('color','black');
	$('.btn5').css('background-color','white');
	$('.btn5').css('color','black');
	
	$("#projectname").css("display","none");
	$("#projectdropdown").css("display","none");
	$("#financialdata").css("display","none");
	$("#financialdataerror").css("display","none");
	$("#ganttchart").css("display","none");
	$("#activitystatusheader").css("display","none");
	$("#activitystatus").css("display","none");
	$("#meetingblock").css("display","none");
	$("#projectdetails1").css("display","none");
	$("#projectdetails2").css("display","none");
	$("#overalltable").css("display","none");
	$("#force-btn").css("display","none");
	$("#overallcard1").css("display","none");
	$("#overallcard2").css("display","none");
	$("#overallcard3").css("display","none");
	$("#overallcard4").css("display","none");
	$("#overallcard5").css("display","none");
	$(".overallheader").css("display","none");
	$('#projectgraph').css("display","none");
	
	$("#todayschedules").css("display","block");
	$("#quicklinks").css("display","block");
	$("#approvalblock").css("display","block");
	$("#mytasks").css("display","block");
	$("#upcomingschedules").css("display","block");
	$("#mytaskdetails").css("display","block");
	$("#noticeboard").css("display","block");
	$("#review").css("display","block");
	$("#reviewheader").css("display","block");
	$("#review2").css("display","block");
	$("#reviewheader2").css("display","block");
	$("#mainactivitystatus").css("display","block");
	
	$('#dgdashboard').css("display","none");

}) 

$('.btn2').click(function(){
	$('.btn4').hide();
	$('.btn2').css('background-color','green');
	$('.btn2').css('color','white');
	$('.btn1').css('background-color','white');
	$('.btn1').css('color','black');
	$('.btn3').css('background-color','white');
	$('.btn3').css('color','black');
	$('.btn5').css('background-color','white');
	$('.btn5').css('color','black');
	
	$("#projectname").css("display","block");
	$("#projectdropdown").css("display","block");
	$("#financialdata").css("display","block");
	$("#financialdataerror").css("display","block");
	$("#ganttchart").css("display","block");
	$("#activitystatusheader").css("display","block");
	$("#activitystatus").css("display","block");
	$("#meetingblock").css("display","block");
	$("#projectdetails1").css("display","block");
	$("#projectdetails2").css("display","block");
	$('#mainactivitystatus').css("display","block");	

	$("#todayschedules").css("display","none");
	$("#quicklinks").css("display","none");
	$("#approvalblock").css("display","none");
	$("#mytasks").css("display","none");
	$("#upcomingschedules").css("display","none");
	$("#mytaskdetails").css("display","none");
	$("#noticeboard").css("display","none");
	$("#review").css("display","none");
	$("#reviewheader").css("display","none");
	$("#review2").css("display","none");
	$("#reviewheader2").css("display","none");
	$("#overalltable").css("display","none");
	$("#force-btn").css("display","none");
	$("#overallcard1").css("display","none");
	$("#overallcard2").css("display","none");
	$("#overallcard3").css("display","none");
	$("#overallcard4").css("display","none");
	$("#overallcard5").css("display","none");
	$(".overallheader").css("display","none");
	$('#projectgraph').css("display","none");
	
	$('#dgdashboard').css("display","none");
})

$('.btn3').click(function(){
	$('.btn4').show();
	$('.btn4').css('background-color','white');
	$('.btn4').css('color','black');
	$('.btn3').css('background-color','green');
	$('.btn3').css('color','white');
	$('.btn1').css('background-color','white');
	$('.btn1').css('color','black');
	$('.btn2').css('background-color','white');
	$('.btn2').css('color','black');
	
	overalldetails('A');

	
	$("#overalltable").css("display","block");
	$("#force-btn").css("display","block");
	$("#overallcard1").css("display","block");
	$("#overallcard2").css("display","block");
	$("#overallcard3").css("display","block");
	$("#overallcard4").css("display","block");
	$("#overallcard5").css("display","block");
	$(".overallheader").css("display","block");

	$("#todayschedules").css("display","none");
	$("#quicklinks").css("display","none");
	$("#approvalblock").css("display","none");
	$("#mytasks").css("display","none");
	$("#upcomingschedules").css("display","none");
	$("#mytaskdetails").css("display","none");
	$("#noticeboard").css("display","none");
	$("#review").css("display","none");
	$("#reviewheader").css("display","none");
	$("#review2").css("display","none");
	$("#reviewheader2").css("display","none");
	$("#projectname").css("display","none");
	$("#projectdropdown").css("display","none");
	$("#financialdata").css("display","none");
	$("#financialdataerror").css("display","none");
	$("#ganttchart").css("display","none");
	$("#activitystatusheader").css("display","none");
	$("#activitystatus").css("display","none");
	$("#meetingblock").css("display","none");
	$("#projectdetails1").css("display","none");
	$("#projectdetails2").css("display","none");
	$('#mainactivitystatus').css("display","none");	
	$('#projectgraph').css("display","none");
	
	<%-- document.getElementById('projecttitle').innerHTML = 'PROJECT HEALTH (' + <%=ProjectCount%> + ')'; --%>	
	$('#dgdashboard').css("display","none");
	
})

$('.btn5').click(function(){
	
	$('.btn4').show();
	$('.btn5').css('background-color','green');
	$('.btn5').css('color','white');
	$('.btn1').css('background-color','white');
	$('.btn1').css('color','black');
	$('.btn2').css('background-color','white');
	$('.btn2').css('color','black');
	
	$('#dgdashboard').css("display","block");

	$("#todayschedules").css("display","none");
	$("#quicklinks").css("display","none");
	$("#approvalblock").css("display","none");
	$("#mytasks").css("display","none");
	$("#upcomingschedules").css("display","none");
	$("#mytaskdetails").css("display","none");
	$("#noticeboard").css("display","none");
	$("#review").css("display","none");
	$("#reviewheader").css("display","none");
	$("#review2").css("display","none");
	$("#reviewheader2").css("display","none");
	$("#projectname").css("display","none");
	$("#projectdropdown").css("display","none");
	$("#financialdata").css("display","none");
	$("#financialdataerror").css("display","none");
	$("#ganttchart").css("display","none");
	$("#activitystatusheader").css("display","none");
	$("#activitystatus").css("display","none");
	$("#meetingblock").css("display","none");
	$("#projectdetails1").css("display","none");
	$("#projectdetails2").css("display","none");
	$('#mainactivitystatus').css("display","none");	
	$('#projectgraph').css("display","none");
	$("#overalltable").css("display","none");
	$("#force-btn").css("display","none");
	$("#overallcard1").css("display","none");
	$("#overallcard2").css("display","none");
	$("#overallcard3").css("display","none");
	$("#overallcard4").css("display","none");
	$("#overallcard5").css("display","none");
	$(".overallheader").css("display","block");
	$('#projectgraph').css("display","none");
	
	
	var logintype = '<%=(String)request.getAttribute("logintype")%>';
	if(logintype=='K')
		document.getElementById('projecttitle').innerHTML = 'DRDO HEALTH' ;
	else
		document.getElementById('projecttitle').innerHTML = 'CLUSTER HEALTH' ;
})



$(document).ready(function(){

	if(<%=count%>>0 ){
		$(".badge-today").text(<%=count%>);
		
		$(".badge-today").addClass('badge-danger');
	}
	
	/* $(".badge-today").addClass('badge-success'); */
	
	var height = $(window).height();
	$('#overalldiv').css('max-height', (height-280)+'px' );
	
})

function actionformtask(term,type){
	
	$('#term').val(term);
	$('#type').val(type);
	 
	$('#mytaskactionform').submit();
	
}

	function actionform(mainid){
				
		$('#Action'+mainid).submit();
		
	}
	function MyTaskDetails(mainid){
		
		$('#MyTaskDetails'+mainid).submit();
	}

	$('#actionsubmit').on('click',function(){
		
		$('#actionform').submit();
		
	})

     $(".action").each(function() {
        var i = $(this).next();
        i.length || (i = $(this).siblings(":first")),
          i.children(":first-child").clone().appendTo($(this));
        
        for (var n = 0; n < 1; n++)(i = i.next()).length ||
          (i = $(this).siblings(":first")),
          i.children(":first-child").clone().appendTo($(this))
    }) 



function dropdown(){


	var val=$('#projectid').val();

	$('.carousel').carousel('pause'); 
	$('.carousel-item').removeClass('active');
	
	$('#Mil'+val).addClass('active');
	$('#Meeting'+val).addClass('active');
	$('#chart'+val).addClass('active');
	$('#act'+val).addClass('active');
	$('#projectname'+val).addClass('active');
	$('#schedule').addClass('active');
	$('#notice').addClass('active');
	$('#actions').addClass('active');
	$('.vert').carousel('cycle'); 
	$('#projectinfo'+val).addClass('active');
	$('#projectdetailsname'+val).addClass('active'); 

	
}

		
	$('.carousel-interval').on('slide.bs.carousel', function(ev) {
	    // get the direction, based on the event which occurs
	    var dir = ev.direction == 'right' ? 'prev' : 'next';
	    // get synchronized non-sliding carousels, and make'em sliding
	    $('.carousel-interval').not('.sliding').addClass('sliding').carousel(dir);
	});
	$('.carousel-interval').on('slid.bs.carousel', function(ev) {
	    // remove .sliding class, to allow the next move
	    $('.carousel-interval').removeClass('sliding');
	});
	
	
	$(document).ready(function(){
	     $(".carousel-interval").carousel({
	         interval : <%=interval%>,
	         pause: false
	     });
	     
	     
	     
	});
	

</script>




<script>

$(document).ready(function () {
	  $('#carouselExampleControls').find('.carousel-item').first().addClass('active');
	});


$(document).ready(function () {
	  $('#carouselExampleControls1').find('.carousel-item').first().addClass('active');
	});
	
$(document).ready(function () {
	  $('#carouselExampleControls2').find('.carousel-item').first().addClass('active');
	});

$(document).ready(function () {
	  $('#carouselExampleControls3').find('.carousel-item').first().addClass('active');
	});
	
$(document).ready(function () {
	  $('#carouselExampleControls5').find('.carousel-item').first().addClass('active');
	});
	
$(document).ready(function () {
	  $('#carouselExampleControls6').find('.carousel-item').first().addClass('active');
	});
	
$(document).ready(function () {
	  $('#carouselExampleControls7').find('.carousel-item').first().addClass('active');
	});
	
$(document).ready(function () {
	  $('#carouselExampleControls8').find('.carousel-item').first().addClass('active');
	});
	
	
$(document).ready(function () {
	  $('#carouselExampleSlidesOnly').find('.carousel-item').first().addClass('active');
	});


$(document).ready(function () {
	  $('#carouselprojectdetailsSlidesOnly').find('.carousel-item').first().addClass('active');
	});
	
$(document).ready(function () {
	  $('#carouselprojectdetailsSlides2Only').find('.carousel-item').first().addClass('active');
	});


function submitForm(type,id)
{ 

   $("#TypeId").val(type);
   $("#Id").val(id);
   
   document.getElementById('dateform').submit(); 
} 

function CommitteeForm(id,comid,status)
{ 
	
	if(id==0){
		
		document.getElementById('committeegeneralform').submit();
		
	}
	else{
	$("#projectidauto").val(id);
	$("#committeeid").val(comid);
	$("#projectstatus").val(status);
	document.getElementById('committeeform').submit(); 
	}
} 


	function addNoticeForm() {
		var message = $('textarea#noticeText').val();
	
		if ((message.length)>0){
			if (confirm('Are You Sure to Add this Notice')) {
				document.getElementById("noticeForm").submit();
			}
		}else{
			alert("Notice Field cannot be empty!");
		}
	}

	/* window.setTimeout(function(){
	
	 $(".animate").fadeTo(500,0).slideUp(500,function(){
	 $(this).remove();
	 })
	 },3000) */

	/* window.setTimeout(function(){
	 document.getElementById("title").style.display = "block";
	 document.getElementById("schedules").style.display = "block";
	 },4000) */
	 
</script>	
	<script type="text/javascript">

var fromDate=null;
$("#fdate").change(function(){
	
	 fromDate = $("#fdate").val();


$('#tdate').daterangepicker({

	"singleDatePicker": true,
	"showDropdowns": true,
	"cancelClass": "btn-default",
	"minDate":fromDate,
	
	locale: {
    	format: 'DD-MM-YYYY'
		}
		
});
});
$('#fdate').daterangepicker({
	
	"singleDatePicker": true,
	"showDropdowns": true,
	"cancelClass": "btn-default",
	"minDate":new Date(),
	locale: {
    	format: 'DD-MM-YYYY'
		}
});


</script>
<script>
//document.getElementById("brandname").style.marginLeft = "-20%";
var projectId=$("#projectIdD").val();
var Overall="<%=(String)request.getParameter("Overall")%>"
var DG="<%=IsDG%>";

if(Overall=='Overall'){
	if( DG == 'Yes'){
		$('.btn5').click();
	}else{
		$('.btn3').click();
	}
}



</script>





<script>

function charts(value){
	
$projectid=value;
	
	$.ajax({
		
			type:"GET",
			url:"IndividualProjectDetails.htm",
			data : {
				
				ProjectId : $projectid
				
			},
			datatype : 'json',
			success : function(result) {

				var result = JSON.parse(result);
				var values = Object.values(result).map(function(key, value) {
					  return result[key,value]
					});

				/* logic to print the project wise data in card */	
				
				/*var s=  values[0] + '/' + values[2]
				document.getElementById('meetingsvaluepmrc').innerHTML = s;*/
				
				/*var t=  values[3] + '/' + values[5]
				document.getElementById('meetingsvalueeb').innerHTML = t;
				
				document.getElementById('pmrcprogress').innerHTML = values[30]+'%' ; */
				
				/* document.getElementById('financevalue').innerHTML = values[23].toLocaleString('en-IN');
				document.getElementById('risksvalue').innerHTML = values[16] + ' / ' + values[18];
				document.getElementById('actionvalue').innerHTML = values[14] + ' / ' + values[15];
				document.getElementById('milestonevalue').innerHTML = values[8] + ' / ' + values[9]; */
				
				<%-- if(values[10]!=null)
				document.getElementById('milestonepercentage').innerHTML = values[10] + '%';
				else
				document.getElementById('milestonepercentage').innerHTML = 'Nil'; 

				if(values[24]!='A')
				document.getElementById('projecttitle').innerHTML = 'Project : ' + values[25];
				else
				document.getElementById('projecttitle').innerHTML = 'PROJECT HEALTH (' + <%=ProjectCount%> + ')';	 --%>
				
				
				
				<!-- ******************************************* Project Details Graph Script ******************************************************* -->
				
				Highcharts.chart('containerh', {
				    chart: {
				        type: 'bar',
				        height: (16 / 16 * 100) + '%' 
				    },
				    exporting: {
				        buttons: {
				          contextButton: {
				            menuItems: [
				              'printChart',
				              'downloadPNG',
				              'downloadJPEG',
				              'downloadPDF',
				              'downloadCSV',
				              'downloadXLS',
				              'viewData'
				            ]
				          }
				        }

				      },
				    title: {
				        text: 'Meeting Data',
				       	style : {
						        	fontWeight: 'bold'
						}
				    },
				    subtitle: {
				        text: ''
				    },
				    xAxis: {
				        categories: ['PMRC', 'EB'],
				        title: {
				            text: null
				        },
				        labels: {
				            overflow: 'justify',
				            style : {
				            	fontWeight: 'bold',
					        	
							}
				        }
				    },
				    yAxis: {
				        min: 0,
				        title: {
				            text: 'Meeting (count)',
				            align: 'high'
				        },
				        labels: {
				            overflow: 'justify',
				            style : {
				            	fontWeight: 'bold',
					        	
							}
				        }
				    },
				    tooltip: {
				        valueSuffix: ''
				    },
				    plotOptions: {
				        bar: {
				            dataLabels: {
				                enabled: true
				            }
				        }
				    },
				    colors: [
				    	'#28a745',
				        '#dc3545',
				        
				    ],
				    credits: {
				        enabled: false
				    },
				    series: meetingdata(),
				 
				    
				});		

				function meetingdata(){
					
					let meetingdata=[];
					if(parseInt(values[2])>0 || parseInt(values[5])>0){
						meetingdata=[
							{
						        name: 'Held',
						        data: [parseInt(values[0]), parseInt(values[3]),]
						    }, {
						        name: 'Pending',
						        data: [parseInt(values[1]), parseInt(values[4]),]
						    },
							
						]
					}
					return meetingdata;
					
				}
				
				/********************************************** Milestone ****************************************************/

			 Highcharts.chart('containerh2', {
					 chart: {
					        type: 'variablepie',
					        height: (16 / 16 * 100) + '%' 
					    },
				    exporting: {
				        buttons: {
				          contextButton: {
				            menuItems: [
				              'printChart',
				              'downloadPNG',
				              'downloadJPEG',
				              'downloadPDF',
				              'downloadCSV',
				              'downloadXLS',
				              'viewData'
				            ]
				          }
				        }

				      },
				    title: {
				        text: 'Milestone',
				        style : {
				        	fontWeight: 'bold'
				        }
				    },
				    subtitle: {
				        text: ''
				    },
				  
				    colors: [
				    	'#28a745',
				    	'#dc3545',
				    	'#ffc107'
				    ],
				    tooltip: {
				        headerFormat: '',
				        pointFormat: '<span style="color:{point.color}">\u25CF</span> <b> {point.name}</b><br/>' 
				        
				    },
				 series: [{
				        minPointSize: 10,
				        innerSize: '20%',
				        zMin: 0,
				        
				      data: [{
				            name: 'Completed('+(parseInt(values[8]))+')',
				            y: parseInt(values[8]),
				            z: 118.7
				        }, {
				            name: 'Delayed('+(parseInt(values[7]))+')',
				            y: parseInt(values[7]),
				            z: 124.6
				        }, {
				            name: 'Pending('+(parseInt(values[6]))+')',
				            y: parseInt(values[6]),
				            z: 137.5
				        }, ]   
				    }],
				    credits: {
				        enabled: false
				    },
				});
				 
			/*  function miletsonedata(){
					let miletsonedata=[];
					
					if(parseInt(values[9])>0){
						miletsonedata=[ 
							['Pending', parseInt(values[6])],
				            ['Delayed', parseInt(values[7])],
				            ['Completed', parseInt(values[8])],
				            ]
					}
					
					return miletsonedata; 
			 }  */
				

				/********************************************** Action ****************************************************/

			/* 	Highcharts.chart('containerh3', {
				    chart: {
				        type: 'pie',
				        options3d: {
				            enabled: true,
				            alpha: 45
				        },
				        height: (12 / 16 * 100) + '%' 
				    },
				    exporting: {
				        buttons: {
				          contextButton: {
				            menuItems: [
				              'printChart',
				              'downloadPNG',
				              'downloadJPEG',
				              'downloadPDF',
				              'downloadCSV',
				              'downloadXLS',
				              'viewData'
				            ]
				          }
				        }

				      },
				    title: {
				        text: 'Action',
				        style : {
				        	fontWeight: 'bold'
				        }
				    },
				    subtitle: {
				        text: ''
				    },
				    plotOptions: {
				        pie: {
				            innerSize: 100,
				            depth: 45
				        }
				    },
				    colors: [
				        '#ffc107',
				        '#dc3545',
				        '#28a745',
				        '#007bff'
				    ],
				    series: [{
				        name: 'Action',
				        data: actiondata(),
				    }],
				    credits: {
				        enabled: false
				    },
				});
				
				function actiondata(){
					let actiondata=[];
					
					if(parseInt(values[15])>0){
						actiondata=[
							 	['Pending', parseInt(values[11])],
					            ['Delayed', parseInt(values[13])],
					            ['Completed', parseInt(values[14])],
					            ['Forwarded', parseInt(values[12])],
							
						]
					}
					
					return actiondata;
				} */
				
			 	 Highcharts.chart('containerh3', {
					 chart: {
					        type: 'variablepie',
					        height: (16 / 16 * 100) + '%' 
					    },
				    exporting: {
				        buttons: {
				          contextButton: {
				            menuItems: [
				              'printChart',
				              'downloadPNG',
				              'downloadJPEG',
				              'downloadPDF',
				              'downloadCSV',
				              'downloadXLS',
				              'viewData'
				            ]
				          }
				        }

				      },
				    title: {
				        text: 'Action',
				        style : {
				        	fontWeight: 'bold'
				        }
				    },
				    subtitle: {
				        text: ''
				    },
				  
				    colors: [
				    	'#ffc107',
				        '#dc3545',
				        '#28a745',
				        '#007bff'
				    ],
				    tooltip: {
				        headerFormat: '',
				        pointFormat: '<span style="color:{point.color}">\u25CF</span> <b> {point.name}</b><br/>' 
				        
				    },
				 series: [{
				        minPointSize: 10,
				        innerSize: '20%',
				        zMin: 0,
				        
				      data: [{
				            name: 'Pending('+parseInt(values[11])+')',
				            y: parseInt(values[11]),
				            z: 137.5
				        },
				        {
				            name: 'Delayed('+parseInt(values[13])+')',
				            y: parseInt(values[13]),
				            z: 124.6
				        },
				    	  {
				            name: 'Completed('+parseInt(values[14])+')',
				            y: parseInt(values[14]),
				            z: 118.7
				        }, {
				            name: 'Forwarded('+parseInt(values[12])+')',
				            y: parseInt(values[12]),
				            z: 124.6
				        },  ]   
				    }],
				    credits: {
				        enabled: false
				    },
				}); 
				/*************************************************************** Risk *****************************************************  */

				Highcharts.chart('containerh4', {
				    chart: {
				        type: 'column',
				        height: (16 / 16 * 100) + '%' 
				    },
				    exporting: {
				        buttons: {
				          contextButton: {
				            menuItems: [
				              'printChart',
				              'downloadPNG',
				              'downloadJPEG',
				              'downloadPDF',
				              'downloadCSV',
				              'downloadXLS',
				              'viewData'
				            ]
				          }
				        }

				      },
				    title: {
				        text: 'Risks',
				        style : {
				        	fontWeight: 'bold'
				        }
				    },
				    subtitle: {
				        text: ''
				    },
				    xAxis: {
				        categories: [
				            'Risk',
				        ],
				        crosshair: true
				    },
				    yAxis: {
				        min: 0,
				        title: {
				            text: 'Count'
				        }
				    },
				    tooltip: {
				        headerFormat: '<span style="font-size:10px">{point.key}</span><table>',
				        pointFormat: '<tr><td style="color:{series.color};padding:0">{series.name}: </td>' +
				            '<td style="padding:0"><b>{point.y:.1f} </b></td></tr>',
				        footerFormat: '</table>',
				        shared: true,
				        useHTML: true
				    },
				    plotOptions: {
				        column: {
				            pointPadding: 0.2,
				            borderWidth: 0
				        }
				    },
				    colors: [
				    	'#28a745',
				        '#dc3545',
				        
				    ],
				    series: riskdata(),
				    credits: {
				        enabled: false
				    },
				});
				
				function riskdata(){
					let riskdata=[];
					if(parseInt(values[18])>0){
						riskdata=[
							{
						        name: 'Completed',
						        data: [parseInt(values[16])]

						    },
							{
						        name: 'Pending',
						        data: [parseInt(values[17])]

						    }, 
						]
						
						
					}
					return riskdata;
					
				}


				/**************************************** Finance ******************************************* */
				
				$(function () {
				
				var TotalFinanceValue =0;
				if(parseInt(values[23])>0){
					 TotalFinanceValue = 'Total Finance Value : ' + parseInt(values[23]).toLocaleString('en-IN', {
					    maximumFractionDigits: 0,
					    style: 'currency',
					    currency: 'INR'
					});	
				}
				
					
				 Highcharts.setOptions({
			      lang: {
			        thousandsSep: ','
			      }
				});
				
				Highcharts.chart('containerh5', {
				    chart: {
				        type: 'pie',
				        height: (16 / 16 * 100) + '%' 
				    },
				    exporting: {
				        buttons: {
				          contextButton: {
				            menuItems: [
				              'printChart',
				              'downloadPNG',
				              'downloadJPEG',
				              'downloadPDF',
				              'downloadCSV',
				              'downloadXLS',
				              'viewData'
				            ]
				          }
				        }

				      },
				    title: {
				        text: 'Finance',
				        style : {
				        	fontWeight: 'bold'
				        }
				    },
				    subtitle: {
				        text: TotalFinanceValue ,
				        style : {
				        	fontWeight: 'bold'
				        }
				    },

				    accessibility: {
				        announceNewData: {
				            enabled: true
				        },
				        point: {
				            valueSuffix: ''
				        }
				    },

				    plotOptions: {
				        series: {
				            dataLabels: {
				                enabled: true,
				                 formatter: function() {
				                    return '<p>&#8377;</p>'+ Highcharts.numberFormat(this.y, 0);
				                } 
				                /* format: '{point.name}: {point.y:.1f}' */
				            }
				        }
				    },
				    
				    
				    
				    colors: [
				        '#ffc107',
				        '#28a745',
				        '#dc3545',
				        '#007bff'
				    ],
				    tooltip: {
				        headerFormat: '<span style="font-size:11px">{series.name}</span><br>',
				        pointFormat: '<span style="color:{point.color}">{point.name}</span>: <b>&#8377; {point.y:.2f}</b><br/>'
				    },
				    
				    series: [
				    	{
				            name: "Finance",
				            colorByPoint: true,
				           
				            data:   generatedata(),
		
				        } 
				       
				    ],
				    
				    credits: {
				        enabled: false
				    },

				},

		);
				
				});
			  
		function  generatedata(){
			
			let financedata=[];
			
			if(parseInt(values[23])>0){
				
				financedata = [
					
					{
	                    name: "O/S",
	                    y: parseInt(values[20]),
	                    drilldown: "O/S"
	                },
	                {
	                    name: "Expenditure",
	                    y: parseInt(values[19]),
	                    drilldown: "Expenditure"
	                },
	                {
	                    name: "Balance",
	                    y: parseInt(values[22]),
	                    drilldown: "Balance"
	                },
	                {
	                    name: "DIPL",
	                    y: parseInt(values[21]),
	                    drilldown: "DIPL"
	                }, 
					
				]
				
			}
			
			return financedata;
		}			
				
		
		/**************************************** Document  ******************************************* */
		

			Highcharts.chart('containerh6', {
			    chart: {
			        type: 'variablepie',
			        height: (16 / 16 * 100) + '%' 
			    },
			    title: {
			        text: 'Document Statistics',
			        style : {
			        	fontWeight: 'bold'
			        }
			    },
			    colors: [
			        '#ffc107',
			        '#28a745',
			        '#dc3545',
			        '#007bff'
			    ],
			    tooltip: {
			        headerFormat: '',
			        pointFormat: '<span style="color:{point.color}">\u25CF</span> <b> {point.name}</b><br/>' 
			        	/* +
			            'Area (square km): <b>{point.y}</b><br/>' +
			            'Population density (people per square km): <b>{point.z}</b><br/>' */
			    },
			    series: [{
			        minPointSize: 10,
			        innerSize: '20%',
			        zMin: 0,
			        name: 'countries',
			        data: [{
			            name: 'Prepared',
			            y: 505370,
			            z: 92.9
			        }, {
			            name: 'Approved',
			            y: 551500,
			            z: 118.7
			        }, {
			            name: 'Pending',
			            y: 312685,
			            z: 124.6
			        }, {
			            name: 'Reviewed',
			            y: 78867,
			            z: 137.5
			        }, ]
			    }],
			    
			    credits: {
			        enabled: false
			    },
			    
			    
			    
			});


		}
		
		})
		
				
				
		$.ajax({
		
			type:"GET",
			url:"ChangesDataTotalCount.htm",
			data :{
				
				ProjectId : $projectid
				
			},
			datatype : 'json',
			success : function(result){
				
				var result = JSON.parse(result);
				var values = Object.values(result).map(function(key,value){
					
					return result[key,value]
				})
			/* 	
				document.getElementById('todaychangescount').innerHTML = values[0] + values[3] + values[6] + values[9] ;
				document.getElementById('weeklychangescount').innerHTML = values[1] + values[4] + values[7] + values[10] ;
				document.getElementById('monthlychangescount').innerHTML = values[2] + values[5] + values[8] + values[11] ; */
			}

		})


}

function checkslideinput()	
{
	var checkboxes = document.getElementsByName("projectlist");
	var checked = false;
	for(let i=0;i<checkboxes.length;i++)
		{
			if(checkboxes[i].checked)checked = true;
		}
	if(!checked)alert("Please select a project for Slideshow");
	return checked;
}

</script>


 <script type="text/javascript">
$( document ).ready(function() {

	var val=$('#projectid').val();

	$('.carousel').carousel('pause'); 
	$('.carousel-item').removeClass('active');
	
	$('#Mil'+val).addClass('active');
	$('#Meeting'+val).addClass('active');
	$('#chart'+val).addClass('active');
	$('#act'+val).addClass('active');
	$('#projectname'+val).addClass('active');
	$('#schedule').addClass('active');
	$('#notice').addClass('active');
	$('#actions').addClass('active');
	$('.vert').carousel('cycle'); 
	$('#projectinfo'+val).addClass('active');
	$('#projectdetailsname'+val).addClass('active'); 
});
function openModalDetails(a,b){
	var jsObjectList
	console.log(b + "--"+ typeof b)
	if(a==="M" && b>0){
		jsObjectList = JSON.parse('<%= jsonArray %>');
	}
	console.log(jsObjectList)
	const dateFromTimestamp = new Date(1703097000000);
	console.log(dateFromTimestamp.getTime()+"-----")
		console.log(new Date().getTime()+"--ghj---")

	var html="";
	for(var i=0;i<jsObjectList.length;i++){
		html=html+'<p style="font-weight: 600;">'+"Project:"+jsObjectList[i][8]+"; Meeting:"+jsObjectList[i][7]+"; Time:"+jsObjectList[i][4]+';</p>'
	}
	document.getElementById('modalcontents').innerHTML=html;
	if(jsObjectList.length>0){
		$('#ModalDetails').show();
		   $( document ).ready(function() {
	    	   setTimeout(() => { 
	    		   closeModals()
			}, 3000);
	    	});
	}
}
function closeModals(){
	$('#ModalDetails').hide();
}

// Functions to open and close the modal
function openModal() {
/*   document.getElementById('myModal').style.display = 'block';
  document.getElementById('modalbtn').style.display = 'none'; */
	$('#myModal').show();
 	$('#modalbtn').hide();
    setTimeout(() => { 
		   closeModal()
	}, 5000);
    $('#brifingBtn').hide();
}

function closeModal() {
/*   document.getElementById('myModal').style.display = 'none';
 */  $('#myModal').hide();
 	$('#modalbtn').show();
 /*  document.getElementById('modalbtn').style.display = 'block'; */
 	 $('#brifingBtn').show();
}

// Close the modal if the user clicks outside of it
window.onclick = function(event) {
  var modal = document.getElementById('myModal');
  if (event.target === modal) {
    modal.style.display = 'none';
  }
}

//clicked the modal 
    document.addEventListener('DOMContentLoaded', function() {
    	openModal();
      });
      
    $( document ).ready(function() {
    	   setTimeout(() => { 
    		   closeModal()
		}, 4500);
    	});
</script> 

<script type="text/javascript">
$("#selectall").click(function(){
	var selectall =  $('#selectall').val();
	if(selectall=="on"){
		 $('.projectlist').prop('checked', this.checked);
	}else{
		 $('.projectlist').prop('checked', this.unchecked);
	}
	
});
</script>

</body>



</html> 