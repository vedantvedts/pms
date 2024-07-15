<%@page import="com.ibm.icu.text.DecimalFormat"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"
	import="java.util.*,com.vts.*,java.text.SimpleDateFormat,java.io.ByteArrayOutputStream,java.io.ObjectOutputStream"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<spring:url value="/resources/css/sweetalert2.min.css" var="sweetalertCss" />
<spring:url value="/resources/js/sweetalert2.min.js" var="sweetalertJs" />
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<jsp:include page="../static/header.jsp"></jsp:include>
<script src="./resources/js/multiselect.js"></script>
<link href="./resources/css/multiselect.css" rel="stylesheet" />
	<link href="${sweetalertCss}" rel="stylesheet" />
	<script src="${sweetalertJs}"></script>

<title>New Action</title>
<style type="text/css">
label {
	font-weight: bold;
	font-size: 13px;
}

body {
	background-color: #f2edfa;
	overflow-x: hidden !important;
}

h6 {
	text-decoration: none !important;
}

.multiselect-container>li>a>label {
	padding: 4px 20px 3px 20px;
}

.cc-rockmenu {
	color: fff;
	padding: 0px 5px;
	font-family: 'Lato', sans-serif;
}

.cc-rockmenu .rolling {
	display: inline-block;
	cursor: pointer;
	width: 34px;
	height: 30px;
	text-align: left;
	overflow: hidden;
	transition: all 0.3s ease-out;
	white-space: nowrap;
}

.cc-rockmenu .rolling:hover {
	width: 108px;
}

.cc-rockmenu .rolling .rolling_icon {
	float: left;
	z-index: 9;
	display: inline-block;
	width: 28px;
	height: 52px;
	box-sizing: border-box;
	margin: 0 5px 0 0;
}

.cc-rockmenu .rolling .rolling_icon:hover .rolling {
	width: 312px;
}

.cc-rockmenu .rolling i.fa {
	font-size: 20px;
	padding: 6px;
}

.cc-rockmenu .rolling span {
	display: block;
	font-weight: bold;
	padding: 2px 0;
	font-size: 14px;
	font-family: 'Muli', sans-serif;
}

.cc-rockmenu .rolling p {
	margin: 0;
}

.width {
	width: 150px !important;
}

/*----------------genealogy-tree----------*/
.genealogy-body {
	white-space: nowrap;
	overflow-y: hidden;
	padding: 50px;
	min-height: 500px;
	padding-top: 10px;
	text-align: center;
}

.genealogy-tree {
	display: inline-block;
}

.genealogy-tree ul {
	padding-top: 20px;
	position: relative;
	padding-left: 0px;
	display: flex;
	justify-content: center;
}

.genealogy-tree li {
	float: left;
	text-align: center;
	list-style-type: none;
	position: relative;
	padding: 20px 5px 0 5px;
}

.genealogy-tree li::before, .genealogy-tree li::after {
	content: '';
	position: absolute;
	top: 0;
	right: 50%;
	border-top: 2px solid #ccc;
	width: 50%;
	height: 18px;
}

.genealogy-tree li::after {
	right: auto;
	left: 50%;
	border-left: 2px solid #ccc;
}

.genealogy-tree li:only-child::after, .genealogy-tree li:only-child::before
	{
	display: none;
}

.genealogy-tree li:only-child {
	padding-top: 0;
}

.genealogy-tree li:first-child::before, .genealogy-tree li:last-child::after
	{
	border: 0 none;
}

.genealogy-tree li:last-child::before {
	border-right: 2px solid #ccc;
	border-radius: 0 5px 0 0;
	-webkit-border-radius: 0 5px 0 0;
	-moz-border-radius: 0 5px 0 0;
}

.genealogy-tree li:first-child::after {
	border-radius: 5px 0 0 0;
	-webkit-border-radius: 5px 0 0 0;
	-moz-border-radius: 5px 0 0 0;
}

.genealogy-tree ul ul::before {
	content: '';
	position: absolute;
	top: 0;
	left: 50%;
	border-left: 2px solid #ccc;
	width: 0;
	height: 20px;
}

.genealogy-tree li .action-view-box {
	text-decoration: none;
	font-family: arial, verdana, tahoma;
	font-size: 11px;
	display: inline-block;
	border-radius: 5px;
	-webkit-border-radius: 5px;
	-moz-border-radius: 5px;
}

.genealogy-tree li a:hover+ul li::after, .genealogy-tree li a:hover+ul li::before,
	.genealogy-tree li a:hover+ul::before, .genealogy-tree li a:hover+ul ul::before
	{
	border-color: #fbba00;
}

/*--------------memeber-card-design----------*/
.member-view-box {
	padding: 0px 15px;
	text-align: center;
	border-radius: 4px;
	position: relative;
}

.member-image {
	width: 60px;
	position: relative;
}

.member-image img {
	width: 60px;
	height: 60px;
	border-radius: 6px;
	background-color: #000;
	z-index: 1;
}

.action-box {
	width: fit-content;
	height: fit-content;
	min-width: 220px;
	border: 1px solid black;
	border-radius: 10px;
}

.action-box-header {
	border-top-right-radius: 10px;
	border-top-left-radius: 10px;
	padding: 5px;
	text-align: center;
}

.action-box-body {
	padding: 5px;
	text-align: center;
	background-color: #ffffff;
	display: block;
	flex-wrap: wrap;
	border-bottom-right-radius: 10px;
	border-bottom-left-radius: 10px;
}

.card-body-table {
	width: 100%;
}

.card-body-table  td {
	border: 0px;
	text-align: left;
}

.card-body-table th {
	border: 0px;
}

.Q1 {
	background-color: #DC3535;
	color: #FFFFFF;
}

.Q2 {
	background-color: #FF7000;
	color: #FFFFFF;
}

.Q3 {
	background-color: #FED049;
	color: #000000;
}

.Q4 {
	background-color: #5F8D4E;
	color: #FFFFFF;
}

.Q5 {
	background-color: #3d3a32;
	color: #FFFFFF;
}

th {
	text-align: left;
	overflow-wrap: break-word;
}

td {
	text-align: justify;
	text-justify: inter-word;
}

.tabledata {
	white-space: -o-pre-wrap;
	word-wrap: break-word;
	white-space: pre-wrap;
	white-space: -moz-pre-wrap;
	white-space: -pre-wrap;
}
</style>

</head>

<body>
	<%
  String ActionMainId=(String)request.getAttribute("ActionMainId");
  String ActionAssignId = (String)request.getAttribute("ActionAssignId"); 
  Object[] Assignee=(Object[])request.getAttribute("Assignee");
  SimpleDateFormat sdf=new SimpleDateFormat("dd-MM-yyyy");
  SimpleDateFormat sdf1=new SimpleDateFormat("yyyy-MM-dd");
  String back = (String)request.getAttribute("back");
  int countflag=0;
  // for re-assign
  String clusterid = (String)session.getAttribute("clusterid");
	String LabCode =(String)request.getAttribute("LabCode"); 
	List<Object[]> AllLabList = (List<Object[]>)request.getAttribute("AllLabList");
	List<Object[]> SubList=(List<Object[]> ) request.getAttribute("SubList");
	String ActionPath= (String)request.getAttribute("ActionPath");
	
	String carsInitiationId = (String)request.getAttribute("carsInitiationId");
	String carsSoCMilestoneId = (String)request.getAttribute("carsSoCMilestoneId");
