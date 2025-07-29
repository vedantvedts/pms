<%@page import="java.time.LocalDate"%>
<%@page import="com.vts.pfms.FormatConverter"%>
<%@page import="java.util.Map"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
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
body{
	background-color: #f2edfa;
	overflow-x:hidden !important; 
}
h6{
	text-decoration: none !important;
}

#containers, #containers2 {
    width: 100%;
    height: 100%;
    margin: 0;
    padding: 0;
}

.anychart-credits {
   display: none;
}

.flex-container {
  display: flex;
  flex-direction: column;
  min-height: 100vh;
}

.form-label {
	font-weight: bold;
	font-size: medium;
}

#taskTable {
   border-collapse: collapse;
   width: 100%;
   table-layout: fixed;
}
#taskTable th, #taskTable td {
    border: 1px solid #ccc;
    padding: 5px;
    text-align: center;
    font-size: 12px;
    position: relative;
}
#taskTable tr:nth-child(even) {
  background-color: #fafafa;
}
#taskTable tr:hover {
  background-color: #f1f1f1;
}

.scroll-container {
  max-height: 600px; /* adjust as needed */
  overflow-y: auto;
  position: relative;
}

/* Sticky header */
#taskTable thead th {
  position: sticky;
  top: 0;
  background-color: #0D47A1;
  color: #fff !important;
  z-index: 2;
}


/* Sticky last row (total load row) */
#taskTable tr.total-row {
  position: sticky;
  bottom: 0;
  background-color: #f0f0f0;
  z-index: 1;
  font-weight: bold;
}


.bar {
  height: 20px;
  border-radius: 4px;
  color: white;
  font-weight: bold;
  font-size: 12px;
  line-height: 22px;
  overflow: hidden;
  text-align: center;
}

.controls {
    margin-bottom: 20px;
}

#customTooltip {
  transition: opacity 0.2s ease;
  max-width: 450px;
  white-space: normal;
}

</style>

</head>
 
<body>
<%
	List<Object[]> employeeList = (List<Object[]>)request.getAttribute("roleWiseEmployeeList");
	List<Object[]> projectList = (List<Object[]>)request.getAttribute("projectList");
	List<Object[]> totalAssignedMainList = (List<Object[]>)request.getAttribute("totalAssignedMainList");
	List<Object[]> totalAssignedSubList = (List<Object[]>)request.getAttribute("totalAssignedSubList");
	List<Object[]> actionAssigneeList = (List<Object[]>)request.getAttribute("actionAssigneeList");
	String empId = (String)request.getAttribute("empId");
	String tabNo = (String)request.getAttribute("tabNo");
	String activityType = (String)request.getAttribute("activityType");
	
	FormatConverter fc = new FormatConverter();
	
	totalAssignedSubList.sort((o1, o2) -> {
	    // Null safety, if needed
	    Long p1 = o1[19] != null ? Long.parseLong(o1[19].toString()) : 0;
	    Long p2 = o2[19] != null ? Long.parseLong(o2[19].toString()) : 0;
	    int result = p1.compareTo(p2);
	    if (result != 0) return result;

	    Long s1 = o1[16] != null ? Long.parseLong(o1[16].toString()) : 0;
	    Long s2 = o2[16] != null ? Long.parseLong(o2[16].toString()) : 0;
	    result = s1.compareTo(s2);
	    if (result != 0) return result;

	    Integer t1 = o1[18] != null ? Integer.parseInt(o1[18].toString()) : 0;
	    Integer t2 = o2[18] != null ? Integer.parseInt(o2[18].toString()) : 0;
	    result = t1.compareTo(t2);
	    if (result != 0) return result;

	    String u1 = o1[17] != null ? o1[17].toString() : "";
	    String u2 = o2[17] != null ? o2[17].toString() : "";
	    return u1.compareTo(u2);
	});

	
