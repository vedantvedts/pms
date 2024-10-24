<%@page import="com.vts.pfms.FormatConverter"%>
<%@page import="com.vts.pfms.cars.model.CARSSoCMilestonesProgress"%>
<%@page import="java.util.List"%>
<%@page import="com.vts.pfms.cars.model.CARSSoCMilestones"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<jsp:include page="../static/header.jsp"></jsp:include>
<style type="text/css">
label{
	font-weight: bold;
	font-size: 13px;
}

.milestoneProgressTable {
	width: 100%;
	border-collapse: collapse;
	margin: 1rem;	
}
.milestoneProgressTable td{
	padding: 10px;
}
</style>
</head>
<body>

<%
	String carsInitiationId = (String)request.getAttribute("carsInitiationId");
	String carsSoCMilestoneId = (String)request.getAttribute("carsSoCMilestoneId");
	CARSSoCMilestones carsSoCMilestones = (CARSSoCMilestones)request.getAttribute("carsSoCMilestones");
	List<CARSSoCMilestonesProgress> carsSoCMilestonesProgressList = (List<CARSSoCMilestonesProgress>)request.getAttribute("carsSoCMilestonesProgressList");
	
	FormatConverter fc = new FormatConverter();
%>

<% String ses=(String)request.getParameter("result"); 
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
		<div class="alert alert-success" role="alert" >
	    	<%=ses %>
		</div>
	</div>
<%} %>

	<div class="container-fluid">
		<div class="container" style="margin-bottom:20px;">
			<div class="card" style=" ">
				<div class="card-header" style="background-color: #055C9D; height: 50px;">
					<div class="row"> 
						<h6 class="text-white"><%=carsSoCMilestones.getMilestoneNo() %></h6>
					</div>
				</div>
				<div class="card-body">
					<form method="post" action="CARSMilestonesProgressDetailsSubmit.htm">
						<div class="row"> 
							<div class="col-md-2" align="left"  >
								<div class="form-group">
									<label  >Progress: <span class="mandatory" style="color: red;" >*</span></label>
									<input type="number" class="form-control" name="progress" id="progress" required="required" max="100" min="1">
								</div>
							</div>

							<div class="col-md-2" align="left"  >
								<div class="form-group">
									<label  >Progress Date: <span class="mandatory" style="color: red;">*</span></label>
									<input class="form-control " name="progressDate" id="progressDate" required="required">
								</div>
							</div>
							
							<div class="col-md-6" align="left"  >
								<div class="form-group">
									<label  >Remarks: <span class="mandatory" style="color: red;">*</span></label>
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
									<button class="btn btn-primary btn-sm back" formaction="CARSMilestonesMonitor.htm" formnovalidate="formnovalidate" >BACK</button>
								</div>
							</div>
						</div>
					</form>
				</div>
			</div>
		</div>
	</div>
	
	
	<div class="container-fluid">
		<div class="container" style="margin-bottom:20px;">
			<div class="card" style=" ">
				<div class="card-header" style="background-color: #055C9D; height: 50px;">
					<div class="row"> 
						<h6 class="text-white">Milestone Progress List</h6>
					</div>
				</div>
				<div class="card-body">
					<table class="milestoneProgressTable">
						<thead class="left">
							<tr>
								<th style="width: 10%;">SN</th>
								<th style="width: 20%;">Progress Date</th>
							 	<th style="width: 35%;">Progress</th>
							 	<th style="width: 35%;">Remarks</th>
							</tr>
						</thead>
						<tbody>
							<%	
							 	if(carsSoCMilestonesProgressList!=null && carsSoCMilestonesProgressList.size()>0){
							 		int count=0;
								for(CARSSoCMilestonesProgress progress: carsSoCMilestonesProgressList){ %>
								<tr>
									<td  ><%=++count %></td>
									<td  ><%=fc.sdfTordf(progress.getProgressDate()) %></td>
									<td >
										<%if(progress.getProgress()!=0){ %>
											<div class="progress" style="background-color:#cdd0cb !important;height: 1.4rem !important;">
												<div class="progress-bar progress-bar-striped" role="progressbar" style=" width: <%=progress.getProgress() %>%;" aria-valuenow="25" aria-valuemin="0" aria-valuemax="100" >
													<%=progress.getProgress() %>
												</div> 
											</div>
										<%}else{ %>
											<div class="progress" style="background-color:#cdd0cb !important;height: 1.4rem !important;">
												<div class="progress-bar" role="progressbar" style=" width: 100%; background-color:#cdd0cb !important;color:black;font-weight: bold;  "  >
													0
												</div>
											</div>
										<%} %>
									</td>
									<td class="left"><%=progress.getRemarks() %></td>
								</tr>
							<%  } }else{%>
								<tr>
									<td colspan="6" style="text-align: center">No List Found</td>
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