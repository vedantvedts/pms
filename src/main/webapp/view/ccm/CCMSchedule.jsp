<%@page import="java.util.Comparator"%>
<%@page import="java.util.Map"%>
<%@page import="java.util.AbstractMap"%>
<%@page import="java.util.stream.Collectors"%>
<%@page import="java.util.List"%>
<%@page import="com.vts.pfms.ccm.model.CCMSchedule"%>
<%@page import="java.time.format.DateTimeFormatter"%>
<%@page import="java.time.LocalTime"%>
<%@page import="java.time.temporal.TemporalAdjusters"%>
<%@page import="com.vts.pfms.FormatConverter"%>
<%@page import="java.time.LocalDate"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>    
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<jsp:include page="../static/header.jsp"></jsp:include>
<spring:url value="/resources/ckeditor/ckeditor.js" var="ckeditor" />
<spring:url value="/resources/ckeditor/contents.css" var="contentCss" />
<script src="${ckeditor}"></script>

<spring:url value="/resources/jquery-ui.css" var="JqueryUIcss" />  
<link href="${JqueryUIcss}" rel="stylesheet" />

<style type="text/css">
label {
	font-weight: 800;
	font-size: 16px;
	color: #07689f;
}

.tab-pane p{
	text-align: justify;
	
}

.tabpanes {
	min-height: 600px;
    max-height: 600px;
    overflow: auto;
    scrollbar-width: thin;
  	scrollbar-color: #216583 #f8f9fa;
}

.card-body {
    padding-bottom: 50px; /* Add some padding to make sure content doesn't overlap with the buttons */
}

/* Chrome, Edge, and Safari */
.tabpanes::-webkit-scrollbar {
  width: 12px;
}

.tabpanes::-webkit-scrollbar-track {
  background: #f8f9fa;
  border-radius: 5px;
}

.tabpanes::-webkit-scrollbar-thum {
  background-color: #216583;
  border-radius: 5px;
  border: 2px solid #f8f9fa;
}


.card-body{
	padding: 0rem !important;
}

