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


<title>COMMITTEE MEETING MINUTES APPROVAL  LIST</title>
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
}

#table tbody tr td {
	padding: 2px 3px !important;
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
	width: 270px !important;
}

a:hover {
	color: white;
}



</style>
</head>
<body>

<%
SimpleDateFormat sdf=new SimpleDateFormat("dd-MM-yyyy");
SimpleDateFormat sdf1=new SimpleDateFormat("yyyy-MM-dd");
List<Object[]> hlo=(List<Object[]>)request.getAttribute("MeetingApprovalMinutes");


%>

 <!-- ----------------------------------message ------------------------- -->

	<%String ses=(String)request.getParameter("result"); 
 String ses1=(String)request.getParameter("resultfail");
	if(ses1!=null){
	%>


	<center>

		<div class="alert alert-danger" role="alert">
			<%=ses1 %>
		</div>
	</center>
	<%}if(ses!=null){ %>
	<center>
		<div class="alert alert-success" role="alert">
			<%=ses %>
		</div>

	</center>


	<%} %>

<!-- ----------------------------------message ------------------------- -->

	<br>

	<div class="container-fluid">
		<div class="row">
			<div class="col-md-12">
			
			<%if(hlo.size()<0){ %>
			
			<h4 style="margin-top: -20px;color:#055C9D">Meeting Approvals</h4>
			
			<%} %>
			
			<%if(hlo.size()>0){ %>
			
				<div class="card shadow-nohover">
				
					<h3 class="card-header">Meeting Minutes Approval List</h3>
					
					<div class="card-body">

						<div class="data-table-area mg-b-15">
							<div class="container-fluid">



								<div class="col-lg-12 col-md-12 col-sm-12 col-xs-12">
									<div class="sparkline13-list">

										<div class="sparkline13-graph">
											<div class="datatable-dashv1-list custom-datatable-overright">
												<div id="toolbar">
													<select class="form-control dt-tb">
														<option value="">Export Basic</option>
														<option value="all">Export All</option>
														<option value="selected">Export Selected</option>
													</select>
												</div>
												<table id="table" data-toggle="table" data-pagination="true"
													data-search="true" data-show-columns="true"
													data-show-pagination-switch="true" data-show-refresh="true"
													data-key-events="true" data-show-toggle="true"
													data-resizable="true" data-cookie="true"
													data-cookie-id-table="saveId" data-show-export="true"
													data-click-to-select="true" data-toolbar="#toolbar">
													<thead>

														<tr>
															<th>SN</th>
															<th>Meeting Id</th>
															<th>Committee Name</th>
															<th>Schedule Date</th>
															<th>Schedule Time</th>
															<th>Project / Non-Project</th>
															<th>Action</th>
														</tr>
													</thead>
													<tbody>
														<%int count=1;
										   	for (Object[] obj :hlo) {
										   			   %>
														<tr>
															<td><%=count %></td>
															<td><%= obj[12]%></td>
															<td><%=obj[2] %></td>
															<td><%= sdf.format(sdf1.parse( obj[9].toString()))%></td>
															<td><%=obj[10] %>
															<td><%=obj[11] %></td>
															<td class="left width">		
																
																<form action="MeetingApprovalMinutesDetails.htm" method="POST" name="myfrm"
																	style="display: inline">

																	<button class="editable-click" name="sub" value="Details" 	>
																		<div class="cc-rockmenu">
																			<div class="rolling">
																				<figure class="rolling_icon">
																					<img src="view/images/preview3.png">
																				</figure>
																				<span>Details</span>
																			</div>
																		</div>
																	</button>

																	<input type="hidden" name="scheduleid"	value="<%=obj[8] %>" />
																	<input type="hidden" name="empid"	value="<%=obj[7] %>" />
																	<input type="hidden" name="committeename"	value="<%=obj[2] %>" />
																	<input type="hidden" name="committeemainid"	value="<%=obj[0] %>" />
 																	<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />

																</form> 
																
																
																
																		
															</td>
														</tr>
												<% count++; } %>

												</tbody>
												</table>
												
				<input type="hidden" name="${_csrf.parameterName}"
													value="${_csrf.token}" />


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

				<%}else{ %>
				
				<div align="center">
					 	
					 	<br><br><br><br>
					
					 	<br><br>
					 	<h2>No Pending Approvals ..!!! </h2>
					 	<br><br>
					 	<a class="btn btn-primary back" href="MainDashBoard.htm" role="button">Back</a>
					 
					 </div>
					 
					 <%} %>
				
	
			</div>

		</div>

	</div>




	<script type="text/javascript">
	
	
	$("#fromyear,#toyear").datepicker({
		
		autoclose: true,
		 format: 'yyyy',
			 viewMode: "years", 
			    minViewMode: "years"
	});

	

	
	  $('#fromyear,#toyear').on('keyup', function() { 
	    if($(this).val().length > 3) {
	        $('#form1').submit();
	    }
	});  
	
	 
	 
	
	
	
	

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

/* 
$(document).ready(function(){
	
	$("#table").DataTable({
		"pageLength": 5
	})
})

 */

</script>
	<div class="modal" id="loader">
		<!-- Place at bottom of page -->
	</div>
</body>
</html>