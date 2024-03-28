<%@page import="java.util.Date"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="com.vts.pfms.FormatConverter"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<jsp:include page="../static/header.jsp"></jsp:include>
<title>Mom Report List</title>
<style type="text/css">

</style>
</head>
<body>
<%
FormatConverter fc=new FormatConverter(); 
SimpleDateFormat sdf=fc.getRegularDateFormat();
SimpleDateFormat  sdf1=fc.getSqlDateFormat();

List<Object[]> projectList=(List<Object[]>) request.getAttribute("projectList");
List<Object[]>  projectCommitteList=(List<Object[]>)request.getAttribute("projectCommitteList");

String projectId=(String)request.getAttribute("projectId");
String committeeId=(String)request.getAttribute("committeeId");

List<Object[]> MomReportList=(List<Object[]>)request.getAttribute("MomReportList");
SimpleDateFormat sdfInput = new SimpleDateFormat("HH:mm:ss");

%>
    <br/>
</body>
<div class="container-fluid">
		<div class="row">
			<div class="col-md-12">
				<div class="card shadow-nohover">
           <div class="card-header ">  
					<div class="row">
						<h4 class="col-md-4">MOM Report List</h4>  
							<div class="col-md-8" style="float: right; margin-top: -8px;" >
					   			<form method="post" action="MomReportList.htm" name="dateform" id="myform">
					   				<table style="margin-left: 10rem;">
					   					<tr>
					   						<td>
					   							<label class="control-label" style="font-size: 17px; margin-bottom: .0rem;">Project: </label>
					   						</td>
					   						<td style="max-width: 300px; padding-right: 50px">
                                               <select class="form-control selectdee" id="projectid" required="required" name="projectid" onchange='submitForm1();' >
										<% if(projectList!=null && projectList.size()>0){
										 for (Object[] obj : projectList) {
											 String projectshortName=(obj[17]!=null)?" ( "+obj[17].toString()+" ) ":"";			 
										 %>
												<option value="<%=obj[0]%>" <%if(obj[0].toString().equals(projectId)){ %>selected<%} %> ><%=obj[4]+projectshortName%></option>
										<%}} %>
								             </select>       
											</td>
											<td>
					   							<label class="control-label" style="font-size: 17px; margin-bottom: .0rem;">Committee: </label>
					   						</td>
					   						<td style="max-width: 300px; padding-right: 50px">
                                              <select class="form-control selectdee" id="committeeid" required="required" name="committeeid" onchange='submitForm();' >
							   			        	<%if(projectCommitteList!=null && projectCommitteList.size()>0){
							   			        	  for (Object[] obj : projectCommitteList) {%>
											     <option value="<%=obj[0]%>"  <%if(obj[0].toString().equals(committeeId)){ %>selected<%} %> ><%=obj[3]%></option>
											        <%}} %>   
							  	             </select>
											</td>
					   					</tr>   					   				
					   				</table>
					   				<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" /> 
					   			</form>
		   					</div>
		   				</div>	   							
					</div>
					
						<div class="card-body"> 
		               <form action="#" >
		                <input type="hidden" name="${_csrf.parameterName}"	value="${_csrf.token}" /> 
					 <div class="data-table-area mg-b-15">
			            <div class="container-fluid">
			                
			                    <div class="col-lg-12 col-md-12 col-sm-12 col-xs-12">
			                        <div class="sparkline13-list">
			                            <div class="sparkline13-graph">
			                                <div class="datatable-dashv1-list custom-datatable-overright">
			                    
			                <table class="table table-bordered table-hover table-striped table-condensed " id="myTable" > 
			                      <thead>

														<tr>
															<th style="text-align: center;">SN</th>
			                                                <th style="text-align: center;">Meeting Id</th>
			                                                <th style="text-align: center;">Schedule Date</th>
			                                                <th style="text-align: center;">ScheduleStart Time</th>
			                                                <th style="text-align: center;">MeetingVenue </th>
			                                                <th style="text-align: center;">Action</th>
														</tr>
													</thead>
													<tbody>
													   <%if(MomReportList!=null && MomReportList.size()>0){
													   int count=0; 
													   for(Object[] 	obj:MomReportList){
														   Date time = sdfInput.parse(obj[4].toString());
														   SimpleDateFormat sdfOutput = new SimpleDateFormat("hh:mm a");
														   String ScheduleTime=sdfOutput.format(time);
														   %>
													   
													    <tr>
													    <td align="center"><%=++count %></td>
													    <td ><%if(obj[2]!=null){%><%=obj[2] %><%}else{ %>-<%} %></td>
													    <td align="center"><%if(obj[3]!=null){%><%=sdf.format(obj[3]) %><%}else{ %>-<%} %></td>
													    <td align="center"><%=ScheduleTime %></td>
													    <td ><%if(obj[5]!=null){%><%=obj[5] %><%}else{ %>-<%} %></td>
													    <td align="center">
													    <button type="submit" class="btn btn-sm " formaction="CommitteeMinutesNewDownload.htm" id=<%="committeescheduleid"+obj[0]%> value="<%=obj[0] %>"  name="committeescheduleid" formmethod="post" formtarget="_blank">
												           <i class="fa fa-download fa-lg"></i>
											            </button>
														</td>
													  </tr>
 												<%}} %>
											</tbody>
												</table>												
											</div>
										</div>
									</div>
								</div>
							</div>
						</div>
						</form>
					</div>
				</div>
			</div>
		</div>
		</div>
</body>
<script>
$(document).ready(function(){
	  $("#myTable").DataTable({
	 "lengthMenu": [ 10,20, 40, 60, 80, 100 ],
	 "pagingType": "simple",
	 "pageLength": 10
	});
});
function submitForm()
{ 
  document.getElementById('myform').submit(); 
}
function submitForm1()
{ 
	$("#committeeid").val("all").change();
}
</script>
</html>