.navigation_btn{
	margin: 1%;
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
.text-center{
	text-align: left !imporatant;
}

.previous{
	color: white !important;
}

.previous, .next{
	font-family: 'Montserrat', sans-serif;
    font-weight: 800 !important;
}

.next {
  padding: 4px 16px;
  font-weight: 800;
  background-color: #394989;
  border-color: #394989;
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

.agendaItemBtn > p {
	margin-bottom : 0;
}

.panel-bottom {
    bottom: 10px;
    right: 10px;
    text-align: right;
}

.ccmSideBar {
	min-height: 670px;
    max-height: 670px;
    overflow-y: auto;
    overflow-x: hidden;
    scrollbar-width: thin;
  	scrollbar-color: #007bff #f8f9fa;
}

.ccmSideBarButton {
	margin-right: 0.25rem;
	margin-left: 0.25rem;
	margin-top: 0.25rem;
	width: 97%;
}

.panel-buttons {
	margin: 1%;
}

.btn-print {
	background-color: purple;
	border: none;
	color: white;
	font-weight: bold;
	text-decoration: none;
}
</style>

<style type="text/css">
.nav-links.active {
	color: green !important;
	font-weight: bold;
	border: none !important;
	display: block;
    padding: .5rem 1rem;
}

.nav-links {
	color: black !important;
	font-weight: bold;
	border: none !important;
	display: block;
    padding: .5rem 1rem;
}

</style>

</head>
<body>
<%
String tabId = (String)request.getAttribute("tabId");
String monthyear = (String)request.getAttribute("monthyear");
String monthyeartext = (String)request.getAttribute("monthyeartext");
LocalDate selectedDate = (LocalDate)request.getAttribute("selectedDate");
String selectedMonthStartDate = (String)request.getAttribute("selectedMonthStartDate");
String selectedMonthEndDate = (String)request.getAttribute("selectedMonthEndDate");

FormatConverter fc = new FormatConverter();
String minDate = fc.sdfTordf(selectedMonthStartDate);
String startDate = fc.sdfTordf(selectedDate.toString());
String endDate = fc.sdfTordf(selectedMonthEndDate);

LocalTime currentTime = LocalTime.now();

List<CCMSchedule> ccmScheduleList = (List<CCMSchedule>) request.getAttribute("ccmScheduleList");
if (ccmScheduleList != null && !ccmScheduleList.isEmpty()) {
    ccmScheduleList = ccmScheduleList.stream()
        .map(e -> {
            LocalDate meetingDate = LocalDate.parse(e.getMeetingDate().substring(0, 10));
            return new AbstractMap.SimpleEntry<>(e, meetingDate);
        })
        .sorted((entry1, entry2) -> entry2.getValue().compareTo(entry1.getValue())) // Sort in descending order
        .map(Map.Entry::getKey)
        .collect(Collectors.toList());
}

/* CCMSchedule ccmScheduleData = ccmScheduleList!=null && ccmScheduleList.size()>0 ? ccmScheduleList.stream()
							  .map(e -> {
						          LocalDate meetingDate = LocalDate.parse(e.getMeetingDate().substring(0,10));
						          return new AbstractMap.SimpleEntry<>(e, meetingDate);
						      })
						      .filter(entry -> {
						          LocalDate meetingDate = entry.getValue();
						          return (meetingDate.equals(selectedDate) || 
						                  meetingDate.equals(LocalDate.parse(selectedMonthEndDate)) || 
						                  (meetingDate.isAfter(selectedDate) && meetingDate.isBefore(LocalDate.parse(selectedMonthEndDate))));
						      })
						      .sorted(Comparator.comparing(Map.Entry::getValue))
						      .map(Map.Entry::getKey)
						      .findFirst()
						      .orElse(null)
						      : null;
long ccmScheduleId = ccmScheduleData!=null?ccmScheduleData.getCCMScheduleId():0; */
String ccmScheduleId =  request.getAttribute("ccmScheduleId")!=null?(String)request.getAttribute("ccmScheduleId"):"0";

List<Object[]> agendaList = (List<Object[]>) request.getAttribute("agendaList");

CCMSchedule ccmScheduleData = ccmScheduleList!=null && ccmScheduleList.size()>0 ? ccmScheduleList.stream()
							.filter(e -> e.getCCMScheduleId()==(Long.parseLong(ccmScheduleId)))
							.findFirst().orElse(null) : null;

List<Object[]> allLabList = (List<Object[]>) request.getAttribute("allLabList");
List<Object[]> labEmpList=(List<Object[]>)request.getAttribute("labEmpList");
String labcode =  (String)request.getAttribute("labcode");
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
	
	<div class="container-fluid mb-3">
		<div class="card shadow-nohover">
 			<div class="card-header" style="background-color: transparent;height: 3rem;">
 				<div class="row">
 					<div class="col-md-2">
 						<h3 class="text-dark" style="font-weight: bold;">Schedule CCM</h3>
 					</div>
 					<div class="col-md-8"></div>
 					<div class="col-md-2 right">
	 					<form action="CCMSchedule.htm" method="post">
	 						<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
	 						<label class="control-label">Choose : </label>
	 						<input class="monthpicker" type="hidden"  name="monthyear" id="monthyear" value="<%=monthyear %>" onchange="this.form.submit()">
	       					<!-- <input class="btn btn-sm" type="button"  style="text-transform: capitalize;" /> -->
	       					<button type="button" class="btn btn-sm submit" name="monthyeartext" id="monthyeartext" value="<%=monthyeartext.toLowerCase() %>" 
	       						style="text-transform: capitalize;background-color: #007bff;border-color: #007bff;" data-toggle="tooltip" data-placement="top" title="Choose Month & Year" >
	       						<%=monthyeartext.toLowerCase() %> &emsp; <i class="fa fa-calendar-check-o" aria-hidden="true" style=""></i>
	       					</button>
	 					</form>
 					</div>
 					
 				</div>
       		</div>
       	
       		<div class="card-body">
       			<div class="row ml-2 mr-2">
       				<div class="col-md-2 p-0">
       					<div class="card">
     						<div class="card-header center" style="background-color: transparent;">
     							<h5 class="text-dark" style="font-weight: bold;">List of CCM</h5>
     						</div>
   							<div class="card-body ccmSideBar">
   								<form action="CCMSchedule.htm" method="GET">
									<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
									<div class="row">
   										<div class="col-md-12">
     										<button class="btn btn-primary ccmSideBarButton" type="submit" data-toggle="tooltip" data-placement="top" title="New CCM for Chosen Month">
     											Add New CCM
     										</button>
   										</div>
    								</div>
    								<%
    								if(ccmScheduleList!=null && ccmScheduleList.size()>0) {
    								for(CCMSchedule ccmSchedule : ccmScheduleList) {%>
    									<div class="row">
    										<div class="col-md-12">
	     										<button class="btn btn-secondary viewbtn ccmSideBarButton" type="submit" name="ccmScheduleId" value="<%=ccmSchedule.getCCMScheduleId()%>"  data-toggle="tooltip" data-placement="top" title="<%=ccmSchedule.getMeetingRefNo() %>">
	     											<%=ccmSchedule.getMeetingRefNo() %>
	     										</button>
    										</div>
    									</div>
    								<%} } else{%>
    									<div class="row">
    										<div class="col-md-12">
    											<button type="button" class="btn btn-secondary viewbtn ccmSideBarButton" data-toggle="tooltip" data-placement="top" title="No Meetings Scheduled">
													<span style="font-weight: bold;">No Meetings</span>
												</button>
    										</div>
    									</div>
    								<%} %>
   								</form>
   							</div>
       					</div>
       				</div>
       				<div class="col-md-10">
       					<div class="row">
       						<div class="col-md-12">
       							<ul class="nav nav-tabs justify-content-center" role="tablist" style="padding-bottom: 0px;" >

			            			<li class="nav-item" id="nav-schedule">
			             				<a  data-toggle="tab" href="#meetingschedule" role="tab"
			             				<%if(tabId!=null && tabId.equalsIgnoreCase("1")){ %> 
			             		    		 class="nav-links active " id="nav"
			             				<%}else{ %>
			              			 		 class="nav-links" role="tab"
			               				<%} %>  
			               				>	
			                	         	Schedule & Agenda
			              			 		</a>
			            			</li>

			            			<li class="nav-item" id="nav-agenda">
			            	     		<a data-toggle="tab" href="#agendadetails" role="tab"
			            	     		<%if(tabId!=null && tabId.equalsIgnoreCase("2")){ %>
			              					class="nav-links active" id="nav"role="tab"
			              				<%}else{ %>
			              					class="nav-links" data-toggle="tab" href="#agendadetails"
			               				<%} %>
			               				>
			                  				Others
			              					</a>
			            			</li>
            			
              					</ul>
       						</div>
       					</div>
       					<div class="row">
       						<div class="col-md-12">
       							<!-- This is for Tab Panes -->
         						<div class="card mr-2 mb-2 ">
         							<div class="tab-content text-center" style="">
         								<!-- *********** Meeting Schedule Details ***********      --> 
				               			<%if(tabId!=null && tabId.equalsIgnoreCase("1")){ %> 
				         					<div class="tab-pane active" id="meetingschedule" role="tabpanel">
				         				<%}else{ %>
				              				<div class="tab-pane " id="meetingschedule" role="tabpanel">
				               			<%} %>
				               				<div class="container-fluid mt-3 tabpanes">
				               					<div class="card-header left" style="background-color: #216583;">
				               						<h5 class="text-white" style="font-weight: bold;">Schedule Details</h5>
				               					</div>
				               					<div class="card-body">
					               					<form action="CCMScheduleDetailsSubmit.htm" method="post">
					               						<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
					               						<input type="hidden" name="monthyear" value="<%=monthyear %>">
					               						<input type="hidden" name="tabId" value="<%=tabId %>">
					               						<div class="fom-group">
							               					<div class="row mt-2">
					        									<div class="col-md-2 mt-1">
					        										<label class="control-label">Meeting Date & Time :</label>
					        									</div>
					        									<div class="col-md-2 left">
					        										<input type="text" class="form-control" name="meetingDate" id="meetingDate" <%if(ccmScheduleData!=null && ccmScheduleData.getMeetingDate()!=null ) {%> value="<%=fc.sdtfTordtf2(ccmScheduleData.getMeetingDate()) %>" <%} else{%> form="agendaForm"<%} %> >	        									
					        									</div>
					        									
					        									<div class="col-md-1 mt-1">
					        										<label class="control-label">Venue :</label>
					        									</div>
					        									<div class="col-md-4 left">
					        										<input type="text" class="form-control" name="meetingVenue" id="meetingVenue" placeholder="Enter Venue Details" maxlength="1000" required  <%if(ccmScheduleData!=null && ccmScheduleData.getMeetingVenue()!=null ) {%> value="<%=ccmScheduleData.getMeetingVenue() %>" <%} else{%> form="agendaForm"<%} %> >
					        									</div>
					        									<%if(ccmScheduleData!=null) {%>
					        										<input type="hidden" name="ccmScheduleId" id="ccmScheduleId" value="<%=ccmScheduleId%>">
						        									<div class="col-md-3 left">
						        										<button type="submit" class=" btn btn-sm edit" name="action" value="Edit" onclick="return confirm('Are You Sure to Update?')" data-toggle="tooltip" data-placement="top" title="Update Schedule Details" >UPDATE</button>
						        									</div>
					        									<%} %>
							        						</div>
							        					</div>	
							        					<!-- <div class="form-group">
							        						<div class="row mt-2">			
																<div class="col-md-12" align="center">
																	<button type="submit" class=" btn btn-sm edit" name="action" value="Edit" onclick="return confirm('Are You Sure to Update?')" >UPDATE</button>
																	<button type="submit" class=" btn btn-sm submit" name="action" value="Add" onclick="return confirm('Are You Sure to Submit?')" >SUBMIT</button>
														        </div> 
															</div>
							        					</div> -->
					               					</form>
		        								</div>
		        								
		        							
		        								<div class="card-header left" style="background-color: #216583;margin-top: 2rem;">
				               						<h5 class="text-white" style="font-weight: bold;">Agenda Details</h5>
				               					</div>
				               					
		        								<div class="card-body">
		        									<!-- Agenda Details Add / Edit -->
		        									<%if(agendaList!=null && agendaList.size()>0){ %>
		        									
			        									<div class="table-responsive"> 
															<table class="table  table-hover table-bordered" style="width: 100%;">
																<thead style="">  
																	<tr>
																		<th>Expand</th>
																		<th>Priority</th>
																		<th>Agenda Item</th>
																		<th>Lab</th>
																		<th>Presenter</th>
																		<th>Duration </th>
																		<th>File</th> 
																		<th>Upload</th>
																		<th>Action</th>	
																	</tr>
																</thead>
																<tbody>
																	<%	
																		int  count=0;
																
																		for(Object[] level1: agendaList){
																	 	if(level1[2].toString().equalsIgnoreCase("0")) {
																	 		++count;
																	 		%>
																	 		<tr>
																				<td class="center" style="width: 3%;">
																					<span class="clickable" data-toggle="collapse" id="row<%=count %>" data-target=".row<%=count %>"><button type="button" class="btn btn-sm btn-success" id="btn<%=count %>"  onclick="ChangeButton('<%=count %>')"  data-toggle="tooltip" data-placement="top" title="Expand"><i class="fa fa-plus"  id="fa<%=count%>"></i> </button></span>
																				</td>
																				<td  style="width: 5%;">
																					<input type="number" form="agendaEditForm-<%=count %>" class="form-control" name="agendaPriority" min="1" id="agendaPriorityMain" value="<%=level1[3] %>" onkeypress="return isNumber(event)">
																					<input type="hidden" name="scheduleAgendaId" id="scheduleAgendaIdMain" value="<%=level1[0] %>">
																				</td>
																				<td style="width: 20%;">
																					<button type="button" class="form-control" id="agendaItemBtn_Edit_<%=count %>" onclick="openEditor('Edit_', '<%=count %>', '0')" style="border: 1px solid #ced4da;height: 35px;width: 22rem;">
																						<%=level1[4] %>
																					</button>
																					<textarea form="agendaEditForm-<%=count %>" class="form-control" name="agendaItem" id="agendaItem_Edit_<%=count %>" style="display: none;"><%=level1[4] %></textarea>
																					<%-- <input type="text" form="agendaEditForm-<%=count %>" class="form-control" name="agendaItem" value="<%=level1[4] %>" required> --%>
																				</td>
																				<td style="width: 10%;">
																					<select form="agendaEditForm-<%=count %>" class="form-control items prepsLabCode" name="prepsLabCode" id="prepsLabCode_Edit_<%=count %>" style="width: 200px" onchange="AgendaPresentors('Edit_<%=count %>')"  data-live-search="true" data-container="body">
																						<option value="0">Lab Name</option>
																					    <% for (Object[] obj : allLabList) {%>
																						    <option value="<%=obj[3]%>" <%if(level1[5].toString().equalsIgnoreCase(obj[3].toString())){ %>selected <%} %>  ><%=obj[3]%></option>
																					    <%} %>
																					    <option value="@EXP" <%if(level1[5].toString().equalsIgnoreCase("@EXP")){ %>selected <%} %> >Expert</option>
																					</select>
																				</td>
																				<td style="width: 10%;">
																					<select form="agendaEditForm-<%=count %>" class="form-control items presenterId" name="presenterId" id="presenterId_Edit_<%=count %>" style=" font-weight: bold; text-align-last: left; width: 300px;" data-live-search="true" data-container="body">
																		        		<%-- <option disabled="disabled" selected value="">Choose...</option>
																				        
																				        <% for(Object[] emp : labEmpList){ %>
																				        	<option value="<%=emp[0] %>" <%if(level1[6].toString().equalsIgnoreCase(emp[0].toString())){ %>selected <%} %> ><%=emp[1] %>, <%=emp[3] %></option>
																				        <%} %> --%>
																					</select>
																				</td>
																				<td style="width: 5%;">
																					<%-- <input type="text" class="form-control startTime" name="startTime" value="<%=level1[7] %>"  style="width: 40%;display: inline;"/>
																				 	-
																				 	<input type="text" class="form-control endTime" name="endTime" value="<%=level1[8] %>" style="width: 40%;display: inline;"> --%>
																					<input type="number" form="agendaEditForm-<%=count %>" class="form-control" name="duration" id="duration_Edit_<%=count %>" value="<%=level1[9] %>" min="1" placeholder="Minutes" onkeypress="return isNumber(event)" required>
																				</td>
																				<td style="width: 3%;">
																					<%if(level1[10]!=null && !level1[10].toString().isEmpty()) {%>
																						<button type="submit" form="agendaEditForm-<%=count %>" class="btn btn-sm" name="scheduleAgendaId" formmethod="post" formnovalidate="formnovalidate" value="<%=level1[0] %>" formaction="CCMScheduleAgendaFileDownload.htm" formtarget="_blank" data-toggle="tooltip" data-placement="top" title="Attachment Download">
		                            					 									<i class="fa fa-download"></i>
		                            					 								</button>
		                            					 								<input type="hidden" form="agendaEditForm-<%=count %>" name="count" value="<%=count %>">
		                            					 								<input type="hidden" form="agendaEditForm-<%=count %>" name="subCount" value="0">
	                            					 								<%} else{%>	
		                            					 								-
		                            					 							<%} %>
																				</td>
																				<td style="width: 15%;">
																					<input type="file" form="agendaEditForm-<%=count %>" class="form-control attachment" name="attachment" id="attachment_Edit_<%=count %>" accept=".pdf,.pptx">
																					<%-- <input type="hidden" name="attachmentname" value="<%=level1[10] %>"> --%>
																				</td>
																				<td style="width: 9%;">
																					<form action="#" id="agendaEditForm-<%=count %>" enctype="multipart/form-data">
										        										<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
										        										<input type="hidden" name="ccmScheduleId" id="ccmScheduleId" value="<%=ccmScheduleId%>">
										        										<input type="hidden" name="monthyear" value="<%=monthyear %>">
													               						<input type="hidden" name="tabId" value="<%=tabId %>">
																						<button type="submit" class="btn btn-sm" name="scheduleAgendaId" value="<%=level1[0] %>" formmethod="post" formaction="CCMScheduleAgendaEdit.htm" onclick="return confirm('Are you sure To Edit this Agenda?')" data-toggle="tooltip" data-placement="top" title="Edit Agenda">
																							<i class="fa fa-pencil-square-o" aria-hidden="true"></i>
																						</button>
																						<button type="submit" class="btn btn-sm" name="scheduleAgendaId" value="<%=level1[0] %>" formmethod="get" formaction="CCMScheduleAgendaDelete.htm" onclick="return confirm('Are you sure To Delete this Agenda?')" data-toggle="tooltip" data-placement="top" title="Delete Agenda"> 
																							<i class="fa fa-trash" aria-hidden="true"></i>
																						</button>
																						<button type="button" class="btn btn-sm " onclick="openSubAgendaAddModal('<%=level1[0] %>','<%=level1[3] %>', '<%=count %>')" formnovalidate="formnovalidate"  data-placement="top" title="Add New Sub Agenda/s">
																							<i class="btn fa fa-plus" style="color: green; padding: 0px  ;"></i>
																						</button>
																					</form>	
																				</td>
																			</tr>
																			<%-- <tr class="collapse row<%=count %>"  id="rowcollapse<%=count%>" style="font-weight: bold;">
																				<th></th>
																				<th>Priority</th>
																				<th>Agenda Item</th>
																				<th>Lab</th>
																				<th>Presenter</th>
																				<th>Duration </th>
																				<th>File</th> 
																				<th>Upload</th>
																				<th>Action</th>	
																			</tr> --%>
																			
																			<tr class="collapse row<%=count %>" id="rowcollapse<%=count%>" >
																				<td colspan="1"></td>
																				<td colspan="8">
																					<table style="width:100%;" class="subagendatable-edit" id="subagendatable-edit-<%=count %>">
																						<tbody class="subagendatable-tbody-edit" id="subagendatable-tbody-edit-<%=count %>">
																							<% 
																								int countA=0;
																								for(Object[] level2: agendaList){
																					 			if(level1[0].toString().equalsIgnoreCase(level2[2].toString())){ 
																					 				++countA;
																					 			%>
																					 			
																						 		<tr>
																						 			<!-- <td class="center" style="width: 3%;"></td> -->
																						 			<td  style="width: 9.5%;">
																										<input type="hidden" form="subAgendaEditForm-<%=count %>-<%=countA %>" class="form-control" name="agendaPriority" id="agendaPrioritySub" value="<%=level2[3] %>">
																										<input type="hidden" name="scheduleAgendaId" id="scheduleAgendaIdSub" value="<%=level2[0] %>">
																									</td>
																									<td style="width: 26%;">
																										<button type="button" class="form-control" id="agendaItemBtn_Edit_<%=count %>_<%=countA %>" onclick="openEditor('Edit_', '<%=count %>', '<%=countA %>')" style="border: 1px solid #ced4da;height: 35px;width: 22rem;">
																											<%=level2[4] %>
																										</button>
																										<textarea form="subAgendaEditForm-<%=count %>-<%=countA %>" class="form-control" name="agendaItem" id="agendaItem_Edit_<%=count %>_<%=countA %>" style="display: none;"><%=level2[4] %></textarea>
																										<%-- <input type="text" form="subAgendaEditForm-<%=count %>-<%=countA %>" class="form-control" name="agendaItem" value="<%=level2[4] %>" required> --%>
																									</td>
																									<td style="width: 10%;">
																										<select form="subAgendaEditForm-<%=count %>-<%=countA %>" class="form-control items prepsLabCode" name="prepsLabCode" id="prepsLabCode_Edit_<%=count %>_<%=countA %>" style="width: 200px" onchange="AgendaPresentors('Edit_<%=count %>_<%=countA %>')" data-live-search="true" data-container="body">
																											<option value="0">Lab Name</option>
																										    <% for (Object[] obj : allLabList) {%>
																											    <option value="<%=obj[3]%>" <%if(level2[5].toString().equalsIgnoreCase(obj[3].toString())){ %>selected <%} %>  ><%=obj[3]%></option>
																										    <%} %>
																										    <option value="@EXP" <%if(level2[5].toString().equalsIgnoreCase("@EXP")){ %>selected <%} %> >Expert</option>
																										</select>
																									</td>
																									<td style="width: 15%;">
																										<select form="subAgendaEditForm-<%=count %>-<%=countA %>" class="form-control items presenterId" name="presenterId" id="presenterId_Edit_<%=count %>_<%=countA %>" style=" font-weight: bold; text-align-last: left; width: 300px;" data-live-search="true" data-container="body">
																							        		<option value="0">Choose...</option>
																									        <%-- <% for(Object[] emp : labEmpList){ %>
																									        	<option value="<%=emp[0] %>" <%if(level2[6].toString().equalsIgnoreCase(emp[0].toString())){ %>selected <%} %> ><%=emp[1] %>, <%=emp[3] %></option>
																									        <%} %> --%>
																										</select>
																									</td>
																									<td style="width: 8.5%;">
																										<%-- <input type="text" class="form-control startTime" name="startTime" value="<%=level2[7] %>" style="width: 40%;display: inline;"/>
																									 	-
																									 	<input type="text" class="form-control endTime" name="endTime" value="<%=level2[8] %>" style="width: 40%;display: inline;"> --%>
																										<input type="number" form="subAgendaEditForm-<%=count %>-<%=countA %>" class="form-control" name="duration" id="duration_Edit_<%=count %>_<%=countA %>" value="<%=level2[9] %>" min="1" placeholder="Minutes"  onkeypress="return isNumber(event)" required >
																									</td>
																									<td style="width: 4%;">
																										<%if(level2[10]!=null && !level2[10].toString().isEmpty()) {%>
																											<button type="submit" form="subAgendaEditForm-<%=count %>-<%=countA %>" class="btn btn-sm" name="scheduleAgendaId" formmethod="post" formnovalidate="formnovalidate" value="<%=level2[0] %>" formaction="CCMScheduleAgendaFileDownload.htm" formtarget="_blank" data-toggle="tooltip" data-placement="top" title="Attachment Download">
							                            					 									<i class="fa fa-download"></i>
							                            					 								</button>
							                            					 								<input type="hidden" form="subAgendaEditForm-<%=count %>-<%=countA %>" name="count" value="<%=count %>">
		                            					 													<input type="hidden" form="subAgendaEditForm-<%=count %>-<%=countA %>" name="subCount" value="<%=countA %>">
							                            					 							<%} else{%>	
							                            					 								-
							                            					 							<%} %>
																									</td>
																									<td style="width: 19.5%;">
																										<input type="file" form="subAgendaEditForm-<%=count %>-<%=countA %>" class="form-control attachment" name="attachment" id="attachment_Edit_<%=count %>_<%=countA %>" accept=".pdf,.pptx">
																										<%-- <input type="hidden" name="attachmentname" value="<%=level2[10] %>"> --%>
																									</td>
																									<td style="width: 10.5%;">
																										<form action="#" id="subAgendaEditForm-<%=count %>-<%=countA %>" enctype="multipart/form-data">
															        										<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
															        										<input type="hidden" name="ccmScheduleId" id="ccmScheduleId" value="<%=ccmScheduleId%>">
															        										<input type="hidden" name="parentScheduleAgendaId" value="<%=level1[0]%>">
															        										<input type="hidden" name="monthyear" value="<%=monthyear %>">
																		               						<input type="hidden" name="tabId" value="<%=tabId %>">
																											<button type="submit" class="btn btn-sm" name="scheduleAgendaId" value="<%=level2[0] %>" formmethod="post" formaction="CCMScheduleAgendaEdit.htm" onclick="return confirm('Are you sure To Edit this Agenda?')" data-toggle="tooltip" data-placement="top" title="Edit Sub Agenda">
																												<i class="fa fa-pencil-square-o" aria-hidden="true"></i>
																											</button>
																											<button type="submit" class="btn btn-sm" name="scheduleAgendaId" value="<%=level2[0] %>" formmethod="get" formnovalidate="formnovalidate" formaction="CCMScheduleSubAgendaDelete.htm" onclick="return confirm('Are you sure To Delete this Agenda?')" data-toggle="tooltip" data-placement="top" title="Delete Sub Agenda"> 
																												<i class="fa fa-trash" aria-hidden="true"></i>
																											</button>
																										</form>	
																									</td>
																						 		</tr>	
																							<%} } %>
																							<%if(countA==0) {%>
																								<tr>
																									<td colspan="8">No Data Available</td>
																								</tr>
																							<%} %>
																						</tbody>
																					</table>	
																				</td>
																			</tr>
																							
																	 <%} } %>	
																	 <%if(agendaList.size()!=1 ){ %>
																		<tr>
																			<td colspan="1"></td>
																			<td >
																				<form action="CCMMainAgendaPriorityUpdate.htm" id="priorityForm">
																					<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
									        										<input type="hidden" name="ccmScheduleId" id="ccmScheduleId" value="<%=ccmScheduleId%>">
									        										<input type="hidden" name="monthyear" value="<%=monthyear %>">
												               						<input type="hidden" name="tabId" value="<%=tabId %>">
												               						<input type="hidden" name="agendaPriority" id="agendaPriorityMainForm">
												               						<input type="hidden" name="scheduleAgendaId" id="scheduleAgendaIdMainForm">
																					<button type="button" class="btn btn-sm edit" onclick="updateMainPriority()" data-toggle="tooltip" data-placement="top" title="Update Agenda Priority">UPDATE</button>
																				</form>
																			</td>
																			<td colspan="8"></td>
																		</tr>
																	<%} %>
																</tbody>
															</table>
														</div>
													
														<div class="mt-2 left">
															<h5 style="text-decoration: underline;font-weight: bold;">Add More Agenda : </h5>
														</div>	
		        									<%} %>
		        									
				                					<form action="CCMAgendaDetailsSubmit.htm" method="POST" name="myform6" id="agendaForm" enctype="multipart/form-data">	
														<input type="hidden" name="ccmScheduleId" value="<%=ccmScheduleId%>">
														<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
														<input type="hidden" name="monthyear" value="<%=monthyear %>">
					               						<input type="hidden" name="tabId" value="<%=tabId %>">
														<div class="row"> 
															<div class="col-md-12"  >
														 		<table class="table table-hover table-bordered" id="agendatable" style="width: 100%;">
																	<thead style="background-color: #7f328f;color: white;">  
																		<tr class="thread_tr_clone_agenda">
																			<th>Agenda Item</th>
																			<th>Lab</th>
																			<th>Presenter</th>
																			<th>Duration </th>
																			<th>Attach File </th> 
																			<th> 
																				<button type="button" class="btn btn-sm tr_clone_add_agenda" name="add" data-toggle="tooltip" data-placement="top" title="Add New Agenda"> <i class="btn fa fa-plus" style="color: green; padding: 0px  ;"></i></button>
																			</th>	
																		</tr>
																	</thead>
																	<tbody>
																		<tr class="tr_clone_agenda" id="tr_clone_agenda-1" data-level="tr_clone_agenda-1">
																		
																			<td style="width: 25%;">
																				<!-- <input type="text" class="form-control main agendaItem" name="agenda[0].agendaItem" id="agendaItem_1" maxlength="500" required/> -->
																				<button type="button" class="form-control main agendaItemBtn" id="agendaItemBtn_1" onclick="openEditor('', '1', '0')" style="border: 1px solid #ced4da;height: 35px;width: 22rem;">
																					Enter Agenda Item
																				</button>
																				<textarea class="form-control main agendaItem" name="agenda[0].agendaItem" id="agendaItem_1" style="display: none;"></textarea>
																			</td>
															         		 
															         		 <td style="width: 10%;">
															         		 	<select class="form-control items main prepsLabCode" name="agenda[0].prepsLabCode" id="prepsLabCode_1" data-live-search="true" data-container="body" style="width: 200px" onchange="AgendaPresentors('1')">
																					<option value="0">Lab Name</option>
																				    <% for (Object[] obj : allLabList) {%>
																					    <option value="<%=obj[3]%>"><%=obj[3]%></option>
																				    <%} %>
																				    <option value="@EXP">Expert</option>
																				</select>
															         		 
															         		 </td>
															         		         	                             
															         		<td style="width: 20%;">						         		
																				<select class="form-control items main presenterId" name="agenda[0].presenterId" id="presenterId_1" data-live-search="true" data-container="body" style="font-weight: bold; text-align-last: left; width: 300px;">
																	        		<option value="0">Choose...</option>
																			        <% for(Object[] emp : labEmpList){ %>
																			        	<option value="<%=emp[0] %>"><%=emp[1] %>, <%=emp[3] %></option>
																			        <%} %>
																				</select>
																			</td>		
																			<td style="width: 15%;">
																			 	<!-- <input type="text" class="form-control main startTime" name="agenda[0].startTime" id="startTime_0" style="width: 40%;display: inline;"/>
																			 	-
																			 	<input type="text" class="form-control main endTime" name="agenda[0].endTime" id="endTime_0" style="width: 40%;display: inline;"> -->
																				<input type="number" class="form-control main duration" name="agenda[0].duration" id="duration_1" min="1" placeholder="Minutes" onkeypress="return isNumber(event)" onchange="return checkMaxDurationAtMainLevel(this)" required/>
																			</td>						         		                                      
																										
																			<td style="text-align: left;width: 20%;">
																				<input type="file" class="form-control main attachment" name="agenda[0].attachment" id="attachment_1" accept=".pdf,.pptx" >										
																			</td>							
																			<td style="width: 10%;">
																				<button type="button" class="btn btn-sm tr_clone_add_sub_agenda" name="add" data-toggle="tooltip" data-placement="top" title="Add New Sub Agenda"> <i class="btn fa fa-plus" style="color: green; padding: 0px  ;"></i></button>
																				<button type="button" class="btn btn-sm tr_clone_rem_agenda" name="sub"  data-toggle="tooltip" data-placement="top" title="Remove Agenda"> <i class="btn fa fa-minus" style="color: red;padding: 0px  ;"> </i></button>
																			</td>	
																									
																		</tr>
																		<tr class="tr_clone_sub_head_agenda" id="agendasubtabletr-1" style="display: none;">
																			<td colspan="6">
																				<table class="agendasubtable" id="agendasubtable-1" style="width: 96%;margin-left: 2%;margin-right: 2%;">
																					<thead style="background-color: #8f8f20;color: white;">  
																						<tr class="thread_tr_clone_sub_agenda">
																							<th>Agenda Item</th>
																							<th>Lab</th>
																							<th>Presenter</th>
																							<th>Duration </th>
																							<th>Attach File </th> 
																							<th> 
																							</th>	
																						</tr>
																					</thead>
																					
																				</table>	
																			</td>	
																		</tr>
																	</tbody>
																</table>
																<table id="agendasubtable_tbody" style="width: 96%;margin-left: 2%;margin-right: 2%;display: none;">
																	<tbody>
																		<tr class="tr_clone_sub_agenda" id="tr_clone_sub_agenda-1" data-sublevel="tr_clone_sub_agenda-1" style="display: none;">
																		
																			<td style="width: 25%;">
																				<!-- <input type="text" class="form-control sub agendaItem" name="agenda[0].subAgendas[0].agendaItem" id="agendaItem_0_0" maxlength="500"  /> -->
																				<button type="button" class="form-control sub agendaItemBtn" id="agendaItemBtn_0_0" onclick="openEditor('', '0', '0')" style="border: 1px solid #ced4da;height: 35px;width: 22rem;">
																					Enter Agenda Item
																				</button>
																				<textarea class="form-control sub agendaItem" name="agenda[0].subAgendas[0].agendaItem" id="agendaItem_0_0" style="display: none;"></textarea>
																			</td>
															         		 
															         		 <td style="width: 6%;">
															         		 	<select class="form-control itemssub sub prepsLabCode" name="agenda[0].subAgendas[0].prepsLabCode" id="prepsLabCode_0_0"  style="width: 200px" onchange="AgendaPresentors('0','0')"  data-live-search="true" data-container="body">
																					<option value="0">Lab Name</option>
																				    <% for (Object[] obj : allLabList) {%>
																					    <option value="<%=obj[3]%>"><%=obj[3]%></option>
																				    <%} %>
																				    <option value="@EXP">Expert</option>
																				</select>
															         		 
															         		 </td>
															         		         	                             
															         		<td style="width: 20%;">						         		
																				<select class="form-control itemssub sub presenterId" name="agenda[0].subAgendas[0].presenterId" id="presenterId_0_0" style=" font-weight: bold; text-align-last: left; width: 300px;" data-live-search="true" data-container="body">
																	        		<option value="0">Choose...</option>
																			        <% for(Object[] emp : labEmpList){ %>
																			        	<option value="<%=emp[0] %>"><%=emp[1] %>, <%=emp[3] %></option>
																			        <%} %>
																				</select>
																			</td>		
																			<td style="width: 15%;">
																				<!-- <input type="text" class="form-control sub startTime" name="agenda[0].subAgendas[0].startTime" id="startTime_0_0" style="width: 40%;display: inline;"/>
																			 	-
																			 	<input type="text" class="form-control sub endTime" name="agenda[0].subAgendas[0].endTime" id="endTime_0_0" style="width: 40%;display: inline;"> -->
																			 	<input type="number" class="form-control sub duration" name="agenda[0].subAgendas[0].duration" id="duration_0_0" min="1" placeholder="Minutes" onkeypress="return isNumber(event)" onchange="return checkMaxDurationAtSubLevel(this)"/>
																			</td>						         		                                      
																										
																			<td style="text-align: left;width: 25%;">
																				<input type="file" class="form-control sub attachment" name="agenda[0].subAgendas[0].attachment" id="attachment_0_0" accept=".pdf,.pptx" >										
																			</td>							
																			<td style="width: 5%;">
																				<button type="button" class="btn btn-sm tr_clone_rem_sub_level_agenda" name="sub"  data-toggle="tooltip" data-placement="top" title="Remove Sub Agenda"> <i class="btn fa fa-minus" style="color: red;padding: 0px  ;"> </i></button>
																			</td>								
																		</tr>
																	</tbody>
																</table>
															</div>
														</div>
														<div class="form-group" align="center" >
															<button type="submit" class="btn btn-sm btn-primary btn-sm submit" name="Action" value="Add" onclick="return confirm('Are you sure to Submit?');" >SUBMIT</button>
														</div>
													</form>
		        								</div>
				               					
				        					</div>
				        					<div class="d-flex justify-content-sm-between">
				        						<div>
				        						</div>
				        						<div class="panel-buttons">
				        							<form action="#">
				        								<input type="hidden" name="ccmScheduleId" value="<%=ccmScheduleId %>">
				        								<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
				        								<%if(agendaList!=null && agendaList.size()>0) {%>
				        									<button type="submit" class="btn btn-sm " style="background-color: #96D500;" formaction="CCMAgendaPresentation.htm" formmethod="post" formtarget="_blank" title="Agenda Presentation">
																<img alt="" src="view/images/presentation.png" style="width:19px !important">
															</button>
						        							<!-- <button class="btn btn-sm btn-info shadow-nohover btn-print" formaction="CCMScheduleAgendaPdfDownload.htm" formtarget="_blank" data-toggle="tooltip" title="Download Agenda">
						        								Print Agenda
						        							</button> -->
					        							<%} %>
				        							</form>
					        							
				        						</div>
				        						<div class="navigation_btn panel-bottom">
	            									<a class="btn btn-info btn-sm shadow-nohover back" href="#" style="color: white!important;text-transform: capitalize;">back</a>
													<button class="btn btn-info btn-sm next">Next</button>
												</div>
				        					</div>
					               				
				               			<%if(tabId!=null && tabId.equalsIgnoreCase("1")){ %> 
				         					</div>
				         				<%}else{ %>
				              				</div>
				               			<%} %>
				               			
         								<!-- *********** Agenda Details ***********      --> 
				               			<%if(tabId!=null && tabId.equalsIgnoreCase("2")){ %> 
				         					<div class="tab-pane active" id="agendadetails" role="tabpanel">
				         				<%}else{ %>
				              				<div class="tab-pane " id="agendadetails" role="tabpanel">
				               			<%} %>
				               				<div class="container-fluid mt-3 tabpanes">
				               				</div>
				               				<div class="navigation_btn panel-bottom" >
				            					<a class="btn btn-info btn-sm  shadow-nohover previous" >Previous</a>
												<button class="btn btn-info btn-sm next">Next</button>
											</div>
				               			<%if(tabId!=null && tabId.equalsIgnoreCase("2")){ %> 
				         					</div>
				         				<%}else{ %>
				              				</div>
				               			<%} %>
               						</div>
               					</div>
       						</div>
       					</div>		
       				</div>
       			</div>
       			
       		</div>
       	</div>
    </div>   	
	<div class="modal fade bd-example-modal-lg" id="cloningTableModal" tabindex="-1" role="dialog" aria-labelledby="cloningTableModal" aria-hidden="true" style="margin-top: 5%;">
		<div class="modal-dialog modal-lg" role="document" style="max-width: 1440px;">
			<div class="modal-content">
				<div class="modal-header bg-primary text-light">
		        	<h5 class="modal-title" id="cloningTableModal">Add New Sub Agenda/s for Priority <span id="agendaheading"></span> </h5>
			        <button type="button" class="close" style="text-shadow: none!important" data-dismiss="modal" aria-label="Close">
			          <span aria-hidden="true" style="color:red;">&times;</span>
			        </button>
		      	</div>
     			<div class="modal-body">
					<form action="CCMScheduleSubAgendaSubmit.htm" method="post" enctype="multipart/form-data">
						
						<table class="table table-hover table-bordered" id="agendatable-edit">
							<thead class="center" style="background-color: #8f8f20;color: white;">  
								<tr>
									<th>Agenda Item</th>
									<th>Lab</th>
									<th>Presenter</th>
									<th>Duration </th>
									<th>Attach File </th> 
									<th> 
										<button type="button" class="btn btn-sm tr_clone_add_sub_agenda_edit" name="add" data-toggle="tooltip" data-placement="top" title="Add New Sub Agenda"> <i class="btn fa fa-plus" style="color: green; padding: 0px  ;"></i></button>
									</th>	
								</tr>
							</thead>
							<tbody id="tbody_clone_sub_agenda_edit">
								<tr class="tr_clone_sub_agenda_edit">
									<td style="width: 25%;">
										<!-- <input type="text" class="form-control agendaedit agendaItem" name="agendaItem" id="agendaItem_edit_0" maxlength="500" /> -->
										<button type="button" class="form-control agendaedit agendaItemBtn" id="agendaItemBtn_edit_0" onclick="openEditor('edit_', '0', '0')" style="border: 1px solid #ced4da;height: 35px;width: 22rem;">
											Enter Agenda Item
										</button>
										<textarea class="form-control agendaedit agendaItem" name="agendaItem" id="agendaItem_edit_0" style="display: none;"></textarea>
									</td>
									<td style="width: 6%;">
					         		 	<select class="form-control itemsubedit agendaedit prepsLabCode" name="prepsLabCode" id="prepsLabCode_edit_0" style="width: 200px" onchange="AgendaPresentors('edit_0')" data-live-search="true" data-container="body">
											<option value="0">Lab Name</option>
										    <% for (Object[] obj : allLabList) {%>
											    <option value="<%=obj[3]%>"><%=obj[3]%></option>
										    <%} %>
										    <option value="@EXP">Expert</option>
										</select>
									</td>
															         		         	                             
					         		<td style="width: 20%;">						         		
										<select class="form-control itemsubedit agendaedit presenterId" name="presenterId" id="presenterId_edit_0" style=" font-weight: bold; text-align-last: left; width: 300px;" data-live-search="true" data-container="body">
							        		<option value="0">Choose...</option>
									        <% for(Object[] emp : labEmpList){ %>
									        	<option value="<%=emp[0] %>"><%=emp[1] %>, <%=emp[3] %></option>
									        <%} %>
										</select>
									</td>		
									<td style="width: 15%;">
										<!-- <input type="text" class="form-control sub startTime" name="agenda[0].subAgendas[0].startTime" id="startTime_0_0" style="width: 40%;display: inline;"/>
									 	-
									 	<input type="text" class="form-control sub endTime" name="agenda[0].subAgendas[0].endTime" id="endTime_0_0" style="width: 40%;display: inline;"> -->
									 	<input type="number" class="form-control agendaedit duration" name="duration" id="duration_edit_0" min="1" placeholder="Minutes" required onkeypress="return isNumber(event)" />
									</td>						         		                                      
																										
									<td style="text-align: left;width: 25%;">
										<input type="file" class="form-control agendaedit attachment" name="attachment" id="attachment_edit_0" accept=".pdf,.pptx">										
									</td>							
									<td style="width: 5%;">
										<button type="button" class="btn btn-sm tr_clone_rem_sub_agenda_edit" name="sub"  data-toggle="tooltip" data-placement="top" title="Remove Sub Agenda"> <i class="btn fa fa-minus" style="color: red;padding: 0px  ;"> </i></button>
									</td>								
								</tr>
							</tbody>
						</table>
						<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
                        <input type="hidden" name="ccmScheduleId" value="<%=ccmScheduleId%>">
                        <input type="hidden" name="monthyear" value="<%=monthyear %>">
					    <input type="hidden" name="tabId" value="<%=tabId %>">
                        <input type="hidden" name="scheduleAgendaId" id="scheduleAgendaIdModal">
                        <input type="hidden" name="slno" id="slno">
                        
                        <div class="center">
                        	<div class="form-group" align="center" >
								<button type="submit" class="btn btn-sm btn-primary btn-sm submit" name="Action" value="Add" onclick="return confirm('Are you sure to Submit?');" >SUBMIT</button>
							</div>
                        </div>
					</form>
				</div>
    		</div>
  		</div>
	</div>

	<div class="modal fade bd-example-modal-lg" id="ckEditorModal" tabindex="-1" role="dialog" aria-labelledby="ckEditorModal" aria-hidden="true" style="margin-top: 5%;">
		<div class="modal-dialog modal-lg" role="document" style="max-width: 900px;">
			<div class="modal-content">
				<div class="modal-header bg-primary text-light">
		        	<h5 class="modal-title" id="ckEditorModal">Agenda Item</h5>
			        <button type="button" class="close closeEditor" style="text-shadow: none!important" data-dismiss="modal" aria-label="Close">
			          <span aria-hidden="true" style="color:red;">&times;</span>
			        </button>
		      	</div>
     			<div class="modal-body">
	         		<div id="Editor" class="center"></div>
	         		<input type="hidden" id="mainLevel">
	         		<input type="hidden" id="subLevel">
	         		<input type="hidden" id="addEdit">
	         		<div class="center mt-2">
	         			<button type="button" class="btn btn-primary closeEditor" data-dismiss="modal">Enter</button>
	         		</div>
	         		
	         	</div>
    		</div>
  		</div>
	</div>
<script type="text/javascript">
	
	/* --------------------- Date Time Picker --------------------------- */

	$(function() {
	
		$('#meetingDate').daterangepicker({
		    singleDatePicker: true,
		    showDropdowns: true,
		    timePicker: true,
		    timePicker24Hour: true,
		    timePickerIncrement: 1,
		    autoUpdateInput: true,
		    <%if(ccmScheduleData==null) {%>
		    startDate : "<%=startDate+" "+currentTime%>",
		    <%}%>
		    minDate : "<%=minDate+" 00:00:00"%>",
			maxDate : "<%=endDate+" 23:59:59"%>",
		    locale: {
		        format: 'DD-MM-YYYY HH:mm'
		    }
		});

		<%
		if(agendaList!=null && agendaList.size()>0) {
			int  count=1;
			for(Object[] level1: agendaList){
	 			if(level1[2].toString().equalsIgnoreCase("0")) { %>
	 				EditAgendaPresentors('<%=count%>','<%=level1[6]%>');
	 			<% 
				int countA=0;
				for(Object[] level2: agendaList){
					if(level1[0].toString().equalsIgnoreCase(level2[2].toString())){ 
						++countA;
				%>
					EditAgendaPresentors('<%=count+"_"+countA%>','<%=level2[6]%>');
	 			<%} } %>
	 	<%} count++; } }%>

	});
	/* --------------------- Agenda Cloning --------------------------- */

	$('.items').select2();
	$('.itemssub').select2();

	var mainAgendaCount = 1;

	/* ------------------------------------------- Agenda Main Level Add ---------------------------------------------------------- */
	$("#agendatable").on('click', '.tr_clone_add_agenda', function() {
	    $('.items').select2("destroy");

	    var $tr = $('.tr_clone_agenda').last();
	    var $clone = $tr.clone();

	    $("#agendatable tbody").append($clone);

	    mainAgendaCount++;

	    $clone.attr("id", "tr_clone_agenda-" + mainAgendaCount);
	    $clone.attr("data-level", "tr_clone_agenda-" + mainAgendaCount);
	    $clone.find(".main.agendaItemBtn").attr("id", 'agendaItemBtn_' + mainAgendaCount).attr("onclick","openEditor('', "+mainAgendaCount+', 0)');
	    $clone.find(".main.agendaItem").attr("id", 'agendaItem_' + mainAgendaCount);
	    $clone.find(".main.prepsLabCode").attr("id", 'prepsLabCode_' + mainAgendaCount).attr("onchange", 'AgendaPresentors(\'' + mainAgendaCount + '\')');
	    $clone.find(".main.presenterId").attr("id", 'presenterId_' + mainAgendaCount);
	    $clone.find(".main.duration").attr("id", 'duration_' + mainAgendaCount);
	    $clone.find(".main.attachment").attr("id", 'attachment_' + mainAgendaCount);

	    $clone.find(".main.agendaItem").attr('name', 'agenda[' + (mainAgendaCount - 1) + '].agendaItem');
	    $clone.find(".main.prepsLabCode").attr('name', 'agenda[' + (mainAgendaCount - 1) + '].prepsLabCode');
	    $clone.find(".main.presenterId").attr('name', 'agenda[' + (mainAgendaCount - 1) + '].presenterId');
	    $clone.find(".main.duration").attr('name', 'agenda[' + (mainAgendaCount - 1) + '].duration');
	    $clone.find(".main.attachment").attr('name', 'agenda[' + (mainAgendaCount - 1) + '].attachment'); 

	    $('.items').select2();
	    $clone.find('.items').select2('val', '');
	    $clone.find("input").val("");
	    $clone.find("textarea").val("");
	    $clone.find(".main.agendaItemBtn").html("Enter Agenda Item");
	    
	    AgendaPresentors(mainAgendaCount + '');

	    // Create a new sub-agenda table for the new main agenda item
	    var $subTableClone = $('.tr_clone_sub_head_agenda').last().clone();
	    $subTableClone.find('.agendasubtable').attr("id", 'agendasubtable-' + mainAgendaCount);
	    $subTableClone.find('.agendasubtable').find('.tr_clone_sub_agenda').remove();
	    $subTableClone.attr("id", 'agendasubtabletr-' + mainAgendaCount);
	    //$subTableClone.find('tbody').empty(); // Clear any sub-rows
	    $subTableClone.hide();
	    $("#agendatable").append($subTableClone);
	});

	/* ------------------------------------------- Agenda Main Level Removal ---------------------------------------------------------- */
	$("#agendatable").on('click', '.tr_clone_rem_agenda', function() {
	    var cl = $('.tr_clone_agenda').length;

	    if (cl > 1) {
	        //$('.items').select2("destroy");

	        var $currentRow = $(this).closest('.tr_clone_agenda');
	        var currentRowId = $currentRow.attr('id');
	        var splitValues = currentRowId.split("-");
	        var mainAgendaIndex = splitValues[splitValues.length - 1];

	        var $subTable = $('#agendasubtabletr-' + mainAgendaIndex);

	        var hasSubRows = $subTable.find('.tr_clone_sub_agenda').length > 0;

	        if (hasSubRows) {
	            var confirmationMessage = 'This will also delete all associated sub-level items. Are you sure you want to proceed?';
	            if (window.confirm(confirmationMessage)) {
	                $subTable.remove();
	                $currentRow.remove();
	                //$('.items').select2();
	            } else {
	                event.preventDefault();
	               // $('.items').select2();
	            }
	        } else {
	            $currentRow.remove();
	            $('#agendasubtable-' + mainAgendaIndex).hide();
	            //$('.items').select2();
	        }
	    }
	});

	/* ------------------------------------------- Agenda Sub Level Add ---------------------------------------------------------- */
	$("#agendatable").on('click', '.tr_clone_add_sub_agenda', function() {
	    $('.itemssub').select2("destroy");

	    var $currentRow = $(this).closest('tr');
	    var currentRowId = $currentRow.attr('id');
	    var splitValues = currentRowId.split("-");
	    var mainAgendaIndex = splitValues[splitValues.length - 1];

	    var $hiddenTable = $('#agendasubtabletr-' + mainAgendaIndex);
	    $('#agendasubtable-' + mainAgendaIndex).show();
	    $hiddenTable.show();

	    var $subTable = $hiddenTable.find('table');

	    var $trSubTemplate = $('.tr_clone_sub_agenda').first();
	    var $cloneSub = $trSubTemplate.clone();
	    var subAgendaCount = $subTable.find('.tr_clone_sub_agenda').length+1;

	    $cloneSub.attr("id", "tr_clone_sub_agenda-" + mainAgendaIndex + "-" + subAgendaCount);
	    $cloneSub.attr("data-sublevel", "tr_clone_sub_agenda-" + mainAgendaIndex + "-" + subAgendaCount);
	    $cloneSub.find(".sub.agendaItemBtn").attr('id', 'agendaItemBtn_' + mainAgendaIndex + "_" + subAgendaCount).attr("onclick","openEditor('', "+mainAgendaIndex+", "+subAgendaCount+")");
	    $cloneSub.find(".sub.agendaItem").attr('id', 'agendaItem_' + mainAgendaIndex + "_" + subAgendaCount);
	    $cloneSub.find(".sub.prepsLabCode").attr('id', 'prepsLabCode_' + mainAgendaIndex + "_" + subAgendaCount).attr("onchange", 'AgendaPresentors(\'' + mainAgendaIndex + '_' + subAgendaCount + '\')');
	    $cloneSub.find(".sub.presenterId").attr('id', 'presenterId_' + mainAgendaIndex + "_" + subAgendaCount);

	    $cloneSub.find(".sub.duration").attr('id', 'duration_' + mainAgendaIndex + "_" + subAgendaCount);
	    $cloneSub.find(".sub.attachment").attr('id', 'attachment_' + mainAgendaIndex + "_" + subAgendaCount);

	    $cloneSub.find(".sub.agendaItem").attr('name', 'agenda[' + (mainAgendaIndex - 1) + '].subAgendas[' + (subAgendaCount - 1) + '].agendaItem');
	    $cloneSub.find(".sub.prepsLabCode").attr('name', 'agenda[' + (mainAgendaIndex - 1) + '].subAgendas[' + (subAgendaCount - 1) + '].prepsLabCode');
	    $cloneSub.find(".sub.presenterId").attr('name', 'agenda[' + (mainAgendaIndex - 1) + '].subAgendas[' + (subAgendaCount - 1) + '].presenterId');
	    $cloneSub.find(".sub.duration").attr('name', 'agenda[' + (mainAgendaIndex - 1) + '].subAgendas[' + (subAgendaCount - 1) + '].duration');
	    $cloneSub.find(".sub.attachment").attr('name', 'agenda[' + (mainAgendaIndex - 1) + '].subAgendas[' + (subAgendaCount - 1) + '].attachment');

	    $cloneSub.find("input").val("");
	    $cloneSub.find("textarea").val("");
	    $cloneSub.find(".sub.agendaItemBtn").html("Enter Agenda Item");
	    
	    $cloneSub.show();
	    $subTable.append($cloneSub);

	    $('.itemssub').select2();
	    $cloneSub.find('.itemssub').select2('val', '');
	    

	    AgendaPresentors(mainAgendaIndex + '_' + subAgendaCount);
	});

	/* ------------------------------------------- Agenda Sub Level Removal ---------------------------------------------------------- */
	$("#agendatable").on('click', '.tr_clone_rem_sub_level_agenda', function() {
	    var $currentRow = $(this).closest('.tr_clone_sub_agenda');
	    $currentRow.remove();
        var currentRowId = $currentRow.attr('id');
        var splitValues = currentRowId.split("-");
        var mainAgendaIndex = splitValues[splitValues.length - 2];
        
        var $subTable = $('#agendasubtable-' + mainAgendaIndex);

        var hasSubRows = $subTable.find('.tr_clone_sub_agenda').length < 1;
        
	    if (hasSubRows) {
	        $('#agendasubtable-' + mainAgendaIndex).hide();
	    }
	}); 
	
	
	/* --------------------- Agenda Cloning End--------------------------- */

	
	/* --------------------- Agenda Presenters (Add)--------------------------- */
	function AgendaPresentors($AddrowId){
		
		var $prepsLabCode = $('#prepsLabCode_'+$AddrowId).val();
		if($prepsLabCode !="" && $prepsLabCode !="null" && $prepsLabCode !=null){
		$.ajax({		
				type : "GET",
				url : "CommitteeAgendaPresenterList.htm",
				data : {
					PresLabCode : $prepsLabCode,
				},
				datatype : 'json',
				success : function(result) {
	
					var result = JSON.parse(result);	
					var values = Object.keys(result).map(function(e) {return result[e]});
							
					var s = '';
					s += '<option value="0" >Choose...</option>';
					for (i = 0; i < values.length; i++) {									
						s += '<option value="'+values[i][0]+'">'+values[i][1] + " (" +values[i][3]+")" + '</option>';
					} 
							 
					$('#presenterId_'+$AddrowId).html(s);
				}
			});
		}
	}
	
	/* --------------------- Agenda Presenters (Add) End--------------------------- */
	/* --------------------- Agenda Presenters (Edit)--------------------------- */
	function EditAgendaPresentors($AddrowId,PresentorID){
		
		
		var $prepsLabCode = $('#prepsLabCode_Edit_'+$AddrowId).val();
		
		if($prepsLabCode !="" && $prepsLabCode !="null" && $prepsLabCode !=null){
		$.ajax({		
			type : "GET",
			url : "CommitteeAgendaPresenterList.htm",
			data : {
				PresLabCode : $prepsLabCode,
				
				   },
			datatype : 'json',
			success : function(result) {

			var result = JSON.parse(result);	
			var values = Object.keys(result).map(function(e) {return result[e]});
			
			var s = '';
				s += '<option value="0">Choose...</option>';
						 for (i = 0; i < values.length; i++) {									
							s += '<option value="'+values[i][0]+'">'
									+values[i][1] + " (" +values[i][3]+")" 
									+ '</option>';
						} 
						 
						$('#presenterId_Edit_'+$AddrowId).html(s);
						$('#presenterId_Edit_'+$AddrowId).val(PresentorID).trigger('change');
					}
				});
			}
	}
	
	/* --------------------- Agenda Presenters (Edit) End--------------------------- */
	
	/* --------------------- Expand Button Handle for Agenda List--------------------------- */
	function ChangeButton(id) {
		  
		if($( "#btn"+id ).hasClass( "btn btn-sm btn-success" ).toString()=='true'){
		$( "#btn"+id ).removeClass( "btn btn-sm btn-success" ).addClass( "btn btn-sm btn-danger" );
		$( "#fa"+id ).removeClass( "fa fa-plus" ).addClass( "fa fa-minus" );
		$( ".row"+id).show();
	    }else{
		$( "#btn"+id ).removeClass( "btn btn-sm btn-danger" ).addClass( "btn btn-sm btn-success" );
		$( "#fa"+id ).removeClass( "fa fa-minus" ).addClass( "fa fa-plus" );
		$( ".row"+id).hide();
	    }
	}	
	/* --------------------- Expand Button Handle for Agenda List End --------------------------- */
	
	/* --------------------- Update Priority --------------------------- */
	
	function updateMainPriority(){
	    var agendaPriority = [];
	    var scheduleAgendaId = [];
	    var isValid = true;
	    var errors = [];
	
	    $("input[id='agendaPriorityMain']").each(function() {
	        agendaPriority.push($(this).val());
	    });
	
	    $("input[id='scheduleAgendaIdMain']").each(function() {
	        scheduleAgendaId.push($(this).val());
	    });
	
	    // Check for zero values and values greater than the length of scheduleAgendaId
	    var maxAllowedValue = scheduleAgendaId.length;
	    var prioritySet = new Set();
	    agendaPriority.forEach(function(value, index) {
	        if (value == 0) {
	            isValid = false;
	            errors.push('Value at position '+(index+1)+' is zero.');
	        } else if (value > maxAllowedValue) {
	            isValid = false;
	            errors.push('Value at position '+(index+1)+' is greater than allowed maximum of '+(maxAllowedValue)+'.');
	        } else if (prioritySet.has(value)) {
	            isValid = false;
	            errors.push('Duplicate value '+(value)+' found at position '+(index+1)+'.');
	        }
	        prioritySet.add(value);
	    });
	
	    if (!isValid) {
	        alert(errors.join("\n"));
	    } else {
	        
	    	$('#agendaPriorityMainForm').val(agendaPriority);
	    	$('#scheduleAgendaIdMainForm').val(scheduleAgendaId);
	    	if(confirm('Are you sure to update Agenda Priority?')){
	    		$('#priorityForm').submit();
	    	}else{
	    		event.preventDefault();
	    	}
	    	
	    }
	}

	/* --------------------- Update Priority End--------------------------- */
	
	/* --------------------- Sub Agenda Cloning Edit ------------------------------------------------------------------------------------- */
	
	const $tableTbody = $('#tbody_clone_sub_agenda_edit').html();
	
	var subAgendaEditCount = 1;
	var scheduleAgendaIdCount = 0;
	function openSubAgendaAddModal(scheduleAgendaId, agendaItem, slno) {
		
		if(scheduleAgendaId!= scheduleAgendaIdCount){
			scheduleAgendaIdCount = scheduleAgendaId;
			subAgendaEditCount = 1;
			
			$('#tbody_clone_sub_agenda_edit').html('');
			$('#tbody_clone_sub_agenda_edit').html($tableTbody);
			$('.itemsubedit').select2();
		}
		
		$('#agendaheading').text(agendaItem);
		$('#scheduleAgendaIdModal').val(scheduleAgendaId);
		$('#slno').val(slno);
		$('#cloningTableModal').modal('show');
		
	}
	
	//$('.itemsubedit').select2();
	
	/* --------------------- Sub Agenda Add ----------------------------------------- */
	$('#agendatable-edit').on('click','.tr_clone_add_sub_agenda_edit', function(){
		$('.itemsubedit').select2("destroy");
		$tr = $('.tr_clone_sub_agenda_edit').last();
		$clone = $tr.clone();
		$tr.after($clone);
		
		++subAgendaEditCount;
		
		$clone.find('.agendaedit.agendaItemBtn').attr('id', 'agendaItemBtn_edit_'+subAgendaEditCount).attr("onclick","openEditor('edit_', "+subAgendaEditCount+', 0)');
		$clone.find('.agendaedit.agendaItem').attr('id', 'agendaItem_edit_'+subAgendaEditCount);
		$clone.find('.agendaedit.prepsLabCode').attr('id', 'prepsLabCode_edit_'+subAgendaEditCount).attr("onchange", 'AgendaPresentors(\'edit_' + subAgendaEditCount + '\')');;
		$clone.find('.agendaedit.presenterId').attr('id', 'presenterId_edit_'+subAgendaEditCount);
		$clone.find(".agendaedit.duration").attr("id", 'duration_edit_' + subAgendaEditCount);
	    $clone.find(".agendaedit.attachment").attr("id", 'attachment_edit_' + subAgendaEditCount);
	    
		$clone.find("input").val("");
		$clone.find("textarea").val("");
	    $clone.find(".agendaedit.agendaItemBtn").html("Enter Agenda Item");
		$('.itemsubedit').select2();
	    $clone.find('.itemsubedit').select2('val', '');
	    
	    AgendaPresentors('edit_'+subAgendaEditCount);
	});
	
	/* --------------------- Sub Agenda Add End ----------------------------------------- */
	/* --------------------- Sub Agenda Removal ----------------------------------------- */
	$("#agendatable-edit").on('click', '.tr_clone_rem_sub_agenda_edit', function() {
	    var cl = $('.tr_clone_sub_agenda_edit').length;
	
	    if (cl > 1) {
	        var $tr = $(this).closest('.tr_clone_sub_agenda_edit');
	        $tr.remove();
	    }
	}); 
	/* --------------------- Sub Agenda Removal End ----------------------------------------- */
	
	/* --------------------- Sub Agenda Cloning End----------------------------------------------------------------------------------------- */
	
	
	
	/* --------------------- Validations --------------------------------------------------------------------------------------------------- */
	function isNumber(evt) {
	    evt = (evt) ? evt : window.event;
	    var charCode = (evt.which) ? evt.which : evt.keyCode;
	    if (charCode > 31 && (charCode < 48 || charCode > 57)) {
	        return false;
	    }
	    return true;
	}
	
	function checkMaxDurationAtSubLevel(element) {
	    var $element = $(element);
	    var elementId = $element.attr('id');
	    var idParts = elementId.split('_');
	    
	    var mainDurationId = idParts.slice(0, 2).join('_');
	    var mainDuration = parseFloat($('#' + mainDurationId).val()) || 0;
	    var idPrefix = mainDurationId + '_';

	    // Select all elements whose ID starts with the prefix and accumulate their values
	    var sum = $('[id^="' + idPrefix + '"]').toArray().reduce(function(total, el) {
	        return total + (parseFloat($(el).val()) || 0);
	    }, 0);

	    $('#' + mainDurationId).val(sum);
	    
	    /* if (sum > mainDuration) {
	        alert('Sub Agenda/s Duration Should not exceed more than Main Agenda Duration');
	        $element.val('');
	    } */
	}

	function checkMaxDurationAtMainLevel(element) {
	    var $element = $(element);
	    var elementId = $element.attr('id');
	    var mainDuration = parseFloat($element.val()) || 0;
	    var idPrefix = elementId + '_';

	    // Select all elements whose ID starts with the prefix and accumulate their values
	    var sum = $('[id^="' + idPrefix + '"]').toArray().reduce(function(total, el) {
	        return total + (parseFloat($(el).val()) || 0);
	    }, 0);

	    if (sum > mainDuration) {
	        alert('Before changing Main Agenda Duration \n Please change the Sub Agenda/s Duration');
	        $element.val(sum);
	    }
	}
	
	/* --------------------- Validations End ---------------------------------------------------------------------------------------------- */
	
	
	/* ---------------------CK Editor Config --------------------------------------------------------------------------------------------------- */

	var editor_config = {
			toolbar : [
					{
						name : 'clipboard',
						items : [ 'Undo', 'Redo' ]
					},
					{
						name : 'basicstyles',
						items : [ 'Bold', 'Italic', 'Underline', 'Strike',
								  'Subscript', 'Superscript' ]
					},

					{
						name : 'paragraph',
						items : [ 'NumberedList', 'BulletedList', '-',
								'Outdent', 'Indent']
					},

					{
						name : 'styles',
						items : [ 'Format', 'Font', 'FontSize' ]
					},
					{
						name : 'colors',
						items : [ 'TextColor', 'BGColor', 'CopyFormatting' ]
					},
					{
						name : 'align',
						items : [ 'JustifyLeft', 'JustifyCenter',
								'JustifyRight', 'JustifyBlock' ]
					}, {
						name : 'document',
						items : [ 'Source' ]
					} ],

			removeButtons : 'Underline,Strike,Subscript,Superscript,Anchor,Styles,Specialchar',

			customConfig : '',

			disallowedContent : 'img{width,height,float}',
			extraAllowedContent : 'img[width,height,align]',

			height : 200,

			contentsCss : [ CKEDITOR.basePath + 'mystyles.css' ],

			bodyClass : 'document-editor',

			format_tags : 'p;h1;h2;h3;pre',

			removeDialogTabs : 'image:advanced;link:advanced',

			stylesSet : [

			{
				name : 'Marker',
				element : 'span',
				attributes : {
					'class' : 'marker'
				}
			}, {
				name : 'Cited Work',
				element : 'cite'
			}, {
				name : 'Inline Quotation',
				element : 'q'
			},

			{
				name : 'Special Container',
				element : 'div',
				styles : {
					padding : '5px 10px',
					background : '#eee',
					border : '1px solid #ccc'
				}
			}, {
				name : 'Compact table',
				element : 'table',
				attributes : {
					cellpadding : '6',
					cellspacing : '0',
					border : '1',
					bordercolor : '#ccc'
				},
				styles : {
					'border-collapse' : 'collapse'
				}
			}, {
				name : 'Borderless Table',
				element : 'table',
				styles : {
					'border-style' : 'hidden',
					'background-color' : '#E6E6FA'
				}
			}, {
				name : 'Square Bulleted List',
				element : 'ul',
				styles : {
					'list-style-type' : 'square'
				}
			}, {
				filebrowserUploadUrl : '/path/to/upload-handler'
			}, ]
		};
	
	/* ---------------------CK Editor Config End --------------------------------------------------------------------------------------------------- */
	
	
	
	/* --------------------- Open Editor Modal --------------------------------------------------------------------------------------------------- */
	
	function openEditor(addEdit, mainLevel, subLevel) {
		
		$('#ckEditorModal').modal('show');
		
		$('#mainLevel').val(mainLevel);
		$('#subLevel').val(subLevel);
		$('#addEdit').val(addEdit);
		
		var html = $('#agendaItemBtn_'+addEdit+''+mainLevel+(subLevel=='0'?'':('_'+subLevel))).html();
		CKEDITOR.replace('Editor', editor_config);
		CKEDITOR.instances['Editor'].setData(html);
	}
	
	$('.closeEditor').click(function(){
		
		var mainLevel = $('#mainLevel').val();
		var subLevel = $('#subLevel').val();
		var addEdit = $('#addEdit').val();
		
		var data = CKEDITOR.instances['Editor'].getData();
				
		$('#agendaItem_'+addEdit+''+mainLevel+(subLevel=='0'?'':('_'+subLevel))).val(data);
		$('#agendaItemBtn_'+addEdit+''+mainLevel+(subLevel=='0'?'':('_'+subLevel))).html(data!=''?data:'Enter Agenda Item');

	});
	/* --------------------- Validations --------------------------------------------------------------------------------------------------- */
</script>


 <script type="text/javascript">

 function bootstrapTabControl(){
	  var i, items = $('.nav-links'), pane = $('.tab-pane');
	  // next
	  $('.next').on('click', function(){
	      for(i = 0; i < items.length; i++){
	          if($(items[i]).hasClass('active') == true){
	              break;
	          }
	      }
	      if(i < items.length - 1){
	          $(items[i+1]).trigger('click');
	      }

	  });
	  // Prev
	  $('.previous').on('click', function(){
	      for(i = 0; i < items.length; i++){
	          if($(items[i]).hasClass('active') == true){
	              break;
	          }
	      }
	      if(i != 0){
	          $(items[i-1]).trigger('click');
	      }
	  });
	}
	bootstrapTabControl(); 

</script>  	




<spring:url value="/resources/jquery-ui.js" var="JqueryUIJs" />  
<script src="${JqueryUIJs}"></script>

<!-- Month And Year picker --> 
<spring:url value="/resources/js/monthpicker.js" var="MonthYearPickerJs" />  
<script src="${MonthYearPickerJs}"></script> 
 
<script type="text/javascript">
 $(function(){
	 $('.monthpicker').monthpicker({ 
		 altFormat:'MM yy',
	});
});
 </script>    
 	
</body>
</html>