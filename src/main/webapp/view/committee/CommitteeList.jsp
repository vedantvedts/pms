<%@page import="com.ibm.icu.text.DecimalFormat"%>
<%@page import="com.vts.pfms.NFormatConvertion"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"
	import="java.util.*,com.vts.*,java.text.SimpleDateFormat"%>
	<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<jsp:include page="../static/header.jsp"></jsp:include>


<title>COMMITTEELIST</title>
<style type="text/css">
label {
	font-weight: bold;
	font-size: 13px;
}

body {
	background-color: #f2edfa;
}

.table .font {
	font-family: 'Muli', sans-serif !important;
	font-style: normal;
	font-size: 13px;
	font-weight: 400 !important;
}

.table button {
	background-color: Transparent !important;
	background-repeat: no-repeat;
	border: none;
	cursor: pointer;
	overflow: hidden;
	outline: none;
	text-align: left !important;
}

.table td {
	padding: 5px !important;
}

.resubmitted {
	color: green;
}

.fa {
	font-size: 1.20rem;
}

.datatable-dashv1-list table tbody tr td {
	padding: 8px 10px !important;
}

.fa-exclamation-triangle {
	font-size: 2.5rem !important;
}

.table-project-n {
	color: #005086;
}

.right {
	text-align: right;
} 
 
.center {
	text-align: center;
}

#table thead tr th {
	padding: 0px 0px !important;
	text-align:center;
}

#table tbody tr td {
	padding: 2px 3px !important;
	text-align:center;
}

.fullname{
margin-left:3px!important;
text-align:left!important;
}
/* icon styles */
.cc-rockmenu {
	color: fff;
	padding: 0px 5px;
	font-family: 'Lato', sans-serif;
}

.cc-rockmenu .rolling {
	display: inline-block;
	cursor: pointer;
	width: 33px;
	height: 30px;
	text-align: left;
	overflow: hidden;
	transition: all 0.3s ease-out;
	white-space: nowrap;
}

.cc-rockmenu .rolling:hover {
	width: 120px;
}

.cc-rockmenu .viewcommittees:hover {
	width: 157px;
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
	width: 270px !important;
}

a:hover {
	color: white;
}



</style>
</head>
<body>

<%
SimpleDateFormat sdf1=new SimpleDateFormat("dd-MM-yyyy");
SimpleDateFormat sdf=new SimpleDateFormat("yyyy-MM-dd");
List<Object[]> committeelist=(List<Object[]>)request.getAttribute("committeelist"); 
String projectid=(String) request.getAttribute("projectid"); 
//List<Object[]> projectslist=(List<Object[]>)request.getAttribute("projectslist"); 
String projectappliacble=(String) request.getAttribute("projectappliacble"); 
Object[] projectdetails=(Object[])request.getAttribute("projectdetails");
%>

 <!-- ----------------------------------message ------------------------- -->

	
<%String ses=(String)request.getParameter("result"); 
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
		<div class="alert alert-success" role="alert">
			<%=ses %>
		</div>
	</div>
<%} %>