%>


	<% 
		List<Object[]> actionslist = (List<Object[]>)request.getAttribute("actionslist");
	%>

	<%String ses=(String)request.getParameter("result"); 
	String ses1=(String)request.getParameter("resultfail");
	if(ses1!=null){
	%>
	<div align="center">
		<div class="alert alert-danger" role="alert">
			<%=ses1 %>
		</div>
	</div>
	<%}if(ses!=null){%>
	<div align="center">
		<div class="alert alert-success" role="alert">
			<%=ses %>
		</div>
	</div>
	<%} %>
	<div class="modal fade  bd-example-modal-lg" tabindex="-1"
		role="dialog" id="ActionAssignfilemodal">
		<div class="modal-dialog " role="document"
			style="min-width: 60rem; max-width: 80rem; overflow-x: auto;">
			<div class="modal-content">
				<div class="modal-header">
					<h4 class="modal-title" style="float: right;">Action Tree</h4>
					<div style="margin-left: 380px;">
						<div style="font-weight: bold;">
							<span style="margin: 0px 0px 10px 10px;">0 - 25 % :&ensp;
								<span class="Q1" style="padding: 0px 15px; border-radius: 3px;"></span>
							</span> <span style="margin: 0px 0px 10px 15px;">26 - 50 %
								:&ensp; <span class="Q2"
								style="padding: 0px 15px; border-radius: 3px;"></span>
							</span> <span style="margin: 0px 0px 10px 15px;">51 - 75 %
								:&ensp; <span class="Q3"
								style="padding: 0px 15px; border-radius: 3px;"></span>
							</span> <span style="margin: 0px 0px 10px 15px;">76 - 100 %
								:&ensp; <span class="Q4"
								style="padding: 0px 15px; border-radius: 3px;"></span>
							</span> <span style="margin: 0px 0px 10px 15px;">Closed:&ensp; <span
								class="Q5" style="padding: 0px 15px; border-radius: 3px;"></span></span>
						</div>
					</div>
					<button type="button" class="close" data-dismiss="modal"
						aria-label="Close">
						<span aria-hidden="true">&times;</span>
					</button>
				</div>
				<%
						int startLevel = 0;
						
						if(actionslist.size()>0){
							startLevel = Integer.parseInt(actionslist.get(0)[3].toString());
						} 
						%>
				<form name="specadd" id="specadd" action="##" method="Get">
					<div class="modal-body"
						style="max-height: 38rem; overflow-y: auto;">

						<div align="center">
							<div class="genealogy-tree">

								<ul>
									<li>
										<%for(Object[] action : actionslist){ %> <% if(Integer.parseInt(action[3].toString()) == startLevel){ %>

										<div class="member-view-box action-view-box">
											<div class=" action-box">
												<div
													<% int progress = action[25]!=null ? Integer.parseInt(action[25].toString()) : 0 ; 
			                          			countflag++;
			                          		%>
													<% if( action[20]!=null && "C".equalsIgnoreCase(action[20]+"") ){ %>
													class="action-box-header Q5"
													<%}else if( progress >= 0 && progress <= 25  ){ %>
													class="action-box-header Q1"
													<%}else if( progress >= 26 && progress <= 50  ){ %>
													class=" action-box-header Q2"
													<%}else if( progress >= 51 && progress <= 75  ){ %>
													class=" action-box-header Q3"
													<%}else if(  progress >= 76 && progress <= 100  ){ %>
													class="action-box-header Q4" <%} %>>

													<span style="cursor: pointer; font-weight: 600;"
														onclick="ActionDetails(	'<%=action[10] %>',   <!-- assignid -->
			                          									'<%=action[5].toString().trim() %>',   <!-- action item -->
			                          									'<%=action[11] %>',   <!-- action No -->
			                          									'<%if(action[25]!=null){ %> <%=action[25] %>% <%}else{ %>0<%} %>', <!-- progress -->
			                          									'<%=sdf.format(action[4]) %>', <!-- action date -->
			                          									'<%=sdf.format(action[24]) %>', <!-- enddate -->
			                          									'<%=sdf.format(action[12]) %>', <!-- orgpdc -->
			                          									'<%=action[22].toString().trim()%>', <!-- assignor -->
			                          									'<%=action[23].toString().trim()%>', <!-- assignee -->
			                          									'<%=action[6]%>' <!-- action type -->
			                          									);">
														<%=action[11] %>
													</span>

												</div>
												<div class="action-box-body" align="center"
													style="cursor: pointer;">
													<table class="card-body-table">
														<tr>
															<th style="width: 40%;">Assignee :</th>
															<td>&emsp;<%=action[23] %></td>
														</tr>
														<tr>
															<th style="">PDC :</th>
															<td>&emsp;<%=sdf.format(action[24]) %></td>
														</tr>
														<tr>
															<th style="">Progress (%) :</th>
															<td style="padding-left: 10px;">
																<%if(action[25]!=null){ %>
																<div class="progress"
																	style="background-color: #cdd0cb !important; height: 0.80rem !important;">
																	<div class="progress-bar progress-bar-striped"
																		role="progressbar" style=" width: <%=action[25]%>%;  "
																		aria-valuenow="25" aria-valuemin="0"
																		aria-valuemax="100">
																		<%=action[25]%>
																	</div>
																</div> <%}else{ %>
																<div class="progress"
																	style="background-color: #cdd0cb !important; height: 0.80rem !important;">
																	<div class="progress-bar" role="progressbar"
																		style="width: 100%; background-color: #cdd0cb !important; color: black; font-weight: bold;">
																		Not Yet Started</div>
																</div> <%} %>

															</td>
														</tr>
													</table>
												</div>
											</div>
										</div> <!-- --------------------------------------------------------   LEVEL 1 ---------------------------------------------------- -->
										<ul class="active">
											<%for(Object[] action_L1 : actionslist){ %>
											<% if(Integer.parseInt(action_L1[3].toString()) == startLevel+1 && Long.parseLong(action[0].toString()) == Long.parseLong(action_L1[1].toString())  
								&&  action[18].toString().trim().equalsIgnoreCase(action_L1[16].toString().trim()) 
								&& Long.parseLong(action[19].toString()) == Long.parseLong(action_L1[17].toString()) ){ %>
											<li>

												<div class="member-view-box action-view-box">
													<div class=" action-box">
														<div
															<% int progress_L1 = action_L1[25]!=null ? Integer.parseInt(action_L1[25].toString()) : 0 ; 
						                          		countflag++;%>
															<% if(action_L1[20]!=null && "C".equalsIgnoreCase(action_L1[20]+"") ){ %>
															class="action-box-header Q5"
															<%}else if( progress_L1 >= 0 && progress_L1 <= 25  ){ %>
															class="action-box-header Q1"
															<%}else if( progress_L1 >= 26 && progress_L1 <= 50  ){ %>
															class=" action-box-header Q2"
															<%}else if( progress_L1 >= 51 && progress_L1 <= 75  ){ %>
															class=" action-box-header Q3"
															<%}else if(  progress_L1 >= 76 && progress_L1 <= 100  ){ %>
															class="action-box-header Q4" <%} %>>

															<span style="cursor: pointer; font-weight: 600;"
																onclick="ActionDetails('<%=action_L1[10] %>',   <!-- assignid -->
							                          									'<%=action_L1[5].toString().trim() %>',   <!-- action item -->
							                          									'<%=action_L1[11] %>',   <!-- action No -->
							                          									'<%if(action_L1[25]!=null){ %> <%=action_L1[25] %>% <%}else{ %>0<%} %>', <!-- progress -->
							                          									'<%=sdf.format(action_L1[4]) %>', <!-- action date -->
							                          									'<%=sdf.format(action_L1[24]) %>', <!-- enddate -->
							                          									'<%=sdf.format(action_L1[12]) %>', <!-- orgpdc -->
							                          									'<%=action_L1[22].toString().trim()%>', <!-- assignor -->
							                          									'<%=action_L1[23].toString().trim()%>', <!-- assignee -->
							                          									'<%=action_L1[6]%>' <!-- action type -->
							                          									);">

																<%=action_L1[11] %></span>

														</div>
														<div class="action-box-body" align="center"
															style="cursor: pointer;">
															<table class="card-body-table">
																<tr>
																	<th style="width: 40%;">Assignee :</th>
																	<td>&emsp;<%=action_L1[23] %></td>
																</tr>
																<tr>
																	<th style="">PDC :</th>
																	<td>&emsp;<%=sdf.format(action_L1[24]) %></td>
																</tr>
																<tr>
																	<th style="">Progress (%) :</th>
																	<td style="padding-left: 10px;">
																		<%if(action_L1[25]!=null){ %>
																		<div class="progress"
																			style="background-color: #cdd0cb !important; height: 0.80rem !important;">
																			<div class="progress-bar progress-bar-striped"
																				role="progressbar"
																				style=" width: <%=action_L1[25]%>%;  "
																				aria-valuenow="25" aria-valuemin="0"
																				aria-valuemax="100">
																				<%=action_L1[25]%>
																			</div>
																		</div> <%}else{ %>
																		<div class="progress"
																			style="background-color: #cdd0cb !important; height: 0.80rem !important;">
																			<div class="progress-bar" role="progressbar"
																				style="width: 100%; background-color: #cdd0cb !important; color: black; font-weight: bold;">
																				Not Yet Started</div>
																		</div> <%} %>

																	</td>
																</tr>
															</table>
														</div>
													</div>
												</div> <!-- --------------------------------------------------------   LEVEL 2 ---------------------------------------------------- -->
												<ul class="">

													<%for(Object[] action_L2 : actionslist){ %>

													<% if(Integer.parseInt(action_L2[3].toString()) == startLevel+2 && Long.parseLong(action_L1[0].toString())== Long.parseLong(action_L2[1].toString())  
												&& action_L1[18].toString().trim().equalsIgnoreCase(action_L2[16].toString().trim()) 
												&& Long.parseLong(action_L1[19].toString()) == Long.parseLong(action_L2[17].toString()) ){ %>
													<li>

														<div class="member-view-box action-view-box">
															<div class=" action-box">
																<div
																	<% int progress_L2 = action_L2[25]!=null ? Integer.parseInt(action_L2[25].toString()) : 0 ; countflag++;%>
																	<% if( action_L2[20]!=null && "C".equalsIgnoreCase(action_L2[20]+"") ){ %>
																	class="action-box-header Q5"
																	<%}else if( progress_L2 >= 0 && progress_L2 <= 25  ){ %>
																	class="action-box-header Q1"
																	<%}else if( progress_L2 >= 26 && progress_L2 <= 50  ){ %>
																	class=" action-box-header Q2"
																	<%}else if( progress_L2 >= 51 && progress_L2 <= 75  ){ %>
																	class=" action-box-header Q3"
																	<%}else if(  progress_L2 >= 76 && progress_L2 <= 100  ){ %>
																	class="action-box-header Q4" <%} %>>

																	<span style="cursor: pointer; font-weight: 600;"
																		onclick="ActionDetails('<%=action_L2[10] %>',   <!-- assignid -->
									                          									'<%=action_L2[5].toString().trim() %>',   <!-- action item -->
									                          									'<%=action_L2[11] %>',   <!-- action No -->
									                          									'<%if(action_L2[25]!=null){ %> <%=action_L2[25] %>% <%}else{ %>0<%} %>', <!-- progress -->
									                          									'<%=sdf.format(action_L2[4]) %>', <!-- action date -->
									                          									'<%=sdf.format(action_L2[24]) %>', <!-- enddate -->
									                          									'<%=sdf.format(action_L2[12]) %>', <!-- orgpdc -->
									                          									'<%=action_L2[22].toString().trim()%>', <!-- assignor -->
									                          									'<%=action_L2[23].toString().trim()%>', <!-- assignee -->
							                          											'<%=action_L2[6]%>' <!-- action type -->
									                          									);">


																		<%=action_L2[11] %></span>
																</div>
																<div class="action-box-body" align="center"
																	style="cursor: pointer;" style="cursor: pointer ;">
																	<table class="card-body-table">
																		<tr>
																			<th style="width: 40%;">Assignee :</th>
																			<td>&emsp;<%=action_L2[23] %></td>
																		</tr>
																		<tr>
																			<th style="">PDC :</th>
																			<td>&emsp;<%=sdf.format(action_L2[24]) %></td>
																		</tr>
																		<tr>
																			<th style="">Progress (%) :</th>
																			<td style="padding-left: 10px;">
																				<%if(action_L2[25]!=null){ %>
																				<div class="progress"
																					style="background-color: #cdd0cb !important; height: 0.80rem !important;">
																					<div class="progress-bar progress-bar-striped"
																						role="progressbar"
																						style=" width: <%=action_L2[25]%>%;  "
																						aria-valuenow="25" aria-valuemin="0"
																						aria-valuemax="100">
																						<%=action_L2[25]%>
																					</div>
																				</div> <%}else{ %>
																				<div class="progress"
																					style="background-color: #cdd0cb !important; height: 0.80rem !important;">
																					<div class="progress-bar" role="progressbar"
																						style="width: 100%; background-color: #cdd0cb !important; color: black; font-weight: bold;">
																						Not Yet Started</div>
																				</div> <%} %>

																			</td>
																		</tr>
																	</table>
																</div>
															</div>
														</div> <!-- --------------------------------------------------------   LEVEL 3 ---------------------------------------------------- -->
														<ul class="">
															<%for(Object[] action_L3 : actionslist){ %>
															<% if(Integer.parseInt(action_L3[3].toString()) == startLevel+3 && Long.parseLong(action_L2[0].toString())== Long.parseLong(action_L3[1].toString()) 
															&&  action_L2[18].toString().trim().equalsIgnoreCase(action_L3[16].toString().trim()) 
															&& Long.parseLong(action_L2[19].toString()) == Long.parseLong(action_L3[17].toString()) ){ %>
															<li>

																<div class="member-view-box action-view-box">
																	<div class=" action-box">
																		<div
																			<% int progress_L3 = action_L3[25]!=null ? Integer.parseInt(action_L3[25].toString()) : 0 ;  countflag++; %>
																			<% if( action_L3[20]!=null && "C".equalsIgnoreCase(action_L3[20]+"") ){ %>
																			class="action-box-header Q5"
																			<%}else if( progress_L3 >= 0 && progress_L3 <= 25  ){ %>
																			class="action-box-header Q1"
																			<%}else if( progress_L3 >= 26 && progress_L3 <= 50  ){ %>
																			class=" action-box-header Q2"
																			<%}else if( progress_L3 >= 51 && progress_L3 <= 75  ){ %>
																			class=" action-box-header Q3"
																			<%}else if(  progress_L3 >= 76 && progress_L3 <= 100  ){ %>
																			class="action-box-header Q4" <%} %>>

																			<span style="cursor: pointer; font-weight: 600;"
																				onclick="ActionDetails('<%=action_L3[10] %>',   <!-- assignid -->
													                          									'<%=action_L3[5].toString().trim() %>',   <!-- action item -->
													                          									'<%=action_L3[11] %>',   <!-- action No -->
													                          									'<%if(action_L3[25]!=null){ %> <%=action_L2[25] %>% <%}else{ %>0<%} %>', <!-- progress -->
													                          									'<%=sdf.format(action_L3[4]) %>', <!-- action date -->
													                          									'<%=sdf.format(action_L3[24]) %>', <!-- enddate -->
													                          									'<%=sdf.format(action_L3[12]) %>', <!-- orgpdc -->
													                          									'<%=action_L3[22].toString().trim()%>', <!-- assignor -->
													                          									'<%=action_L3[23].toString().trim()%>', <!-- assignee -->
							                          															'<%=action_L3[6]%>' <!-- action type -->
													                          									);">

																				<%=action_L3[11] %></span>

																		</div>
																		<div class="action-box-body" align="center"
																			style="cursor: pointer;">
																			<table class="card-body-table">
																				<tr>
																					<th style="width: 40%;">Assignee :</th>
																					<td>&emsp;<%=action_L3[23] %></td>
																				</tr>
																				<tr>
																					<th style="">PDC :</th>
																					<td>&emsp;<%=sdf.format(action_L3[24]) %></td>
																				</tr>
																				<tr>
																					<th style="">Progress (%) :</th>
																					<td style="padding-left: 10px;">
																						<%if(action_L3[25]!=null){ %>
																						<div class="progress"
																							style="background-color: #cdd0cb !important; height: 0.80rem !important;">
																							<div class="progress-bar progress-bar-striped"
																								role="progressbar"
																								style=" width: <%=action_L3[25]%>%;  "
																								aria-valuenow="25" aria-valuemin="0"
																								aria-valuemax="100">
																								<%=action_L3[25]%>
																							</div>
																						</div> <%}else{ %>
																						<div class="progress"
																							style="background-color: #cdd0cb !important; height: 0.80rem !important;">
																							<div class="progress-bar" role="progressbar"
																								style="width: 100%; background-color: #cdd0cb !important; color: black; font-weight: bold;">
																								Not Yet Started</div>
																						</div> <%} %>

																					</td>
																				</tr>
																			</table>
																		</div>
																	</div>
																</div> <!-- --------------------------------------------------------   LEVEL 4 ---------------------------------------------------- -->
																<ul class="">
																	<%for(Object[] action_L4 : actionslist){ %>
																	<% if(Integer.parseInt(action_L4[3].toString()) == startLevel+4 && Long.parseLong(action_L3[0].toString())== Long.parseLong(action_L4[1].toString())  
																				&& action_L3[18].toString().trim().equalsIgnoreCase(action_L4[16].toString().trim()) 
																				&& Long.parseLong(action_L3[19].toString()) == Long.parseLong(action_L4[17].toString()) ){ %>
																	<li>

																		<div class="member-view-box action-view-box">
																			<div class=" action-box">
																				<div
																					<% int progress_L4 = action_L4[25]!=null ? Integer.parseInt(action_L4[25].toString()) : 0 ; countflag++; %>
																					<% if( action_L4[20]!=null && "C".equalsIgnoreCase(action_L4[20]+"") ){ %>
																					class="action-box-header Q5"
																					<%}else if( progress_L4 >= 0 && progress_L4 <= 25  ){ %>
																					class="action-box-header Q1"
																					<%}else if( progress_L4 >= 26 && progress_L4 <= 50  ){ %>
																					class=" action-box-header Q2"
																					<%}else if( progress_L4 >= 51 && progress_L4 <= 75  ){ %>
																					class=" action-box-header Q3"
																					<%}else if(  progress_L4 >= 76 && progress_L4 <= 100  ){ %>
																					class="action-box-header Q4" <%} %>>

																					<span style="cursor: pointer; font-weight: 600;"
																						onclick="ActionDetails('<%=action_L4[10] %>',   <!-- assignid -->
																		                          									'<%=action_L4[5].toString().trim() %>',   <!-- action item -->
																		                          									'<%=action_L4[11] %>',   <!-- action No -->
																		                          									'<%if(action_L4[25]!=null){ %> <%=action_L4[25] %>% <%}else{ %>0<%} %>', <!-- progress -->
																		                          									'<%=sdf.format(action_L4[4]) %>', <!-- action date -->
																		                          									'<%=sdf.format(action_L4[24]) %>', <!-- enddate -->
																		                          									'<%=sdf.format(action_L4[12]) %>', <!-- orgpdc -->
																		                          									'<%=action_L4[22].toString().trim()%>', <!-- assignor -->
																		                          									'<%=action_L4[23].toString().trim()%>', <!-- assignee -->
							                          																				'<%=action_L4[6]%>' <!-- action type -->
																		                          									);">


																						<%=action_L4[11] %></span>

																				</div>
																				<div class="action-box-body"
																					style="cursor: pointer;">
																					<table class="card-body-table">
																						<tr>
																							<th style="width: 40%;">Assignee :</th>
																							<td>&emsp;<%=action_L4[23] %></td>
																						</tr>
																						<tr>
																							<th style="">PDC :</th>
																							<td>&emsp;<%=sdf.format(action_L4[24]) %></td>
																						</tr>
																						<tr>
																							<th style="">Progress (%) :</th>
																							<td style="padding-left: 10px;">
																								<%if(action_L4[25]!=null){ %>
																								<div class="progress"
																									style="background-color: #cdd0cb !important; height: 0.80rem !important;">
																									<div class="progress-bar progress-bar-striped"
																										role="progressbar"
																										style=" width: <%=action_L4[25]%>%;  "
																										aria-valuenow="25" aria-valuemin="0"
																										aria-valuemax="100">
																										<%=action_L4[25]%>
																									</div>
																								</div> <%}else{ %>
																								<div class="progress"
																									style="background-color: #cdd0cb !important; height: 0.80rem !important;">
																									<div class="progress-bar" role="progressbar"
																										style="width: 100%; background-color: #cdd0cb !important; color: black; font-weight: bold;">
																										Not Yet Started</div>
																								</div> <%} %>

																							</td>
																						</tr>
																					</table>
																				</div>
																			</div>
																		</div>


																	</li>
																	<% } %>
																	<%} %>
																</ul> <!-- --------------------------------------------------------   LEVEL 4 ---------------------------------------------------- -->



															</li>
															<% } %>
															<%} %>
														</ul> <!-- --------------------------------------------------------   LEVEL 3 ---------------------------------------------------- -->


													</li>
													<% } %>
													<%} %>
												</ul> <!-- --------------------------------------------------------   LEVEL 2 ---------------------------------------------------- -->




											</li>
											<% } %>
											<% } %>
										</ul> <!-- --------------------------------------------------------   LEVEL 1 ---------------------------------------------------- -->

										<% 
							
							} %> <% } %>
									</li>
								</ul>

							</div>
						</div>
					</div>


					<!-- model Footer -->
					<div class="modal-footer">
						<div style="margin-right: 650px;">
							<h6>
								<span style="color: red;">Note :</span> If you close this
								Action. All this Sub-Action will also Closed
							</h6>
						</div>
						<div>
							<button type="submit" class="btn btn-danger btn-sm revoke"
								onclick="return  close5()" formmethod="post"
								formaction="CloseSubmit.htm">Close Action</button>
							<input type="hidden" name="ActionMainId"
								value="<%=Assignee[0] %>" /> <input type="hidden"
								name="ActionAssignId" value="<%=Assignee[19] %>" /> <input
								type="hidden" name="LevelCount" value="<%=Assignee[20] %>" /> <input
								type="hidden" name="Remarks" id="actionremarks" /> <input
								type="hidden" name="${_csrf.parameterName}"
								value="${_csrf.token}" />
						</div>
					</div>
				</form>
				<!-- Form End -->
			</div>
		</div>
	</div>
	<!-- model end -->

	<!---------------------------------------------------------------- action modal ----------------------------------------------------- -->

	<div class=" modal bd-example-modal-lg" tabindex="-1" role="dialog"
		id="action_modal">
		<div class="modal-dialog modal-lg" role="document">
			<div class="modal-content">
				<div class="modal-header" style="background-color: #FFE0AD;">
					<div class="row w-100">
						<div class="col-md-12">
							<h5 class="modal-title" id="modal_action_no"
								style="font-weight: 700; color: #A30808;"></h5>
						</div>
					</div>

					<button type="button" class="close" data-dismiss="modal"
						aria-label="Close">
						<span aria-hidden="true">&times;</span>
					</button>
				</div>
				<div class="modal-body" align="center">
					<form action="#" method="post" autocomplete="off">
						<table style="width: 100%;">
							<tr>
								<th style="width: 10%; padding: 5px;">Action Item :</th>
								<td class="tabledata"
									style="width: 90%; padding: 5px; word-wrap: break-word;"
									colspan="3" id="modal_action_item"></td>
							</tr>
							<tr>
								<th style="padding: 5px;">Assign Date :</th>
								<td style="padding: 5px;" id="modal_action_date"></td>
								<th style="padding: 5px;">PDC :</th>
								<td style="padding: 5px;" id="modal_action_PDC"></td>
							</tr>
							<tr>
								<th style="padding: 5px;">Assignor :</th>
								<td style="padding: 5px;" class="tabledata"
									id="modal_action_assignor"></td>
								<th style="padding: 5px;">Assignee :</th>
								<td style="padding: 5px;" class="tabledata"
									id="modal_action_assignee"></td>
							</tr>
							<tr>
								<th style="padding: 5px;">Final Progress :</th>
								<td style="padding: 5px;" id="modal_action_progress"></td>
								<th style="padding: 5px;">Type :</th>
								<td style="padding: 5px; font-weight: bold; color: #A30808"
									id="modal_action_type"></td>
							</tr>

						</table>
					</form>
					<hr>
					<form action="#" method="get">

						<table
							class="table table-bordered table-hover table-striped table-condensed "
							id="" style="width: 100%">
							<thead>
								<tr style="background-color: #055C9D; color: white;">
									<th style="text-align: center; width: 5% !important;">SN</th>
									<th style="text-align: center; width: 10% !important;">Progress
										Date</th>
									<th style="text-align: center; width: 15% !important;">
										Progress</th>
									<th style="width: 65% !important;">Remarks</th>
									<th style="text-align: center; width: 5% !important;">Download</th>
								</tr>
							</thead>
							<tbody id="modal_progress_table_body">

							</tbody>
						</table>
					</form>
				</div>

			</div>
		</div>
	</div>


	<!---------------------------------------------------------------- action modal ----------------------------------------------------- -->

	<div class="container-fluid">
		<div class="container" style="margin-bottom: 20px;">
			<div class="card">
				<div class="card-header" style="background-color: #055C9D;">
					<div class="row">
						<div class="col-sm-5" align="left">
							<h6
								style="color: white; font-weight: bold; font-size: 1.2rem !important"
								align="left">Action</h6>
						</div>
						<div class="col-sm-7" align="right"
							style="color: white; font-weight: bold; font-size: 1.2rem !important">
							Action Id :
							<%=Assignee[9] %>
						</div>
					</div>
				</div>
				<div style="">
					<div class="card-body">
						<div class="row">
							<div class="col-md-12">
								<table style="width: 100%;">
									<tr>
										<td style="width: 12%;"><label
											style="font-size: medium; padding-top: 10px;"> Action
												Item :</label></td>
										<td><%=Assignee[5]%></td>
									</tr>
								</table>
								<table>
									<tr>
										<td><label style="font-size: medium; padding-top: 10px;">
												Assignee :</label></td>
										<td><%=Assignee[11] %> &nbsp;(<%=Assignee[17] %>)</td>
										<td style="padding-left: 50px;"><label
											style="font-size: medium; padding-top: 10px;">
												Assigner :</label></td>
										<td><%=Assignee[1]%> &nbsp;(<%=Assignee[16] %>)</td>
										<td style="padding-left: 15px;"><label
											style="font-size: medium; padding-top: 10px;"> PDC
												(Current) :</label></td>
										<td><%=sdf.format(Assignee[4])%></td>
									</tr>
									<tr>
										<td><label style="font-size: medium; padding-top: 10px;">
												PDC Original :</label></td>
										<td>&nbsp;&nbsp; <%=sdf.format(Assignee[13])%>
										</td>

										<% int revision=Integer.parseInt(Assignee[10].toString());
	      							if(revision>2){
	      								revision=2;
	      							}
	      							for(int i=1;i<=revision;i++){%>

										<td style="padding-left: 50px;"><label
											style="font-size: medium; padding-top: 10px;">
												Revision - <%=i%> :
										</label></td>
										<td>&nbsp;&nbsp; <%=sdf.format(Assignee[14+i-1])%>
										</td>

										<%}%>
									</tr>

									<tr>
										<td><label style="font-size: medium; padding-top: 10px;">
												Action Type :</label></td>

										<td>
											<%if(Assignee[21].toString().equalsIgnoreCase("A")) {%> <span>Action</span>
											<%} %> <%if(Assignee[21].toString().equalsIgnoreCase("I")) {%> <span>Issue</span>
											<%} %> <%if(Assignee[21].toString().equalsIgnoreCase("K")) {%> <span>Risk</span>
											<%} %>
										</td>
									</tr>

								</table>
							</div>
						</div>
						<br>
						<hr>
						<br>
						<form method="post" action="##">
							<div class="row">
								<div class="col-md-2">
									<label style="font-size: medium; padding-top: 10px;">Remarks:</label>
								</div>
								<div class="col-md-7">
									<textarea rows="2" style="display: block; margin-top: -15px;"
										class="form-control" id="Remarks" name="Remarks"
										placeholder="Enter Remarks..!!"></textarea>
								</div>
								<div class="col-md-3">
									<%if(countflag>1){ %>
									<button type="button" class="btn btn-danger btn-sm revoke"
										name="sub" value="C"
										onclick=" CloseAction(<%=Assignee[18] %>)">Close
										Action</button>
									<%}else{%>
									<button type="submit" class="btn btn-danger btn-sm revoke"
										name="sub" value="C"
										onclick="return confirm('Are You Sure To Submit ?')"
										formaction="CloseSubmit.htm">Close Action</button>
									<%}%>
									<input type="hidden" name="ActionMainId"
										value="<%=Assignee[0] %>" /> <input type="hidden"
										name="ActionAssignId" value="<%=Assignee[18] %>" /> <input
										type="hidden" name="LevelCount" value="<%=Assignee[19] %>" />
									<input type="hidden" name="${_csrf.parameterName}"
										value="${_csrf.token}" />
								</div>
							</div>
						</form>

						<%-- <%if(Integer.parseInt(Assignee[10].toString())<2){ %>  --%>
						<br>
						<hr>
						<br>
						<form action="ActionReassign.htm" method="POST">
							<div class="row">
								<div class="col-md-2">
									<label>Re Assign</label>&nbsp;&nbsp;&nbsp;
								</div>
								<div class="col-md-2">
									<select class="form-control selectdee"
										name="modelAssigneeLabCode" id="modelAssigneelabcode"
										style="width: 100% !important;"
										onchange="AssigneeEmpListForEdit(0);">
										<%if(AllLabList!=null && AllLabList.size()>0){
								for(Object[] lab : AllLabList){
								if(clusterid!=null && clusterid.equalsIgnoreCase(lab[1].toString())){
								 %>
										<option value="<%=lab[3] %>"
											<%if(LabCode.equals(lab[3].toString())){ %> selected <%} %>><%=lab[3] %></option>
										<%}}}%>
										<option value="@EXP">Expert</option>
									</select>
								</div>
								<div class="col-md-5">
									<select class="form-control selectdee" name="Assignee"
										style="width: 100% !important;" id="modalassignee"
										required="required" data-live-search="true"
										data-placeholder="Select Assignee">
									</select>
								</div>
								<div class="col-md-3">
									<button type="submit" class="btn btn-sm btn-warning text-dark"
										onclick="reassign()">REASSIGN</button>
								</div>
								<input type="hidden" name="ActionPath" value="<%=ActionPath%>">
								<input type="hidden" name="ActionMainId"
									value="<%=Assignee[0] %>" /> <input type="hidden"
									name="ActionAssignId" value="<%=Assignee[18] %>" /> <input
									type="hidden" name="${_csrf.parameterName}"
									value="${_csrf.token}" />
							</div>
						</form>
						<br>
						<hr>
						<br>
						<form method="post" action="ExtendPdc.htm">
							<div class="row">

								<div class="col-sm-2">
									<label>Extend PDC:</label>
								</div>
								<div class="col-sm-2">
									<input class="form-control " name="ExtendPdc"
										id="DateCompletion" required="required"
										value="<%=sdf.format(Assignee[4])%>" style="margin-top: -4px;">
								</div>
								<div class="col-md-4 mb-3">
									<button type="submit" class="btn btn-sm submit"
										onclick="return confirm('Are You Sure To Submit ?')">
										Extend PDC</button>
									<input type="hidden" name="ActionMainId"
										value="<%=Assignee[0] %>" /> <input type="hidden"
										name="ActionAssignId" value="<%=Assignee[18] %>" /> <input
										type="hidden" name="${_csrf.parameterName}"
										value="${_csrf.token}" /> <input type="hidden" name="flag"
										value="A"> <input type="hidden" name="ActionPath"
										value="<%=ActionPath%>">
								</div>
							</div>
						</form>

						<hr>
						<%-- <%} %> --%>
						<div style="padding: 5px;">
							<form enctype="multipart/form-data">
								<div align="center"></div>
								<div class="row">
									<div class="col-md-2 mt-2">
										<label>Progress Date :</label>
									</div>
									<div class="col-md-2 mt-2">
										<input class="form-control " name="progressDate"
											id="progressDate" readonly="readonly">
									</div>
									<div class="col-md-1 mt-2">
										<label>Progress:</label>
									</div>
									<div class="col-md-2 mt-2">
										<input class="form-control " name="Progress" id="Progress"
											oninput="this.value = this.value.replace(/[^0-9.]/g, '').replace(/(\..*?)\..*/g, '$1');">
									</div>
									<div class="col-md-1 mt-2">
										<label>Attachment:</label>
									</div>
									<div class="col-md-4 mt-2">
										<input type="file" class="form-control" id="Attachment"
											accept=".pdf, .jpg, .jpeg" onchange="validateFile()">

									</div>
								</div>
								<div class="row mt-2">
									<div class="col-md-2 ">
										<label>Remarks:</label>
									</div>
									<div class="col-md-8">
										<!-- <input class="form-control " name="remarks" id="remarks"
											maxlength="250" placeholder="Maximum 250 chcarcters"> -->
									<textarea rows="2" style="display: block; "
										class="form-control" id="remarks" name="Remarks"
										placeholder="Enter Remarks..!!"></textarea>
									</div>
									<div class="col-md-2">
										<button type="button" onclick="submitProgress()"
											class="btn btn-sm submit">SUBMIT</button>
									</div>
								</div>
							</form>
						</div>
					</div>
				</div>
				<%if(ActionPath!=null && ActionPath.equalsIgnoreCase("I")){%>
				<div align="center" style="padding-bottom: 15px;">
					<a class="btn btn-primary btn-sm back" href="ActionIssue.htm">BACK</a>
				</div>
				<%}else if(ActionPath!=null && ActionPath.equalsIgnoreCase("F")){%>
				<div align="center" style="padding-bottom: 15px;">
					<a class="btn btn-primary btn-sm back"
						href="ActionForwardList.htm?Type=A">BACK</a>
				</div>
				<%}else if(ActionPath!=null && ActionPath.equalsIgnoreCase("A")){%>
				<div align="center" style="padding-bottom: 15px;">
					<a class="btn btn-primary btn-sm back" href="ActionLaunch.htm">BACK</a>
				</div>
				<%}else if(ActionPath!=null && ActionPath.equalsIgnoreCase("C")){%>
				<div align="center" style="padding-bottom: 15px;">
					<a class="btn btn-primary btn-sm back" href="CARSMilestonesMonitorDetails.htm?carsInitiationId=<%=carsInitiationId%>&carsSoCMilestoneId=<%=carsSoCMilestoneId%>">BACK</a>
				</div>
				<%} %>
			</div>
			<div class="card-header"
				style="background-color: #055C9D; height: 50px;">
				<div class="row"></div>
			</div>
		</div>
	</div>
	<% if(SubList.size()>0){ %>
	<div class="row" style="margin: 10px;">
		<div class="col-md-12">
			<div class="card" style="">
				<div class="card-body">
					<div class="row">
						<div class="col-md-1"></div>
						<div class="col-md-10" style="padding-left: 0px">

							<div class="table-responsive">
								<table
									class="table table-bordered table-hover table-striped table-condensed"
									id="myTable3" style="margin-top: 20px;">
									<thead>
										<tr>
											<th colspan="7"
												style="background-color: #346691; color: white; text-align: center; font-size: 18px !important; border-left: 0px solid; text-transform: capitalize;">Action
												Updated Details</th>
										</tr>
										<tr>
											<th style="text-align: left; width: 10%">As On Date</th>
											<th style="width: 20%">Progress %</th>
											<th style="width: 30%">Remarks</th>
											<th style="width: 10%">Attachment</th>
											<th style="width: 20%">Progress By</th>
											<!-- <th style="">Action</th> -->
										</tr>
									</thead>
									<tbody>
										<%int  count=1;
										for(Object[] obj: SubList){ %>

										<tr>
											<td width="12%"><%=sdf.format(obj[3])%></td>
											<td width="6%">
												<div class="progress"
													style="background-color: #cdd0cb !important">
													<div class="progress-bar progress-bar-striped"
														role="progressbar" style="width: <%=obj[2]%>%;"
														aria-valuenow="25" aria-valuemin="0" aria-valuemax="100"><%=obj[2]%></div>
												</div>
											</td>
											<td style="text-align: left; width: 10%;"><%=obj[4]%></td>
											<td style="text-align: left; width: 3%;">
												<%if( obj[5]!=null){%>
												<div align="center">
													<a
														href="ActionDataAttachDownload.htm?ActionSubId=<%=obj[5]%>"
														target="_blank"><i class="fa fa-download"></i></a>
												</div> <%}else{%>
												<div align="center">-</div> <%}%>
											</td>
											<td><%=obj[7].toString() %>
											<%if(count==SubList.size()) {%>
											<%} %>
											</td>
										</tr>
										<% count++; } %>
									</tbody>
								</table>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
	<%}%>
