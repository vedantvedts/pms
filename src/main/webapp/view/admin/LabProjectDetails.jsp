
<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1" import="java.util.*,com.vts.*,java.text.SimpleDateFormat,java.text.ParseException,java.math.BigInteger"%>
<%@page import="com.vts.pfms.IndianRupeeFormat" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
 
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Lab Details</title>

<jsp:include page="../static/header.jsp"></jsp:include>

<spring:url value="/resources/css/newfont.css" var="NewFontCss" />
<link href="${NewFontCss}" rel="stylesheet" /> 

<spring:url value="/resources/css/master.css" var="masterCss" />
<link href="${masterCss}" rel="stylesheet" />

<spring:url value="/resources/css/masterdashboard.css" var="masterdashboardCss" />
<link href="${masterdashboardCss}" rel="stylesheet" />

<style type="text/css">

.header-top{
	display: none;
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

#fixed-table tbody .custom-td{
	padding-left : 0.5rem !important;
}

.tableFixHead          { overflow: auto;  }
.tableFixHead thead td { position: sticky; top: 0; z-index: 1; }
.tableFixHead thead td {background-color: #1363DF}


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

.small-list{
	margin: 0px !important;
	font-size: 11px;
	text-align: left;
	padding: 0px !important;
}

.small-list li{
	display: inline-block;
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

.small-list span, .countstable span,.normalfont span{
	font-size: 12px;
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

.small-list{
	font-size: 14px;
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
	padding-left : 1.5rem !important;
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

	
	.card-header h3,a{
		display: inline;
	}


	.custom-td .col-md-10{
		padding-right: 5px !important;
	}


	
</style>
</head>

<body>
<%
IndianRupeeFormat nfc=new IndianRupeeFormat();
List<Object[]> ProjectHealthData = (List<Object[]>)request.getAttribute("projecthealthdata");
Object[] ProjectHealthTotalData = (Object[])request.getAttribute("projecthealthtotal"); 
int ProjectCount = 0;
String logintype=(String)request.getAttribute("logintype"); 
List<Object[]> projecthealthtotaldg = (List<Object[]>)request.getAttribute("projecthealthtotaldg");


%>
	
<div class="container-fluid">		
	<div class="row">
		<div class="col-md-12">
		
			<div class="card " style="background: transparent;" >
				<div class="card-header">
						<h3><%=ProjectHealthTotalData[45] %> - <%if(logintype.equalsIgnoreCase("K")){ %> Cluster <%}else{%>Lab <%} %> Details</h3>
						<a class="btn btn-info btn-sm back"   href="MainDashBoard.htm" style="float: right">Back</a>
				</div>
				<div class="card-body"> 
					
							<%if(ProjectHealthData.size()!=0){ %>
					
							<div class="card-deck">
							  <div class="card overall-card normal-dashboard" id="overallcard1" >
								<div class="card-content">
							    	<div class="card-body">
							    	<div class="row">
							    		<div class="col-md-6">
							    			<h6 class="text-left">PMRC </h6>
							    			<h6 class="text-left" id="meetingsvaluepmrc" style="margin-bottom: 2px !important"><%if(ProjectHealthTotalData[0] !=null){%><%=ProjectHealthTotalData[0] %><%}if(ProjectHealthTotalData[2] !=null){%>/<%=ProjectHealthTotalData[2] %><%} %></h6> 
							    		</div>
							    		<div class="col-md-6">
							    			<h6 class="text-left">EB </h6>
			 				    			<h6 class="text-left" id="meetingsvalueeb" style="margin-bottom: 2px !important"><%if(ProjectHealthTotalData[3] !=null){%><%=ProjectHealthTotalData[3] %><%}if(ProjectHealthTotalData[5] !=null){%>/<%=ProjectHealthTotalData[5] %><%} %></h6> 
			 				    		</div>
							    	</div>
							        	
							         </div>
							     </div>
							 </div>	
							 <div class="card overall-card normal-dashboard" id="overallcard2" >
					          <div class="card-content">
						    	<div class="card-body">
						            <div class="row">
						            	<div class="col-md-8"  style="padding-right:0px !important">
						            		<h6 class="text-left">Milestone</h6>
						            		<ul class="small-list">
						            			<li><span class="green">&#x220E;</span>&nbsp;C&nbsp;</li>
							                 	<li><span class="yellow">&#x220E;</span>&nbsp;D&nbsp;</li>
							                 	<li><span class="red">&#x220E;</span>&nbsp;P&nbsp;</li>
						                 	</ul>
						                 	
						            	</div>
						            	<div class="col-md-4"  style="padding-right:0px !important">
						            		<h5 class="text-left" id="milestonevalue" style="margin-bottom: 5px !important"><%if(ProjectHealthTotalData[8] !=null){%><%=ProjectHealthTotalData[8] %><%}if(ProjectHealthTotalData[9] !=null){%>/<%=ProjectHealthTotalData[9] %><%} %></h5>
						            		<h6 id="milestonepercentage" style="margin-bottom: 0px !important"><%if(ProjectHealthTotalData[10] !=null){%><%=ProjectHealthTotalData[10] %><%}%>%</h6>
						            	</div>
						            </div>
						         </div>
					     	  </div>
					      	</div>
					      	<div class="card overall-card normal-dashboard" id="overallcard3" >
						          <div class="card-content">
						            <div class="card-body" >
							            <div class="row">
							            	<div class="col-md-8" style="padding-right:0px !important" >
							            		<h6 class="text-left">Action</h6>
							            		<ul class="small-list">
									                 	<li><span class="green">&#x220E;</span> C&nbsp;</li>
									                 	<li><span class="yellow">&#x220E;</span> D&nbsp;</li>
									                 	<li><span class="blue">&#x220E;</span> F&nbsp;</li>
									                 	<li><span class="red">&#x220E;</span> P&nbsp;</li>
								                 </ul>
							            	</div>
							            	<div class="col-md-4" style="padding-right:2px !important;padding-left:2px !important">
 								            	<h5 class="text-left" id="actionvalue"><%if(ProjectHealthTotalData[14] !=null){%><%=ProjectHealthTotalData[14] %><%}if(ProjectHealthTotalData[15] !=null){%>/<%=ProjectHealthTotalData[15] %><%} %></h5>
 							            </div>
							            </div>
					         		</div>
						          </div>
				        	</div>
				        	<div class="card overall-card normal-dashboard" id="overallcard4" >
						          <div class="card-content">
						            <div class="card-body">
							            <div class="row">
							            	<div class="col-md-8">
							            		<h6 class="text-left">Risks</h6>
							            		 <ul class="small-list">
								            		 <li><span class="green">&#x220E;</span>&nbsp;C&nbsp; </li>
								            		 <li><span class="yellow">&#x220E;</span>&nbsp;D&nbsp; </li>
										             <li><span class="red">&#x220E;</span>&nbsp;P&nbsp; </li>
									                 	
								                 </ul>
							            	</div>
							            	<div class="col-md-4" style="padding-right:0px !important">
 								                <h5 class="text-left" id="risksvalue"><%if(ProjectHealthTotalData[16] !=null){%><%=ProjectHealthTotalData[16] %><%}if(ProjectHealthTotalData[18] !=null){%>/<%=ProjectHealthTotalData[18] %><%} %></h5>
							            	</div>
							            </div>
					         		</div>
						          </div>
				        		</div>
								<div class="card overall-card normal-dashboard" id="overallcard5" >
						          <div class="card-content">
						            <div class="card-body" >
										<div class="row">
									     	<div class="col-md-7" style="padding-right: 0px !important" >
									       		
									       		<form action="ProjectHoaUpdate.htm" method="get">
											       <h6 class="text-left" style="margin-bottom: 3px !important">Finance</h6>
											    </form>
									       		<ul class="small-list">
										           	<li><span class="green">&#x220E;</span> E</li>
										           	<li><span class="yellow">&#x220E;</span> O/S</li>
										           	<li><span class="blue">&#x220E;</span> D</li>
										           	<li><span class="red">&#x220E;</span> B</li>
									           	</ul>
									       	</div>
									       	<div class="col-md-5" style="padding-right: 0px !important">
 									       		<h6 class="text-left" style="font-size: 0.75rem !important" >&#8377; <span id="financevalue"><%if(ProjectHealthTotalData[23]!=null){%><%=nfc.rupeeFormat(String.valueOf(Math.round(Double.parseDouble(ProjectHealthTotalData[23].toString() ))))%><%} %></span> </h6>
 									      	</div>
									     </div>
							         </div>
						          </div>
						        </div>
							
							
							</div>
				
							<br>
				
			            					            		
								<div style="background-color: rgba(255, 255, 255, 0.39999) !important ;border-radius: 4px ;  ">
								
									<table class="table meeting tableFixHead fixed-table "  style="table-layout: fixed;overflow-y:auto;overflow-x:hidden "  id="overalldiv"> 
										<thead style=" background: #1363DF; color: white;">												
											<tr>
												<td style="width:4%">
													<a  data-toggle="modal"  class="fa faa-pulse animated " data-target="#exampleModal1" data-whatever="@mdo" style="padding: 0px 1.5rem;cursor:pointer" ><i class="fa fa-info-circle " style="font-size: 1.3rem;color: " aria-hidden="true"></i> </a>
												</td>
												<td style="width:15%"><span style="font-size :15px;font-weight: bold; ">Project</span></td>
												<td style="padding: 0px !important"><span style="font-size :15px;font-weight: bold;">PMRC </span></td>
												<td style="padding: 0px !important"><span style="font-size :15px;font-weight: bold;">EB </span></td>
												<td ><span style="font-size :15px;font-weight: bold;  ">Milestone </span></td>
												<td ><span style="font-size :15px;font-weight: bold;  ">Action</span></td>
												<td ><span style="font-size :15px;font-weight: bold;  ">Risk</span></td>
												<td ><span style="font-size :15px;font-weight: bold;  ">Finance</span></td>
											</tr>
										</thead>
										
										<tbody>
										
											<%for(Object[] obj : ProjectHealthData){
			
													 
												%>
										
											<tr>
												<td><a href="javascript:ProjectDetails('<%=obj[2]%>')"> <i class="fa fa-hand-o-right" aria-hidden="true" style="color: purple;font-size: 1.3rem !important"></i></a></td>
												<td   style="font-weight: 800; font-size:1rem;text-align:left;
												
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
												<td class="custom-td">
													<%if(Integer.parseInt(obj[8].toString())>0){ %>
														
														<div class="row">
															<div class="col-md-10">
															    <div class="progress"  >
																  <div class="progress-bar progress-bar-striped bg-success" onclick="overallmeetingredirect('<%=obj[2]%>','1', 'B')" style="width:<%=obj[5]%>%;" data-toggle="tooltip" title="PMRC Held : <%=obj[4]%> / <%=obj[8] %>" ></div>
																  <div class="progress-bar progress-bar-striped bg-primary" onclick="overallmeetingredirect('<%=obj[2]%>','1', 'C' )" style="width:<%=obj[7]%>%;" data-toggle="tooltip" title="PMRC Pending : <%=obj[6]%> / <%=obj[8] %>" ></div>
																</div>
														  	</div>
															<div class="col-md-2" style="padding-left: 0px !important">
																<span class="health-circle" style="<%if(Integer.parseInt(obj[7].toString())<=25){%> background-color:green <%}%>
																								   <%if( (Integer.parseInt(obj[7].toString())>25) && (Integer.parseInt(obj[7].toString())<=50)){%> background-color: #F8CB2E;color:black <%}%>
																								   <%if( (Integer.parseInt(obj[7].toString())>50) && (Integer.parseInt(obj[7].toString())<=75)){%> background-color: #EE5007 <%}%>
																								   <%if( (Integer.parseInt(obj[7].toString())>75) && (Integer.parseInt(obj[7].toString())<=100)){%> background-color:red <%}%>
																"><%=obj[7] %></span>
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
													<%if(Integer.parseInt(obj[13].toString())>0){ %>
														<div class="row">
															<div class="col-md-10">
																<div class="progress" >
																  <div class="progress-bar progress-bar-striped bg-success" onclick="overallmeetingredirect('<%=obj[2]%>','2', 'B')" style="width:<%=obj[10]%>%;" data-toggle="tooltip" title="EB Held : <%=obj[9]%> / <%=obj[13] %>" ></div>
																  <div class="progress-bar progress-bar-striped bg-primary" onclick="overallmeetingredirect('<%=obj[2]%>','2', 'C')" style="width:<%=obj[12]%>%;" data-toggle="tooltip" title="EB Pending :  <%=obj[11]%> / <%=obj[13] %>" ></div>
																</div>
															</div>
															<div class="col-md-2" style="padding-left: 0px !important">
																<span class="health-circle" style="<%if(Integer.parseInt(obj[12].toString())<=25){%> background-color:green <%}%>
																								   <%if( (Integer.parseInt(obj[12].toString())>25) && (Integer.parseInt(obj[12].toString())<=50)){%> background-color: #F8CB2E;color:black <%}%>
																								   <%if( (Integer.parseInt(obj[12].toString())>50) && (Integer.parseInt(obj[12].toString())<=75)){%> background-color: #EE5007 <%}%>
																								   <%if( (Integer.parseInt(obj[12].toString())>75) && (Integer.parseInt(obj[12].toString())<=100)){%> background-color:red <%}%>
																"><%=obj[12] %></span>
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
													<%if(Integer.parseInt(obj[20].toString())>0){ %>
													<div class="row">
														<div class="col-md-10">
															<div class="progress" onclick="overallcommonredirect('mil','<%=obj[2]%>')">
															  <div class="progress-bar progress-bar-striped bg-success" style="width:<%=obj[19]%>%" data-toggle="tooltip" title="Completed : <%=obj[18]%> / <%=obj[20] %>" ></div>
															  <div class="progress-bar progress-bar-striped bg-warning" style="width:<%=obj[17]%>%" data-toggle="tooltip" title="Delayed : <%=obj[16]%> / <%=obj[20] %>" ></div>
															  <div class="progress-bar progress-bar-striped bg-danger" style="width:<%=obj[15]%>%" data-toggle="tooltip" title="Pending : <%=obj[14]%> / <%=obj[20] %>" ></div>															  
															</div>
														</div>
														<div class="col-md-2" style="padding-left: 0px !important">
																<span class="health-circle" style="<%if(Integer.parseInt(obj[15].toString())<=25){%> background-color:green <%}%>
																								   <%if( (Integer.parseInt(obj[15].toString())>25) && (Integer.parseInt(obj[15].toString())<=50)){%> background-color: #F8CB2E;color:black <%}%>
																								   <%if( (Integer.parseInt(obj[15].toString())>50) && (Integer.parseInt(obj[15].toString())<=75)){%> background-color: #EE5007 <%}%>
																								   <%if( (Integer.parseInt(obj[15].toString())>75) && (Integer.parseInt(obj[15].toString())<=100)){%> background-color:red <%}%>
																"><%=obj[15] %></span>
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
													<%if(Integer.parseInt(obj[29].toString())>0){ %>
													<div class="row">
														<div class="col-md-10">
															<div class="progress" onclick="overallcommonredirect('action','<%=obj[2]%>')">
															  <div class="progress-bar progress-bar-striped bg-success" style="width:<%=obj[28]%>%" data-toggle="tooltip" title="Completed : <%=obj[27]%> / <%=obj[29]%>" ></div>
															  <div class="progress-bar progress-bar-striped bg-warning" style="width:<%=obj[26]%>%" data-toggle="tooltip" title="Delayed : <%=obj[25]%> / <%=obj[29]%>" ></div>
															  <div class="progress-bar progress-bar-striped bg-primary" style="width:<%=obj[24]%>%" data-toggle="tooltip" title="Forwarded : <%=obj[23]%> / <%=obj[29]%>" ></div>
															  <div class="progress-bar progress-bar-striped bg-danger" style="width:<%=obj[22]%>%" data-toggle="tooltip" title="Pending : <%=obj[21]%> / <%=obj[29]%>" ></div>
															</div>
														</div>
														<div class="col-md-2" style="padding-left: 0px !important">
															<span class="health-circle" style="<%if(Integer.parseInt(obj[22].toString())<=25){%> background-color:green <%}%>
																									   <%if( (Integer.parseInt(obj[22].toString())>25) && (Integer.parseInt(obj[22].toString())<=50)){%> background-color: #F8CB2E;color:black <%}%>
																									   <%if( (Integer.parseInt(obj[22].toString())>50) && (Integer.parseInt(obj[22].toString())<=75)){%> background-color: #EE5007 <%}%>
																									   <%if( (Integer.parseInt(obj[22].toString())>75) && (Integer.parseInt(obj[22].toString())<=100)){%> background-color:red <%}%>
															"><%=obj[22] %></span>
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
													<%if(Integer.parseInt(obj[34].toString())>0){ %>
													<div class="row">
														<div class="col-md-10">
															<div class="progress" onclick="overallcommonredirect('risk','<%=obj[2]%>')">
															  <div class="progress-bar progress-bar-striped bg-success" style="width:<%=obj[31]%>%" data-toggle="tooltip" title="Completed : <%=obj[30]%> / <%=obj[34] %>" ></div>
															  <div class="progress-bar progress-bar-striped bg-danger" style="width:<%=obj[33]%>%" data-toggle="tooltip" title="Pending : <%=obj[32]%> / <%=obj[34] %>" ></div>
															</div>
														</div>
														<div class="col-md-2" style="padding-left: 0px !important">
																<span class="health-circle" style="<%if(Integer.parseInt(obj[33].toString())<=25){%> background-color:green <%}%>
																										   <%if( (Integer.parseInt(obj[33].toString())>25) && (Integer.parseInt(obj[33].toString())<=50)){%> background-color: #F8CB2E;color:black <%}%>
																										   <%if( (Integer.parseInt(obj[33].toString())>50) && (Integer.parseInt(obj[33].toString())<=75)){%> background-color: #EE5007 <%}%>
																										   <%if( (Integer.parseInt(obj[33].toString())>75) && (Integer.parseInt(obj[33].toString())<=100)){%> background-color:red <%}%>
																"><%=obj[33] %></span>
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
													BigInteger number = new BigInteger(obj[43].toString());
													if(number.compareTo(new BigInteger("0")) >0){ %>
													<div class="row">
														<div class="col-md-10">
															<div class="progress" onclick="overallfinance()">
															  <div class="progress-bar progress-bar-striped bg-success" style="width:<%=obj[36]%>%" data-toggle="tooltip" title="Expenditure : &#8377; <%=nfc.rupeeFormat(String.valueOf(Math.round(Double.parseDouble(obj[35].toString() ))))%>" ></div>
															  <div class="progress-bar progress-bar-striped bg-warning" style="width:<%=obj[38]%>%" data-toggle="tooltip" title="OC : &#8377; <%=nfc.rupeeFormat(String.valueOf(Math.round(Double.parseDouble(obj[37].toString() ))))%> " ></div>
															  <div class="progress-bar progress-bar-striped bg-primary" style="width:<%=obj[40]%>%" data-toggle="tooltip" title="DIPL : &#8377; <%=nfc.rupeeFormat(String.valueOf(Math.round(Double.parseDouble(obj[39].toString() ))))%> " ></div>
															  <div class="progress-bar progress-bar-striped bg-danger" style="width:<%=obj[42]%>%" data-toggle="tooltip" title="Balance : &#8377; <%=nfc.rupeeFormat(String.valueOf(Math.round(Double.parseDouble(obj[41].toString() ))))%> " ></div>
															</div>
														</div>
														<div class="col-md-2" style="padding-left: 0px !important">
																	<span class="health-circle" style="<%if(Integer.parseInt(obj[36].toString())<=25){%> background-color:green <%}%>
																											   <%if( (Integer.parseInt(obj[36].toString())>25) && (Integer.parseInt(obj[36].toString())<=50)){%> background-color: #F8CB2E;color:black <%}%>
																											   <%if( (Integer.parseInt(obj[36].toString())>50) && (Integer.parseInt(obj[36].toString())<=75)){%> background-color: #EE5007 <%}%>
																											   <%if( (Integer.parseInt(obj[36].toString())>75) && (Integer.parseInt(obj[36].toString())<=100)){%> background-color:red <%}%>
																	"><%=obj[36] %></span>
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
											
											<%  ProjectCount++;  } %>
											
										</tbody>
											
											
									</table>	
									
									<!-- ******************************************************** INDIVIDUAL PROJECT DETAILS ******************************************* -->
	
									<div class="card" style="background: white;display:none;" id="projectgraph">
										<div style="background-color: rgba(255, 255, 255, 0.39999) !important ;border-radius: 4px ;overflow-x:hidden ">
											<div  style="float: right;margin: 10px">
												<button class="btn btn-sm back" onclick="overalldetails('A')">Details</button>
												<br>
												<button class="btn btn-sm back" style="margin-top: 10px;padding: 3px 19px;" onclick="overalldoc()"><i class="fa fa-file-text-o" aria-hidden="true"></i> DOC </button>
											</div>
											
											<div class="row">
												<div class="col-md-4">
								 					<figure class="highcharts-figure">
														<div id="containerh"></div>
													</figure>
												</div>
												<div class="col-md-4">
								 					<figure class="highcharts-figure">
														<div id="containerh2"></div>
													</figure>
												</div>
												<div class="col-md-4">
								 					<figure class="highcharts-figure">
														<div id="containerh3"></div>
													</figure>
												</div>
												<!-- <div class="col-md-1">
													<button class="btn btn-sm back" style="float: right;margin: 10px" onclick="overalldetails('A')">Details</button>
													<button class="btn btn-sm back" style="float: right;margin: 10px" onclick="overalldetails('A')">DOC</button>
												</div> -->
											</div>
											<hr>
											<div class="row">
												<div class="col-md-4">
								 					<figure class="highcharts-figure">
														<div id="containerh4"></div>
													</figure>
												</div>
												<div class="col-md-4">
								 					<figure class="highcharts-figure">
														<div id="containerh5"></div>
													</figure>
												</div>
												<div class="col-md-4">
								 					<figure class="highcharts-figure">
														<div id="containerh6"></div>
													</figure>
												</div>
											</div>
											
											
										</div>
									</div>		
								
								<!-- ******************************************************** INDIVIDUAL PROJECT DETAILS END ******************************************* -->
			
				
								</div> 
								
								<%}else{ %>
								
								
									<h2> <%if(logintype.equalsIgnoreCase("K")){ %> No Lab Details <%}else{ %> No Project Details  <%} %></h2>
								
								<%} %>

	        	</div>
			</div>
			
			
			<div class="card" style="background: transparent;">
		
			<div id="overalldivdg" style="background-color: rgba(255, 255, 255, 0.39999) !important ;border-radius: 4px ;/* max-height: 26rem */; overflow-y:auto;overflow-x:hidden  ">
								
				<table class="table meeting tableFixHead fixed-table "  style="table-layout: fixed"> 
										<thead style=" background: #1363DF; color: white;">												
											<tr>
												<td style="width:4%">
													<a  data-toggle="modal"  class="fa faa-pulse animated " data-target="#exampleModal1" data-whatever="@mdo" style="padding: 0px 1.5rem;cursor:pointer" ><i class="fa fa-info-circle " style="font-size: 1.3rem;color: " aria-hidden="true"></i> </a>
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
												<td   style="font-weight: 800; font-size:0.75rem;text-align:left;"><%=obj[45] %>	</td>
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
																<span class="health-circle" style="<%if(Integer.parseInt(obj[30].toString())<=25){%> background-color:green <%}%>
																								   <%if( (Integer.parseInt(obj[30].toString())>25) && (Integer.parseInt(obj[30].toString())<=50)){%> background-color: #F8CB2E;color:black <%}%>
																								   <%if( (Integer.parseInt(obj[30].toString())>50) && (Integer.parseInt(obj[30].toString())<=75)){%> background-color: #EE5007 <%}%>
																								   <%if( (Integer.parseInt(obj[30].toString())>75) && (Integer.parseInt(obj[30].toString())<=100)){%> background-color:red <%}%>
																"><%=obj[30] %></span>
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
																<span class="health-circle" style="<%if(Integer.parseInt(obj[32].toString())<=25){%> background-color:green <%}%>
																								   <%if( (Integer.parseInt(obj[32].toString())>25) && (Integer.parseInt(obj[32].toString())<=50)){%> background-color: #F8CB2E;color:black <%}%>
																								   <%if( (Integer.parseInt(obj[32].toString())>50) && (Integer.parseInt(obj[32].toString())<=75)){%> background-color: #EE5007 <%}%>
																								   <%if( (Integer.parseInt(obj[32].toString())>75) && (Integer.parseInt(obj[32].toString())<=100)){%> background-color:red <%}%>
																"><%=obj[32] %></span>
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
																<span class="health-circle" style="<%if(Integer.parseInt(obj[44].toString())<=25){%> background-color:green <%}%>
																								   <%if( (Integer.parseInt(obj[44].toString())>25) && (Integer.parseInt(obj[44].toString())<=50)){%> background-color: #F8CB2E;color:black <%}%>
																								   <%if( (Integer.parseInt(obj[44].toString())>50) && (Integer.parseInt(obj[44].toString())<=75)){%> background-color: #EE5007 <%}%>
																								   <%if( (Integer.parseInt(obj[44].toString())>75) && (Integer.parseInt(obj[44].toString())<=100)){%> background-color:red <%}%>
																"><%=obj[44] %></span>
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
															<span class="health-circle" style="<%if(Integer.parseInt(obj[34].toString())<=25){%> background-color:green <%}%>
																									   <%if( (Integer.parseInt(obj[34].toString())>25) && (Integer.parseInt(obj[34].toString())<=50)){%> background-color: #F8CB2E;color:black <%}%>
																									   <%if( (Integer.parseInt(obj[34].toString())>50) && (Integer.parseInt(obj[34].toString())<=75)){%> background-color: #EE5007 <%}%>
																									   <%if( (Integer.parseInt(obj[34].toString())>75) && (Integer.parseInt(obj[34].toString())<=100)){%> background-color:red <%}%>
															"><%=obj[34] %></span>
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
																<span class="health-circle" style="<%if(Integer.parseInt(obj[38].toString())<=25){%> background-color:green <%}%>
																										   <%if( (Integer.parseInt(obj[38].toString())>25) && (Integer.parseInt(obj[38].toString())<=50)){%> background-color: #F8CB2E;color:black <%}%>
																										   <%if( (Integer.parseInt(obj[38].toString())>50) && (Integer.parseInt(obj[38].toString())<=75)){%> background-color: #EE5007 <%}%>
																										   <%if( (Integer.parseInt(obj[38].toString())>75) && (Integer.parseInt(obj[38].toString())<=100)){%> background-color:red <%}%>
																"><%=obj[38] %></span>
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
																	<span class="health-circle" style="<%if(Integer.parseInt(obj[40].toString())<=25){%> background-color:green <%}%>
																											   <%if( (Integer.parseInt(obj[40].toString())>25) && (Integer.parseInt(obj[40].toString())<=50)){%> background-color: #F8CB2E;color:black <%}%>
																											   <%if( (Integer.parseInt(obj[40].toString())>50) && (Integer.parseInt(obj[40].toString())<=75)){%> background-color: #EE5007 <%}%>
																											   <%if( (Integer.parseInt(obj[40].toString())>75) && (Integer.parseInt(obj[40].toString())<=100)){%> background-color:red <%}%>
																	"><%=obj[40] %></span>
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
</div>
	
<!-- ************************Informative Modal Start********************* -->

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
					<div class="row">
						<div style="text-align: left">
								<p style="margin-bottom: 0px !important;margin-left:10px">Project Health (Pending %)</p>
								<hr class="modal-hr">
								<ul class="modal-list">
						          	<li><span class="modal-span" style="color:green">&#8226;</span><span class="modal-text">0-25%</span></li>
						           	<li><span class="modal-span" style="color:#F8CB2E;">&#8226;</span><span class="modal-text">25-50%</span></li>
						           	<li><span class="modal-span" style="color:#EE5007">&#8226;</span><span class="modal-text">50-75%</span></li>
						           	<li><span class="modal-span" style="color:red">&#8226;</span><span class="modal-text">75-100%</span></li>
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
				
					          
				</div>
				
					      
			</div>
		</div>
	</div>

<!-- ************************Informative Modal End********************* -->




<script>
$('.progress-bar[data-toggle="tooltip"]').tooltip({
    animated: 'fade',
    placement: 'bottom'
});

function ProjectDetails(value){
	
	$("#overalldiv").css("display","none");
	$('#projectgraph').css("display","block");
	
	$('#projectiddoc').val(value);
	$('#projectidchanges').val(value);
	charts(value);
	
}

function overalldetails(value){
	
	$("#overalldiv").css("display","block");
	$('#projectgraph').css("display","none");
	$('#projectidchanges').val("A");
	
	/* individualprojectdetails(value); */
	charts(value);
	
}


function charts(value){
	
	$projectid=value;
		
		$
			
			.ajax({
			
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
					
					document.getElementById('financevalue').innerHTML = values[23].toLocaleString('en-IN');
					document.getElementById('risksvalue').innerHTML = values[16] + ' / ' + values[18];
					document.getElementById('actionvalue').innerHTML = values[14] + ' / ' + values[15];
					document.getElementById('milestonevalue').innerHTML = values[8] + ' / ' + values[9];
					
					if(values[10]!=null)
					document.getElementById('milestonepercentage').innerHTML = values[10] + '%';
					else
					document.getElementById('milestonepercentage').innerHTML = 'Nil'; 
					
					
					
					var s=  values[0] + '/' + values[2]
					document.getElementById('meetingsvaluepmrc').innerHTML = s;
					var t=  values[3] + '/' + values[5]
					document.getElementById('meetingsvalueeb').innerHTML = t;
					
					<%-- if(values[24]!='A')
					document.getElementById('projecttitle').innerHTML = 'Project : ' + values[25];
					else
					document.getElementById('projecttitle').innerHTML = 'Project Count : ' + <%=ProjectCount%>;	
					document.getElementById('projecttitle').innerHTML = 'PROJECT HEALTH (' + <%=ProjectCount%> + ')';	 --%>
					
					
					
					<!-- ******************************************* Project Details Graph Script ******************************************************* -->
					
					Highcharts.chart('containerh', {
					    chart: {
					        type: 'bar',
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
					        text: 'Milestone',
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
					            depth: 15
					        }
					    },
					    colors: [
					        '#ffc107',
					        '#dc3545',
					        '#28a745'
					    ],
					    series: [{
					        name: 'Milestone',
					        data: miletsonedata(),
					    
					    }],
					    credits: {
					        enabled: false
					    },
					});
					
					function miletsonedata(){
						let miletsonedata=[];
						
						if(parseInt(values[9])>0){
							miletsonedata=[ 
								['Pending', parseInt(values[6])],
					            ['Delayed', parseInt(values[7])],
					            ['Completed', parseInt(values[8])],
					            ]
						}
						
						return miletsonedata;
					}

					/********************************************** Action ****************************************************/

					Highcharts.chart('containerh3', {
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
					}
					
					/*************************************************************** Risk *****************************************************  */

					Highcharts.chart('containerh4', {
					    chart: {
					        type: 'column',
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
				        height: (12 / 16 * 100) + '%' 
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
				        pointFormat: '<span style="color:{point.color}">\u25CF</span> <b> {point.name}</b><br/>' +
				            'Area (square km): <b>{point.y}</b><br/>' +
				            'Population density (people per square km): <b>{point.z}</b><br/>'
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
			
					
		


	}



</script>









</body>
</html>