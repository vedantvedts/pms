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
<spring:url value="/resources/css/committeeModule/ComConstitutionApprovalHistory.css" var="ComConstitutionApprovalHistory" />
<link href="${ComConstitutionApprovalHistory}" rel="stylesheet" />
<title>COMMITTEE MEETING AGENDA APPROVAL  LIST</title>
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
			
		
			
			<%if(historydata.size()>0){ %>
			
				<div class="card shadow-nohover">
					<div class="card-header">
						<div class="row">
							<div class="col-md-10">
							<h3 class="h3Color"><%=committeedata[8]!=null?StringEscapeUtils.escapeHtml4(committeedata[8].toString()): " - " %>
							
								<p class="float-right">
									
										<%if(Long.parseLong(projectid)>0){ %> Project : <%=projectdata[4]!=null?StringEscapeUtils.escapeHtml4(projectdata[4].toString()): " - " %><%}else if (Long.parseLong(divisionid)>0){ %>  Division : <%=divisiondata[1]!=null?StringEscapeUtils.escapeHtml4(divisiondata[1].toString()): " - " %> <%}else if(Long.parseLong(initiationid)>0){ %>Initiated Project : <%=initiationdata[1]!=null?StringEscapeUtils.escapeHtml4(initiationdata[1].toString()): " - "%> <%} %> (Approval Pending)
									
								</p>
							</h3>
							</div>	
							<div class="col-md-2">
								<form action="CommitteeMainMembers.htm" method="post">
									<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
									<input type="hidden" name="committeemainid" value="<%=committeemainid%>">
									<button class="btn btn-primary btn-sm back float-right" type="submit">BACK</button>
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
															<th class="width-10">SN</th>
															<th class="width-40">Remarks</th>
															<th class="width-20">Action</th>
															<th class="width-20">ActionBy</th>
															<th class="width-10">Date</th>
														</tr>
													</thead>
													<tbody>
														<%int count=1;
														   	for (Object[] obj :historydata) {   %>
																<tr>
																	<td><%=count %></td>
																	<td><%=obj[3]!=null?StringEscapeUtils.escapeHtml4(obj[3].toString()): " - " %></td>
																	<td><%=obj[7]!=null?StringEscapeUtils.escapeHtml4(obj[7].toString()): " - " %></td>
																	<td><%=obj[8]!=null?StringEscapeUtils.escapeHtml4(obj[8].toString()): " - " %>(<%=obj[9]!=null?StringEscapeUtils.escapeHtml4(obj[9].toString()): " - " %>)</td>
																	<td><%=obj[6]!=null? sdf.format(sdf1.parse(StringEscapeUtils.escapeHtml4(obj[6].toString()))):" - "%> </td>															
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




</body>
</html>