<div class="modal fade bd-example-modal-lg" tabindex="-1" role="dialog" aria-labelledby="myLargeModalLabel" aria-hidden="true" id="EditModal">
  <div class="modal-dialog modal-lg">
    <div class="modal-content" style="padding:10px">
     <div class="modal-header">
        <h5 class="modal-title" id="exampleModalLabel">New message</h5>
        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
          <span aria-hidden="true">&times;</span>
        </button>
      </div>
      <div class="modal-body">
      						<div style="padding: 5px;">
							<form enctype="multipart/form-data">
								<div align="center"></div>
								<div class="row">
									<div class="col-md-2 mt-2">
									<label>Progress Date:</label>
									</div>
									<div class="col-md-4 mt-2">
										<input class="form-control " name="progressDate"
											id="" readonly="readonly">
									</div>
									<div class="col-md-2 mt-2">
										<label>Progress:</label>
									</div>
									<div class="col-md-4 mt-2">
										<input class="form-control " name="Progress" id=""
											oninput="this.value = this.value.replace(/[^0-9.]/g, '').replace(/(\..*?)\..*/g, '$1');">
									</div>
								</div>
								<div class="row mt-2">
									<div class="col-md-2 ">
										<label>Remarks:</label>
									</div>
									<div class="col-md-8">
										<!-- <input class="form-control " name="remarks" id="remarks"
											maxlength="250" placeholder="Maximum 250 chcarcters"> -->
									<textarea rows="2" style="display: block; "
										class="form-control" id="" name="Remarks"
										placeholder="Enter Remarks..!!"></textarea>
									</div>
								</div>
								<div class="row mt-2">
									<div class="col-md-2 mt-2">
										<label>Attachment:</label>
									</div>
									<div class="col-md-4 mt-2">
										<input type="file" class="form-control" id=""
											accept=".pdf, .jpg, .jpeg" onchange="validateFile()">

									</div>
								</div>
								
							</form>
						</div>
    </div>
  </div>
  </div>