%>
	
	<div class="container-fluid">
		<div class="card">
			<div class="card-header ">  
				<form method="post" action="ResourceGanttChart.htm" name="myform" id="myform">
					<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" /> 
					<input type="hidden" name="tabNo" id="tabNo" value="<%=tabNo%>">
							
					<div class="row" style="margin-top: -5px;">
						<div class="col-md-5">
							<h5>Resource Details</h5>  
						</div>
						<div class="col-md-1 right">
							<label class="form-label">Type:</label>
						</div>
						<div class="col-md-2 ">
							<select class="form-control selectdee" name="activityType" onchange="this.form.submit()" >
								<option value="A" <%if(activityType!=null && activityType.equalsIgnoreCase("A")) {%>selected<%} %> >All</option>
								<option value="B" <%if(activityType!=null && activityType.equalsIgnoreCase("B")) {%>selected<%} %>>Action</option>
								<option value="C" <%if(activityType!=null && activityType.equalsIgnoreCase("C")) {%>selected<%} %>>Milestone</option>
							</select>
						</div>
						<div class="col-md-1 right">
							<label class="form-label">Employee:</label>
						</div>
						<div class="col-md-3">
                           	<select class="form-control selectdee" name="empId" onchange="this.form.submit()" >
								<option selected disabled>---Select---</option>
								<%if(employeeList!=null && employeeList.size()>0) {
									for(Object[] obj : employeeList) {%>
										<option value="<%=obj[0]%>" <%if(empId.equalsIgnoreCase(obj[0]+"")) {%>selected<%} %> >
											<%=(obj[1]!=null?obj[1]:(obj[2]!=null?obj[2]:""))+" "+obj[5]+", "+obj[6] %>
										</option>
								<%} }%>
							</select>
						</div>
		   			</div>	   							
				</form>
			</div>
		</div>
		<% String ses = (String) request.getParameter("result"); 
	       String ses1 = (String) request.getParameter("resultfail");
	       if (ses1 != null) { %>
	        <div align="center">
	            <div class="alert alert-danger" role="alert">
	                <%= ses1 %>
	            </div>
	        </div>
	    <% } if (ses != null) { %>
	        <div align="center">
	            <div class="alert alert-success" role="alert">
	                <%= ses %>
	            </div>
	        </div>
	    <% } %>
		<div class="row" style="margin: 0.5rem;">
			<div class="col-12">
        		<ul class="nav nav-pills" id="pills-tab" role="tablist" style="background-color: #E1E5E8;padding:0px;">
	  				<li class="nav-item" style="width: 33%;"  >
	    				<div class="nav-link center <%if(tabNo.equals("1")) {%>active<%} %>" id="pills-tab-1" data-toggle="pill" data-target="#tab-1" role="tab" aria-controls="tab-1" aria-selected="<%if(tabNo.equals("1")) {%>true<%} else{%>false<%}%>">
		   					<span>Resource List</span> 
	    				</div>
	  				</li>
	  				<li class="nav-item"  style="width: 34%;">
	    				<div class="nav-link center <%if(tabNo.equals("2")) {%>active<%} %>" id="pills-tab-2" data-toggle="pill" data-target="#tab-2" role="tab" aria-controls="tab-2" aria-selected="<%if(tabNo.equals("2")) {%>true<%} else{%>false<%}%>">
	    	 				<span>Gantt Chart</span> 
	    				</div>
	  				</li>
	  				<li class="nav-item"  style="width: 33%;">
	    				<div class="nav-link center <%if(tabNo.equals("3")) {%>active<%} %>" id="pills-tab-3" data-toggle="pill" data-target="#tab-3" role="tab" aria-controls="tab-3" aria-selected="<%if(tabNo.equals("3")) {%>true<%} else{%>false<%}%>">
	    	 				<span>Resource Progress</span> 
	    				</div>
	  				</li>
				</ul>
   			</div>
		</div>
		
		<div class="tab-content" id="pills-tabContent">
		
       		<div class="tab-pane <%if(tabNo.equals("1")) {%>fade show active <%} %>" id="tab-1" role="tabpanel" aria-labelledby="pills-tab-1">
       			<div class="row">
					<div class="col-md-12">
						<div class="card shadow-nohover">
							<div class="card-body ">
								<div class="row">
									<div class="col-md-12">
										<div class="table-responsive"> 
                        					<table class="table table-bordered table-hover table-striped table-condensed" id="myTable">
					                            <thead class="center">
					                                <tr>
					                                    <th width="3%">SN</th>
					                                    <th width="12%">Project</th>
					                                    <th width="15%">Activity Id</th>
					                                    <th width="30%">Activity</th>
					                                    <th width="10%">Start</th>
					                                    <th width="10%">End</th>
					                                    <!-- <th width="10%">Weightage</th> -->
					                                    <th width="10%">Progress</th>
					                                    <th width="10%">Loading (%)</th>
					                                </tr>
					                            </thead>
					                            <tbody>
					                            	<%
					                            	int slno = 0;
					                            	if((activityType.equalsIgnoreCase("A") || activityType.equalsIgnoreCase("B")) ) { %>
					                            		<%if(actionAssigneeList!=null && actionAssigneeList.size()>0) { 
						                            		for(Object[] obj : actionAssigneeList) { %>
						                            		<tr>
						                            			<td class="center"><%=++slno %></td>
						                            			<td class="center">
						                            				<%if(obj[9]!=null && obj[10]!=null) {%>
						                            					<%=obj[9]+" ("+obj[10]+")"%>
						                            				<%} else if(obj[2]!=null){%>
						                            					<%=obj[2].toString().split("/")[1]%>
						                            				<%} %>
						                            			</td>
						                            			<td class="center"><%=obj[2]%></td>
						                            			<td><%=obj[3]%></td>
						                            			<td class="center"><%=obj[5]!=null?fc.sdfTordf(obj[5].toString()):"-" %></td>
						                            			<td class="center"><%=obj[6]!=null?fc.sdfTordf(obj[6].toString()):"-" %></td>
						                            			<%-- <td class="center"><%=obj[13]%></td> --%>
						                            			<td>
						                            				<%if(!obj[11].toString().equalsIgnoreCase("0")){ %>
																		<div class="progress" style="background-color:#cdd0cb !important;height: 1.4rem !important;">
																			<div class="progress-bar progress-bar-striped
																				<%if(obj[11].toString().equalsIgnoreCase("2")){ %>
																					bg-success
																				<%} else if(obj[11].toString().equalsIgnoreCase("3")){ %>
																					bg-info
																				<%} else if(obj[11].toString().equalsIgnoreCase("4")){ %>
																					bg-danger
																				<%} else if(obj[11].toString().equalsIgnoreCase("5")){ %>
																					bg-warning
																				<%}  %>
																				" role="progressbar" style=" width: <%=obj[11] %>%;  " aria-valuenow="25" aria-valuemin="0" aria-valuemax="100" >
																				<%=obj[11] %>
																			</div> 
																		</div> 
																	<%}else{ %>
																		<div class="progress" style="background-color:#cdd0cb !important;height: 1.4rem !important;">
																			<div class="progress-bar" role="progressbar" style=" width: 100%; background-color:#cdd0cb !important;color:black;font-weight: bold;  "  >
																				Not Started
																			</div>
																		</div> 
																	<%} %>
						                            			</td>
						                            			<td class="left">
						                            				<form action="ActionActivityLoadingSubmit.htm" method="post" id="inlineform_<%=slno %>">
						                            					<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" /> 
						                            					<input type="hidden" name="actionAssignId" value="<%=obj[0] %>">
						                            					<input type="hidden" name="empId" value="<%=empId%>">
						                            					<input type="hidden" name="tabNo" value="1">
						                            					<input type="hidden" name="activityType" value="<%=activityType%>">
						                            					
						                            					<input type="number" name="loading" value="<%=obj[8] %>" min="0" max="100" required style="border-left: 0;border-top: 0;border-right: 0;width: 65%;">
						                            					&emsp;
																		<button type="submit" class="btn btn-sm btn-success" data-toggle="tooltip" data-placement="top" onclick="return confirm('Are you sure to submit?')" style="border-radius: 2rem;">
																			<i class="fa fa-check" aria-hidden="true"></i> 
																		</button>
						                            				</form>
						                            			</td>
						                            		</tr>
						                            	<%} }%>
					                            	<%} %>
					                            	<%
					                            	if((activityType.equalsIgnoreCase("A") || activityType.equalsIgnoreCase("C")) ) { %>
					                            	
						                            	<%if(totalAssignedMainList!=null && totalAssignedMainList.size()>0) { 
						                            		for(Object[] obj : totalAssignedMainList) { %>
						                            		<tr>
						                            			<td class="center"><%=++slno %></td>
						                            			<td class="center"><%=obj[14]+" ("+obj[15]+")"%></td>
						                            			<td class="center">M<%=obj[2]%></td>
						                            			<td><%=obj[3]%></td>
						                            			<td class="center"><%=obj[6]!=null?fc.sdfTordf(obj[6].toString()):"-" %></td>
						                            			<td class="center"><%=obj[7]!=null?fc.sdfTordf(obj[7].toString()):"-" %></td>
						                            			<%-- <td class="center"><%=obj[13]%></td> --%>
						                            			<td>
						                            				<%if(!obj[8].toString().equalsIgnoreCase("0")){ %>
																		<div class="progress" style="background-color:#cdd0cb !important;height: 1.4rem !important;">
																			<div class="progress-bar progress-bar-striped
																				<%if(obj[12].toString().equalsIgnoreCase("2")){ %>
																					bg-success
																				<%} else if(obj[12].toString().equalsIgnoreCase("3")){ %>
																					bg-info
																				<%} else if(obj[12].toString().equalsIgnoreCase("4")){ %>
																					bg-danger
																				<%} else if(obj[12].toString().equalsIgnoreCase("5")){ %>
																					bg-warning
																				<%}  %>
																				" role="progressbar" style=" width: <%=obj[8] %>%;  " aria-valuenow="25" aria-valuemin="0" aria-valuemax="100" >
																				<%=obj[8] %>
																			</div> 
																		</div> 
																	<%}else{ %>
																		<div class="progress" style="background-color:#cdd0cb !important;height: 1.4rem !important;">
																			<div class="progress-bar" role="progressbar" style=" width: 100%; background-color:#cdd0cb !important;color:black;font-weight: bold;  "  >
																				Not Started
																			</div>
																		</div> 
																	<%} %>
						                            			</td>
						                            			<td class="left">
						                            				<form action="MilestoneActivityLoadingSubmit.htm" method="post" id="inlineform_<%=slno %>">
						                            					<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" /> 
						                            					<input type="hidden" name="milestoneActivityId" value="<%=obj[0] %>">
						                            					<input type="hidden" name="milestoneType" value="M">
						                            					<input type="hidden" name="empId" value="<%=empId%>">
						                            					<input type="hidden" name="tabNo" value="1">
						                            					<input type="hidden" name="activityType" value="<%=activityType%>">
						                            					
						                            					<input type="number" name="loading" value="<%=obj[17] %>" min="0" max="100" required style="border-left: 0;border-top: 0;border-right: 0;width: 65%;">
						                            					&emsp;
																		<button type="submit" class="btn btn-sm btn-success" data-toggle="tooltip" data-placement="top" onclick="return confirm('Are you sure to submit?')" style="border-radius: 2rem;">
																			<i class="fa fa-check" aria-hidden="true"></i> 
																		</button>
						                            				</form>
						                            			</td>
						                            		</tr>
						                            	<%} }%>
						                            	<%if(totalAssignedSubList!=null && totalAssignedSubList.size()>0) { 
						                            		for(Object[] obj : totalAssignedSubList) { 
						                    	   				Object[] projectDetails = projectList.stream().filter(e -> Long.parseLong(e[0].toString())== Long.parseLong(obj[18].toString())).findFirst().orElse(null);
						                            		%>
						                            		<tr>
						                            			<td class="center"><%=++slno %></td>
						                            			<td class="center"><%=projectDetails!=null?(projectDetails[1]+" ("+projectDetails[3]+")"):"-"%></td>
						                            			<td class="center">M<%=obj[18] %> <%=obj[17] %></td>
						                            			<td><%=obj[3]%></td>
						                            			<td class="center"><%=obj[6]!=null?fc.sdfTordf(obj[6].toString()):"-" %></td>
						                            			<td class="center"><%=obj[7]!=null?fc.sdfTordf(obj[7].toString()):"-" %></td>
						                            			<%-- <td class="center"><%=obj[13]%></td> --%>
						                            			<td>
						                            				<%if(!obj[8].toString().equalsIgnoreCase("0")){ %>
																		<div class="progress" style="background-color:#cdd0cb !important;height: 1.4rem !important;">
																			<div class="progress-bar progress-bar-striped
																				" role="progressbar" style=" width: <%=obj[8] %>%;  " aria-valuenow="25" aria-valuemin="0" aria-valuemax="100" >
																				<%=obj[8] %>
																			</div> 
																		</div> 
																	<%}else{ %>
																		<div class="progress" style="background-color:#cdd0cb !important;height: 1.4rem !important;">
																			<div class="progress-bar" role="progressbar" style=" width: 100%; background-color:#cdd0cb !important;color:black;font-weight: bold;  "  >
																				Not Started
																			</div>
																		</div> 
																	<%} %>
						                            			</td>
						                            			<td class="left">
						                            				<form action="MilestoneActivityLoadingSubmit.htm" method="post" id="inlineform_<%=slno %>">
						                            					<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" /> 
						                            					<input type="hidden" name="milestoneActivityId" value="<%=obj[0] %>">
						                            					<input type="hidden" name="milestoneType" value="S">
						                            					<input type="hidden" name="empId" value="<%=empId%>">
						                            					<input type="hidden" name="tabNo" value="1">
						                            					<input type="hidden" name="activityType" value="<%=activityType%>">
						                            					
						                            					<input type="number" name="loading" value="<%=obj[14] %>" min="0" max="100" required style="border-left: 0;border-top: 0;border-right: 0;width: 65%;">
						                            					&emsp;
																		<button type="submit" class="btn btn-sm btn-success" data-toggle="tooltip" data-placement="top" onclick="return confirm('Are you sure to submit?')" style="border-radius: 2rem;">
																			<i class="fa fa-check" aria-hidden="true"></i> 
																		</button>
						                            				</form>
						                            			</td>
						                            		</tr>
						                            	<%} }%>
					                            	
					                            	<%} %>
					               				</tbody>
					               			</table>
					               		</div>		 
									</div>
								</div>
							</div>
						</div>
					</div>
				</div>			
       		</div>	
       		
			<div class="tab-pane <%if(tabNo.equals("2")) {%>fade show active <%} %>" id="tab-2" role="tabpane2" aria-labelledby="pills-tab-2">
				<div class="row">
					<div class="col-md-12">
						<div class="card shadow-nohover">
							<div class="card-header ">  
		
								<div class="row" style="margin-top: -5px;">
									<div class="col-md-5">
									</div>
									<div class="col-md-4">
									</div>
								
									<div class="col-md-2">
										<div>
											<label class="form-label">Interval : </label>
											<select class="form-control selectdee " name="interval" id="interval" required="required"  data-live-search="true"  style="width:150px !important; float : right;" >
			                                	<option value="quarter"> Quarterly </option>
			                                	<option value="half" >Half-Yearly</option>
			                                	<option value="year" >Yearly</option>
			                                	<option value="month"> Monthly </option>
											</select>
										</div>
									</div>
								
									<div class="col-md-1" >
										 <button type="submit" class="btn btn-sm prints" id="prints" style="float:left" onclick="ChartPrint(interval)" >Print</button> 
									</div>
									<%-- <div class="col-md-1" >
										<form method="post">
											<button type="submit" class="btn btn-sm back"  formaction="ResourceGanttChart.htm" style="float:right; background-color: #DE834D; font-weight: 600;border:0px;"  >Sub Level</button>
											<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" /> 
										<input type="hidden" name="empId"  id="empId" value="<%=empId %>" /> 
										</form>
									</div> --%>
					   			</div>	   							
		
							</div>
							
							<div class="card-body "> 
									
								<div class="row" style="margin-top: -18px;">
										
									<div class="col-md-12" style="float: right;" >
											
										<div class="row" style="margin-top: 5px;font-weight: bold;"   >
											<div class="col-md-8"></div>
											<div class="col-md-4">
												<div style="font-weight: bold; " >
													<span style="margin:0px 0px 10px  10px;">Original :&ensp; <span style=" background-color: #4A90E2;  padding: 0px 15px; border-radius: 3px;"></span></span>
													<span style="margin:0px 0px 10px  15px;">Ongoing :&ensp; <span style=" background-color: #059212;  padding: 0px 15px;border-radius: 3px;"></span></span>
													<span style="margin:0px 0px 10px  15px;">Revised :&ensp; <span style=" background-color: #F5A623; opacity: 0.5; padding: 0px 15px;border-radius: 3px;"></span></span>
												</div>
											</div>
										</div>
											
							   			<div class="flex-container" id="containers" ></div>
		                        			
		                        	</div>
								</div>
							</div>
						</div>
					</div>
				</div>
			</div>
			<div class="tab-pane  <%if(tabNo.equals("3")) {%>fade show active <%} %>" id="tab-3" role="tabpane3" aria-labelledby="pills-tab-3">
				<div class="row">
					<div class="col-md-12">
						<div class="card shadow-nohover">
							<div class="card-header ">  
		
								<div class="row" style="margin-top: -5px;">
									<div class="col-md-4">
									</div>
									<div class="col-md-4">
									</div>
								
									<div class="col-md-1 right">
										<label class="form-label">Year:</label>
									</div>
									<div class="col-md-1">
										<input class="form-control" type="text" id="yearSelect" value="<%=LocalDate.now().getYear() %>" >
									</div>
									
									<div class="col-md-2">
										<label class="form-label">Interval:</label>
										<select class="form-control selectdee " id="viewType" required="required"  data-live-search="true"  style="width:150px !important; float : right;" >
		                                	<option value="weekly" selected>Weekly</option>
		                                	<option value="monthly"> Monthly </option>
		                                	<option value="quarterly">Quarterly</option>
										</select>
									</div>
								
					   			</div>	   							
		
							</div>
							
							<div class="card-body "> 
									
								<div class="row" style="margin-top: -18px;">
										
									<div class="col-md-12" >
										<div class="scroll-container">
											<table id="taskTable">
											    <thead>
											        <tr id="timeHeader">
											            <th>Task</th>
											        </tr>
											    </thead>
											    <tbody id="taskBody">
											    </tbody>
											</table>
										</div>	
		                        	</div>
								</div>
							</div>
						</div>
					</div>
				</div>
       		</div>	
		</div>		
	</div>
