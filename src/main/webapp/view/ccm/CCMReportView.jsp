<%@page import="com.vts.pfms.FormatConverter"%>
<%@page import="com.vts.pfms.committee.model.CommitteeSchedule"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<jsp:include page="../static/header.jsp"></jsp:include>
<style type="text/css">
label {
	font-weight: 800;
	font-size: 16px;
	color: #07689f;
}

.tab-pane p{
	text-align: justify;
	
}

.tabpanes1 {
	min-height: 651px;
    max-height: 651px;
    overflow: auto;
    scrollbar-width: thin;
    scrollbar-height: thin;
  	scrollbar-color: #216583 #f8f9fa;
}

.card-body {
    padding-bottom: 50px; /* Add some padding to make sure content doesn't overlap with the buttons */
}

/* Chrome, Edge, and Safari */
.tabpanes1::-webkit-scrollbar {
  width: 12px;
}

.tabpanes1::-webkit-scrollbar-track{
  background: #f8f9fa;
  border-radius: 5px;
}

.tabpanes1::-webkit-scrollbar-thum {
  background-color: #216583;
  border-radius: 5px;
  border: 2px solid #f8f9fa;
}


.card-body{
	padding: 0rem !important;
}


 .b{
	background-color: #ebecf1;	
}
.a{
	background-color: #d6e0f0;
}

.nav-links{
	text-align: left;
}

body { 
   font-family : "Lato", Arial, sans-serif !important;
   overflow-x: hidden;
}

input,select,table,div,label,span {
	font-family : "Lato", Arial, sans-serif !important;
}


.center {
	text-align: center !important;
}

.right {
	text-align: right !important;
}

.left {
	text-align: left !important;
}

.fw-bold {
	font-weight: bold;
}
.select2-selection__rendered{
	text-align: left !important;
}

.data-table {
	overflow-y: auto; 
	overflow-x: auto; 
}

.data-table thead {
    position: sticky;
	top: 0; /* Keeps the header at the top */
	z-index: 10; /* Ensure the header stays on top of the body */
	background-color: white; /* For visibility */
	background-color: #4B70F5;
    color: #ffff !important;
}

.data-table tbody td {
	border-left: 0px !important;
	border-right: 0px !important;
}

.data-table td {
	padding: 1rem !important;
}

</style>

</head>
<body>
	<%
	List<CommitteeSchedule> ccmScheduleList = (List<CommitteeSchedule>)request.getAttribute("ccmScheduleList");
	
	FormatConverter fc = new FormatConverter();
	%>
	<div class="container-fluid mb-3">
		<div class="card shadow-nohover">
 			<div class="card-header" style="background-color: transparent;height: 3rem;">
 				<div class="row">
 					<div class="col-md-3">
 						<h3 class="text-dark" style="font-weight: bold;">CCM Report
 							<a class="btn btn-info btn-sm shadow-nohover back mb-2" href="CCMModules.htm">
	 							<i class="fa fa-home" aria-hidden="true" style="font-size: 1rem;"></i> 
	 							CCM
 							</a> 
 						</h3>
 					</div>
 					<div class="col-md-7"></div>
 					<div class="col-md-2 right">
 					</div>
 					
 				</div>
       		</div>
       		<div class="card-body">
       			<div class="tab-pane active" id="meetingschedule" role="tabpanel">
       				<div class="container-fluid mt-3 tabpanes1">
		       			<table class="table table-bordered table-hover table-striped table-condensed data-table">
		       				<thead class="center">
		       					<tr>
		       						<th>SN</th>
		       						<th>CCM No</th>
		       						<th>Meeting Date & Time</th>
		       						<th>Docs</th>
		       					</tr>
		       				</thead>
		       				<tbody>
		       					<%if(ccmScheduleList!=null && ccmScheduleList.size()>0) {
		       						int slno = 0;
		       						for(CommitteeSchedule ccm : ccmScheduleList) {%>
		       							<tr class="center">
		       								<td style="padding: 0.8rem !important;"><%=++slno %></td>
		       								<td style="padding: 0.8rem !important;"><b><%=ccm.getMeetingId() %></b></td>
		       								<td style="padding: 0.8rem !important;"><%=fc.sdfTordf(ccm.getScheduleDate().toString()) %> & <%=ccm.getScheduleStartTime() %></td>
		       								<td class="center" style="padding: 0.8rem !important;">
		       									<form action="#"> 
													<button type="submit" class="btn btn-sm " formaction="CCMAgendaPresentation.htm" formmethod="GET" formtarget="_blank" title="" style="border: 0 ;border-radius: 3px;" data-toggle="tooltip" data-placement="top" data-original-title="Presentation">
														<img alt="" src="view/images/presentation.png" style="width:19px !important">
													</button>
													&emsp;
													<button type="submit" class="btn btn-sm" formaction="CCMPresentationDownload.htm" formmethod="GET" formtarget="_blank" style="border: 0 ;border-radius: 3px;" data-toggle="tooltip" data-placement="top" title="" data-original-title="Presentation pdf">
														<img alt="" src="view/images/presentation.png" style="width:19px !important"><i class="fa fa-download" aria-hidden="true" style="margin-left:6px;"></i>
													</button>
													
													<%-- <%if(ccm.getScheduleFlag().equalsIgnoreCase("MKV") || ccm.getScheduleFlag().equalsIgnoreCase("MMR") ){ %> --%>
													&emsp;
													<button type="submit" class="btn btn-sm prints" formaction="CommitteeMinutesViewAllDownload.htm" formmethod="GET" formtarget="_blank"  style="font-size:12px;">
														MINUTES <i class="fa fa-download text-white" style="font-size: 12px;"></i>
													</button>
													&emsp;
													<button type="submit" class="btn btn-sm view" formaction="MeetingTabularMinutesDownload.htm" formmethod="GET" formtarget="_blank" style="background-color:#0e49b5 ;color:white ;font-size:12px;">
														TABULAR MINUTES <i class="fa fa-download text-white" style="font-size: 12px;"></i>
													</button>
													<%-- <%} %> --%>
													<input type="hidden" name="isFrozen" value="<%=ccm.getPresentationFrozen()%>">
													<input type="hidden" name="committeescheduleid" value="<%=ccm.getScheduleId()%>">
													<input type="hidden" name="scheduleid" value="<%=ccm.getScheduleId()%>">
													<input type="hidden" name="ccmScheduleId" value="<%=ccm.getScheduleId()%>">
													<input type="hidden" name="committeeId" value="<%=ccm.getCommitteeId()%>">
												</form>
		       								</td>
		       							</tr>
		       					<%} }%>
		       				</tbody>
		       			</table>
		       		</div>
		       	</div>		
       		</div>
       	</div>
	</div>		
</body>
</html>