</div>
	<!-- ------------------------------- tree script ------------------------------- -->
	<script type="text/javascript">
function close5(){
	
	var rem = $("#Remarks").val().trim();
	if(rem!="" && rem!="null" && rem!=null){
		$("#actionremarks").val(rem);
		if(confirm('Are You Sure to Close This Action ?')){
			return true;
		}else{
			return false;
		}
	}else{
		$('#ActionAssignfilemodal').modal('hide');
		alert("Please Enter the Remarks!");
		event.preventDefault;
		$("#Remarks").prop('required',true);
		return false;
	}
	
}
function CloseAction(assignid) {
	
	$('#ActionAssignfilemodal').modal('toggle');
}
$(function () {
    $('.genealogy-tree ul').hide();
    $('.genealogy-tree>ul').show();
    $('.genealogy-tree ul.active').show();
    $('.genealogy-tree li .action-box-body').on('click', function (e) {
		
        var children = $(this).parent().parent().parent().find('> ul');
        if (children.is(":visible")) children.hide('fast').removeClass('active');
        else children.show('fast').addClass('active');
        e.stopPropagation();
    });
});

<!-- ------------------------------- tree script ------------------------------- -->

	function ActionDetails(InAssignId,InActionItem,InActionNo,InProgress,InActionDate,InEndDate,InPDCOrg,
							InAssignor,InAssignee, InActionType	)
	{
		$("#modal_progress_table").DataTable().destroy();
		$.ajax({		
			type : "GET",
			url : "ActionSubListAjax.htm",
			data : {
				ActionAssignid : InAssignId
			},
			datatype : 'json',
			success : function(result) {
				var result = JSON.parse(result);
				
				$('#modal_action_no').html(InActionNo);
				$('#modal_action_item').html(InActionItem);
				$('#modal_action_date').html(InActionDate);
				$('#modal_action_PDC').html(InEndDate);
				$('#modal_action_assignor').html(InAssignor);
				$('#modal_action_assignee').html(InAssignee);
				
				var ActionType = 'Action';
				
				if(InActionType==='A')
				{
					ActionType = 'Action';
				}
				else if(InActionType==='I')
				{
					ActionType = 'Issue';
				}
				else if(InActionType==='D')
				{
					ActionType = 'Decision';
				}
				else if(InActionType==='R')
				{
					ActionType = 'Recommendation';
				}
				else if(InActionType==='C')
				{
					ActionType = 'Comment';
				}
				else if(InActionType==='K')
				{
					ActionType = 'Risk';
				}
				
				$('#modal_action_type').html(ActionType);
				
				if(InProgress.trim() === '0')
				{
					var progressBar ='<div class="progress" style="background-color:#cdd0cb !important;height: 1.5rem !important;">'; 
					progressBar += 		'<div class="progress-bar" role="progressbar" style=" width: 100%; background-color:#cdd0cb !important;color:black;font-weight: bold;  "  >';
					progressBar +=		'Not Started'
					progressBar +=		'</div>'; 
					progressBar += '</div>'; 
				}
				else
				{
					var progressBar ='<div class="progress" style="background-color:#cdd0cb !important;height:1.5rem !important; ">'; 
					progressBar += 		'<div class="progress-bar progress-bar-striped" role="progressbar" style=" width: '+InProgress+';  " aria-valuenow="25" aria-valuemin="0" aria-valuemax="100" >';
					progressBar +=		InProgress
					progressBar +=		'</div>'; 
					progressBar += '</div>'; 
				}
				$('#modal_action_progress').html(progressBar);
				
				var htmlStr='';
				if(result.length> 0){
					for(var v=0;v<result.length;v++)
					{	
						htmlStr += '<tr>';
						
						htmlStr += '<td class="tabledata" style="text-align: center;" >'+ (v+1) + '</td>';
						htmlStr += '<td class="tabledata" style="text-align: center;" >'+ moment(new Date(result[v][3]) ).format('DD-MM-YYYY') + '</td>';
						htmlStr += '<td class="tabledata" style="text-align: center;" >'+ result[v][2] + ' %</td>';
						htmlStr += '<td class="tabledata" >'+ result[v][4] + '</td>';
						
						if(result[v][5]=== null)
						{
							htmlStr += '<td class="tabledata" style="text-align: center;">-</td>';
						}
						else
						{
							htmlStr += '<td class="tabledata" style="text-align: center;"><button type="submit" class="btn btn-sm" name="ActionSubId" value="'+ result[v][5] + '" target="blank" formaction="ActionDataAttachDownload.htm" ><i class="fa fa-download"></i></button></td>';
						}
						htmlStr += '</tr>';
					}
				}
				else
				{
					htmlStr += '<tr>';
					
					htmlStr += '<td colspan="5" style="text-align: center;"> Progress Not Updated </td>';
					
					htmlStr += '</tr>';
				}
				setModalDataTable();
				$('#modal_progress_table_body').html(htmlStr);
				
				
				$('#action_modal').modal('toggle');
			}
		});
		
		
	}
	setModalDataTable();
	function setModalDataTable()
	{
		$("#modal_progress_table").DataTable({
			"lengthMenu": [ 5, 10,25, 50, 75, 100 ],
			"pagingType": "simple",
			"pageLength": 5
		});
	}