<div id="customTooltip" style="position:absolute; display:none; z-index:9999; background:#fff; border:1px solid #ccc; padding:8px 10px; border-radius:6px; box-shadow: 0 2px 8px rgba(0,0,0,0.15); font-size:13px; color:#333; pointer-events:none;"></div>

<script>
	$(document).ready(function() {
	    $('#myTable').DataTable({
	        "lengthMenu": [10, 25, 50, 75, 100],
	        "pagingType": "simple",
	        "pageLength": 10
	    });
	});
	

    $('#pills-tab-1').click(function () {
      $('#tabNo').val('1');
    });
    $('#pills-tab-2').click(function () {
      $('#tabNo').val('2');
    });
    $('#pills-tab-3').click(function () {
      $('#tabNo').val('3');
    });

	
   	  
	function chartprint(type,interval){
		var data = [
			<% if((activityType.equalsIgnoreCase("A") || activityType.equalsIgnoreCase("B")) ) { %>
				<%for(Object[] obj : actionAssigneeList){ %>
				
					{
						id: "<%=obj[0]%>",
					    name: "<%=obj[3].toString().replaceAll("'", "\\\\'").replaceAll("\"", "\\\\\"").replaceAll("\n", " ").replaceAll("\r", "")%>",
					    project: "<%if(obj[9]!=null && obj[10]!=null) {%><%=obj[9]+" ("+obj[10]+")"%><%} else if(obj[2]!=null){%><%=obj[2].toString().split("/")[1]%><%} %>",
					    baselineStart: new Date("<%=obj[5]%>"),
					    baselineEnd: new Date("<%=obj[6]%>"),
						baseline: {fill: "#4A90E2", stroke: "0.8 #4A90E2"},
						baselineProgressValue: "<%= Math.round((int)obj[11])%>%",
						progress: {fill: "#7ED321 0.0", stroke: "0.0 #150e56"},
						progressValue: "<%= Math.round((int)obj[11])%>% ", 
						rowHeight: "55",
					},
				<%}%>
			<%}%>
			<% if((activityType.equalsIgnoreCase("A") || activityType.equalsIgnoreCase("C")) ) { %>
	   			<%for(Object[] obj : totalAssignedMainList){ %>
	
					{
						id: "<%=obj[2]%>",
					    name: "<%=obj[3].toString().replaceAll("'", "\\\\'").replaceAll("\"", "\\\\\"").replaceAll("\n", " ").replaceAll("\r", "")%>",
						project: "<%=obj[14]+" ("+obj[15]+")"%>",
						<%if(!obj[9].toString().equalsIgnoreCase("0") && !obj[9].toString().equalsIgnoreCase("1")){ %>
							baselineStart: "<%=obj[6]%>",
							baselineEnd: "<%=obj[7]%>", 
							baseline: {fill: "#F5A623 0.5", stroke: "0.0 #F5A623"},
							actualStart: "<%=obj[4]%>",
							actualEnd: "<%=obj[5]%>",
							actual: {fill: "#4A90E2", stroke: "0.8 #4A90E2"},
							baselineProgressValue: "<%= Math.round((int)obj[8])%>%",
							progress: {fill: "#7ED321 0.0", stroke: "0.0 #150e56"},
							progressValue: "<%= Math.round((int)obj[8])%>% ", 
						<%} else{%>
							<%-- baselineStart: "<%=obj[6]%>",
							baselineEnd: "<%=obj[7]%>",  --%>
							baselineStart: "<%=obj[4]%>",
							baselineEnd: "<%=obj[5]%>", 
							baseline: {fill: "#4A90E2", stroke: "0.8 #4A90E2"},
							baselineProgressValue: "<%= Math.round((int)obj[8])%>%",
							progress: {fill: "#7ED321 0.0", stroke: "0.0 #150e56"},
							progressValue: "<%= Math.round((int)obj[8])%>% ", 
						<%}%>
						  rowHeight: "55",
					},
				<%}%>
		   		<%for(Object[] obj : totalAssignedSubList){ 
	   				Object[] projectDetails = projectList.stream().filter(e -> Long.parseLong(e[0].toString())== Long.parseLong(obj[17].toString())).findFirst().orElse(null);
		   		  %>
		
						{
							id: "<%=obj[2]%>",
						    name: "<%=obj[3].toString().replaceAll("'", "\\\\'").replaceAll("\"", "\\\\\"").replaceAll("\n", " ").replaceAll("\r", "")%>",
						    project: "<%=projectDetails!=null?(projectDetails[1]+" ("+projectDetails[3]+")"):"-"%>",
							<%if(!obj[9].toString().equalsIgnoreCase("0") && !obj[9].toString().equalsIgnoreCase("1")){ %>
								baselineStart: "<%=obj[6]%>",
								baselineEnd: "<%=obj[7]%>", 
								baseline: {fill: "#F5A623 0.5", stroke: "0.0 #F5A623"},
								actualStart: "<%=obj[4]%>",
								actualEnd: "<%=obj[5]%>",
								actual: {fill: "#4A90E2", stroke: "0.8 #4A90E2"},
								baselineProgressValue: "<%= Math.round((int)obj[8])%>%",
								progress: {fill: "#7ED321 0.0", stroke: "0.0 #150e56"},
								progressValue: "<%= Math.round((int)obj[8])%>% ", 
							<%} else{%>
								<%-- baselineStart: "<%=obj[6]%>",
								baselineEnd: "<%=obj[7]%>",  --%>
								baselineStart: "<%=obj[4]%>",
								baselineEnd: "<%=obj[5]%>", 
								baseline: {fill: "#4A90E2", stroke: "0.8 #4A90E2"},
								baselineProgressValue: "<%= Math.round((int)obj[8])%>%",
								progress: {fill: "#7ED321 0.0", stroke: "0.0 #150e56"},
								progressValue: "<%= Math.round((int)obj[8])%>% ", 
							<%}%>
							  rowHeight: "55",
						},
				<%}%>
				<%} %>
			];
		
			// create a data tree
			var treeData = anychart.data.tree(data, "as-tree");
			// create a chart
			var chart = anychart.ganttProject();
			// set the data
			chart.data(treeData);   
	    	// set the container id
	    	chart.container("containers");  
    	
    	
    	
	    	// initiate drawing the chart
	    	chart.draw();    
	    	// fit elements to the width of the timeline
	    	chart.fitAll();
		    /* ToolTip */
		    chart.getTimeline().tooltip().useHtml(true);  
		    
		    var timeline = chart.getTimeline();

			// configure labels of elements
			timeline.elements().labels().fontWeight(600);
			timeline.elements().labels().fontSize("14px");
			timeline.elements().labels().fontColor("#333333");

		    chart.getTimeline().tooltip().format(
		   		 function() {
		   		        var actualStart = this.getData("actualStart") ? this.getData("actualStart") : this.getData("baselineStart");
		   		        var actualEnd = this.getData("actualEnd") ? this.getData("actualEnd") : this.getData("baselineEnd");
		   		        var reDate=this.getData("actualStart") ;
		   		   
		   		        var html="";
		   		        if(reDate===undefined){
		   		        	html="";
		   		        	html= "<span style='font-weight:600;font-size:10pt'> Actual : " +
		   		               anychart.format.dateTime(actualStart, 'dd MMM yyyy') + " - " +
		   		               anychart.format.dateTime(actualEnd, 'dd MMM yyyy') + "</span><br>" +
		   		               "Progress: " + this.getData("baselineProgressValue") + "<br>"
		   		        }else{
		   		        	html="";
		   		        html="<span style='font-weight:600;font-size:10pt'> Actual : " +
		   		               anychart.format.dateTime(actualStart, 'dd MMM yyyy') + " - " +
		   		               anychart.format.dateTime(actualEnd, 'dd MMM yyyy') + "</span><br>" +
		   		               "<span style='font-weight:600;font-size:10pt'> Revised : " +
		   		               anychart.format.dateTime(this.getData("baselineStart"), 'dd MMM yyyy') + " - " +
		   		               anychart.format.dateTime(this.getData("baselineEnd"), 'dd MMM yyyy') + "</span><br>" +
		   		               "Progress: " + this.getData("baselineProgressValue") + "<br>"
		   		        }
		   		        
		   		        return html;
		   		    }
		      
		    ); 
    

			/* Title */
			var title = chart.title();
			title.enabled(true);
			title.text("Resource Gantt Chart");
			title.fontColor("#1976D2");  // Darker blue for better contrast
			title.fontSize(18);
			title.fontWeight(600);
			title.padding(5);


		
			/* Hover */
			chart.rowHoverFill("#FFCC80 0.3");  // Softer orange for hover
			chart.rowSelectedFill("#FFCC80 0.3");
			chart.rowStroke("0.5 #4A90E2");  // Matches Sky Blue
			chart.columnStroke("0.5 #4A90E2");  
	
			chart.defaultRowHeight(35);
			chart.headerHeight(90);
	
			/* Hiding the middle column */
			chart.splitterPosition("15.6%");
	
			var dataGrid = chart.dataGrid();
			dataGrid.rowEvenFill("#E0E0E0 0.3");  // Light gray for contrast
			dataGrid.rowOddFill("#E0E0E0 0.1");
			dataGrid.rowHoverFill("#FFD54F 0.3");  // Light yellow hover
			dataGrid.rowSelectedFill("#FFD54F 0.3");
			dataGrid.columnStroke("2 #4A90E2");  
			dataGrid.headerFill("#4A90E2 0.2");
	
			/* Title */
			var column_1 = chart.dataGrid().column(1);
			column_1.labels().fontWeight(600);
			column_1.labels().useHtml(true);
			column_1.labels().fontColor("#0D47A1");  // Dark blue for labels
	
			var column_2 = chart.dataGrid().column(1);
			column_2.title().text("Activity");
			column_2.title().fontColor("#2C3E50");  // Deep blue title
			column_2.title().fontWeight(600);
	
			var column_3 = chart.dataGrid().column(2);
			column_3.title().text("Project");
			column_3.title().fontColor("#2C3E50");
			column_3.title().fontWeight(600);
			column_3.labels().useHtml(true);
			column_3.labels().fontColor("#0D47A1");
			column_3.labels().format("{%project}");
			column_3.width(150);
			
			chart.dataGrid().column(0).width(25);
	
			chart.dataGrid().tooltip().useHtml(true);

      
   	
   	
		   	 /* Set width of column */
		   	/* chart.dataGrid().column(0).setColumnFormat(
		   		   
		   		    {
		   		      formatter: function(value) {
		   		        return value.toUpperCase();
		   		      },
		   		      textStyle: {fontColor: "#055C9D",fontWeight:"600"},
		   		      width: 10
		   		    }
		   		);   */
		   	
		/* chart.fitAll();
		   	chart.zoomTo("month", 3, "first-date"); */
		   	
		   	/* chart.getTimeline().scale().minimum("2019-01-01");
		   	chart.getTimeline().scale().maximum("2021-07-15"); */
		   	
		   	//chart.getTimeline().scale().zoomLevels([["month", "quarter","year"]]);
   	
		if(interval==="year"){
	   		/* Yearly */
	    	chart.getTimeline().scale().zoomLevels([["year"]]);
	    	var header = chart.getTimeline().header();
	    	header.level(2).format("{%value}-{%endValue}");
	    	header.level(1).format("{%value}-{%endValue}"); 
	   	}
	   	
	   	if(interval==="half"){
	   		/* Half-yearly */
	    	chart.getTimeline().scale().zoomLevels([["semester", "year"]]);
	    	var header = chart.getTimeline().header();
	    	/* header.level(2).format("{%value}-{%endValue}"); */
	    	header.level(2).format("{%value}-{%endValue}");
	    	header.level(0).format(function() {
	    			var duration = '';
	    			if(this.value=='Q1')
	    				duration='H1';
	    			if(this.value=='Q3')
	    				duration='H2'
	    		  return duration;
	    		});
	   	}
	   	
	   	if(interval==="quarter"){
	   		/* Quarterly */
	    	chart.getTimeline().scale().zoomLevels([["quarter", "semester","year"]]);
	    	var header = chart.getTimeline().header();
	    	header.level(1).format(function() {
	   			var duration = '';
	   			if(this.value=='Q1')
	   				duration='H1';
	   			if(this.value=='Q3')
	   				duration='H2'
	   		  return duration;
	   		});
	   		
	   		
	   	}
	   	
	   	if(interval==="month"){
	   		/* Monthly */
	    	chart.getTimeline().scale().zoomLevels([["month", "quarter","year"]]);
	   	}
	   	
	   	else if(interval===""){
	
	   		/* Quarterly */
	    	chart.getTimeline().scale().zoomLevels([["quarter", "semester","year"]]);
	    	var header = chart.getTimeline().header();
	    	header.level(1).format(function() {
	   			
	   			var duration = '';
	   		
	   			if(this.value=='Q1')
	   				duration='H1';
	   			if(this.value=='Q3')
	   				duration='H2'
	
	   		  return duration;
	   		});
	   		
	   	}
   	
   	
   	
	   	/* chart.getTimeline().scale().fiscalYearStartMonth(4); */
	   	
	   	/* Header */
	   	var header = chart.getTimeline().header();
	   	header.level(0).fill("#4A90E2 0.2");  // Softer Sky Blue for clarity
	   	header.level(0).stroke("#4A90E2");   // Matches Sky Blue
	   	header.level(0).fontColor("#0D47A1");  // Darker blue for better readability
	   	header.level(0).fontWeight(600);
	   	
	   	/* Marker */
	   	var marker_1 = chart.getTimeline().lineMarker(0);
	   	marker_1.value("current");
	   	marker_1.stroke("2 #FF6F00");  // Bright Orange for better visibility
	   	
	   	/* Progress */
	   	var timeline = chart.getTimeline();
	   	
	   	timeline.tasks().labels().useHtml(true);
	   	timeline.tasks().labels().format(function() {
	   		if (this.progress == 1) {
	   		    return "<span style='color:#388E3C;font-weight:bold;font-family:Lato;'>Completed</span>";  // Green for completion
	   		  } else {
	   		    return "<span style='color:#D32F2F;font-weight:bold;font-family:Lato;'></span>";  // Red for pending
	   		  }
	   	});
   	
   	
   	
  		// calculate height
	   	var traverser = treeData.getTraverser();
	      var itemSum = 0;
	      var rowHeight = chart.defaultRowHeight();
	      while (traverser.advance()){
	         if (traverser.get('rowHeight')) {
	        itemSum += traverser.get('rowHeight');
	      } else {
	      	itemSum += rowHeight;
	      }
	      if (chart.rowStroke().thickness != null) {
	      	itemSum += chart.rowStroke().thickness;
	      } else {
	        itemSum += 1;
	      }
	      }
	      itemSum += chart.headerHeight();
	      
	      //customize printing
	      var menu = chart.contextMenu();
	      
	      // To download and stuff 
	      
	     /*  menu.itemsFormatter(function(items) {
	        items['print-chart'].action = 
	      	  
	      	  function() {
	          document.getElementById('containers').style.height = String(itemSum) + 'px';
	          setTimeout(function() {
	            chart.print();
	            setTimeout(function() {
	              document.getElementById('containers').style.height = '100%';
	            },5000);
	          },1000);
	        }
	        return items;
	      });   */
	      
	      
	     // to print
	
	  	if(type==="print"){
	
	  		anychart.onDocumentReady(function () { 
	  		
	           document.getElementById('containers').style.height = String(itemSum) + 'px';
	           setTimeout(function() {
	           
	           //  anychart.exports.server("E://pmsuploadedfiles");	
	             //chart.saveAsPng(360, 500, 0.3, 'PngChart'); 
	             
	       /*       chart.saveAsJpg({"width": 360,
	           "height": 500,
	           "quality": 0.3,
	           "forceTransparentWhite": false,
	           "filename": "My Chart JPG"}); */
	             
	             
	           // chart.saveAsPdf('a4', true, 100, 100, 'PdfChart');
	             chart.print();
	             setTimeout(function() {
	               //document.getElementById('containers').style.height = '100%';
	             },3000);
	           },1000);
	         }); 
	    
	  	}
    }     
    
 /*    });  */
    
    $( document ).ready(function(){
  	  
  	  chartprint('type','');
  	  
    })
    
    
    function ChartPrint(){
  		
  	  var interval = $("#interval").val();
  	  $('#containers').empty();
  	  chartprint('print',interval);
   }
 
