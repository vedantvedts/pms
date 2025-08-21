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


<title>COMMITTEE MEETING AGENDA APPROVAL  LIST</title>
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
List<Object[]> committeelist=(List<Object[]>)request.getAttribute("approvallist");


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
			
		
			
			<%if(committeelist.size()>0){ %>
			
				<div class="card shadow-nohover">
					<div class="card-header">
						<div class="row">
							<div class="col-md-6">
								<h4>Committee Constitution Approval List</h4>
							</div>
							<div class="col-md-6">
								<a class="btn btn-primary btn-sm back" type="button" style="float: right; margin-top: -5px;" href="MainDashBoard.htm" >BACK</a>
							</div>
						</div>
					</div>
					
					
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
															<th>Committee Name</th>
															<th>Project / Division / Initiation /Non-Project</th>
															<th>Action</th>
														</tr>
													</thead>
													<tbody>
												<%int count=1;
												   	for (Object[] obj :committeelist) {   %>
														<tr>
															<td><%=count %></td>
															<td><%=obj[2]!=null?StringEscapeUtils.escapeHtml4(obj[2].toString()): " - " %></td>
															<td><%=obj[4]!=null?StringEscapeUtils.escapeHtml4(obj[4].toString()): " - " %></td>
															<td class="left width">		
																
																<form action="ComConstitutionApprovalDetails.htm" method="POST" name="myfrm" style="display: inline">

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

																	<input type="hidden" name="committeemainid"	value="<%=obj[0] %>" />
 																	<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />

																</form> 
																
															</td>
														</tr>
												<% count++; } %>
												</tbody>
												</table>
												
												<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
											</div>
										</div>
									</div>
								</div>
							</div>
						</div>

					</div>
				
				
				<div class="card-footer" align="right"></div>
				</div>
				
				<%} %>
				

				
			<%if(committeelist.size()==0){ %>
				
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




</body>
</html>