</script>


	<script>
var from ="<%=sdf.format(Assignee[4])%>".split("-");
var dt = new Date(from[2], from[1] - 1, from[0]);
	$('#DateCompletion').daterangepicker({
			"singleDatePicker" : true,
			"linkedCalendars" : false,
			"showCustomRangeLabel" : true,
			"minDate" : dt,
			"cancelClass" : "btn-default",
			showDropdowns : true,
			locale : {
				format : 'DD-MM-YYYY'
			}
		});
	
	$('#progressDate').daterangepicker({
		"singleDatePicker" : true,
		"linkedCalendars" : false,
		"showCustomRangeLabel" : true,
		"maxDate" : new Date(),
		"cancelClass" : "btn-default",
		showDropdowns : true,
		locale : {
			format : 'DD-MM-YYYY'
		}
	});
	$( document ).ready(function() {
		 AssigneeEmpListForEdit(0);
	});
	
	
		function AssigneeEmpListForEdit(empid){
	 	var $AssigneeLabCode =  $('#modelAssigneelabcode').val(); 
		console.log($AssigneeLabCode)
	 	if($AssigneeLabCode!=""){
	 		
	 		$.ajax({
	 			
	 			type : "GET",
	 			url : "ActionAssigneeEmployeeList.htm",
	 			data : {
	 				LabCode : $AssigneeLabCode,	
	 			},
	 			datatype : 'json',
	 			success : function(result) {
	 				var result = JSON.parse(result);
	 				var values = Object.keys(result).map(function(e) {
	 					return result[e]
	 				});
	 				
	 				var s = '';
	 				s += '<option value="">Choose ...</option>';
	 				if($AssigneeLabCode == '@EXP'){
	 					
	 				}
	 				for (i = 0; i < values.length; i++) 
	 				{

	 					s += '<option value="'+values[i][0]+'">'+values[i][1] + ', ' +values[i][3] + '</option>';
	 				} 
	 				
	 				$('#modalassignee').html(s);
	 				$('#modalassignee').val(''+empid).trigger('change');
	 			}
	 		});
	 		
	 	}
	 }	
		
		function reassign(){
			
			var modalassignee=$('#modalassignee').val();
			if(modalassignee!==null ){
				if(confirm('Are you sure to reassign this action?')){
					
				}else{
					event.preventDefault();
					return false;
				}
			}else{
				alert("Please select an employee")
				return false;
			}
			
		}