<!-- ----------------------------------message ------------------------- -->

	<div class="card shadow-nohover">
			<div class="card-header">	
				<div class="row">
					<div class="col-md-6">
						<h4>
							Committees List 	<%if(Long.parseLong(projectid)>0){ %>	(Project : <%=projectdetails[4] %>)		<%} %>
						</h4>
					</div>
					<div class="col-md-6">
						<table style="float:right; border: 0px">
							<tr>
								<td>
									<%if(Long.parseLong(projectid)==0){ %>
									<span style=" font-size :20px">Type  :&nbsp;&nbsp;</span> 
									<form method="post" action="CommitteeList.htm" id="selectfrm" style="float:right; margin-top: -10px;">
										<select class="form-control " name="projectappliacble" required="required" id="projectappliacble" onchange="return  projectselectsubmit('selectfrm');" >
											<option <%if( projectappliacble.equalsIgnoreCase("N")){ %> selected <%} %> value="N">Non - Project</option>
											<option <%if(projectappliacble.equalsIgnoreCase("P") ){ %> selected <%} %> value="P">Project</option>
							  			</select>
							  			<input type="hidden" name="projectid" id="projectid" value="<%=projectid %>"  />
										<input type="hidden" name="projectappliacble" id="projectappliacble" value="<%=projectappliacble %>" />
							  			<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
									</form>
									<%}else{ %>
									<form method="post" action="ProjectMaster.htm" id="selectfrm" style="float:right;">
										<button type="submit" class="btn btn-sm back" >BACK</button>
							  			<input type="hidden" name="projectid" id="projectid" value="<%=projectid %>"  />
										<input type="hidden" name="projectappliacble" id="projectappliacble" value="<%=projectappliacble %>" />
							  			<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
									</form>
									<%} %>
								</td>
								<td style="padding-left: 30px;">
									<form method="post" action="CommitteeAdd.htm" >
										<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
										<button type="submit"  style="margin-top: -10px; " name="projectid" value="<%=projectid %>" class="btn btn-sm add" >ADD COMMITTEE</button>											
										<input type="hidden" name="projectappliacble" id="projectappliacble" value="<%=projectappliacble %>" />						
									</form>
								</td>					
							</tr>
						</table>
					</div>	
				</div>
			</div>
		
					<div class="card-body">
						<div class="data-table-area mg-b-15">
							<div class="container-fluid">
								<!-- <form action="ProjectIntiationListSubmit.htm" method="POST" name="myfrm" > -->
								<div class="col-lg-12 col-md-12 col-sm-12 col-xs-12">
									<div class="sparkline13-list">

										<div class="sparkline13-graph">
											<div class="datatable-dashv1-list custom-datatable-overright">
												<div id="toolbar">
													
												</div>
												<table id="table" data-toggle="table" data-pagination="true"
													data-search="true" data-show-columns="true"
													data-show-pagination-switch="true" 
													data-key-events="true" data-show-toggle="true"
													data-resizable="true" data-cookie="true"
													data-cookie-id-table="saveId" data-show-export="true"
													data-click-to-select="true" data-toolbar="#toolbar">
													<thead>

														<tr>
															<th>SN</th>
															<th>Full Name</th>
															<th>Code</th>
															<th>Type</th>
															<th>Project Applicable</th>
															<th>Action</th>
														</tr>
													</thead>
													
													<tbody>
											<%int count1=1;
										   	for (Object[] obj :committeelist) {
										   		
										   			   %>
														<tr>
															<td><%=count1 %></td>
															<td class="fullname"><%=obj[2] %></td>
															<td><%=obj[1] %></td>
															<td>
															<%if(obj[3].toString().equals("S")){%>Standard<%}else{ %>Adhoc<%} %>
															</td>															
															<td><%if(obj[4].toString().equals("P")){%>Project<%}else{ %>Non-Project<%}%></td>															
															<td class="left width">		
															
																<form action="CommitteeEdit.htm" method="post" name="myfrm"
																	style="display: inline">

																	<button class="editable-click" name="sub"
																		value="Modify">
																		<div class="cc-rockmenu">
																			<div class="rolling">
																				<figure class="rolling_icon">
																					<img src="view/images/edit.png">
																				</figure>
																				<span>Modify</span>
																			</div>
																		</div>
																	</button>
																	
																	<input type="hidden" name="committeeid"	value="<%=obj[0]%>" /> 
																	<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />

																</form> 		
															
												
																<%if(projectappliacble.equalsIgnoreCase("N") && !Arrays.asList("CCM","CARS").contains(obj[1].toString()) ){ %>												
																	<form action="CommitteeMainMembers.htm" method="post" name="myfrm"	style="display: inline">
																		<button class="editable-click" name="sub" value="Details" 	>
																			<div class="cc-rockmenu">
																				<div class="rolling">
																					<figure class="rolling_icon">
																						<img src="view/images/preview3.png">
																					</figure>
																					<span>Constitution</span>
																				</div>
																			</div>
																		</button>
	
																		<input type="hidden" name="committeeid"	value="<%=obj[0] %>" />
																		<input type="hidden" name="projectid"	value="0" />
																		<input type="hidden" name="divisionid"	value="0" />
																		<input type="hidden" name="initiationid" value="0" />
	 																	<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
																	</form> 
																	<form action="NonProjectCommitteeAutoSchedule.htm" method="post" name="myfrm"	style="display: inline">
																		<button class="editable-click" name="sub" value="Details" 	>
																			<div class="cc-rockmenu">
																				<div class="rolling">
																					<figure class="rolling_icon">
																						<i class="fa fa-calendar" aria-hidden="true" style="color:purple"></i>
																					</figure>
																					<span>Auto Schedule</span>
																				</div>
																			</div>
																		</button>
	
																		<input type="hidden" name="committeeid"	value="<%=obj[0] %>" />
																		<input type="hidden" name="projectid"	value="0" />
																		<input type="hidden" name="divisionid"	value="0" />
																		<input type="hidden" name="initiationid" value="0" />
	 																	<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
																	</form> 
																<%} %>
																	
																<%-- <form action="CommitteeDelete.htm" method="GET" name="myfrm"
																	style="display: inline">

																	<button class="editable-click" name="sub" value="Modify" onclick="return confirm('Are you sure To Remove this Committee ?')">
																		<div class="cc-rockmenu">
																			<div class="rolling">
																				<figure class="rolling_icon">
																					<img src="view/images/delete.png">
																				</figure>
																				<span>Delete</span>
																			</div>
																		</div>
																	</button>

																	<input type="hidden" name="committeeid"
																		value="<%=obj[0] %>" /> <input type="hidden"
																		name="${_csrf.parameterName}" value="${_csrf.token}" />

																</form>  --%>
																
																
															
																		
															</td>
														</tr>
												<% count1++; } %>

												</tbody>
												</table>												
												<input type="hidden" name="${_csrf.parameterName}"value="${_csrf.token}" />
											</div>
										</div>
									</div>
								</div> 
							</div>
						</div>
					</div>			
					<div class="card-footer" align="right">								
					</div>				
				</div>
<!-- Project committee -->
<script type="text/javascript">	
$('#projecttype').select2();
$(function () {
	  $('[data-toggle="tooltip"]').tooltip()
	})


function Prints(myfrm){
	
	 var fields = $("input[name='btSelectItem']").serializeArray();

	 
	  if (fields.length === 0){
		  myalert();
	 event.preventDefault();
	return false;
	}
		  return true;	 		
	}

function projectselectsubmit(frmid)
{
	$('#'+frmid).submit();
}

</script>

				
</body>
</html>