<%@page import="org.apache.commons.text.StringEscapeUtils"%>
<%@page import="com.vts.pfms.FormatConverter"%>
<%@page import="com.vts.pfms.cars.model.CARSSoCMilestonesProgress"%>
<%@page import="java.util.List"%>
<%@page import="com.vts.pfms.cars.model.CARSSoCMilestones"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<jsp:include page="../static/header.jsp"></jsp:include>

<spring:url value="/resources/css/cars/CARSMilestonesProgressDetails.css" var="carsMilestonesProgressDetails" />
<link href="${carsMilestonesProgressDetails}" rel="stylesheet" />
<spring:url value="/resources/css/cars/carscommon.css" var="carscommon4" />
<link href="${carscommon4}" rel="stylesheet" />

</head>
<body>

<%
	String carsInitiationId = (String)request.getAttribute("carsInitiationId");
	String carsSoCMilestoneId = (String)request.getAttribute("carsSoCMilestoneId");
	CARSSoCMilestones carsSoCMilestones = (CARSSoCMilestones)request.getAttribute("carsSoCMilestones");
	List<CARSSoCMilestonesProgress> carsSoCMilestonesProgressList = (List<CARSSoCMilestonesProgress>)request.getAttribute("carsSoCMilestonesProgressList");
	String presFlag = (String)request.getAttribute("presFlag");
	
	FormatConverter fc = new FormatConverter();
%>

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
		<div class="container mb-20" >
			<div class="card" >
				<div class="card-header card-head"  >
					<div class="row"> 
						<h6 class="text-white"><%=carsSoCMilestones.getMilestoneNo()!=null?StringEscapeUtils.escapeHtml4(carsSoCMilestones.getMilestoneNo()): " - " %></h6>
					</div>
				</div>
				<div class="card-body">
					<form method="post" action="CARSMilestonesProgressDetailsSubmit.htm">
						<div class="row"> 
							<div class="col-md-2" align="left"  >
								<div class="form-group">
									<label  >Progress: <span class="mandatory" >*</span></label>
									<input type="number" class="form-control" name="progress" id="progress" required="required" max="100" min="1">
								</div>
							</div>

							<div class="col-md-2" align="left"  >
								<div class="form-group">
									<label  >Progress Date: <span class="mandatory">*</span></label>
									<input class="form-control " name="progressDate" id="progressDate" required="required">
								</div>
							</div>
							
							<div class="col-md-6" align="left"  >
								<div class="form-group">
									<label  >Remarks: <span class="mandatory">*</span></label>
									<input type="text" name="remarks" class="form-control" maxlength="1000" required="required" value="Nil">
								</div>
							</div>
							
						</div>
						<div class="row" align="center">
							<div class="col-sm-12" align="center">
								<div class="form-group">
									<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
									<input type="hidden" name="carsInitiationId" value="<%=carsInitiationId %>" />
									<input type="hidden" name="carsSoCMilestoneId" value="<%=carsSoCMilestoneId %>" />
									<button type="submit" class="btn btn-sm btn-success submit " name="Action" value="Add" onclick="return confirm('Are you sure to submit?')" >SUBMIT</button>
									<button class="btn btn-primary btn-sm back" formaction="<%if(presFlag!=null && presFlag.equalsIgnoreCase("A")) {%>CARSReportPresentation.htm<%}else {%>CARSMilestonesMonitor.htm<%} %>" formnovalidate="formnovalidate" >BACK</button>
								</div>
							</div>
						</div>
					</form>
				</div>
			</div>
		</div>
	</div>
	
	
	<div class="container-fluid">
		<div class="container mb-20">
			<div class="card" >
				<div class="card-header card-head" >
					<div class="row"> 
						<h6 class="text-white">Milestone Progress List</h6>
					</div>
				</div>
				<div class="card-body">
					<table class="milestoneProgressTable">
						<thead class="left">
							<tr>
								<th class="w-10">SN</th>
								<th class="w-20">Progress Date</th>
							 	<th class="w-35">Progress</th>
							 	<th class="w-35">Remarks</th>
							</tr>
						</thead>
						<tbody>
							<%	
							 	if(carsSoCMilestonesProgressList!=null && carsSoCMilestonesProgressList.size()>0){
							 		int count=0;
								for(CARSSoCMilestonesProgress progress: carsSoCMilestonesProgressList){ %>
								<tr>
									<td  ><%=++count %></td>
									<td  ><%=progress.getProgressDate()!=null?fc.sdfTordf(StringEscapeUtils.escapeHtml4(progress.getProgressDate())):" - " %></td>
									<td >
										<%if(progress.getProgress()!=0){ %>
											<div class="progress pro-bg" >
												<div class="progress-bar progress-bar-striped width-<%=progress.getProgress() %>" role="progressbar" aria-valuenow="25" aria-valuemin="0" aria-valuemax="100" >
													<%=progress.getProgress() %>
												</div> 
											</div>
										<%}else{ %>
											<div class="progress pro-bg">
												<div class="progress-bar w-100 pro-bground" role="progressbar"   >
													0
												</div>
											</div>
										<%} %>
									</td>
									<td class="left"><%=progress.getRemarks()!=null?StringEscapeUtils.escapeHtml4(progress.getRemarks()): " - " %></td>
								</tr>
							<%  } }else{%>
								<tr>
									<td colspan="6" class="text-center">No List Found</td>
								</tr>
							<%}%>
						</tbody>
					</table>
				</div>
			</div>
		</div>
	</div>
<script type="text/javascript">
$(document).ready(function() {
$('#progressDate').daterangepicker({
	"singleDatePicker" : true,
	"linkedCalendars" : false,
	"showCustomRangeLabel" : true,	
	"cancelClass" : "btn-default",
	showDropdowns : true,
	locale : {
		format : 'DD-MM-YYYY'
	}
});

});

</script>
	
</body>
</html>