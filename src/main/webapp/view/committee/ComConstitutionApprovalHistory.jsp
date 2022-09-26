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
List<Object[]> historydata=(List<Object[]>)request.getAttribute("historydata");


Object[] projectdata=(Object[])request.getAttribute("projectdata"); 
Object[] divisiondata=(Object[])request.getAttribute("divisiondata"); 
Object[] initiationdata=(Object[])request.getAttribute("initiationdata");

Object[] committeedata=(Object[])request.getAttribute("committeedata");
String initiationid=committeedata[4].toString();
String divisionid=committeedata[3].toString();
String projectid=committeedata[2].toString();
String committeeid=committeedata[1].toString();
String committeemainid=committeedata[0].toString();
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
			
		
			
			<%if(historydata.size()>0){ %>
			
				<div class="card shadow-nohover">
					<div class="card-header">
						<div class="row">
							<div class="col-md-10">
							<h3 style="color:  #055C9D" ><%=committeedata[8] %>
							
								<p style="float: right;">
									
										<%if(Long.parseLong(projectid)>0){ %> Project : <%=projectdata[4] %><%}else if (Long.parseLong(divisionid)>0){ %>  Division : <%=divisiondata[1] %> <%}else if(Long.parseLong(initiationid)>0){ %>Initiated Project : <%=initiationdata[1]%> <%} %> (Approval Pending)
									
								</p>
							</h3>
							</div>	
							<div class="col-md-2">
								<form action="CommitteeMainMembers.htm" method="post">
									<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
									<input type="hidden" name="committeemainid" value="<%=committeemainid%>">
									<button class="btn btn-primary btn-sm back" type="submit" style="float: right;" >BACK</button>
								</form>
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
															<th style="width:10%" >SN</th>
															<th  style="width:40%">Remarks</th>
															<th  style="width:20%" >Action</th>
															<th  style="width:20%" >ActionBy</th>
															<th  style="width:10%">Date</th>
														</tr>
													</thead>
													<tbody>
														<%int count=1;
														   	for (Object[] obj :historydata) {   %>
																<tr>
																	<td><%=count %></td>
																	<td><%=obj[3] %></td>
																	<td><%=obj[7] %></td>
																	<td><%=obj[8] %>(<%=obj[9] %>)</td>
																	<td> <%= sdf.format(sdf1.parse( obj[6].toString()))%> </td>															
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
				
				
				<div class="card-footer" align="right"></div>
				</div>
				
				<%} %>
				

				
			<%if(historydata.size()==0){ %>
				
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




	<div class="modal" id="loader"></div>
</body>
</html>