$('#interval').on('change',function(){
	
	$('#containers').empty();
	var interval = $("#interval").val()
	chartprint('type',interval);
	
});

$('#empId').on('change',function(){
	
	$('#myform').submit();
})


/* Resource Progress chart */

// On load and change
/* $(document).ready(function () {
  $('#yearSelect').datepicker({
    format: "yyyy",
    viewMode: "years",
    minViewMode: "years",
    autoclose: true,
    todayHighlight: true
  });

  loadResourceChart();
  $('#calendarYear').on('change', loadResourceChart);
  $('#interval2').on('change', loadResourceChart);
}); */

/* function loadResourceChart() {
  let year = parseInt($('#calendarYear').val());
  let interval = $('#interval2').val();
  $('#containers2').empty();
  renderGanttChart(data, year, interval);
} */


</script>
<script>
    const yearSelect = document.getElementById("yearSelect");
    const viewType = document.getElementById("viewType");
    const timeHeader = document.getElementById("timeHeader");
    const taskBody = document.getElementById("taskBody");

    // Sample task data (replace with your server-side logic)
	var tasks = [
    	<% if((activityType.equalsIgnoreCase("A") || activityType.equalsIgnoreCase("B")) ) { %>
			<% for (Object[] obj : actionAssigneeList) {
				String taskshortname = obj[3]!=null && obj[3].toString().length()>90?obj[3].toString().substring(0, 90)+"....":obj[3].toString();
				%>
			    {
				  id: "<%=obj[0]%>",
				  taskshortname: "<%=taskshortname.replaceAll("'", "\\\\'").replaceAll("\"", "\\\\\"").replaceAll("\n", " ").replaceAll("\r", "")%>",
			      name: "<%=obj[3].toString().replaceAll("'", "\\\\'").replaceAll("\"", "\\\\\"").replaceAll("\n", " ").replaceAll("\r", "")%>",
			      project: "<%if(obj[9]!=null && obj[10]!=null) {%><%=obj[9]+" ("+obj[10]+")"%><%} else if(obj[2]!=null){%><%=obj[2].toString().split("/")[1]%><%} %>",
			      start: "<%=obj[5]%>",
			      end: "<%=obj[6]%>",
			      loading: "<%= Math.round((int)obj[8])%>",
			    },
			<% } %>
		<%}%>
		<% if((activityType.equalsIgnoreCase("A") || activityType.equalsIgnoreCase("C")) ) { %>
	        <% for (Object[] obj : totalAssignedMainList) { 
				String taskshortname = obj[3]!=null && obj[3].toString().length()>90?obj[3].toString().substring(0, 90)+"....":obj[3].toString();
	        %>
		        {
		            id: "<%=obj[2]%>",
		            taskshortname: "<%=taskshortname.replaceAll("'", "\\\\'").replaceAll("\"", "\\\\\"").replaceAll("\n", " ").replaceAll("\r", "")%>",
				    name: "<%=obj[3].toString().replaceAll("'", "\\\\'").replaceAll("\"", "\\\\\"").replaceAll("\n", " ").replaceAll("\r", "")%>",
		            project: "<%=obj[14] + " (" + obj[15] + ")"%>",
		            start: "<%=obj[6]%>",
		            end: "<%=obj[7]%>",
		            loading: "<%= Math.round((int)obj[17])%>"
		        },
	        <% } %>
	        <% for (Object[] obj : totalAssignedSubList) {
	            Object[] projectDetails = projectList.stream().filter(e -> Long.parseLong(e[0].toString()) == Long.parseLong(obj[18].toString())).findFirst().orElse(null);
				String taskshortname = obj[3]!=null && obj[3].toString().length()>90?obj[3].toString().substring(0, 90)+"....":obj[3].toString();
	        %>
		        {
		            id: "<%=obj[2]%>",
		            taskshortname: "<%=taskshortname.replaceAll("'", "\\\\'").replaceAll("\"", "\\\\\"").replaceAll("\n", " ").replaceAll("\r", "")%>",
				    name: "<%=obj[3].toString().replaceAll("'", "\\\\'").replaceAll("\"", "\\\\\"").replaceAll("\n", " ").replaceAll("\r", "")%>",
				    project: "<%=projectDetails!=null?(projectDetails[1] + " (" + projectDetails[3] + ")"):"-"%>",
		            start: "<%=obj[6]%>",
		            end: "<%=obj[7]%>",
		            loading: "<%= Math.round((int)obj[14])%>"
		        },
	        <% } %>
        <% } %>
    ];

    $('#viewType').on("change", function () {
        renderTable();
    });;

    function renderTable() {
        var view = viewType.value;
        var year = parseInt(yearSelect.value);
        if (isNaN(year)) return;
        var headers = [];

        if (view === "weekly") {
            var weeks = getWeeksInYear(year);
            for (var i = 1; i <= weeks; i++) {
                headers.push("W" + i);
            }
        } else if (view === "monthly") {
            headers = ["JAN", "FEB", "MAR", "APR", "MAY", "JUN", "JUL", "AUG", "SEP", "OCT", "NOV", "DEC"];
        } else if (view === "quarterly") {
            headers = ["Q1", "Q2", "Q3", "Q4"];
        }

        // Header
        timeHeader.innerHTML = "";
        var headerHtml = '<th style="width: 40px;">SN</th><th style="width: 200px;">Task Name</th><th style="width: 100px;">Project</th>';

        for (var h = 0; h < headers.length; h++) {
            headerHtml += '<th>' + headers[h] + '</th>';
        }
        timeHeader.innerHTML = headerHtml;

        // Initialize column total array
        var columnTotals = new Array(headers.length).fill(0);

        // Clear rows
        taskBody.innerHTML = "";
        
        var slno = 0;
        
        for (var t = 0; t < tasks.length; t++) {
        	var task = tasks[t];
            var taskStart = new Date(task.start);
            var taskEnd = new Date(task.end);
			
            // Skip if the task doesn't intersect the selected year
            if (taskStart.getFullYear() > year || taskEnd.getFullYear() < year) continue;
			slno++;

            
            var row = document.createElement("tr");

         	// Sl. No
            var slCell = document.createElement("td");
            slCell.textContent = slno;
            slCell.style.color = "#1976D2";
            slCell.style.fontWeight = "bold";
            row.appendChild(slCell);

            // Task Name
            var taskCell = document.createElement("td");
			taskCell.style.width = "200px";
			taskCell.style.textAlign = "left";
			taskCell.style.color = "#1976D2";
			taskCell.style.fontWeight = "bold";
			taskCell.textContent = task.taskshortname;
			row.appendChild(taskCell);

            // Project
            var projectCell = document.createElement("td");
            projectCell.textContent = task.project;
            projectCell.style.color = "#1976D2";
            projectCell.style.fontWeight = "bold";
            row.appendChild(projectCell);

            var taskStart = new Date(task.start);
            var taskEnd = new Date(task.end);
            var startIndex = 0;
            var endIndex = 0;

            if (view === "weekly") {
                const weeks = getWeeksInYear(year);

                const [startIsoYear, startWeek] = getWeekNumber(taskStart);
                const [endIsoYear, endWeek] = getWeekNumber(taskEnd);

                // If task doesn't touch the ISO week of the selected year, skip
                if (startIsoYear > year || endIsoYear < year) continue;

                // Clamp weeks within selected year
                startIndex = (startIsoYear === year) ? startWeek - 1 : 0;
                endIndex = (endIsoYear === year) ? endWeek - 1 : weeks - 1;

                startIndex = Math.max(0, Math.min(startIndex, weeks - 1));
                endIndex = Math.max(0, Math.min(endIndex, weeks - 1));
            }else if (view === "monthly") {
                startIndex = (taskStart.getFullYear() === year) ? taskStart.getMonth() : 0;
                endIndex = (taskEnd.getFullYear() === year) ? taskEnd.getMonth() : headers.length - 1;
            } else if (view === "quarterly") {
                startIndex = (taskStart.getFullYear() === year) ? Math.floor(taskStart.getMonth() / 3) : 0;
                endIndex = (taskEnd.getFullYear() === year) ? Math.floor(taskEnd.getMonth() / 3) : headers.length - 1;
            }

            startIndex = Math.max(0, Math.min(startIndex, headers.length - 1));
            endIndex = Math.max(0, Math.min(endIndex, headers.length - 1));

            // Add to columnTotals
            for (var j = startIndex; j <= endIndex; j++) {
                columnTotals[j] += parseInt(task.loading);
            }

            // Fill before bar
            for (var i = 0; i < startIndex; i++) {
                var empty = document.createElement("td");
                row.appendChild(empty);
            }

            // Bar cell
			var barCell = document.createElement("td");
			barCell.colSpan = endIndex - startIndex + 1;
			
			var bar = document.createElement("div");
			bar.className = "bar";
			bar.style.width = "100%";
			bar.style.textAlign = "center";
			bar.style.background = getBarColor(task.loading);
			bar.textContent = task.loading + "%";
			
			// Tooltip handlers
			(function(taskCopy, taskStartCopy, taskEndCopy) {
			    bar.addEventListener("mousemove", function (e) {
			        var tooltip = document.getElementById("customTooltip");
			        tooltip.style.display = "block";
			        tooltip.style.left = (e.pageX + 15) + "px";
			        tooltip.style.top = (e.pageY + 10) + "px";
			        tooltip.innerHTML =
			            "<b>Task:</b> " + taskCopy.name + "<br>" +
			            "<b>Project:</b> " + taskCopy.project + "<br>" +
			            "<b>From:</b> " + formatDate(taskStartCopy) + "<br>" +
			            "<b>To:</b> " + formatDate(taskEndCopy) + "<br>" +
			            "<b>Load:</b> " + taskCopy.loading + "%";
			    });
			
			    bar.addEventListener("mouseleave", function () {
			        var tooltip = document.getElementById("customTooltip");
			        tooltip.style.display = "none";
			    });
			})(task, taskStart, taskEnd); // Pass copies to IIFE
			
			barCell.appendChild(bar);
			row.appendChild(barCell);


            // Fill after bar
            for (var i = endIndex + 1; i < headers.length; i++) {
                var empty = document.createElement("td");
                row.appendChild(empty);
            }

            taskBody.appendChild(row);
        }

        // Add total row
        var totalRow = document.createElement("tr");
        totalRow.className = "total-row";
        var totalLabel = document.createElement("td");
        totalLabel.colSpan = 3;
        totalLabel.style.fontSize = "large";
        totalLabel.innerHTML = "<b>Total Load</b>";
        totalRow.appendChild(totalLabel);

        for (var c = 0; c < headers.length; c++) {
            var td = document.createElement("td");
            td.style.fontWeight = "bold";
            td.style.color = columnTotals[c] > 100 ? "red" : "black";
            /* const val = columnTotals[c];
		    let color = "#8c8989";
		
		    if (val > 0 && val <= 25) color = "green";
		    else if (val > 25 && val <= 50) color = "#ac8705";
		    else if (val > 50 && val <= 75) color = "#EE5007";
		    else if (val > 75) color = "red";
		
		    td.style.color = color; */
            td.textContent = columnTotals[c] + "%";
            totalRow.appendChild(td);
        }

        taskBody.appendChild(totalRow);
    }


    // Utilities
    function getWeeksInYear(year) {
        const d = new Date(year, 11, 31);
        const week = getWeekNumber(d)[1];
        return week === 1 ? 52 : week;
    }

    function getWeekNumber(d) {
        d = new Date(Date.UTC(d.getFullYear(), d.getMonth(), d.getDate()));
        const dayNum = d.getUTCDay() || 7;
        d.setUTCDate(d.getUTCDate() + 4 - dayNum);
        const yearStart = new Date(Date.UTC(d.getUTCFullYear(), 0, 1));
        const weekNo = Math.ceil((((d - yearStart) / 86400000) + 1) / 7);
        return [d.getUTCFullYear(), weekNo]; // Returns ISO week year and number
    }

    function getDateOfISOWeek(week, year) {
        const simple = new Date(year, 0, 1 + (week - 1) * 7);
        const dow = simple.getDay();
        const ISOweekStart = simple;
        if (dow <= 4)
            ISOweekStart.setDate(simple.getDate() - simple.getDay() + 1);
        else
            ISOweekStart.setDate(simple.getDate() + 8 - simple.getDay());
        return ISOweekStart;
    }

    function getBarColor(loading) {
		if(loading==0){
			return "#8c8989";
    	}else if(loading>0 && loading<=25){
    		return "green";
    	}else if(loading>26 && loading<=50) {
    		return "#ac8705";
    	}else if(loading>50 && loading<=75) {
    		return "#EE5007";
    	}else if(loading>76 && loading<=100) {
    		return "red";
    	}
    }

    function formatDate(dateStr) {
        var date = new Date(dateStr);
        var dd = String(date.getDate()).padStart(2, '0');
        var mm = String(date.getMonth() + 1).padStart(2, '0'); // January is 0!
        var yyyy = date.getFullYear();
        return dd + '-' + mm + '-' + yyyy;
    }

    
    // Setup datepicker
    $(document).ready(function () {
        $('#yearSelect').datepicker({
            format: "yyyy",
            viewMode: "years",
            minViewMode: "years",
            autoclose: true,
            todayHighlight: true
        }).on("changeDate", function () {
            renderTable();
        });

        renderTable(); // Initial call
    });
</script>


</body>

</html>