</script>
	<script>
    function validateFile() {
        var fileInput = document.getElementById('Attachment');
        var fileSize = fileInput.files[0].size; // in bytes

        // Check if the file size is greater than 5MB (in bytes)
        if (fileSize > 5 * 1024 * 1024) {
            alert('File size exceeds 5MB. Please choose a smaller file.');
            fileInput.value = ''; // Clear the file input
        }
    }
    
    
    function submitProgress(){
    	
    	 var Progress=Number($('#Progress').val());
    	 var ActionAssignId = <%=ActionAssignId%>;
    	 var file= $("#Attachment")[0].files[0];
    	 console.log(ActionAssignId)
    	 var formData = new FormData();
            formData.append("file", $("#Attachment")[0].files[0]);
            formData.append("progressDate", $("#progressDate").val());
            formData.append("Progress",Progress);
            formData.append("remarks",$('#remarks').val());
            formData.append("ActionAssignId",ActionAssignId);
            formData.append("${_csrf.parameterName}", "${_csrf.token}");
    	if(Progress==0){
    		Swal.fire({
    			  icon: "error",
    			  text: "Please give some progress",
    			 
    			});
    		/* alert("Please give some progress"); */
    	}else if (Progress>100){
    		Swal.fire({
  			  icon: "warning",
  			  text: "Progrss should not be more than 100 !",
  			 
  			});
    		/* alert("progress can not be more than 100"); */
    	}
    	else{
    		if(confirm('Are you sure to submit progress?')){
    			$.ajax({
    				type:'POST',
    				url:'ActionProgressAjaxSubmit.htm',
    				 data: formData,
    	                contentType: false,
    	                processData: false,
    	                success:function(result){
    	               
		    	        Swal.fire({
		    	       	title: "Success",
		                text: "Progress Updated Successfully.",
		                icon: "success",
		                allowOutsideClick :false
		         		});
		    	        $('.swal2-confirm').click(function (){
		    	        	console.log("hiiii")
		    	            location.reload();
		    	        	})
    	                }
    			
    			})
    			
    		}else{
    			event.preventDefault();
    			return false;
    		}
    	}
    }
    
    
    
    function showModal(){
    	$('#EditModal').modal('show');
    }
    
    $('.swal2-confirm').click(function (){
    	console.log("hiiii")
        location.reload();
    	})
</script>

</body>
</html>