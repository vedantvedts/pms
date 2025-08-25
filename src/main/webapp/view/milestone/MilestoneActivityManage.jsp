<%@page import="org.apache.commons.text.StringEscapeUtils"%>
<%@page import="com.ibm.icu.text.DecimalFormat"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"
	import="java.util.*,com.vts.*,java.text.SimpleDateFormat,java.io.ByteArrayOutputStream,java.io.ObjectOutputStream"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<jsp:include page="../static/header.jsp"></jsp:include>
<spring:url value="/resources/css/sweetalert2.min.css"
	var="sweetalertCss" />
<spring:url value="/resources/js/sweetalert2.min.js" var="sweetalertJs" />
<link href="${sweetalertCss}" rel="stylesheet" />
<script src="${sweetalertJs}"></script>


<title>Milestone List</title>
<style type="text/css">
label {
	font-weight: bold;
	font-size: 14px;
}

.table thead tr, tbody tr {
	font-size: 14px;
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

/*  #swal2-title , #swal2-html-container{
display:none !important;
}

.swal2-popup{
background: none !important;
}  */
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
	width: 120px;
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
	width: 210px !important;
}

.bootstrap-select {
	width: 400px !important;
}

input[type=checkbox] {
	accent-color: green;
}
</style>
</head>

<body>
	<%
  
  String projectshortName="";
  

  List<Object[]> MilestoneList=(List<Object[]>)request.getAttribute("MilestoneActivityList");
  List<Object[]> ProjectList=(List<Object[]>)request.getAttribute("ProjectList");
  SimpleDateFormat sdf=new SimpleDateFormat("dd-MM-yyyy");
  SimpleDateFormat sdf1=new SimpleDateFormat("yyyy-MM-dd");
  String ProjectId=(String)request.getAttribute("ProjectId");
  String LoginType = (String)session.getAttribute("LoginType");
  List<String> actionAllowedFor =  Arrays.asList("A", "P");
  Long projectDirector = 0L;
  String selectedProject = "";
  Long empId = (Long)session.getAttribute("EmpId");
  

 %>

	<form class="form-inline" method="POST"
		action="MilestoneActivityManage.htm">
		<div class="row W-100" style="width: 100%;">


			<div class="col-md-10" style="display: flex;justify-content: flex-end;">
				<label class="control-label">Project Name :</label>
			</div>
			<div class="col-md-2" style="margin-top: -7px;">
				<select class="form-control selectdee" id="ProjectId"
					required="required" name="ProjectId">
					<option disabled="true" selected value="">Choose...</option>
					<% for (Object[] obj : ProjectList) {
    										 projectshortName=(obj[17]!=null)?" ("+obj[17].toString()+") ":"";
    										%>
					<option value="<%=obj[0]%>"
						<%if(obj[0].toString().equalsIgnoreCase(ProjectId)){ %>
						selected="selected"
						<%projectDirector = Long.parseLong(obj[23].toString());selectedProject=projectshortName; %>
						<%} %>>
						<%=obj[4]!=null?StringEscapeUtils.escapeHtml4(obj[4].toString()): " - "%> <%=projectshortName!=null?StringEscapeUtils.escapeHtml4(projectshortName): " - "%>
					</option>
					<%} %>
				</select>
			</div>
			<input type="hidden" name="${_csrf.parameterName}"
				value="${_csrf.token}" /> <input id="submit" type="submit"
				name="submit" value="Submit" hidden="hidden">
		</div>
	</form>

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
				<div class="card shadow-nohover" style="margin-top: -0px;">
					<div class="row card-header">
						<div class="col-md-10">
							<h5>
								<%if(ProjectId!=null){
						Object[] ProjectDetail=(Object[])request.getAttribute("ProjectDetails");
						%>
								<%=ProjectDetail[2]!=null?StringEscapeUtils.escapeHtml4(ProjectDetail[2].toString()): "" %>
								(
								<%=ProjectDetail[1]!=null?StringEscapeUtils.escapeHtml4(ProjectDetail[1].toString()): "" %>
								)
								<%} %>
								Milestone List
							</h5>
						</div>
					</div>

					<div class="card-body">
						<div class="table-responsive">
							<table class="table  table-hover table-bordered">
								<thead class="center">

									<tr>
										<th colspan="2">Expand</th>

										<th>Mil-No</th>
										<!-- 	<th style="text-align: left;">Project Name</th> -->
										<th>Milestone Activity</th>
										<th>Start Date</th>
										<th>End Date</th>
										<th style="padding: 0px !important">
											<div style="border-bottom: 1px solid #dee2e6;">First
												OIC</div> Second OIC
										</th>
										<th>Status</th>
										<th>Weightage</th>
										<th>Progress</th>
										<%-- <%if(actionAllowedFor.contains(LoginType) || projectDirector.equals(empId) || oicEmpId.equals(empId)) {%>	 --%>
										<th>Action</th>
										<%-- <%} %> --%>

									</tr>
								</thead>
								<tbody>
									<%int  count=1;
															
														 	if(MilestoneList!=null&&MilestoneList.size()>0){
															for(Object[] obj: MilestoneList){ %>
									<tr>
										<td style="width: 2% !important;" class="center" colspan="2">
											<span class="clickable" data-toggle="collapse"
											id="row<%=obj[0] %>" data-target=".row<%=obj[0]  %>">
												<button class="btn btn-sm btn-success" id="btn<%=obj[0]  %>"
													onclick="ChangeButton('<%=obj[0]  %>')">
													<i class="fa fa-plus" id="fa<%=obj[0] %>"></i>
												</button>
										</span> <input type="hidden" id="financialOutlay_<%=obj[0]%>"
											value="<%=obj[18]!=null?obj[18]:"-"%>"> <input
											type="hidden" id="statusRemarks_<%=obj[0]%>"
											value="<%=obj[11]!=null?obj[11].toString().replaceAll("'", "\\\\'").replaceAll("\"", "\\\\\"").replaceAll("\n", "<br>").replaceAll("\r", ""):"-"%>">
										</td>

										<td style="text-align: left; width: 5%;">Mil-<%=obj[5]!=null?StringEscapeUtils.escapeHtml4(obj[5].toString()): " - "%></td>
										<%-- <td class="width-30px"><%=obj[1]%></td> --%>
										<td
											style="overflow-wrap: break-word !important; word-break: break-all !important; white-space: normal !important; max-width: 20% !important; min-width: 20% !important; cursor: pointer;"
											onclick="showMilestoneStatusProgress('<%=obj[0]%>')"><%=obj[4]!=null?StringEscapeUtils.escapeHtml4(obj[4].toString()): " - " %>
										</td>

										<td style="width: 8% !important;"><%=sdf.format(StringEscapeUtils.escapeHtml4(obj[2].toString()))%></td>
										<td style="width: 8% !important;"><%=sdf.format(StringEscapeUtils.escapeHtml4(obj[3].toString()))%></td>
										<td style="width: 15% !important;"><%=obj[6]!=null?StringEscapeUtils.escapeHtml4(obj[6].toString()): " - "%> <br>
											<%=obj[7]!=null?StringEscapeUtils.escapeHtml4(obj[7].toString()): " - "%></td>
										<td style="width: 8% !important;">-</td>
										<td style="width: 7% !important;" align="center"><%=obj[13]!=null?StringEscapeUtils.escapeHtml4(obj[13].toString()): " - "%></td>
										<td>
											<%if(!obj[12].toString().equalsIgnoreCase("0")){ %>
											<div class="progress"
												style="background-color: #cdd0cb !important; height: 1.4rem !important;">
												<div
													class="progress-bar progress-bar-striped
																<%if(obj[14].toString().equalsIgnoreCase("2")){ %>
																 bg-success
																<%} else if(obj[14].toString().equalsIgnoreCase("3")){ %>
																  bg-info
																<%} else if(obj[14].toString().equalsIgnoreCase("4")){ %>
																  bg-danger
																<%} else if(obj[14].toString().equalsIgnoreCase("5")){ %>
																  bg-warning
																<%}  %>
																"
													role="progressbar" style=" width: <%=obj[12] %>%;  "
													aria-valuenow="25" aria-valuemin="0" aria-valuemax="100">
													<%=obj[12]!=null?StringEscapeUtils.escapeHtml4(obj[12].toString()): " - " %>
												</div>
											</div> <%}else{ %>
											<div class="progress"
												style="background-color: #cdd0cb !important; height: 1.4rem !important;">
												<div class="progress-bar" role="progressbar"
													style="width: 100%; background-color: #cdd0cb !important; color: black; font-weight: bold;">
													Not Started</div>
											</div> <%} %>
										</td>
										<td style="width: 20% !important; text-align: center;"></td>
										<%-- <%} else {%>
																<td class="center"> <span class="btn btn-sm btn-info">Access Denied</span> </td>
															<%} %> --%>
									</tr>
									<tr class="collapse row<%=obj[0]%> trclass<%=obj[0]%>"
										style="font-weight: bold;">
										<td></td>
										<td></td>
										<td>Sub</td>
										<td>Activity</td>
										<td>Start Date</td>
										<td>End Date</td>
										<th style="padding: 0px !important; text-align: center;">
										 First OIC</th>
										<td>Date Of Completion</td>
										<td>Sub Weightage</td>
										<td>Sub Progress</td>
										<%if(actionAllowedFor.contains(LoginType)) { %>
										<td><!-- Shown in display of Briefing Paper and MOM --></td>
										<%} %>
									</tr>
									<%
                                                         List<String>empList = new ArrayList<>();
                                                         int countA=1;
                                                            List<Object[]> MilestoneA=(List<Object[]>)request.getAttribute(count+"MilestoneActivityA");
														 	if(MilestoneA!=null&&MilestoneA.size()>0){
															for(Object[] objA: MilestoneA){
																//check if empList contains first OIC of A level 
																if(!empList.contains(objA[13].toString() )){
																empList.add(objA[13].toString());
																}
																//check if empList contains first 2ndIC of A level 
																if(!empList.contains(objA[15].toString() )){
																	empList.add(objA[15].toString());
																	}
	                                                            List<Object[]> MilestoneB=(List<Object[]>)request.getAttribute(count+"MilestoneActivityB"+countA);
	
																%>

									<tr class="collapse row<%=obj[0]  %> trclass<%=obj[0]%>">

										<td style="width: 2% !important;" class="center">
											<%if(((empId.toString().equalsIgnoreCase(projectDirector+"")) || LoginType.equalsIgnoreCase("A")) && objA[5].toString().equalsIgnoreCase("0") && objA[24].toString().equalsIgnoreCase("0")  ) {%>

											<button
												class="btn btn-sm class_<%=obj[0].toString()%> class<%=objA[0]%>"
												type="button" data-toggle="tooltip" data-placement="top"
												data-original-data="" title="Delete Milestone"
												onclick="deleteSubMilestone('<%=objA[0]%>', '<%=ProjectId %>')"
												value="<%=objA[0]%>">
												<i class="fa fa-trash-o" aria-hidden="true"></i>
											</button> <%} %>


										</td>
										<td class="center">
											<%if(MilestoneB!=null && MilestoneB.size()>0) { %> <span
											class="clickable" data-toggle="collapse"
											id="row_<%=objA[0] %>" data-target=".row_<%=objA[0]  %>">
												<button class="btn btn-sm btn-success"
													id="btn<%=objA[0]  %>"
													onclick="ChangeButton('<%=objA[0]  %>')">
													<i class="fa fa-plus" id="fa<%=objA[0] %>"></i>
												</button>
										</span> <%}else{ %> <%if(!objA[24].toString().equalsIgnoreCase("0")  ){ %>
											<%if((empId.toString().equalsIgnoreCase(projectDirector+"")) || LoginType.equalsIgnoreCase("A")) {%>
											<button type="button" class="btn btn-sm btn-success"
												data-toggle="tooltip" data-placement="top"
												data-original-data="" title="Linked Milestone"
												onclick="supersedingMilestone('<%=objA[0] %>','<%=objA[4] %>', 'M<%=obj[5]%>-A<%=countA%>' , '<%=objA[24].toString()%>' )">
												<i class="fa fa-link " style="color: white"
													aria-hidden="true"></i>
											</button> <%} %> <%}else{ %> <%if((empId.toString().equalsIgnoreCase(projectDirector+"")) || LoginType.equalsIgnoreCase("A")) {%>
											<button type="button" class="btn btn-sm btn-primary"
												data-toggle="tooltip" data-placement="top"
												data-original-data="" title="Link Milestone"
												onclick="supersedingMilestone('<%=objA[0] %>','<%=objA[4] %>', 'M<%=obj[5]%>-A<%=countA%>' , '<%=objA[24].toString()%>' )">
												<i class="fa fa-link " style="color: white"
													aria-hidden="true"></i>
											</button> <%} %> <%} %> <%} %>
										</td>
										<td style="text-align: left; width: 5%;">A-<%=countA%></td>
										<%-- <td class="width-30px"><%=obj[1]%></td> --%>
										<td
											style="overflow-wrap: break-word !important; word-break: break-all !important; white-space: normal !important; max-width: 20% !important; min-width: 20% !important; cursor: pointer;">
											<%=objA[4]!=null?StringEscapeUtils.escapeHtml4(objA[4].toString()): " - " %>
										</td>

										<td class="width-30px"><%=sdf.format(StringEscapeUtils.escapeHtml4(objA[2].toString()))%></td>
										<td style="width: 8% !important;"><%=sdf.format(StringEscapeUtils.escapeHtml4(objA[3].toString()))%></td>
										<td><%=objA[14]!=null?StringEscapeUtils.escapeHtml4(objA[14].toString()): " - "%></td>
										<td class="width-30px">
											<%if(objA[9].toString().equalsIgnoreCase("3")||objA[9].toString().equalsIgnoreCase("5")){ %>
											<%if(objA[7]!=null){ %> <%=sdf.format(StringEscapeUtils.escapeHtml4(objA[7].toString())) %> <%}else{ %><%=objA[8]!=null?StringEscapeUtils.escapeHtml4(objA[8].toString()): " - " %>
											<%} %> <%}else{ %> <%=objA[8]!=null?StringEscapeUtils.escapeHtml4(objA[8].toString()): " - " %> <%} %>
										</td>
										<td align="center"><%=objA[6]!=null?StringEscapeUtils.escapeHtml4(objA[6].toString()): " - " %></td>
										<td>
											<%if(!objA[5].toString().equalsIgnoreCase("0")){ %>
											<div class="progress"
												style="background-color: #cdd0cb !important; height: 1.4rem !important;">
												<div
													class="progress-bar progress-bar-striped
															<%if(objA[9].toString().equalsIgnoreCase("2")){ %>
															 bg-success
															<%} else if(objA[9].toString().equalsIgnoreCase("3")){ %>
															  bg-info
															<%} else if(objA[9].toString().equalsIgnoreCase("4")){ %>
															  bg-danger
															<%} else if(objA[9].toString().equalsIgnoreCase("5")){ %>
															  bg-warning
															<%}  %>
															"
													role="progressbar" style=" width: <%=objA[5] %>%;  "
													aria-valuenow="25" aria-valuemin="0" aria-valuemax="100">
													<%=objA[5]!=null?StringEscapeUtils.escapeHtml4(objA[5].toString()): " - " %>
												</div>
											</div> <%}else{ %>
											<div class="progress"
												style="background-color: #cdd0cb !important; height: 1.4rem !important;">
												<div class="progress-bar" role="progressbar"
													style="width: 100%; background-color: #cdd0cb !important; color: black; font-weight: bold;">
													Not Started</div>
											</div> <%} %>
										</td>

										<td>

											<button type="button" class="btn btn-lg" style="color: green" data-toggle="tooltip" data-placement="top"
												data-original-data="" title="Linked Predecessor"  onclick="linkPredecessor('<%=objA[0] %>','<%=objA[4] %>', 'M<%=obj[5]%>-A<%=countA%>' , '<%=objA[24].toString()%>' )">
										<i class="fa fa-angle-left" aria-hidden="true"></i>-<i class="fa fa-angle-right" aria-hidden="true"></i>
											</button>
											<div id="MIL_<%=objA[0] %>">
											
											</div>
											<script>
											$(document).ready(function() {
												$.ajax({
													type:'GET',
													url:'getProjectMilestones.htm',
													datatype:'json',
													data:{
														projectid:<%=ProjectId%>,
													},
													success:function (result){
														var data = JSON.parse(result);
														console.log(data)
										
													
														
														
														  $.ajax({
															  type:'GET',
															  url:'predecessorList.htm',
															  datatype:'json',
															  data:{
																  successor:'<%=objA[0]!=null?StringEscapeUtils.escapeHtml4(objA[0].toString()): ""%>',
															  },
															  success:function(result){
																  var ajaxresult = JSON.parse(result);
																  console.log(ajaxresult);
																	
																  var html="";
																  for(var i=0;i<ajaxresult.length;i++){
																	  for (var key in data) {
																		 
																		  if(key.split("/")[1]===ajaxresult[i]){
																			 var val = data[key];
																			 html = html+"<div class='text-primary'> "+val[4]+ " (" + key.split("/")[0]+ ") </div>"
																		  }
																		  
																		}
																  }
																  var id = 'MIL_<%=objA[0]!=null?StringEscapeUtils.escapeHtml4(objA[0].toString()): ""%>';
																  $('#'+id).html(html) 
															  }
															  
														  }) 
														  
														
												        
													}
												})
											});
											</script>
										</td>
									</tr>

									<% int countB=1;
														 	if(MilestoneB!=null&&MilestoneB.size()>0){
															for(Object[] objB: MilestoneB){
																
																//check if empList contains first OIC of B level 
																if(!empList.contains(objB[13].toString() )){
																empList.add(objB[13].toString());
																}
																//check if empList contains first 2ndIC of B level 
																if(!empList.contains(objB[15].toString() )){
																	empList.add(objB[15].toString());
																	}
	                                                            List<Object[]> MilestoneC=(List<Object[]>)request.getAttribute(count+"MilestoneActivityC"+countA+countB);
	
																%>
									<tr
										class="collapse row_<%=objA[0]  %> trclass<%=obj[0]%> trclass<%=objA[0]%>">
										<td style="width: 2% !important;" class="center">
											<%if(((empId.toString().equalsIgnoreCase(projectDirector+"")) || LoginType.equalsIgnoreCase("A")) && objB[5].toString().equalsIgnoreCase("0") && objB[24].toString().equalsIgnoreCase("0") ) {%>
											<button
												class="btn btn-sm class_<%=obj[0].toString()%> class<%=objA[0]%> class<%=objB[0]%>"
												value="<%=objB[0] %>" type="button" data-toggle="tooltip"
												data-placement="top" data-original-data=""
												title="Delete Milestone"
												onclick="deleteSubMilestone('<%=objB[0]%>', '<%=ProjectId %>')">
												<i class="fa fa-trash-o" aria-hidden="true"></i>
											</button> <%} %>


										</td>
										<td class="center">
											<%if(MilestoneC!=null && MilestoneC.size()>0) {%> <span
											class="clickable" data-toggle="collapse"
											id="row_<%=objB[0] %>" data-target=".row_<%=objB[0]  %>">
												<button class="btn btn-sm btn-success"
													id="btn<%=objB[0]  %>"
													onclick="ChangeButton('<%=objB[0]  %>')">
													<i class="fa fa-plus" id="fa<%=objB[0] %>"></i>
												</button>
										</span> <%}else{ %> <%if(!objB[24].toString().equalsIgnoreCase("0") ){ %>
											<%if((empId.toString().equalsIgnoreCase(projectDirector+"")) || LoginType.equalsIgnoreCase("A")) {%>
											<button type="button" data-toggle="tooltip"
												data-placement="top" data-original-data=""
												title="Linked Milestone" class="btn btn-sm btn-success"
												onclick="supersedingMilestone('<%=objB[0] %>','<%=objB[4] %>', 'M<%=obj[5]%>-A<%=countA%>-B<%=countB%>' , '<%=objB[24].toString()%>' )">
												<i class="fa fa-link " style="color: white"
													aria-hidden="true"></i>
											</button> <%} %> <%}else{%> <%if((empId.toString().equalsIgnoreCase(projectDirector+"")) || LoginType.equalsIgnoreCase("A")) {%>
											<button type="button" data-toggle="tooltip"
												data-placement="top" data-original-data=""
												title="Link Milestone" class="btn btn-sm btn-primary"
												onclick="supersedingMilestone('<%=objB[0] %>','<%=objB[4] %>', 'M<%=obj[5]%>-A<%=countA%>-B<%=countB%>' , '<%=objB[24].toString()%>' )">
												<i class="fa fa-link " style="color: white"
													aria-hidden="true"></i>
											</button> <%} %> <%}} %>
										</td>
										<td style="text-align: left; width: 5%;">
											&nbsp;&nbsp;&nbsp;B-<%=countB%></td>
										<%-- <td class="width-30px"><%=obj[1]%></td> --%>
										<td
											style="overflow-wrap: break-word !important; word-break: break-all !important; white-space: normal !important; max-width: 20% !important; min-width: 20% !important; cursor: pointer;">
											<%=objB[4]!=null?StringEscapeUtils.escapeHtml4(objB[4].toString()): " - " %>
										</td>

										<td class="width-30px"><%=sdf.format(StringEscapeUtils.escapeHtml4(objB[2].toString()))%></td>
										<td style="width: 8% !important;"><%=sdf.format(StringEscapeUtils.escapeHtml4(objB[3].toString()))%></td>
										<td><%=objB[14]!=null?StringEscapeUtils.escapeHtml4(objB[14].toString()): " - "%></td>
										<td class="width-30px">
											<%if(objB[9].toString().equalsIgnoreCase("3")||objB[9].toString().equalsIgnoreCase("5")){ %>
											<%if(objB[7]!=null){ %> <%=sdf.format(objB[7]) %> <%}else{ %><%=objB[8]!=null?StringEscapeUtils.escapeHtml4(objB[8].toString()): " - " %>
											<%} %> <%}else{ %> <%=objB[8]!=null?StringEscapeUtils.escapeHtml4(objB[8].toString()): " - " %> <%} %>
										</td>
										<td align="center"><%=objB[6]!=null?StringEscapeUtils.escapeHtml4(objB[6].toString()): " - " %></td>
										<td>
											<%if(!objB[5].toString().equalsIgnoreCase("0")){ %>
											<div class="progress"
												style="background-color: #cdd0cb !important; height: 1.4rem !important;">
												<div
													class="progress-bar progress-bar-striped
															<%if(objB[9].toString().equalsIgnoreCase("2")){ %>
															 bg-success
															<%} else if(objB[9].toString().equalsIgnoreCase("3")){ %>
															  bg-info
															<%} else if(objB[9].toString().equalsIgnoreCase("4")){ %>
															  bg-danger
															<%} else if(objB[9].toString().equalsIgnoreCase("5")){ %>
															  bg-warning
															<%}  %>
															"
													role="progressbar" style=" width: <%=objB[5] %>%;  "
													aria-valuenow="25" aria-valuemin="0" aria-valuemax="100">
													<%=objB[5]!=null?StringEscapeUtils.escapeHtml4(objB[5].toString()): " - " %>
												</div>
											</div> <%}else{ %>
											<div class="progress"
												style="background-color: #cdd0cb !important; height: 1.4rem !important;">
												<div class="progress-bar" role="progressbar"
													style="width: 100%; background-color: #cdd0cb !important; color: black; font-weight: bold;">
													Not Started</div>
											</div> <%} %>
										</td>
										<td>
												<button type="button" class="btn btn-lg" style="color: green" data-toggle="tooltip" data-placement="top"
												data-original-data="" title="Linked Predecessor"  onclick="linkPredecessor('<%=objB[0] %>','<%=objB[4] %>', 'M<%=obj[5]%>-A<%=countA%>-B<%=countB%>' , '<%=objB[24].toString()%>' )">
										<i class="fa fa-angle-left" aria-hidden="true"></i>-<i class="fa fa-angle-right" aria-hidden="true"></i>
											</button>
										<div id="MIL_<%=objB[0] %>">
											
											</div>
											<script>
											$(document).ready(function() {
												$.ajax({
													type:'GET',
													url:'getProjectMilestones.htm',
													datatype:'json',
													data:{
														projectid:<%=ProjectId%>,
													},
													success:function (result){
														var data = JSON.parse(result);
														console.log(data)
										
													
														
														
														  $.ajax({
															  type:'GET',
															  url:'predecessorList.htm',
															  datatype:'json',
															  data:{
																  successor:'<%=objB[0]!=null?StringEscapeUtils.escapeHtml4(objB[0].toString()): ""%>',
															  },
															  success:function(result){
																  var ajaxresult = JSON.parse(result);
																  console.log(ajaxresult);
																	
																  var html="";
																  for(var i=0;i<ajaxresult.length;i++){
																	  for (var key in data) {
																		 
																		  if(key.split("/")[1]===ajaxresult[i]){
																			 var val = data[key];
																			 html = html+"<div class='text-primary'> "+val[4]+ " (" + key.split("/")[0]+ ") </div>"
																		  }
																		  
																		}
																  }
																  var id = 'MIL_<%=objB[0]!=null?StringEscapeUtils.escapeHtml4(objB[0].toString()): ""%>';
																  $('#'+id).html(html) 
															  }
															  
														  }) 
														  
														
												        
													}
												})
											});
											</script>
										</td>
										
										
									</tr>
									<% int countC=1;
														 	if(MilestoneC!=null&&MilestoneC.size()>0){
															for(Object[] objC: MilestoneC){
																
																//check if empList contains first OIC of C level 
																if(!empList.contains(objC[13].toString() )){
																empList.add(objC[13].toString());
																}
																//check if empList contains first 2ndIC of C level 
																if(!empList.contains(objC[15].toString() )){
																	empList.add(objC[15].toString());
																	}
													         List<Object[]> MilestoneD=(List<Object[]>)request.getAttribute(count+"MilestoneActivityD"+countA+countB+countC);
																%>
									<tr
										class="collapse row_<%=objB[0] %> trclass<%=obj[0]%> trclass<%=objA[0]%> trclass<%=objB[0]%>">
										<td style="width: 2% !important;" class="center">
											<%if(((empId.toString().equalsIgnoreCase(projectDirector+"")) || LoginType.equalsIgnoreCase("A")) && objC[5].toString().equalsIgnoreCase("0") && objC[24].toString().equalsIgnoreCase("0")  ) {%>
											<button
												class="btn btn-sm class_<%=obj[0].toString()%> class<%=objA[0]%> class<%=objB[0]%> class<%=objC[0] %>"
												value="<%=objC[0] %>" type="button" data-toggle="tooltip"
												data-placement="top" data-original-data=""
												title="Delete Milestone"
												onclick="deleteSubMilestone('<%=objC[0]%>', '<%=ProjectId %>')">
												<i class="fa fa-trash-o" aria-hidden="true"></i>
											</button> <%} %>

										</td>
										<td class="center">
											<%if(MilestoneD!=null && MilestoneD.size()>0) {%> <span
											class="clickable" data-toggle="collapse"
											id="row_<%=objC[0] %>" data-target=".row_<%=objC[0]  %>">
												<button class="btn btn-sm btn-success"
													id="btn<%=objC[0]  %>"
													onclick="ChangeButton('<%=objC[0]  %>')">
													<i class="fa fa-plus" id="fa<%=objC[0] %>"></i>
												</button>
										</span> <%}else{ %> <%if(!objC[24].toString().equalsIgnoreCase("0") ){ %>
											<%if((empId.toString().equalsIgnoreCase(projectDirector+"")) || LoginType.equalsIgnoreCase("A")) {%>
											<button type="button" data-toggle="tooltip"
												data-placement="top" data-original-data=""
												title="Linked Milestone" class="btn btn-sm btn-success"
												onclick="supersedingMilestone('<%=objC[0] %>','<%=objC[4] %>', 'M<%=obj[5]%>-A<%=countA%>-B<%=countB%>-C<%=countC%>' , '<%=objC[24].toString()%>' )">
												<i class="fa fa-link " style="color: white"
													aria-hidden="true"></i>
											</button> <%} %> <%}else{%> <%if((empId.toString().equalsIgnoreCase(projectDirector+"")) || LoginType.equalsIgnoreCase("A")) {%>
											<button type="button" data-toggle="tooltip"
												data-placement="top" data-original-data=""
												title="Link Milestone" class="btn btn-sm btn-primary"
												onclick="supersedingMilestone('<%=objC[0] %>','<%=objC[4] %>', 'M<%=obj[5]%>-A<%=countA%>-B<%=countB%>-C<%=countC%>' , '<%=objC[24].toString()%>' )">
												<i class="fa fa-link " style="color: white"
													aria-hidden="true"></i>
											</button> <%} %> <% }} %>
										</td>
										<td style="text-align: left; width: 5%;">
											&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;C-<%=countC%></td>
										<%-- <td class="width-30px"><%=obj[1]%></td> --%>
										<td
											style="overflow-wrap: break-word !important; word-break: break-all !important; white-space: normal !important; max-width: 20% !important; min-width: 20% !important; cursor: pointer;">
											<%=objC[4]!=null?StringEscapeUtils.escapeHtml4(objC[4].toString()): " - " %>
										</td>

										<td class="width-30px"><%=sdf.format(StringEscapeUtils.escapeHtml4(objC[2].toString()))%></td>
										<td style="width: 8% !important;"><%=sdf.format(StringEscapeUtils.escapeHtml4(objC[3].toString()))%></td>
										<td><%=objC[14]!=null?StringEscapeUtils.escapeHtml4(objC[14].toString()): " - " %></td>
										<td class="width-30px">
											<%if(objC[9].toString().equalsIgnoreCase("3")||objC[9].toString().equalsIgnoreCase("5")){ %>
											<%if(objC[7]!=null){ %> <%=sdf.format(objC[7]) %> <%}else{ %><%=objC[8]!=null?StringEscapeUtils.escapeHtml4(objC[8].toString()): " - "  %>
											<%} %> <%}else{ %> <%=objC[8]!=null?StringEscapeUtils.escapeHtml4(objC[8].toString()): " - "  %> <%} %>
										</td>
										<td align="center"><%=objC[6]!=null?StringEscapeUtils.escapeHtml4(objC[6].toString()): " - "  %></td>
										<td>
											<%if(!objC[5].toString().equalsIgnoreCase("0")){ %>
											<div class="progress"
												style="background-color: #cdd0cb !important; height: 1.4rem !important;">
												<div
													class="progress-bar progress-bar-striped
																	<%if(objC[9].toString().equalsIgnoreCase("2")){ %>
																	 bg-success
																	<%} else if(objC[9].toString().equalsIgnoreCase("3")){ %>
																	  bg-info
																	<%} else if(objC[9].toString().equalsIgnoreCase("4")){ %>
																	  bg-danger
																	<%} else if(objC[9].toString().equalsIgnoreCase("5")){ %>
																	  bg-warning
																	<%}  %>
																	"
													role="progressbar" style=" width: <%=objC[5] %>%;  "
													aria-valuenow="25" aria-valuemin="0" aria-valuemax="100">
													<%=objC[5]!=null?StringEscapeUtils.escapeHtml4(objC[5].toString()): " - "  %>
												</div>
											</div> <%}else{ %>
											<div class="progress"
												style="background-color: #cdd0cb !important; height: 1.4rem !important;">
												<div class="progress-bar" role="progressbar"
													style="width: 100%; background-color: #cdd0cb !important; color: black; font-weight: bold;">
													Not Started</div>
											</div> <%} %>
										</td>
										<td>
										
											<button type="button" class="btn btn-lg" style="color: green" data-toggle="tooltip" data-placement="top"
												data-original-data="" title="Linked Predecessor"  onclick="linkPredecessor('<%=objC[0] %>','<%=objC[4] %>', 'M<%=obj[5]%>-A<%=countA%>-B<%=countB%>-C<%=countC%>' , '<%=objC[24].toString()%>' )">
										<i class="fa fa-angle-left" aria-hidden="true"></i>-<i class="fa fa-angle-right" aria-hidden="true"></i>
											</button>
											<div id="MIL_<%=objC[0] %>">
											
											</div>
											<script>
											$(document).ready(function() {
												$.ajax({
													type:'GET',
													url:'getProjectMilestones.htm',
													datatype:'json',
													data:{
														projectid:<%=ProjectId%>,
													},
													success:function (result){
														var data = JSON.parse(result);
														console.log(data)
										
													
														
														
														  $.ajax({
															  type:'GET',
															  url:'predecessorList.htm',
															  datatype:'json',
															  data:{
																  successor:'<%=objC[0]!=null?StringEscapeUtils.escapeHtml4(objC[0].toString()): "" %>',
															  },
															  success:function(result){
																  var ajaxresult = JSON.parse(result);
																  console.log(ajaxresult);
																	
																  var html="";
																  for(var i=0;i<ajaxresult.length;i++){
																	  for (var key in data) {
																		 
																		  if(key.split("/")[1]===ajaxresult[i]){
																			 var val = data[key];
																			 html = html+"<div class='text-primary'> "+val[4]+ " (" + key.split("/")[0]+ ") </div>"
																		  }
																		  
																		}
																  }
																  var id = 'MIL_<%=objC[0]!=null?StringEscapeUtils.escapeHtml4(objC[0].toString()): "" %>';
																  $('#'+id).html(html) 
															  }
															  
														  }) 
														  
														
												        
													}
												})
											});
											</script>
										</td>
									</tr>
									<% int countD=1;
														 	if(MilestoneD!=null&&MilestoneD.size()>0){
															for(Object[] objD: MilestoneD){
																
																//check if empList contains first OIC of D level 
																if(!empList.contains(objD[13].toString() )){
																empList.add(objD[13].toString());
																}
																//check if empList contains first 2ndIC of D level 
																if(!empList.contains(objD[15].toString() )){
																	empList.add(objD[15].toString());
																	}
	                                                            List<Object[]> MilestoneE=(List<Object[]>)request.getAttribute(count+"MilestoneActivityE"+countA+countB+countC+countD);
	
																%>
									<tr
										class="collapse row_<%=objC[0] %> trclass<%=obj[0]%> trclass<%=objA[0]%> trclass<%=objB[0]%> trclass<%=objC[0]%>">
										<td style="width: 2% !important;" class="center">
											<%if(((empId.toString().equalsIgnoreCase(projectDirector+"")) || LoginType.equalsIgnoreCase("A")) && objD[5].toString().equalsIgnoreCase("0")  && objD[24].toString().equalsIgnoreCase("0")) {%>
											<button
												class="btn btn-sm class_<%=obj[0].toString()%> class<%=objA[0]%> class<%=objB[0]%> class<%=objC[0]%> class<%=objD[0]%>"
												type="button" data-toggle="tooltip" data-placement="top"
												data-original-data="" title="Delete Milestone"
												value="<%=objD[0] %>"
												onclick="deleteSubMilestone('<%=objD[0]%>', '<%=ProjectId %>')">
												<i class="fa fa-trash-o" aria-hidden="true"></i>
											</button> <%} %>


										</td>
										<td class="center">
											<%if(MilestoneE!=null && MilestoneE.size()>0) {%> <span
											class="clickable" data-toggle="collapse"
											id="row_<%=objD[0] %>" data-target=".row_<%=objD[0]  %>">
												<button class="btn btn-sm btn-success"
													id="btn<%=objD[0]  %>"
													onclick="ChangeButton('<%=objD[0]%>')">
													<i class="fa fa-plus" id="fa<%=objD[0] %>"></i>
												</button>
										</span> <%}else{ %> <%if(!objD[24].toString().equalsIgnoreCase("0")  ){ %>
											<%if((empId.toString().equalsIgnoreCase(projectDirector+"")) || LoginType.equalsIgnoreCase("A")) {%>
											<button type="button" data-toggle="tooltip"
												data-placement="top" data-original-data=""
												title="Linked Milestone" class="btn btn-sm btn-success"
												onclick="supersedingMilestone('<%=objD[0] %>','<%=objD[4] %>', 'M<%=obj[5]%>-A<%=countA%>-B<%=countB%>-C<%=countC%>-D<%=countD%>' , '<%=objD[24].toString()%>' )">
												<i class="fa fa-link " style="color: white"
													aria-hidden="true"></i>
											</button> <%} %> <%}else{ %> <%if((empId.toString().equalsIgnoreCase(projectDirector+"")) || LoginType.equalsIgnoreCase("A")) {%>
											<button type="button" data-toggle="tooltip"
												data-placement="top" data-original-data=""
												title="Link Milestone" class="btn btn-sm btn-primary"
												onclick="supersedingMilestone('<%=objD[0] %>','<%=objD[4] %>', 'M<%=obj[5]%>-A<%=countA%>-B<%=countB%>-C<%=countC%>-D<%=countD%>' , '<%=objD[24].toString()%>' )">
												<i class="fa fa-link " style="color: white"
													aria-hidden="true"></i>
											</button> <%} %> <%}} %>

										</td>
										<td style="text-align: left; width: 5%;">
											&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;D-<%=countD%></td>
										<%-- <td class="width-30px"><%=obj[1]%></td> --%>
										<td
											style="overflow-wrap: break-word !important; word-break: break-all !important; white-space: normal !important; max-width: 20% !important; min-width: 20% !important; cursor: pointer;">
											<%=objD[4]!=null?StringEscapeUtils.escapeHtml4(objD[4].toString()): " - "  %>
										</td>

										<td class="width-30px"><%=sdf.format(StringEscapeUtils.escapeHtml4(objD[2].toString()))%></td>
										<td style="width: 8% !important;"><%=sdf.format(StringEscapeUtils.escapeHtml4(objD[3].toString()))%></td>
										<td><%=objD[14]!=null?StringEscapeUtils.escapeHtml4(objD[14].toString()): " - "%></td>
										<td class="width-30px">
											<%if(objD[9].toString().equalsIgnoreCase("3")||objD[9].toString().equalsIgnoreCase("5")){ %>
											<%if(objD[7]!=null){ %> <%=sdf.format(objD[7]) %> <%}else{ %><%=objD[8]!=null?StringEscapeUtils.escapeHtml4(objD[8].toString()): " - " %>
											<%} %> <%}else{ %> <%=objD[8]!=null?StringEscapeUtils.escapeHtml4(objD[8].toString()): " - " %> <%} %>
										</td>
										<td align="center"><%=objD[6]!=null?StringEscapeUtils.escapeHtml4(objD[6].toString()): " - " %></td>
										<td>
											<%if(!objD[5].toString().equalsIgnoreCase("0")){ %>
											<div class="progress"
												style="background-color: #cdd0cb !important; height: 1.4rem !important;">
												<div
													class="progress-bar progress-bar-striped
															<%if(objD[9].toString().equalsIgnoreCase("2")){ %>
															 bg-success
															<%} else if(objD[9].toString().equalsIgnoreCase("3")){ %>
															  bg-info
															<%} else if(objD[9].toString().equalsIgnoreCase("4")){ %>
															  bg-danger
															<%} else if(objD[9].toString().equalsIgnoreCase("5")){ %>
															  bg-warning
															<%}  %>
															"
													role="progressbar" style=" width: <%=objD[5] %>%;  "
													aria-valuenow="25" aria-valuemin="0" aria-valuemax="100">
													<%=objD[5]!=null?StringEscapeUtils.escapeHtml4(objD[5].toString()): " - " %>
												</div>
											</div> <%}else{ %>
											<div class="progress"
												style="background-color: #cdd0cb !important; height: 1.4rem !important;">
												<div class="progress-bar" role="progressbar"
													style="width: 100%; background-color: #cdd0cb !important; color: black; font-weight: bold;">
													Not Started</div>
											</div> <%} %>
										</td>
										<td>
										<button type="button" class="btn btn-lg" style="color: green" data-toggle="tooltip" data-placement="top"
										data-original-data="" title="Linked Predecessor"  onclick="linkPredecessor('<%=objD[0] %>','<%=objD[4] %>', 'M<%=obj[5]%>-A<%=countA%>-B<%=countB%>-C<%=countC%>-D<%=countD%>' , '<%=objD[24].toString()%>' )">
										<i class="fa fa-angle-left" aria-hidden="true"></i>-<i class="fa fa-angle-right" aria-hidden="true"></i>
										</button>
												<div id="MIL_<%=objD[0] %>">
											
											</div>
											<script>
											$(document).ready(function() {
												$.ajax({
													type:'GET',
													url:'getProjectMilestones.htm',
													datatype:'json',
													data:{
														projectid:<%=ProjectId%>,
													},
													success:function (result){
														var data = JSON.parse(result);
														console.log(data)
										
													
														
														
														  $.ajax({
															  type:'GET',
															  url:'predecessorList.htm',
															  datatype:'json',
															  data:{
																  successor:'<%=objD[0]!=null?StringEscapeUtils.escapeHtml4(objD[0].toString()): ""%>',
															  },
															  success:function(result){
																  var ajaxresult = JSON.parse(result);
																  console.log(ajaxresult);
																	
																  var html="";
																  for(var i=0;i<ajaxresult.length;i++){
																	  for (var key in data) {
																		 
																		  if(key.split("/")[1]===ajaxresult[i]){
																			 var val = data[key];
																			 html = html+"<div class='text-primary'> "+val[4]+ " (" + key.split("/")[0]+ ") </div>"
																		  }
																		  
																		}
																  }
																  var id = 'MIL_<%=objD[0]!=null?StringEscapeUtils.escapeHtml4(objD[0].toString()): ""%>';
																  $('#'+id).html(html) 
															  }
															  
														  }) 
														  
														
												        
													}
												})
											});
											</script>
										</td>
									</tr>
									<% int countE=1;
														 	if(MilestoneE!=null&&MilestoneE.size()>0){
															for(Object[] objE: MilestoneE){
																//check if empList contains first OIC of E level 
																if(!empList.contains(objE[13].toString() )){
																empList.add(objE[13].toString());
																}
																//check if empList contains first 2ndIC of A level 
																if(!empList.contains(objE[15].toString() )){
																	empList.add(objE[15].toString());
																	}
																
																%>
									<tr
										class="collapse row_<%=objD[0] %> trclass<%=obj[0]%> trclass<%=objA[0]%> trclass<%=objB[0]%> trclass<%=objC[0]%> trclass<%=objD[0]%>"
										style="">
										<td style="width: 2% !important;" class="center">
											<%if(((empId.toString().equalsIgnoreCase(projectDirector+"")) || LoginType.equalsIgnoreCase("A")) && objE[5].toString().equalsIgnoreCase("0")  && objE[24].toString().equalsIgnoreCase("0") ) {%>
											<button
												class="btn btn-sm class_<%=obj[0].toString()%> class<%=objA[0]%> class<%=objB[0]%> class<%=objC[0]%> class<%=objD[0]%> class<%=objE[0] %>"
												value="<%=objE[0] %>" type="button" data-toggle="tooltip"
												data-placement="top" data-original-data=""
												title="Delete Milestone"
												onclick="deleteSubMilestone('<%=objE[0]%>', '<%=ProjectId %>')">
												<i class="fa fa-trash-o" aria-hidden="true"></i>
											</button> <%} %>

										</td>
										<td class="center">
											<%if(!objE[24].toString().equalsIgnoreCase("0") ){ %> <%if((empId.toString().equalsIgnoreCase(projectDirector+"")) || LoginType.equalsIgnoreCase("A")) {%>
											<button type="button" data-toggle="tooltip"
												data-placement="top" data-original-data=""
												title="Linked Milestone" class="btn btn-sm btn-success"
												onclick="supersedingMilestone('<%=objE[0] %>','<%=objE[4] %>', 'M<%=obj[5]%>-A<%=countA%>-B<%=countB%>-C<%=countC%>-D<%=countD%>-E<%=countE%>', '<%=objE[24].toString()%>'  )">
												<i class="fa fa-link " style="color: white"
													aria-hidden="true"></i>
											</button> <%} %> <%}else{ %> <%if((empId.toString().equalsIgnoreCase(projectDirector+"")) || LoginType.equalsIgnoreCase("A")) {%>
											<button type="button" data-toggle="tooltip"
												data-placement="top" data-original-data=""
												title="Link Milestone" class="btn btn-sm btn-primary"
												onclick="supersedingMilestone('<%=objE[0] %>','<%=objE[4] %>', 'M<%=obj[5]%>-A<%=countA%>-B<%=countB%>-C<%=countC%>-D<%=countD%>-E<%=countE%>', '<%=objE[24].toString()%>'  )">
												<i class="fa fa-link " style="color: white"
													aria-hidden="true"></i>
											</button> <%} %> <%} %>
										</td>
										<td style="text-align: left; width: 5%;">
											&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;E-<%=countE%></td>
										<%-- <td class="width-30px"><%=obj[1]%></td> --%>
										<td
											style="overflow-wrap: break-word !important; word-break: break-all !important; white-space: normal !important; max-width: 20% !important; min-width: 20% !important; cursor: pointer;">
											<%=objE[4]!=null?StringEscapeUtils.escapeHtml4(objE[4].toString()): " - " %>
										</td>

										<td class="width-30px"><%=sdf.format(StringEscapeUtils.escapeHtml4(objE[2].toString()))%></td>
										<td style="width: 8% !important;"><%=sdf.format(StringEscapeUtils.escapeHtml4(objE[3].toString()))%></td>
										<td><%=objE[14]!=null?StringEscapeUtils.escapeHtml4(objE[14].toString()): " - "%></td>
										<td class="width-30px">
											<%if(objE[9].toString().equalsIgnoreCase("3")||objE[9].toString().equalsIgnoreCase("5")){ %>
											<%if(objE[7]!=null){ %> <%=sdf.format(objE[7]) %> <%}else{ %><%=objE[8]!=null?StringEscapeUtils.escapeHtml4(objE[8].toString()): " - " %>
											<%} %> <%}else{ %> <%=objE[8]!=null?StringEscapeUtils.escapeHtml4(objE[8].toString()): " - " %> <%} %>
										</td>
										<td align="center"><%=objE[6]!=null?StringEscapeUtils.escapeHtml4(objE[6].toString()): " - " %></td>
										<td>
											<%if(!objE[5].toString().equalsIgnoreCase("0")){ %>
											<div class="progress"
												style="background-color: #cdd0cb !important; height: 1.4rem !important;">
												<div
													class="progress-bar progress-bar-striped
															<%if(objC[9].toString().equalsIgnoreCase("2")){ %>
															 bg-success
															<%} else if(objE[9].toString().equalsIgnoreCase("3")){ %>
															  bg-info
															<%} else if(objE[9].toString().equalsIgnoreCase("4")){ %>
															  bg-danger
															<%} else if(objE[9].toString().equalsIgnoreCase("5")){ %>
															  bg-warning
															<%}  %>
															"
													role="progressbar" style=" width: <%=objE[5] %>%;  "
													aria-valuenow="25" aria-valuemin="0" aria-valuemax="100">
													<%=objE[5]!=null?StringEscapeUtils.escapeHtml4(objE[5].toString()): " - " %>
												</div>
											</div> <%}else{ %>
											<div class="progress"
												style="background-color: #cdd0cb !important; height: 1.4rem !important;">
												<div class="progress-bar" role="progressbar"
													style="width: 100%; background-color: #cdd0cb !important; color: black; font-weight: bold;">
													Not Started</div>
											</div> <%} %>
										</td>

										<td>
										<button type="button" class="btn btn-lg" style="color: green" data-toggle="tooltip" data-placement="top"
										data-original-data="" title="Linked Predecessor"  onclick="linkPredecessor('<%=objE[0] %>','<%=objE[4] %>', 'M<%=obj[5]%>-A<%=countA%>-B<%=countB%>-C<%=countC%>-D<%=countD%>-E<%=countE%>' , '<%=objE[24].toString()%>' )">
										<i class="fa fa-angle-left" aria-hidden="true"></i>-<i class="fa fa-angle-right" aria-hidden="true"></i>
										</button>
										
												<div id="MIL_<%=objE[0] %>">
											
											</div>
											<script>
											$(document).ready(function() {
												$.ajax({
													type:'GET',
													url:'getProjectMilestones.htm',
													datatype:'json',
													data:{
														projectid:<%=ProjectId%>,
													},
													success:function (result){
														var data = JSON.parse(result);
														console.log(data)
										
													
														
														
														  $.ajax({
															  type:'GET',
															  url:'predecessorList.htm',
															  datatype:'json',
															  data:{
																  successor:'<%=objE[0]!=null?StringEscapeUtils.escapeHtml4(objE[0].toString()): ""%>',
															  },
															  success:function(result){
																  var ajaxresult = JSON.parse(result);
																  console.log(ajaxresult);
																	
																  var html="";
																  for(var i=0;i<ajaxresult.length;i++){
																	  for (var key in data) {
																		 
																		  if(key.split("/")[1]===ajaxresult[i]){
																			 var val = data[key];
																			 html = html+"<div class='text-primary'> "+val[4]+ " (" + key.split("/")[0]+ ") </div>"
																		  }
																		  
																		}
																  }
																  var id = 'MIL_<%=objE[0]!=null?StringEscapeUtils.escapeHtml4(objE[0].toString()): ""%>';
																  $('#'+id).html(html) 
															  }
															  
														  }) 
														  
														
												        
													}
												})
											});
											</script>
										
										
										</td>
									</tr>

									<% countE++;} }%>
									<% countD++;} }%>
									<% countC++;} }%>
									<% countB++;} }%>
									<% countA++;} }else{%>
									<tr class="collapse row<%=count %>">
										<td colspan="11" style="text-align: center" class="center">No
											Sub List Found</td>
									</tr>

									<%} %>

									<% count++; } %>


									<%-- 	<tr>
														<td></td>
														<td colspan=1 style="display: flex;justify-content: center;align-items: center">
															<form action="MilestoneActivityMilNoUpdate.htm" method="POST" name="slnoupdateform" id="slnoupdateform">
							              						<input type="hidden" name="${_csrf.parameterName}"	value="${_csrf.token}" /> 
							              						<input type="hidden" name="projectId" value="<%=ProjectId%>">
							              						<button class="btn btn-sm edit" onclick="return slnocheck();">UPDATE</button>
						              						</form>
					              						</td>
														<td colspan="9"></td>
													</tr> --%>
									<% }else{%>
									<tr>
										<td colspan="11" style="text-align: center" class="center">No
											List Found</td>
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


	<br>

	<div class="row m-2">
		<div class="col-md-12"
			style="text-align: center; width: 140px; height: 30px;">
			<b>Milestone Flow </b>
		</div>
	</div>

	<div class="row m-2"
		style="text-align: center; padding-top: 10px; padding-bottom: 15px;">

		<table align="center" style="border-spacing: 0 20px;">
			<tr>


				<td class="trup"
					style="background: #c4ced3; width: 230px; height: 20px;"><b
					class="text-primary">Add Milestone Activity </b></td>
				<td class="trup" style="width: 10px; height: 20px;"></td>
				<td><i class="fa fa-long-arrow-right " aria-hidden="true"></i></td>
				<td rowspan="2" class="trup" style="width: 30px; height: 20px;"></td>

				<td class="trup"
					style="background: #c4ced3; width: 230px; height: 20px;"><b
					class="text-primary">Add Sub Milestone Activity </b></td>
				<td class="trup" style="width: 10px; height: 20px;"></td>
				<td><i class="fa fa-long-arrow-right " aria-hidden="true"></i></td>
				<td rowspan="2" class="trup" style="width: 30px; height: 20px;"></td>

				<td class="trup"
					style="background: #c4ced3; width: 230px; height: 20px;"><b
					class="text-primary">Assign Weightage </b></td>
				<td class="trup" style="width: 10px; height: 20px;"></td>
				<td><i class="fa fa-long-arrow-right " aria-hidden="true"></i></td>
				<td rowspan="2" class="trup" style="width: 30px; height: 20px;"></td>

				<td class="trup"
					style="background: #c4ced3; width: 230px; height: 20px;"><b
					class="text-primary">Assign Milestone Activity </b></td>
				<td class="trup" style="width: 10px; height: 20px;"></td>
				<td><i class="fa fa-long-arrow-right " aria-hidden="true"></i></td>
				<td rowspan="2" class="trup" style="width: 30px; height: 20px;"></td>

				<td class="trup"
					style="background: #c4ced3; width: 230px; height: 20px;"><b
					class="text-primary">Set Baseline </b></td>
				<td class="trup" style="width: 10px; height: 20px;"></td>
				<td><i class="fa fa-long-arrow-right " aria-hidden="true"></i></td>
				<td rowspan="2" class="trup" style="width: 30px; height: 20px;"></td>

				<td class="trup"
					style="background: #c4ced3; width: 230px; height: 20px;"><b
					class="text-primary">Assignee</b></td>
				<td class="trup" style="width: 10px; height: 20px;"></td>
				<td><i class="fa fa-long-arrow-right " aria-hidden="true"></i></td>
				<td rowspan="2" class="trup" style="width: 30px; height: 20px;"></td>

				<td class="trup"
					style="background: #c4ced3; width: 230px; height: 20px;"><b
					class="text-primary"> Acknowledge Milestone Activity </b></td>
				<td class="trup" style="width: 10px; height: 20px;"></td>
				<td><i class="fa fa-long-arrow-right " aria-hidden="true"></i></td>
				<td rowspan="2" class="trup" style="width: 30px; height: 20px;"></td>

				<td class="trup"
					style="background: #c4ced3; width: 230px; height: 20px;"><b
					class="text-primary">Update progress</b></td>




			</tr>

		</table>



	</div>
	<br>
	<br>
	<br>

	<div class="modal" id="MainDOCEditModal" tabindex="-1" role="dialog"
		aria-labelledby="exampleModalCenterTitle" aria-hidden="true">
		<div class="modal-dialog modal-dialog-centered" role="document">
			<div class="modal-content">
				<div class="modal-header">
					<h5 class="modal-title" id="exampleModalLongTitle">Edit Date
						of Completion</h5>
					<button type="button" class="close" data-dismiss="modal"
						aria-label="Close">
						<span aria-hidden="true">&times;</span>
					</button>
				</div>
				<div class="modal-body" align="center">
					<form action="MainMilestoneDOCUpdate.htm" method="post">
						<table style="width: 80%;">
							<tr>
								<th style="width: 40%;">Date of Completion : &nbsp;</th>
								<td style="width: 60%;"><input type="text"
									class="form-control" name="DateOfCompletion" id="MainDOCDate"
									value="" readonly="readonly"></td>
							</tr>
							<tr>
								<td colspan="2" style="text-align: center;"><br>
									<button type="button" class="btn btn-sm btn-danger"
										data-dismiss="modal">
										<b>Close</b>
									</button>
									<button class="btn btn-sm submit"
										onclick="return confirm('Are You Sure to Edit?');">SUBMIT</button>
								</td>
							</tr>
						</table>

						<input type="hidden" id="MSMainid" name="MSMainid" value="">
						<input type="hidden" name="projectid" value="<%=ProjectId %>">
						<input type="hidden" name="${_csrf.parameterName}"
							value="${_csrf.token}" />
					</form>
				</div>

			</div>
		</div>
	</div>




	<!-- -------------------------------------------- Milestone Progess Modal -------------------------------------------- -->

	<!-- -------------------------------------------- Milestone Progress Modal End -------------------------------------------- -->


	<!-- -------------------------------------------- Milestone Status Remarks Modal -------------------------------------------- -->
	<div class="modal fade" id="milestoneStatusRemarksModal" tabindex="-1"
		role="dialog" aria-labelledby="milestoneStatusRemarksModal"
		aria-hidden="true">
		<div class="modal-dialog modal-lg modal-dialog-jump" role="document">
			<div class="modal-content" style="width: 135%; margin-left: -20%;">
				<div class="modal-header" id="ModalHeader"
					style="background: #055C9D; color: white;">
					<h5 class="modal-title">Status Remarks</h5>
					<button type="button" class="close" data-dismiss="modal"
						aria-label="Close">
						<span aria-hidden="true" class="text-light">&times;</span>
					</button>
				</div>

				<div class="modal-body">
					<div class="row">
						<div class="col-md-12">
							<label class="form-label">Financial Outlay :</label> <span
								id="financialOutlay"></span>
						</div>
					</div>
					<div class="row mb-2">
						<div class="col-md-12">
							<label class="form-label">Remarks : </label>
							<div id="statusRemarks"></div>
						</div>
					</div>

				</div>
			</div>
		</div>
	</div>
	<!-- -------------------------------------------- Milestone Status Remarks Modal End -------------------------------------------- -->

	<div class="modal fade" id="largeModal" tabindex="-1" role="dialog"
		aria-labelledby="largeModalLabel" aria-hidden="true">
		<div class="modal-dialog modal-lg" role="document">
			<!-- Use modal-lg here -->
			<div class="modal-content" style="width: 150%; margin-left: -22%;">
				<div class="modal-header">
					<h5 class="modal-title" id="modalheader">Choose Milestone for
						Linking & Superseding</h5>
					<button type="button" class="close" data-dismiss="modal"
						aria-label="Close">
						<span aria-hidden="true">&times;</span>
					</button>
				</div>
				<div class="modal-body">
					<div class="row">
						<div class="col-md-3">
							<label class="control-label">Project Name :</label>
						</div>
						<div class="col-md-5" style="">
							<select class="form-control selectdee" id="projectIds"
								required="required" style="width: 100%"
								onchange="getProjectMilestones()">
								<option selected value="0">Choose...</option>
								<%
								for (Object[] obj : ProjectList) {
								if(!ProjectId.equalsIgnoreCase(obj[0].toString())){
									String projectshortName1= (obj[17] != null) ? " (" + obj[17].toString() + ") " : "";
								%>
								<option value="<%=obj[0]%>"><%=obj[4]!=null?StringEscapeUtils.escapeHtml4(obj[4].toString()): " - " %><%=projectshortName1!=null?StringEscapeUtils.escapeHtml4(projectshortName1): " - " %></option>
								<%
								}}
								%>
							</select>
						</div>
					</div>

					<div class="row mt-4" id="MilestoneDataLinked"
						style="display: none;"></div>

					<div class="row mt-4">
						<div class="col-md-3">
							<label class="control-label">Milestone List:</label>
						</div>
						<div class="col-md-8" style="">
							<select class="form-control selectdee" id="mileIdLink"
								required="required" style="width: 100%">



							</select>
						</div>
					</div>
					<div class="row mt-4" id="superSede" style="display: none;">
						<div class="col-md-12"
							style="text-align: center; font-weight: 700">The main
							Milestone for Progress</div>
					</div>

					<div class="row mt-4" id="IsMasterDiv" style="display: none;">
						<div class="col-md-1" id="IsMasterDivDetails" style=""></div>
						<div class="col-md-4" style="text-align: right;">
							<input type="radio" name="IsMaster" value="Y" checked="checked">&nbsp;&nbsp;
							<label class="control-label" id="masterDataLabel">Is
								Master Data:</label>
						</div>
						<div class="col-md-1" id="IsMasterDivDetails" style=""></div>
						<div class="col-md-4">
							<input type="radio" name="IsMaster" value="N">
							&nbsp;&nbsp;<label class="control-label" id="submasterDataLabel">Is
								Master Data:</label>
						</div>

					</div>

					<div align="center" class="mt-4">
						<button class="btn btn-sm submit" onclick="saveData()">SUBMIT</button>
						<input type="hidden" id="milesMainId">
					</div>
				</div>

			</div>
		</div>
	</div>




	<div class="modal fade" id="predecessorModal" tabindex="-1" role="dialog"
		aria-labelledby="largeModalLabel" aria-hidden="true">
		<div class="modal-dialog modal-lg" role="document">
			<!-- Use modal-lg here -->
			<div class="modal-content" style="width: 150%; margin-left: -22%;">
				<div class="modal-header">
					<h5 class="modal-title" id="modalheaderP">Predecessor</h5>
					<button type="button" class="close" data-dismiss="modal"
						aria-label="Close">
						<span aria-hidden="true">&times;</span>
					</button>
				</div>
				<div class="modal-body">
				

					<div class="row mt-4">
						<div class="col-md-3">
							<label class="control-label">Milestone List:</label>
						</div>
						<div class="col-md-8" style="">
							<select class="form-control selectdee" id="predecessorMileId" multiple
								required="required" style="width: 100%" >



							</select>
						</div>
					</div>
					<div align="center" class="mt-4">
						<button class="btn btn-sm submit" onclick="savePredecessorData()">SUBMIT</button>
						<!-- <input type="hidden" id="milesMainId"> -->
					</div>
				</div>

			</div>
		</div>
	</div>
	<script type="text/javascript">
function MainDOCEditModal(mainid, DOC)
{
	$('#MSMainid').val(mainid);			
	$('#MainDOCDate').daterangepicker({
		"singleDatePicker" : true,
		"linkedCalendars" : false,
		"showCustomRangeLabel" : true,
		"startDate" : new Date(DOC),
		"cancelClass" : "btn-default",
		showDropdowns : true,
		locale : {
			format : 'DD-MM-YYYY'
		}
	});
	$('#MainDOCEditModal').modal('toggle');
	
}
															 
</script>


	<script>


$(document).ready(function() {
	   $('#ProjectId').on('change', function() {
	     $('#submit').click();

	   });
	});
	
	 
function ChangeButton(id) {
    // Show loading using SweetAlert2
    Swal.fire({
       
        allowOutsideClick: false,
        allowEscapeKey: false,
        didOpen: () => {
            Swal.showLoading();
        }
    });

    // Give DOM time to update (for smoother animation), then process logic
    setTimeout(() => {
        if ($("#btn" + id).hasClass("btn btn-sm btn-success").toString() == 'true') {
            $("#btn" + id).removeClass("btn btn-sm btn-success").addClass("btn btn-sm btn-danger");
            $("#fa" + id).removeClass("fa fa-plus").addClass("fa fa-minus");
        } else {
            var targetRow = $(".trclass" + id);
            targetRow.collapse("hide");
            $("#btn" + id).removeClass("btn btn-sm btn-danger").addClass("btn btn-sm btn-success");
            $("#fa" + id).removeClass("fa fa-minus").addClass("fa fa-plus");
       
            if (targetRow && targetRow.length > 0) {
                targetRow.find("button.btn.btn-sm.btn-danger").each(function () {
                    $(this)
                        .removeClass("btn btn-sm btn-danger")
                        .addClass("btn btn-sm btn-success");

                    $(this).find("i.fa.fa-minus")
                        .removeClass("fa fa-minus")
                        .addClass("fa fa-plus");
                });
            }
        
        }

     

    
        Swal.close();  
    }, 300); // Small timeout to allow loading to render
}



</script>




	<script>
	$('#DateCompletion').daterangepicker({
			"singleDatePicker" : true,
			"linkedCalendars" : false,
			"showCustomRangeLabel" : true,
			"minDate" : new Date(),
			"cancelClass" : "btn-default",
			showDropdowns : true,
			locale : {
				format : 'DD-MM-YYYY'
			}
		});

	$('#DateCompletion2').daterangepicker({
		"singleDatePicker" : true,
		"linkedCalendars" : false,
		"showCustomRangeLabel" : true,
		"minDate" : new Date(),
		"cancelClass" : "btn-default",
		showDropdowns : true,
		locale : {
			format : 'DD-MM-YYYY'
		}
	});
	
	
	function updateBpPoints(ele){
		var a=ele.value;
		var value1=a.split("/")[0];
		var value2=a.split("/")[1];
		var value3=a.split("/")[2]
		
		$.ajax({
			type:'GET',
			url:'BriefingPointsUpdate.htm',
			datatype:'json',
			data:{
				ActivityId:value1,
				point:value3,
				status:value2,
			}
		});
		
		
		if(value2==="Y"){
		ele.value=value1+"/N/"+value3
		}else{
			ele.value=value1+"/Y/"+value3
		}
	}
	
	// Milestone No Check
	function slnocheck() {
		
		 var arr = document.getElementsByName("newslno");

		var arr1 = [];
		for (var i=0;i<arr.length;i++){
			arr1.push(arr[i].value);
		}		 
		 
	    let result = false;
	  
	    const s = new Set(arr1);
	    
	    if(arr.length !== s.size){
	       result = true;
	    }
	    if(result) {
	   		event.preventDefault();
	       	alert('Serial No contains duplicate Values');
	       	return false;
	    } else {
	   	 return confirm('Are You Sure to Update?');
	    }
	  }
	

	function formatDate(sqlDate) {
	    if (!sqlDate) {
	        return ""; // Handle null or undefined dates
	    }

	    let date = new Date(sqlDate);
	    let day = String(date.getDate()).padStart(2, '0');
	    let month = String(date.getMonth() + 1).padStart(2, '0'); // Months are 0-indexed
	    let year = date.getFullYear();

	    return day + '-' + month + '-' + year;
	}
	
	function showMilestoneStatusProgress(rowId) {
		$('#financialOutlay').text($('#financialOutlay_'+rowId).val());
		$('#statusRemarks').html($('#statusRemarks_'+rowId).val());
		$('#milestoneStatusRemarksModal').modal('show');
	}
	
	/* $(".deleteBtn").click(function(){
		
		var id = this.value;
		if(confirm('Kindly Note if you remove a milestone sub-milestones will also get removed.Are you sure to delete this Milestone?')){
			
			$.ajax({
				type:'GET',
				url:'MilestoneIsActive.htm',
				datatype:'json',
				data:{
					id:id,
				},
				success:function(result){
					var ajaxresult = JSON.parse(result);
					
					if(ajaxresult=='1'){
						alert('Milestone Deleted successfully!')
						window.location.reload()
					}else{
						alert('Milestone Delete unsuccessful!')
					}
				}
			})
		}else{
			
		}
		
		
		}); */
	
	
	var yesText="";
	function supersedingMilestone(a,b ,c ,d ){
		
		yesText = b+ " ("+ c + ") "+ '<%=selectedProject %>';
		
		
		$("#mileIdLink").html("<option disabled selected value=''>Choose...</option>");
		$("#modalheader").html(" Linking & Superseding for "+b+ " ("+ c + ")" +    "<%=selectedProject %>");
		$('#projectIds').val('0').trigger('change');
		$('#IsMasterDiv').hide();
		$('#superSede').hide();
		$('#MilestoneDataLinked').hide();
		$('#milesMainId').val(a);
		
		if(d!=='0'){
			
			$.ajax({
				type:'GET',
				url:'MilestoneLinked.htm',
				datatype:'json',
				data:{
					id:d,
				
				},
				success:function(result){
					var ajaxresult = JSON.parse(result);
					
					var val="";
					for (var key in ajaxresult) {
					  if (ajaxresult.hasOwnProperty(key)) {
						   
					    if(key===d){val = ajaxresult[key];}
					
					  }
					}
					
					
					var arr = val.split("/");
					
					console.log(arr)
					
					$('#projectIds').val(arr[3]+"").trigger('change');
					$('#MilestoneDataLinked').show();
					var html = "<div class='col-md-12 text-primary' style='font-weight:600'>Superseded Milestone : "+ arr[2] + "("+ arr[1] + "  " +arr[0] +")</span>"; 
					$('#MilestoneDataLinked').html(html);
				}
			})
		}
		$('#largeModal').modal('show');
	}
	
	var successor = "";
	function linkPredecessor(a,b ,c ,d ){
		successor=a;


		$("#modalheaderP").html("Predecessor Of "+b+ " ("+ c + ") - " +    "<%=selectedProject %>");
	
		var projectid = $('#projectIds').val();
		  Swal.fire({
		       
		        allowOutsideClick: false,
		        allowEscapeKey: false,
		        didOpen: () => {
		            Swal.showLoading();
		        }
		    });
		
	
		
		  
		
		  
		  
		  
			$.ajax({
			type:'GET',
			url:'getProjectMilestones.htm',
			datatype:'json',
			data:{
				projectid:<%=ProjectId%>,
			},
			success:function (result){
				var data = JSON.parse(result);
				console.log(data)
				var html = "<option disabled  value=''>Choose...</option>";	
				for (var key in data) {
					  if (data.hasOwnProperty(key)) {
					    var val = data[key]; 
						
					 
					 if((val[0]+"")!==a){
					 html += "<option value='" + val[0] + "'>" + val[4] +" (" +key.split("/")[0] + ")"+ "</option>";
					  }
					  }
					}
				$("#predecessorMileId").html(html);
			
				
				  $.ajax({
					  type:'GET',
					  url:'predecessorList.htm',
					  datatype:'json',
					  data:{
						  successor:successor,
					  },
					  success:function(result){
						  var ajaxresult = JSON.parse(result);
						  console.log(ajaxresult);
						  
						  $('#predecessorMileId').val(ajaxresult).trigger('change');
						  
						  Swal.close(); 
					  }
					  
				  }) 
				  
				
		        
			}
		})
		
		$('#predecessorModal').modal('show');
		
		
	}
	
	
	function getProjectMilestones(){
		
		var projectid = $('#projectIds').val();
		  Swal.fire({
		       
		        allowOutsideClick: false,
		        allowEscapeKey: false,
		        didOpen: () => {
		            Swal.showLoading();
		        }
		    });
		
	
			$.ajax({
			type:'GET',
			url:'getProjectMilestones.htm',
			datatype:'json',
			data:{
				projectid:projectid,
			},
			success:function (result){
				var data = JSON.parse(result);
				console.log(data)
				var html = "<option disabled selected value=''>Choose...</option>";	
				for (var key in data) {
					  if (data.hasOwnProperty(key)) {
					    var val = data[key]; 
						
					  if((val[22]+"")==="0" && (val[24]+"")==="0"){
						  if((val[5]+"")!=="100"){
						html += "<option value='" + val[0] + "'>" + val[4] +"(" +key.split("/")[0] + ")"+ "</option>";
					  }}
					  }
					}
				$("#mileIdLink").html(html);
			
		        Swal.close();  
			}
		})
	}
	
	var mainselectedTextProject="";
	
	$('#mileIdLink').on('change', function () {
	    var selectedValue = $(this).val();                
	    var selectedText = $(this).find("option:selected").text(); // Gets the displayed text
	   
	    var selectedTextProject = $('#projectIds').find("option:selected").text();
	    mainselectedTextProject=selectedTextProject;

	    
	    $('#superSede').show();
	    $('#IsMasterDiv').show();
	    $('#masterDataLabel').html(yesText);
	    $('#submasterDataLabel').html(selectedText+" "+mainselectedTextProject.split(" ")[1]);
	
	});
	
	
	function savePredecessorData(){
		var value = $("#predecessorMileId").val();
		
		if(value.length===0){
		    Swal.fire({
		        icon: 'error',
		        title: 'Milestone Required',
		        text: 'You did not choose any milestone!',
		    });
		    return;
		}
		
		
	    Swal.fire({
	        title: 'Are you sure?',
	        text: 'Are you sure to make this milestones as predecessor?',
	        icon: 'warning',
	        showCancelButton: true,
	        confirmButtonText: 'Yes',
	        cancelButtonText: 'No',
	        allowOutsideClick: false
	    }).then((result) => {
	        if (result.isConfirmed) {
	          
	            $.ajax({
	                type: 'get',
	                url: 'predecessorActivity.htm',
	                data: {
	                    activityIds: value + "", 
	                    successor:successor,
	                },
	                dataType: 'json',
	                success: function (response) {
	                    Swal.close(); // close the loading state

	                    // Step 4: Success Alert
	                    Swal.fire({
	                        title: "Success",
	                        icon: "success",
	                        allowOutsideClick: false
	                    }).then(() => {
	                        location.reload(); 
	                	    /* $('#predecessorModal').modal('hide'); */
	                    });
	                },
	                error: function (xhr, status, error) {
	                    Swal.close(); // close the loading state

	                    // Step 5: Error Alert
	                    Swal.fire({
	                        icon: 'error',
	                        title: 'Error',
	                        text: 'An error occurred while deleting the milestone'
	                    });
	                }
	            });
	        }
	        // If result.isDismissed: do nothing (user clicked Cancel)
	    });

	}
	
	function saveData(){
		
		var mileIdLink = $('#mileIdLink').val();
		var milesMainId = $('#milesMainId').val();
		var selectedValue = $('input[name="IsMaster"]:checked').val();

		if (!mileIdLink || mileIdLink.trim() === "") {
		    Swal.fire({
		        icon: 'error',
		        title: 'Milestone Required',
		        text: 'You need to choose a milestone to link. If no milestones are visible, it may be because all milestones for the selected project have already started progressing.',
		    });
		    return;
		}

		var isPresent = $('#MilestoneDataLinked').is(':hidden');  // This is a boolean

		
		if (!isPresent) {
		    Swal.fire({
		        icon: 'warning',
		        text: 'Milestone is already linked to another milestone. Linking it to a different milestone might change the progress scenario!',
		    }).then(() => {
		       
		        showConfirmationDialog();
		    });
		} else {
		   
		    showConfirmationDialog();
		}

		
		function showConfirmationDialog() {
		    Swal.fire({
		        title: 'Are you sure to link?',
		        icon: 'question',
		        showCancelButton: true,
		        confirmButtonColor: 'green',
		        cancelButtonColor: '#d33',
		        confirmButtonText: 'Yes'
		    }).then((result) => {
		        if (result.isConfirmed) {
		            $.ajax({
		                type: 'GET',
		                url: 'updateMilestonSuperSeding.htm',
		                datatype: 'json',
		                data: {
		                    mileIdLink: mileIdLink,
		                    milesMainId: milesMainId,
		                    isMasterData: selectedValue
		                },
		                success: function(response) {
		                    Swal.fire({
		                        title: "Success",
		                        text: "Milestone Linked Successfully",
		                        icon: "success",
		                        allowOutsideClick: false
		                    });

		                    $('.swal2-confirm').click(function () {
		                        location.reload();
		                    });
		                },
		                error: function(xhr, status, error) {
		                    Swal.fire({
		                        icon: 'error',
		                        title: 'Error',
		                        text: 'An error occurred while uploading the file'
		                    });
		                }
		            });
		        }
		    });
		}

		
	}
	
	$(function () {
		$('[data-toggle="tooltip"]').tooltip()
	})
	
	function deleteSubMilestone(activityId, ProjectId) {
    const allButtons = document.querySelectorAll('.class' + activityId);

    // Extract their values into an array
    const allValues = Array.from(allButtons).map(btn => btn.value);
    

    // Step 1: Confirmation Dialog
    Swal.fire({
        title: 'Are you sure?',
        text: 'Deleting a milestone may also remove its associated sub-milestones. Are you sure you want to continue?',
        icon: 'warning',
        showCancelButton: true,
        confirmButtonText: 'Yes',
        cancelButtonText: 'No',
        allowOutsideClick: false
    }).then((result) => {
        if (result.isConfirmed) {
            // Step 2: Show loading
            Swal.fire({
                title: 'Deleting...',
                text: 'Please wait',
                allowOutsideClick: false,
                didOpen: () => {
                    Swal.showLoading();
                }
            });

            // Step 3: Ajax Call
            $.ajax({
                type: 'get',
                url: 'delteSubMilestoneActivity.htm',
                data: {
                    activityId: allValues + "", // send as comma-separated string
                },
                dataType: 'json',
                success: function (response) {
                    Swal.close(); // close the loading state

                    // Step 4: Success Alert
                    Swal.fire({
                        title: "Success",
                        text: "Milestones Deleted Successfully",
                        icon: "success",
                        allowOutsideClick: false
                    }).then(() => {
                        location.reload();
                    });
                },
                error: function (xhr, status, error) {
                    Swal.close(); // close the loading state

                    // Step 5: Error Alert
                    Swal.fire({
                        icon: 'error',
                        title: 'Error',
                        text: 'An error occurred while deleting the milestone'
                    });
                }
            });
        }
        // If result.isDismissed: do nothing (user clicked Cancel)
    });
}

$(".deleteBtn").click(function(){
		
		var id = this.value;
	/*     
	
	const allButtons = document.querySelectorAll('.class_' + id);

	    // Extract their values into an array
	    const allValues = Array.from(allButtons).map(btn => btn.value);
	    console.log('All button values:', allValues); */
		
		Swal.fire({
		    title: 'Are you sure?',
		    text: 'Kindly note: if you remove a milestone, its sub-milestones will also be removed. Do you want to delete this milestone?',
		    icon: 'warning',
		    showCancelButton: true,
		    confirmButtonText: 'Yes',
		    cancelButtonText: 'No',
		    allowOutsideClick: false
		}).then((result) => {
		    if (result.isConfirmed) {

		        // Optional: Show a loading spinner while Ajax runs
		        Swal.fire({
		            title: 'Deleting...',
		            text: 'Please wait',
		            allowOutsideClick: false,
		            didOpen: () => {
		                Swal.showLoading();
		            }
		        });

		        // Ajax request
		        $.ajax({
		            type: 'GET',
		            url: 'MilestoneIsActive.htm',
		            dataType: 'json',
		            data: {
		                id: id,
		            },
		            success: function (result) {
		                Swal.close(); // Close loading

		                var ajaxresult = typeof result === 'string' ? JSON.parse(result) : result;

		                if (ajaxresult == '1') {
		                    Swal.fire({
		                        icon: 'success',
		                        title: 'Deleted!',
		                        text: 'Milestone deleted successfully.',
		                        confirmButtonText: 'OK'
		                    }).then(() => {
		                        window.location.reload();
		                    });
		                } else {
		                    Swal.fire({
		                        icon: 'error',
		                        title: 'Failed!',
		                        text: 'Milestone delete unsuccessful.',
		                        confirmButtonText: 'OK'
		                    });
		                }
		            },
		            error: function () {
		                Swal.close(); // Close loading
		                Swal.fire({
		                    icon: 'error',
		                    title: 'Error!',
		                    text: 'An error occurred while trying to delete the milestone.',
		                    confirmButtonText: 'OK'
		                });
		            }
		        });
		    }
		    // If cancelled, do nothing
		});
		
		
		});
	
	
	
	
</script>


</body>
</html>