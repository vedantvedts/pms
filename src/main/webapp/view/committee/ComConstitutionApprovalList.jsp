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
<spring:url value="/resources/css/committeeModule/ComConstitutionApprovalList.css" var="ComConstitutionApprovalList" />
<link href="${ComConstitutionApprovalList}" rel="stylesheet" />
<title>COMMITTEE MEETING AGENDA APPROVAL  LIST</title>
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
								<a class="btn btn-primary btn-sm back float-right mt-n5" type="button" href="MainDashBoard.htm" >BACK</a>
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
																
																<form action="ComConstitutionApprovalDetails.htm" class="d-inline" method="POST" name="myfrm">

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