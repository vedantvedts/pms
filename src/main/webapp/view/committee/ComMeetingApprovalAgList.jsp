<%@page import="org.apache.commons.text.StringEscapeUtils"%>
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
<spring:url value="/resources/css/committeeModule/ComMeetingApprovalAgList.css" var="ComMeetingApprovalAgList" />
<link href="${ComMeetingApprovalAgList}" rel="stylesheet" />
<title>COMMITTEE MEETING AGENDA APPROVAL  LIST</title>
</head>
<body>

<%
SimpleDateFormat sdf=new SimpleDateFormat("dd-MM-yyyy");
SimpleDateFormat sdf1=new SimpleDateFormat("yyyy-MM-dd");
List<Object[]> hlo=(List<Object[]>)request.getAttribute("MeetingApprovalAgList");
List<Object[]> hlo1=(List<Object[]>)request.getAttribute("MeetingApprovalMinutes");


%>

 <!-- ----------------------------------message ------------------------- -->

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

<!-- ----------------------------------message ------------------------- -->

	<br>

	<div class="container-fluid">
		<div class="row">
			<div class="col-md-12">
			
			<%if(hlo.size()<0 && hlo1.size()<0 || hlo.isEmpty() && hlo1.isEmpty()){ %>
			
			<h4 class="meetingApprovalStyle">Meeting Approvals</h4>
			
			<%} %>
			
			<%if(hlo.size()>0){ %>
			
				<div class="card shadow-nohover">
				
					<h3 class="card-header">Meeting Agenda Approval List</h3>
					
					<div class="card-body">

						<div class="data-table-area mg-b-15">
							<div class="container-fluid">

								<div class="col-lg-12 col-md-12 col-sm-12 col-xs-12">
									<div class="sparkline13-list">

										<div class="sparkline13-graph">
											<div class="datatable-dashv1-list custom-datatable-overright">
												
												<table id="table" data-toggle="table" data-pagination="true">
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
															<td><%=obj[12]!=null?StringEscapeUtils.escapeHtml4(obj[12].toString()): " - " %></td>
															<td><%=obj[2]!=null?StringEscapeUtils.escapeHtml4(obj[2].toString()): " - " %></td>
															<td><%= obj[9]!=null?sdf.format(sdf1.parse( StringEscapeUtils.escapeHtml4(obj[9].toString()))):" - " %></td>
															<td><%=obj[10]!=null?StringEscapeUtils.escapeHtml4(obj[10].toString()): " - " %>
															<td><%=obj[11]!=null?StringEscapeUtils.escapeHtml4(obj[11].toString()): " - " %></td>
															<td class="left width">		
																
																<form action="MeetingApprovalAgendaDetails.htm" method="POST" name="myfrm" class="displayStyle">

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
																	<%-- <input type="hidden" name="empid"	value="<%=obj[7] %>" />
																	<input type="hidden" name="committeename"	value="<%=obj[1] %>" />
																	<input type="hidden" name="committeemainid"	value="<%=obj[0] %>" /> --%>
																	<input type="hidden" name="committeename"	value="<%=obj[1] %>" />
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

				<br>
				<%}%>
				
				
				<%if(hlo1.size()>0){ %>
				
				<div class="card shadow-nohover">
				
					<h3 class="card-header">Meeting Minutes Approval List</h3>
					
					<div class="card-body">

						<div class="data-table-area mg-b-15">
							<div class="container-fluid">

								<div class="col-lg-12 col-md-12 col-sm-12 col-xs-12">
									<div class="sparkline13-list">

										<div class="sparkline13-graph">
											<div class="datatable-dashv1-list custom-datatable-overright">
												
												<table id="table" data-toggle="table" data-pagination="true">
													<thead>

														<tr>
															<th>Serial No</th>
															<th>Committee Name</th>
															<th>Schedule Date</th>
															<th>Schedule Time</th>
															<th>Project / Non-Project</th>
															<th>Action</th>
														</tr>
													</thead>
													<tbody>
														<%int count=1;
										   	for (Object[] obj :hlo1) {
										   			   %>
														<tr>
															<td><%=count %></td>
															<td><%=obj[2]!=null?StringEscapeUtils.escapeHtml4(obj[2].toString()): " - " %></td>
															<td><%= obj[9]!=null?sdf.format(sdf1.parse(StringEscapeUtils.escapeHtml4(obj[9].toString()))):" - "%></td>
															<td><%=obj[10]!=null?StringEscapeUtils.escapeHtml4(obj[10].toString()): " - " %>
															<td><%=obj[11]!=null?StringEscapeUtils.escapeHtml4(obj[11].toString()): " - " %></td>
															<td class="left width">		
																
																<form class="displayStyle" action="MeetingApprovalMinutesDetails.htm" method="POST" name="myfrm">

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
				
				<%} %>
				

				
			<%if(hlo.size()<0 && hlo1.size()<0 || hlo.isEmpty() && hlo1.isEmpty()){ %>
				
				<div align="center">
					 	
					 	<br><br><br><br>
					 	
					 	<br><br>
					 	<h2>No Pending 	Approvals ..!!! </h2>
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
</body>
</html>